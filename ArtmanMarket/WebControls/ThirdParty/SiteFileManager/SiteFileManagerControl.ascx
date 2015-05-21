<%@ Control Language="VB" Inherits="SiteFileManager.SiteFileManagerControl" %>
<%@ Register Src="~/WebControls/Common/WaitPanel.ascx" TagName="WaitPanel" TagPrefix="uc1" %>

<script runat="server" type="text/VB">
    
    Private _panelWidth As Unit = Unit.Percentage("100")
    Private _editorUrl As String = Nothing
    
    Dim BackupThread As Threading.Thread
    
    Public Property PanelWidth() As Unit
        Get
            Return _panelWidth
        End Get
        Set(ByVal value As Unit)
            _panelWidth = value
        End Set
    End Property
    
    Public Property EditorUrl() As String
        Get
            Return _editorUrl
        End Get
        Set(ByVal value As String)
            _editorUrl = value
        End Set
    End Property
    
    Public ExtensionList() As String = {"cs", "vb", "asax", "ascx", "aspx", "asmx", "ashx", "master", "htm", "html", "xml", "xsl", "xsd", "resx", "rdlc", "cd", "browser", "sitemap", "config", "wsdl", "disco", "discomap", "css", "js", "vbs", "ini", "bat", "java", "py", "perl", "php", "sql", "txt"}
    
    Private Function GetItemLinkOrText(ByVal item As Object, Optional ByVal isLink As Boolean = True) As String
        Dim currentFolder As String = Request.QueryString("folder")
        If String.IsNullOrEmpty(currentFolder) Then
            currentFolder = Server.MapPath(Request.ApplicationPath)
        End If
        
        Dim fileName As String = System.IO.Path.Combine(currentFolder, item)
        Dim extention As String = fileName.Substring(fileName.LastIndexOf(".") + 1).ToLower()
           
        Try
            If EditorUrl <> Nothing _
            AndAlso System.IO.File.GetAttributes(fileName) <> FileAttribute.Directory _
            AndAlso Array.IndexOf(ExtensionList, extention) <> -1 Then
                If isLink Then
                    Return Page.ResolveUrl(EditorUrl) & "?file=" & fileName
                Else
                    Return "Edit"
                End If
            Else
                Return Nothing
            End If
        Catch ex As Exception
            Return Nothing
        End Try
    End Function
    
    Private Sub CreateSiteMap()
        Dim baseDir As String = Server.MapPath("~")
        
        Dim currentFolder As String = Request.QueryString("folder")
        If String.IsNullOrEmpty(currentFolder) Then
            currentFolder = baseDir
        End If
                
        baseDir = baseDir.Substring(0, baseDir.LastIndexOf("\") + 1)
        If currentFolder.IndexOf(baseDir) = -1 Then
            SiteMapLiteral.Text = ""
            Return
        End If
        
        Dim paths() As String = currentFolder.Substring(baseDir.Length).Split(New Char() {"\\"}, StringSplitOptions.RemoveEmptyEntries)
        For i As Integer = 0 To paths.Length - 1
            If i <> (paths.Length - 1) Then
                baseDir = System.IO.Path.Combine(baseDir, paths(i))
                SiteMapLiteral.Text += "<a href='" + Request.Url.AbsolutePath + "?folder=" + baseDir + "'>" + paths(i) + "</a> <span style='color:#990000'>►</span> "
            Else
                SiteMapLiteral.Text += paths(i)
            End If
        Next
    End Sub
    
    Private Sub DetachDatabase()
        Using conn As New Data.SqlClient.SqlConnection("Data Source=.\SQLEXPRESS;Integrated Security=True;User Instance=True")
            conn.Open()
                    
            Dim cmd As New Data.SqlClient.SqlCommand("sp_detach_db", conn)
            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("dbname", "ArtmanMarket")
                    
            cmd.ExecuteNonQuery()
                    
            conn.Close()
        End Using
    End Sub
    
    Private Function IsDBInUse(ByVal inputDirectory As String) As Boolean
        For Each dir As String In System.IO.Directory.GetDirectories(inputDirectory)
            If dir.ToLower().EndsWith("app_data") Then
                For Each file As String In System.IO.Directory.GetFiles(dir)
                    If file.ToLower().EndsWith(".mdf") Then
                        Try
                            Using stream As System.IO.Stream = New System.IO.FileStream(file, IO.FileMode.Open)
                                stream.Close()
                            End Using
                            Return False
                        Catch ex As Exception
                            Return True
                        End Try
                        Exit For
                    End If
                Next
                Exit For
            End If
        Next
        
        Return False
    End Function
    
    Private Sub CreateBackup()
        Dim lockThis As New Object
        
        Try
            Using compressor As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile()
                Dim zipFileName As String = "Backup_" + System.DateTime.Now.ToString("MM_dd_yy") + ".zip"
                Session("BackupFileName") = zipFileName
            
                Dim inputDirectory As String = Server.MapPath("~")
                Dim outputZipFile As String = System.IO.Path.Combine(inputDirectory, zipFileName)
               
                If System.IO.File.Exists(outputZipFile) Then
                    System.IO.File.Delete(outputZipFile)
                End If
                
                compressor.Password = "artmanmarket"
                
                'DetachDatabase()           
                
                If Not IsDBInUse(inputDirectory) Then
                    compressor.AddDirectory(inputDirectory)
                Else
                    For Each dir As String In System.IO.Directory.GetDirectories(inputDirectory)
                        If Not dir.ToLower().EndsWith("app_data") Then 'Skip Sql Server DB files, because they are used by another process
                            compressor.AddDirectory(dir, dir.Substring(dir.LastIndexOf("\") + 1))
                        Else
                            compressor.AddDirectoryByName(dir.Substring(dir.LastIndexOf("\") + 1))
                            For Each subDir As String In System.IO.Directory.GetDirectories(dir)
                                compressor.AddDirectory(subDir, subDir.Substring(dir.LastIndexOf("\") + 1))
                            Next
                            For Each file As String In System.IO.Directory.GetFiles(dir)
                                If Not file.ToLower().EndsWith(".mdf") AndAlso Not file.ToLower().EndsWith(".ldf") Then
                                    compressor.AddFile(file, dir.Substring(dir.LastIndexOf("\") + 1))
                                End If
                            Next
                        End If
                    Next
                
                    For Each file As String In System.IO.Directory.GetFiles(inputDirectory)
                        compressor.AddFile(file, "")
                    Next
                End If
                
                compressor.Comment = "Backup created at " + System.DateTime.Now.ToString("G")
                compressor.CompressionLevel = Ionic.Zlib.CompressionLevel.BestCompression
                compressor.ZipErrorAction = Ionic.Zip.ZipErrorAction.Skip
                compressor.UseUnicodeAsNecessary = True
                compressor.Save(outputZipFile)
            End Using
        Catch ex As Exception
            SyncLock lockThis
                BackupThread = CType(Session("BackupThread"), Threading.Thread)
                Session.Remove("BackupThread")
                Session.Add("BackupError", "An error ocuured while creating the backup: " + ex.Message)
            End SyncLock
        End Try
        
    End Sub
    
    Private Sub ShowBackupStatus()
        If Session("BackupThread") Is Nothing Then
            CreateBackupLinkButton.Visible = True
            BackupProgressInfoLabel.Text = ""
        ElseIf Session("BackupError") Is Nothing Then
            BackupThread = CType(Session("BackupThread"), Threading.Thread)
           
            If BackupThread.ThreadState <> Threading.ThreadState.Stopped Then
                CreateBackupLinkButton.Visible = False
                BackupProgressInfoLabel.Text = "Backup in Progress... (Refresh after several minutes)"
            Else
                CreateBackupLinkButton.Visible = True
                BackupProgressInfoLabel.Text = "Backup Completed : " + Session("BackupFileName").ToString()
                Session.Remove("BackupThread")
            End If
        End If
        
        If Not Session("BackupError") Is Nothing Then
            lblErrMsg.Text = Session("BackupError").ToString()
            Session.Remove("BackupError")
        Else
            lblErrMsg.Text = ""
        End If
    End Sub
    
    Protected Sub CreateBackupLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CreateBackupLinkButton.Click
        If Session("BackupThread") Is Nothing Then
            BackupThread = New Threading.Thread(AddressOf CreateBackup)
            BackupThread.IsBackground = True
            Session.Add("BackupThread", BackupThread)
            BackupThread.Start()
        End If
        
        ShowBackupStatus()
    End Sub
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            DataBind()
            txtFolderName.Focus()
            CreateSiteMap()
        End If
        
        lblHeading.Text = ""
        lblCopyright.Text = ""
        
        ShowBackupStatus()
    End Sub
   
</script>

<asp:Panel ID="FileManagerPanel" runat="server" Font-Size="12px" Font-Names="Times New Roman"
    DefaultButton="cmdUpload" Width="<%# PanelWidth %>" ScrollBars="Auto">
    <asp:UpdatePanel ID="FileManagerUpdatePanel" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="cmdUpload" />
        </Triggers>
        <ContentTemplate>
            <table cellspacing="0" cellpadding="3" width="<%= PanelWidth %>" align="center" style="border: ridge 1px Silver">
                <tr>
                    <td style="background-color: sienna;" align="left">
                        <asp:Label ID="lblHeading" runat="server" Font-Bold="True" Font-Size="Small" Font-Names="Verdana">
				FREE Web Site File Manager From <a href='http://www.dotnetbips.com'>DotNetBips.com</a></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: sienna" align="left">
                        <asp:Label ID="lblCurrentFolderHeading" runat="server" Font-Bold="True" Text="Current Folder : "
                            ForeColor="#FFFFC0">
                        </asp:Label><asp:Label ID="lblCurrentFolder" runat="server" Font-Italic="true" ForeColor="#FFFFC0"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="middle" style="background-color: navajowhite; font-size: 11px" align="left"
                        nowrap="nowrap">
                        <asp:LinkButton ID="cmdDelete" Text="[Delete]" runat="server" Font-Bold="True" />
                        &nbsp;
                        <asp:LinkButton ID="cmdCut" Text="[Cut]" runat="server" Font-Bold="True" />
                        &nbsp;
                        <asp:LinkButton ID="cmdPaste" Text="[Paste]" runat="server" Font-Bold="True" />
                        &nbsp;
                        <asp:TextBox ID="txtFolderName" runat="server" Width="140px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CreateFolderRequiredFieldValidator" ControlToValidate="txtFolderName"
                            ValidationGroup="CreateFolder" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:LinkButton ID="cmdCreateFolder" ValidationGroup="CreateFolder" CausesValidation="true"
                            Text="[Create Folder]" runat="server" Font-Bold="True" />
                        &nbsp;
                        <asp:LinkButton ID="cmdDelFolder" Text="[Delete Current Folder]" ToolTip="Only works on empty folders"
                            runat="server" Font-Bold="True" />
                    </td>
                </tr>
                <tr>
                    <td style="background-color: lemonchiffon" align="left">
                        <asp:HyperLink ID="lnkUp" runat="server" Font-Bold="True" ForeColor="green" BackColor="#FFFFC0"
                            BorderWidth="1px" BorderStyle="None" Text="[ Up ]" />
                        &nbsp;&nbsp;<span style="font-family: Arial; font-weight: bold">
                            <asp:Literal ID="SiteMapLiteral" runat="server"></asp:Literal></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:DataGrid ID="dgExplorer" runat="server" Width="100%" BackColor="White" BorderWidth="1px"
                            BorderStyle="None" AutoGenerateColumns="False" CellPadding="4" BorderColor="#CC9966">
                            <FooterStyle ForeColor="#330099" BackColor="#FFFFCC"></FooterStyle>
                            <HeaderStyle Font-Bold="True" ForeColor="#FFFFCC" BackColor="#990000"></HeaderStyle>
                            <PagerStyle HorizontalAlign="Center" ForeColor="#330099" BackColor="#FFFFCC"></PagerStyle>
                            <SelectedItemStyle Font-Bold="True" ForeColor="#663399" BackColor="#FFCC66"></SelectedItemStyle>
                            <ItemStyle ForeColor="#330099" BackColor="White"></ItemStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="center" />
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="File Name" SortExpression="name">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="true" Font-Underline="true"
                                            Text='<%# Container.DataItem("name") %>'>
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.name") %>'>
                                        </asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateColumn>
                                <asp:BoundColumn DataField="modified" ReadOnly="True" HeaderText="Last Modified"
                                    SortExpression="modified"></asp:BoundColumn>
                                <asp:BoundColumn DataField="size" ReadOnly="True" HeaderText="Size (B)" SortExpression="size">
                                </asp:BoundColumn>
                                <asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel"
                                    EditText="Rename" HeaderText="Rename" ItemStyle-Font-Bold="true" ItemStyle-Font-Underline="true">
                                </asp:EditCommandColumn>
                                <asp:TemplateColumn HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:HyperLink runat="server" Font-Bold="true" Font-Underline="true" ID="EditHyperLink"
                                            Target="_blank" NavigateUrl='<%# GetItemLinkOrText(Eval("name")) %>' Text='<%# GetItemLinkOrText(Eval("name"), False) %>'></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                        </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: lemonchiffon" align="left">
                        <asp:Label ID="lblUploadHeading" runat="server" Font-Bold="True" Font-Size="13px"
                            Text="Select File To Upload :">
                        </asp:Label>&nbsp;
                        <input id="File1" style="width: 243px; height: 22px" type="file" size="21" name="File1"
                            runat="server">
                        <asp:RequiredFieldValidator ID="File1RequiredFieldValidator" ControlToValidate="File1"
                            ValidationGroup="UploadFile" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:LinkButton ID="cmdUpload" runat="server" Font-Bold="True" CausesValidation="true"
                            ValidationGroup="UploadFile" Text="[Upload]" />
                    </td>
                </tr>
                <tr>
                    <td style="background-color: lemonchiffon" align="left">
                        <asp:LinkButton ID="CreateBackupLinkButton" Font-Bold="True" OnClick="CreateBackupLinkButton_Click"
                            runat="server" Text="[Create Backup from the Website]" />
                        <asp:Label ID="BackupProgressInfoLabel" runat="server" Font-Bold="True" ForeColor="Purple"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: lemonchiffon" align="left">
                        <asp:Label ID="lblErrMsg" runat="server" Font-Bold="True" Width="100%" BackColor="#FFFFC0"
                            ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="center" style="background-color: lemonchiffon">
                        <asp:Label ID="lblCopyright" runat="server" Font-Bold="True">
				(C) DotNetBips.com				
				<a href='mailto:webmaster@dotnetbips.com'>webmaster@dotnetbips.com</a></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="FileManagerUpdateProgress" runat="server" AssociatedUpdatePanelID="FileManagerUpdatePanel">
        <ProgressTemplate>
            <uc1:WaitPanel ID="FileManagerWaitPanel" runat="server" />
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Panel>

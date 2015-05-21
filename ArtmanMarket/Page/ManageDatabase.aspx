<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ManageDatabase.aspx.cs" Inherits="Page_ManageDatabase" Title="مديريت پايگاه داده"
    ErrorPage="~/Page/News.aspx" %>

<asp:Content ID="ManageDatabaseContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div style="direction: ltr; text-align: left; font-family: verdana, arial; font-size: 10pt">
        <h3 class="signupTable" style="color: gray; font-size: 12px">
            مديريت پايگاه داده</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <center>
            <asp:Panel ID="ManageDatabasePanel" runat="server" DefaultButton="btnBackup">
                <table cellpadding="2" cellspacing="1" border="1" style="border-collapse: collapse;">
                    <tr>
                        <th style="background-color: #e0e0e0;" colspan="2">
                            Backup and Restore the Tables of
                            <br />
                            SQL Server Database
                        </th>
                    </tr>
                    <tr>
                        <td align="Center">
                            List of DB Tables</td>
                        <td colspan="2" align="Center">
                            List of DB Files</td>
                    </tr>
                    <tr>
                        <td align="Center">
                            <asp:ListBox ID="DBTableListBox" SelectionMode="Multiple" Rows="10" runat="Server"
                                DataTextField="table_name" DataValueField="table_name"></asp:ListBox>
                        </td>
                        <td align="Center">
                            <asp:ListBox ID="DBFileListBox" SelectionMode="Multiple" Rows="10" runat="Server"></asp:ListBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="Center">
                            <asp:Button ID="btnBackup" runat="Server" Text="Backup" OnClick="BackUpNow" OnClientClick="return confirm('Caution: All old related backups will be replaced.\nAre you sure to backup the selected table(s)?')" />
                        </td>
                        <td align="Center">
                            <asp:Button ID="btnRestore" runat="Server" Text="Restore" OnClick="RestoreNow" OnClientClick="return confirm('Caution: All current related data will be replaced.\nAre you sure to restore the selected table(s)?')" />
                        </td>
                    </tr>
                </table>
                <br />
                <asp:Label ID="lblMessage" runat="Server" EnableViewState="False" ForeColor="Blue"></asp:Label>
            </asp:Panel>
        </center>
        &nbsp;
        <br />
    </div>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AddProduct.aspx.cs" Inherits="Page_Product_AddProduct" Title="اضافه کردن محصول"
    ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Src="~/WebControls/Common/ImageBrowser.ascx" TagName="ImageBrowser"
    TagPrefix="uc1" %>
<%@ Register Assembly="Winthusiasm.HtmlEditor" Namespace="Winthusiasm.HtmlEditor"
    TagPrefix="rte" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href='<%= Page.ResolveUrl("~/StyleSheets/AjaxControlStyles.css")%>' rel="stylesheet"
        type="text/css" />

    <script type="text/javascript">
        function OpenCategoryPopup() 
        { 
            window.open('<%= Page.ResolveUrl("~/Page/Product/SelectCategoryPopup.aspx") + "?tid=" + CategoryTextBox.ClientID + "&vid=" + CategoryHiddenField.ClientID %>',
            'SelectCategory',
            'scrollbars=yes,resizable=yes,width=400,height=600'); 
            return false; 
        }
    </script>

</asp:Content>
<asp:Content ID="AddProductContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <h3 class="signupTable" style="color: Gray">
            اضافه کردن محصول</h3>
        <hr style="border-top: 1px dashed Gray;" />
        <br />
        <asp:MultiView ID="AddProductMultiView" runat="server" ActiveViewIndex="0">
            <asp:View ID="AddPanelView" runat="server">
                <center>
                    <asp:ValidationSummary ID="AddProductValidationSummary" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="AddProductWizard" Style="direction: rtl;
                        text-align: right" DisplayMode="list" />
                    <asp:Wizard ID="AddProductWizard" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE"
                        BorderWidth="1px" Font-Names="Tahoma" Width="535px" Font-Size="Small" CssClass="signupTable"
                        FinishCompleteButtonText="پايان" FinishPreviousButtonText="قبلي" StartNextButtonText="بعدي"
                        StepNextButtonText="بعدي" StepPreviousButtonText="قبلي" ActiveStepIndex="0" OnFinishButtonClick="AddProductWizard_FinishButtonClick"
                        OnActiveStepChanged="AddProductWizard_ActiveStepChanged">
                        <StepStyle ForeColor="#333333" Font-Names="Tahoma" Font-Size="Small" />
                        <SideBarStyle BackColor="#507CD1" VerticalAlign="Top" Font-Size="Medium" Font-Names="Tahoma"
                            Width="90px" />
                        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                            BorderWidth="1px" Font-Names="Tahoma" ForeColor="#284E98" Font-Size="Small" />
                        <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
                            Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderTemplate>
                            مرحله
                            <%=AddProductWizard.ActiveStepIndex + 1%>
                            از
                            <%=AddProductWizard.WizardSteps.Count%>
                        </HeaderTemplate>
                        <StartNavigationTemplate>
                            <asp:Button ID="StartNextButton" runat="server" Text="بعدي" CommandName="MoveNext"
                                BackColor="#EFF3FB" ForeColor="#333333" Font-Names="Tahoma" BorderColor="#B5C7DE"
                                BorderWidth="1px" Font-Size="Small" ValidationGroup="AddProductWizard" />
                        </StartNavigationTemplate>
                        <StepNavigationTemplate>
                            <asp:Button ID="StepNextButton" runat="server" Text="بعدي" CommandName="MoveNext"
                                BackColor="#EFF3FB" ForeColor="#333333" Font-Names="Tahoma" BorderColor="#B5C7DE"
                                BorderWidth="1px" Font-Size="Small" ValidationGroup="AddProductWizard" />
                            <asp:Button ID="StepPreviousButton" runat="server" Text="قبلي" CommandName="MovePrevious"
                                BackColor="#EFF3FB" ForeColor="#333333" Font-Names="Tahoma" BorderColor="#B5C7DE"
                                BorderWidth="1px" Font-Size="Small" CausesValidation="false" ValidationGroup="AddProductWizard" />
                        </StepNavigationTemplate>
                        <FinishNavigationTemplate>
                            <asp:Button ID="FinishButton" runat="server" Text="پايان" CommandName="MoveComplete"
                                BackColor="#EFF3FB" ForeColor="#333333" Font-Names="Tahoma" BorderColor="#B5C7DE"
                                BorderWidth="1px" Font-Size="Small" ValidationGroup="AddProductWizard" />
                            <asp:Button ID="FinishPreviousButton" runat="server" Text="قبلي" CommandName="MovePrevious"
                                BackColor="#EFF3FB" ForeColor="#333333" Font-Names="Tahoma" BorderColor="#B5C7DE"
                                BorderWidth="1px" Font-Size="Small" CausesValidation="false" ValidationGroup="AddProductWizard" />
                        </FinishNavigationTemplate>
                        <WizardSteps>
                            <asp:WizardStep runat="server" Title="مشخصات اصلي">
                                <br />
                                <table class="signupTable" cellspacing="2px">
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="ProductNameLabel" runat="server" AssociatedControlID="ProductNameTextBox"
                                                Font-Size="Small" Text="نام کالا *"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="ProductNameTextBox" MaxLength="100" runat="server" Width="150px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="ProductNameRequiredFieldValidator" runat="server"
                                                ErrorMessage="نام کالا بايد وارد شود" ValidationGroup="AddProductWizard" ControlToValidate="ProductNameTextBox"
                                                SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="CategoryLabel" runat="server" AssociatedControlID="CategoryTextBox"
                                                Font-Size="Small" Text="زيرشاخه"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="CategoryTextBox" runat="server" Font-Names="Tahoma" Width="150px"
                                                onclick="javascript:return OpenCategoryPopup()">
                                            </asp:TextBox>
                                            <asp:HiddenField ID="CategoryHiddenField" runat="server" />
                                        </td>
                                        <td>
                                            <asp:ImageButton ID="CategoryPopupImageButton" ToolTip="انتخاب زيرشاخه" runat="server"
                                                Height="23px" Width="23px" ImageUrl="~/Images/Product/popup.gif" OnClientClick="javascript:return OpenCategoryPopup()" />
                                            &nbsp;
                                            <asp:RequiredFieldValidator ID="CategoryRequiredFieldValidator" runat="server" ErrorMessage="زيرشاخه بايد انتخاب شود"
                                                ValidationGroup="AddProductWizard" ControlToValidate="CategoryTextBox" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="PriceLabel" runat="server" AssociatedControlID="PriceTextBox" Font-Size="Small"
                                                Text="قيمت (ريال) *"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="PriceTextBox" runat="server" Width="150px" Text="0"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="PriceRequiredFieldValidator" runat="server" ErrorMessage="قيمت بايد وارد شود"
                                                ControlToValidate="PriceTextBox" ValidationGroup="AddProductWizard" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="PriceRegularExpressionValidator" runat="server"
                                                ControlToValidate="PriceTextBox" ValidationGroup="AddProductWizard" ErrorMessage="قيمت نامعتبر است"
                                                ValidationExpression="\d+(\.\d+)?" SetFocusOnError="True">*</asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="ShopNameLabel" runat="server" AssociatedControlID="ShopNameTextBox"
                                                Font-Size="Small" Text="نام فروشگاه"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="ShopNameTextBox" runat="server" Width="150px" Enabled="false"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="WarrantyLabel" runat="server" AssociatedControlID="WarrantyTextBox"
                                                Font-Size="Small" Text="ضمانتنامه"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="WarrantyTextBox" runat="server" MaxLength="100" Width="150px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="WarrantyDurationLabel" runat="server" AssociatedControlID="WarrantyDurationTextBox"
                                                Font-Size="Small" Text="مدت ضمانتنامه"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="WarrantyDurationTextBox" MaxLength="50" runat="server" Width="150px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="VendorDescriptionLabel" runat="server" AssociatedControlID="VendorDescriptionTextBox"
                                                Font-Size="Small" Text="توضيحات فروشنده"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="VendorDescriptionTextBox" MaxLength="500" runat="server" Width="150px"
                                                TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 95px;">
                                            <asp:Label ID="ProductRatingLabel" runat="server" AssociatedControlID="ProductRatingControl"
                                                Font-Size="Small" Text="امتياز"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <ajax:Rating ID="ProductRatingControl" runat="server" EmptyStarCssClass="emptyRatingStar"
                                                CssClass="sigupTable" FilledStarCssClass="filledRatingStar" StarCssClass="ratingStar"
                                                WaitingStarCssClass="savedRatingStar" Width="150px" RatingDirection="RightToLeftBottomToTop"
                                                BehaviorID="ProductRatingControl_RatingExtender" CurrentRating="0">
                                            </ajax:Rating>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" Title="توضيحات">
                                <br />
                                <table class="signupTable" cellspacing="3px">
                                    <tr>
                                        <td style="width: 70px; height: 42px;">
                                            <asp:Label ID="OverviewLabel" runat="server" AssociatedControlID="OverviewTextBox"
                                                Font-Size="Small" Text="توضيحات کلي *"></asp:Label>
                                        </td>
                                        <td style="height: 42px">
                                            <asp:TextBox ID="OverviewTextBox" Rows="6" runat="server" Width="390px" Font-Size="10px"
                                                TextMode="MultiLine">توضيحات: </asp:TextBox>
                                        </td>
                                        <td style="width: 19px; height: 42px;">
                                            <asp:RequiredFieldValidator ID="OverviewRequiredFieldValidator" runat="server" ErrorMessage="توضيحات کلي بايد وارد شود"
                                                ControlToValidate="OverviewTextBox" ValidationGroup="AddProductWizard" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 70px">
                                            <asp:Label ID="DetailsLabel" runat="server" AssociatedControlID="DetailsHtmlEditor"
                                                Font-Size="Small" Text="جزئيات"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <rte:HtmlEditor ID="DetailsHtmlEditor" runat="server" AspxDirectory="~/Images/Product/ImageBrowser/Aspx"
                                                EnableViewState="true" BackColor="White" ButtonMouseOverBorderColor="49, 106, 197"
                                                ButtonMouseOverColor="193, 210, 238" ContextChanged="" CountLockedColor="Red"
                                                CountNormalColor="Black" CountStateChanged="" CountWarningColor="Navy" DialogBackColor="GhostWhite"
                                                DialogBorderColor="Black" DialogButtonBarColor="LightSteelBlue" DialogForeColor="Black"
                                                DialogHeadingColor="LightSteelBlue" DialogHeadingTextColor="Black" DialogSelectedTabColor="127, 157, 185"
                                                DialogSelectedTabTextColor="White" DialogTableColor="238, 238, 238" DialogTabTextColor="Black"
                                                DialogUnselectedTabColor="LightSteelBlue" EditorBackColor="White" EditorBorderColor="127, 157, 185"
                                                EditorForeColor="Black" EditorInnerBorderColor="Gray" EmotionsFolder="~/Images/AjaxControlImages/HtmlEditorEmotions"
                                                LockedMessage="" ModifiedChanged="" PasteConversion="" SaveButtons="" SelectedTabBackColor="127, 157, 185"
                                                SelectedTabTextColor="White" SizeChanged="" SizeHandleColor="127, 157, 185" TabBackColor="LightSteelBlue"
                                                TabbarBackColor="White" TabForeColor="Black" TabMouseOverColor="LightBlue" ToolbarColor="127, 157, 185"
                                                UrlConversion="" Width="395px" Height="400px" TextDirection="RightToLeft" Toolbars="Select#Format,Select#Font,Select#Size:ForeColor,BackColor;Undo,Redo:Cut,Copy,Paste:Link,Unlink,Image,Symbol,Rule,Table,RemoveFormat:Emotions;Bold,Italic,Underline:Left,Center,Right,Justify|OrderedList,BulletedList|Indent,Outdent|Subscript,Superscript,StrikeThrough"
                                                ImagesDirectory="~/Images/Product/ImageBrowser/images" AllowedImageExtensions="gif,jpg,jpeg,png,bmp"
                                                AllowedMimeTypes="image/gif,image/jpeg,image/pjpeg,image/png,image/x-png,image/bmp"
                                                ConvertDeprecatedSyntax="false" Style="margin-top: 10px" AllowedTags="a,abbr,acronym,address,b,big,blockquote,br,caption,center,code,col,colgroup,dd,del,dfn,dir,div,dl,dt,em,fieldset,font,h1,h2,h3,h4,h5,h6,hr,i,img,ins,li,map,ol,p,pre,q,s,small,span,strike,strong,style,sub,sup,table,tbody,td,textarea,tfoot,th,thead,title,tr,tt,u,ul"
                                                AllowedAttributes="align,alt,background,bgcolor,border,cellpadding,cellspacing,class,color,cols,colspan,coords,dir,face,href,hspace,marginheight,marginwidth,noshade,nowrap,rows,rowspan,shape,size,src,style,summary,target,title,usemap,valign" />
                                            <!-- AllowedTags="a,abbr,acronym,address,applet,area,b,base,basefont,bdo,big,blockquote,body,br,button,caption,center,cite,code,col,colgroup,dd,del,dfn,dir,div,dl,dt,em,fieldset,font,form,frame,frameset,h1,h2,h3,h4,h5,h6,head,hr,html,i,iframe,img,input,ins,isindex,kbd,label,legend,li,link,map,menu,meta,noframes,noscript,object,ol,optgroup,option,p,param,pre,q,s,samp,script,select,small,span,strike,strong,style,sub,sup,table,tbody,td,textarea,tfoot,th,thead,title,tr,tt,u,ul,var"
                                                AllowedAttributes="abbr,accept-charset,accept,accesskey,action,align,alink,alt,archive,axis,background,bgcolor,border,cellpadding,cellspacing,char,charoff,charset,checked,cite,class,classid,clear,code,codebase,codetype,color,cols,colspan,compact,content,coords,data,datetime,declare,defer,dir,disabled,enctype,face,for,frame,frameborder,headers,height,href,hreflang,hspace,http-equiv,id,ismap,label,lang,language,link,longdesc,marginheight,marginwidth,maxlength,method,multiple,name,nohref,noresize,noshade,nowrap,object,onblur,onchange,onclick,ondblclick,onfocus,onkeydown,onkeypress,onkeyup,onload,onload,onmousedown,onmousemove,onmouseout,onmouseover,onmouseup,onreset,onselect,onsubmit,onunload,onunload,profile,prompt,readonly,rel,rev,rows,rowspan,rules,scheme,scope,scrolling,selected,shape,size,span,src,standby,start,style,summary,tabindex,target,text,title,type,usemap,valign,value,valuetype,version,vlink,vspace,width" -->
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 70px">
                                            <asp:Label ID="TagsLabel" runat="server" AssociatedControlID="TagsTextBox" Font-Size="Small"
                                                Text="برچسب ها"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="TagsTextBox" MaxLength="200" runat="server" Width="390px" ToolTip="برچسب ها را با کاما (,) از يکديگر جدا نماييد"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" Title="تصاوير کالا">
                                <br />
                                <asp:Label ID="AddProductInvalidMessageLabel" runat="server" Text="خطا: نام کالا وارد نشده است"
                                    CssClass="signupTable" Visible="False" ForeColor="Red" Font-Size="Small"></asp:Label>
                                <br />
                                <table class="signupTable" cellspacing="2px">
                                    <tr>
                                        <td style="width: 105px;">
                                            <asp:Label ID="BrandImageLabel" runat="server" AssociatedControlID="BrandImageBrowser"
                                                Font-Size="Small" Text="علامت تجاري"></asp:Label>
                                        </td>
                                        <td>
                                            <uc1:ImageBrowser ID="BrandImageBrowser" runat="server" ToolTip="مسير تصوير علامت تجاري"
                                                AddressWidth="250px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 105px;">
                                            <asp:Label ID="LogoImageLabel" runat="server" AssociatedControlID="LogoImageBrowser"
                                                Font-Size="Small" Text="لوگوي کالا"></asp:Label>
                                        </td>
                                        <td>
                                            <uc1:ImageBrowser ID="LogoImageBrowser" runat="server" ToolTip="مسير تصوير لوگوي کالا"
                                                AddressWidth="250px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 105px;">
                                            <asp:Label ID="OtherImagesLabel" runat="server" AssociatedControlID="OtherImagesBrowser"
                                                Font-Size="Small" Text="تصاوير کالا"></asp:Label>
                                        </td>
                                        <td>
                                            <uc1:ImageBrowser ID="OtherImagesBrowser" runat="server" ToolTip="مسير تصاوير کالا که با علامت '|' از هم جدا شده اند"
                                                AddressWidth="250px" IsAppendable="true" />
                                            <br />
                                            <asp:TextBox ID="TooltipTextBox" runat="server" Height="50px" Width="340px" Style="text-align: right;
                                                direction: rtl; float: right; margin-top: 3px" ToolTip="توضيح هر يک از تصاوير کالا را به ترتيب وارد و با علامت '|' از هم جدا کنيد."
                                                TextMode="MultiLine"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                            </asp:WizardStep>
                        </WizardSteps>
                    </asp:Wizard>
                </center>
                <br />
                <asp:SqlDataSource ID="AddProductSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:MarketConnectionString %>"
                    InsertCommand="INSERT INTO [Product] ([Name], [LogoImageUrl], [BrandImageUrl], [ImagesUrl], [MinPrice], [MaxPrice], [Overview], [Details], [Tags], [Category_ID], [Rate]) VALUES (@Name, @LogoImageUrl, @BrandImageUrl, @ImagesUrl, @MinPrice, @MaxPrice, @Overview, @Details, @Tags, @Category_ID, @Rate)">
                </asp:SqlDataSource>
            </asp:View>
            <asp:View ID="AddPromptView" runat="server">
                <div class="signupTable">
                    <asp:Label ID="SuccessLabel" runat="server" Text="محصول با موفقيت اضافه شد." Font-Bold="True"
                        ForeColor="#009900" Height="25px"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="BackButton" runat="server" Text="اضافه کردن يک محصول ديگر" Font-Bold="True"
                        BackColor="#330099" Font-Size="11pt" ForeColor="#FFFFFF" Height="28px" Width="172px"
                        OnClick="BackButton_Click" />
                </div>
            </asp:View>
        </asp:MultiView>
        &nbsp;<br />
    </div>
</asp:Content>

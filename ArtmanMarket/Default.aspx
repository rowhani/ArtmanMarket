<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" Title="پايگاه اينترنتي اطلاع رساني کالاها و فروشندگان"
    MaintainScrollPositionOnPostback="true" ErrorPage="~/Page/Errors/Error500.htm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Register Src="~/WebControls/Product/ProductList.ascx" TagName="ProductList" TagPrefix="uc1" %>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">
    <link href='<%= Page.ResolveUrl("~/StyleSheets/AjaxControlStyles.css")%>' rel="stylesheet"
        type="text/css" />
</asp:Content>
<asp:Content ID="DefaultContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <div class="masterContent">
        <br />
        <ajax:AnimationExtender ID="TitlePanelAnimationExtender" runat="server" TargetControlID="TitlePanel">
            <Animations>
            <OnLoad>
                <Sequence>
                    <Parallel Duration="1.3" AnimationTarget="CaptionLabel">                   
                        <FadeIn Duration="1.3" Fps="30" />
                        <Color Duration="1.3"
                            StartValue="#FFFFFF"
                            EndValue="#009966"
                            Property="style"
                            PropertyKey="color" />
                    </Parallel>
                    <Parallel Duration="1.5" AnimationTarget="DescriptionLabel">                   
                        <FadeIn Duration="1.5" Fps="30" />
                        <Color Duration="1.5"
                            StartValue="#FFFFFF"
                            EndValue="#A52A2A"
                            Property="style"
                            PropertyKey="color" />
                    </Parallel>
                </Sequence>
            </OnLoad>
            </Animations>
        </ajax:AnimationExtender>
        <asp:Panel ID="TitlePanel" runat="server" HorizontalAlign="Center">
            <asp:Label ID="CaptionLabel" runat="server" Font-Bold="True" Font-Size="24pt" ForeColor="#FFFFFF">
           به آرتمن مارکت خوش آمديد
            </asp:Label>
            <br />
            <br />
            <asp:Label ID="DescriptionLabel" runat="server" Font-Bold="True" Font-Size="9pt"
                ForeColor="#FFFFFF" Font-Names="Tahoma">
            پايگاه اينترنتي اطلاع رساني کالاها و فروشندگان
            </asp:Label>
        </asp:Panel>
        <br />
        <br />
        <uc1:ProductList ID="AllProductList" runat="server" MaxNumOfRecords="100" ProductCountLabelVisible="false" />
        <br />
    </div>
</asp:Content>

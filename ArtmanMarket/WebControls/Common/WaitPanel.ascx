<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WaitPanel.ascx.cs" Inherits="WebControls_Common_WaitPanel"
    ClassName="WaitPanel" %>
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<center>
    <div id="WaitPanelBackgroundFilter">
    </div>
    <div id="WaitPanelMessage">
        <asp:Label ID="LoadingLabel" runat="server" Text="...درحال بارگذاري" Font-Bold="true"></asp:Label>
        <br />
        <br />
        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/Images/AjaxControlImages/LoadingSpiralBlue.gif"
            Height="60" Width="60" AlternateText='<%# LoadingLabel.Text %>' />
    </div>
</center>

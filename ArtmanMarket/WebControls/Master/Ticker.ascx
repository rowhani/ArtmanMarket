<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Ticker.ascx.cs" Inherits="WebControls_Master_Ticker" %>
<%@ OutputCache Duration="6000" VaryByParam="None" %> 
<link href="~/StyleSheets/ControlStyles.css" rel="stylesheet" type="text/css" />
<div id="theTicker" style="direction: rtl; text-align: center">
</div>

<script type="text/javascript">
        var theSummaries =  new Array('فروشندگان عزیز، در صورت تمایل به ارائه محصولاتتان در آرتمن مارکت با ما تماس بگیرید.','جهت مشاهده سايت بصورت كامل وصحيح از IE8 استفاده فرمائيد.');
        var theSiteLinks =  new Array('<%= Page.ResolveUrl("~/Page/ContactUs.aspx") %>','http://www.microsoft.com/windows/internet-explorer/worldwide-sites.aspx');       
</script>

<script language="javascript" type="text/javascript" src='<%= Page.ResolveUrl("~/JavaScripts/Ticker.js") %>'></script>


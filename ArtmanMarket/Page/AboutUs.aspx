<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AboutUs.aspx.cs" Inherits="Page_AboutUs" Title="درباره ما" ErrorPage="~/Page/Errors/Error500.htm" %>

<%-- <%@ OutputCache Duration="600" VaryByParam="None" %> --%>
<asp:Content ID="MasterHeadContent" ContentPlaceHolderID="HeadContentPlaceHolder"
    runat="Server">

    <script type="text/javascript" src='<%= Page.ResolveUrl("~/JavaScripts/jquery-1.4.4.js") %>'></script>

    <script type="text/javascript" src='<%= Page.ResolveUrl("~/JavaScripts/jquery.jqDock.min.js") %>'></script>

    <script type="text/javascript">
	    $(document).ready(function(){
	        $('#AboutUsDockPanel').jqDock();
        });
	</script>

</asp:Content>
<asp:Content ID="AboutUsContent" ContentPlaceHolderID="MasterContentPlaceHolder"
    runat="Server">
    <asp:Panel ID="AboutUsContentPanel" runat="server" Style='<%# "direction: ltr; text-align: justify; background-image: url(" + Page.ResolveUrl("~/images/misc/artmanlogo.png") + "); background-position: center; background-repeat: no-repeat; padding: 5px 5px 5px 5px; min-height: 551px" %>'>
        <asp:MultiView ID="AboutUsContentMultiView" runat="server">
            <asp:View ID="AboutArtmanView" runat="server">
                <strong><span style="color: #330099">This website is created by <span style="color: #ff6600">
                    Artman®</span> Company. <em>Artman Systems Inc.</em> has started to work since 2004
                    and has developed several desktop and web applications under the license of other
                    companies so far.<br />
                    <br />
                    Artman generally develops its applications using C/C++, Java™ SE/EE/ME, C#/VB/ASP
                    .NET, and Python as well as the related technologies and databases such as MS Access,
                    MS SQL Server, MYSQL, and Oracle DB.<br />
                    <br />
                    In the recent two years, Artman has been the manager and developer of Graphic and
                    Animation System, Computational Geometries Module, and Reporting System of AcuSolve™
                    and AcuConsole™ Software under the license of ACUSIM® Software Company.<br />
                    <br />
                    Payman Rowhani and Artin Rezaie are the co-founder and technical-lead of this company.
                    They received their BS degree in Software Engineering in 2009 from BIHE University.</span><br />
                </strong>
                <br />
                <span style="color: #cc0000; font-family: Courier New"><strong>
                    <br />
                    <span style="font-size: 12pt; font-family: Arial">Contact Info:</span></strong></span><ul>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:artmans@live.com">artmans@live.com</a> </strong></span></li>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:artmansoft@yahoo.com">artmansoft@yahoo.com</a> </strong></span></li>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:rowhani_payman@yahoo.com">rowhani_payman@yahoo.com</a> </strong></span>
                        </li>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:artin_r99@yahoo.com">artin_r99@yahoo.com</a> </strong></span></li>
                        <li><span style="color: Blue; font-family: Tahoma; font-size: 11pt;"><strong>Tel: +989171888432
                        </strong></span></li>
                    </ul>
            </asp:View>
            <asp:View ID="AboutDeveloperView" runat="server">
                <strong><span style="color: #330099">Payman Rowhani received his BS degree in Software
                    Engineering in 2009 from BIHE University. He has worked over 2 years for ACUSIM®
                    Software Co. as a python senior programmer and project manager of Graphic and Animation
                    System, Computational Geometries Module, and Reporting System of AcuSolve™ and AcuConsole™.<br />
                    <br />
                    He's quite experienced in C#/VB.NET, ASP.NET/HTML, SQL Server, JavaScript/Ajax,
                    and related technologies. He has also developed several academic and commercial
                    applications so far under C/C++, Java™ SE/EE/ME, C#/VB/ASP .NET, and Python programming
                    languages for both Windows and Linux platforms.
                    <br />
                    <br />
                    In 2004, he and his beloved fellow, Artin Rezaie, founded the <span style="color: #ff6600">
                        Artman®</span> Company. For several reasons, they have not yet succeded to improve
                    it. However, this dream may come true in near future.</span><br />
                </strong>
                <br />
                <span style="color: #cc0000; font-family: Courier New"><strong>
                    <br />
                    <span style="font-size: 12pt; font-family: Arial">Contact Info:</span></strong></span><ul>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:artmans@live.com">artmans@live.com</a> </strong></span></li>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:artmansoft@yahoo.com">artmansoft@yahoo.com</a> </strong></span></li>
                        <li><span style="color: #cc0000; font-family: Tahoma; font-size: 11pt;"><strong><a
                            href="mailto:rowhani_payman@yahoo.com">rowhani_payman@yahoo.com</a></strong></span></li>
                        <li><span style="font-size: 11pt; color: #cc0000; font-family: Tahoma"><strong></strong>
                        </span><span style="color: Blue; font-family: Tahoma; font-size: 11pt;"><strong>Tel:
                            +989171888432 </strong></span></li>
                    </ul>
            </asp:View>
            <asp:View ID="AboutFeaturesView" runat="server">
                <strong><span></span><span style="color: #330099">This website is mainly develped under
                    ASP.NET and MS SQL Server and tens of third-party web controls.<br />
                    <br />
                    <span style="font-family: Arial"><span style="color: #cc0000; font-size: 11pt;">Applied
                        Technologies:</span></span></span></strong><ul style="list-style-type: square">
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>ASP.NET/HTML along with C#.NET/VB.NET</span></strong>
                                </span></span></span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>SQL Server (both tables and stored procedures)</span></strong>
                                </span></span></span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>User Controls</span></strong> </span>
                            </span></span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>Web Services</span></strong> </span></span>
                            </span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>Third-Party Web Controls</span></strong>
                                </span></span></span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>JavaScript</span></strong> </span></span>
                            </span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>Ajax</span></strong> </span></span></span>
                            </span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>jQuery</span></strong> </span></span>
                            </span></span></span></li>
                            <li><span><span style="font-family: Courier New"><span><span style="font-size: 10pt">
                                <span style="color: #0000ff"><strong><span>Stylesheets</span></strong> </span></span>
                            </span></span></span></li>
                            <li><span></span><span style="color: #009999"><span style="font-family: Courier New">
                                <span><span style="font-size: 10pt"><strong><span style="color: #0000ff">User-defined
                                    Site-Maps, Master Page, Global Configuration and Caching</span></strong> </span>
                                </span></span></span></li>
                        </ul>
                <strong><span style="color: #330099"><span style="font-size: 11pt"><span style="color: #cc0000;
                    font-family: Arial">Admin and Normal User Features:</span> </span></span></strong>
                <ul style="list-style-type: square">
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Add/Remove/Update/View Users</span></strong>
                        </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Add/Remove/Update/View Shops</span></strong>
                        </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Add/Remove/Update/View Products</span></strong>
                        </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Add/Remove/Update/View/Move Product Categories</span></strong>
                        </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Add/Remove/Update/View/Move Advertisements</span></strong>
                        </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Add/Remove/Update/View Web Resources (including
                            source and non-source files)</span></strong> </span></span></span></span></span>
                    </span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Backup/Restore Website Files and Database
                            Tables</span></strong> </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Manage Layout and Panels</span></strong>
                        </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Review User Statistics and Utilize External
                            Gadgets (including weather forcasting, clock, calendar,currency exchange rate, gold
                            and coin price, and etc.)</span></strong> </span></span></span></span></span>
                    </span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Image Manager, File Manager, Rich Text Editor,
                            Source Code Highlighter</span></strong> </span></span></span></span></span></span>
                    </li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Review Latest News</span></strong> </span>
                    </span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Extensive usage of Ajax and Caching to improve
                            user experience</span></strong> </span></span></span></span></span></span></li>
                    <li><span><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Strong Error Handling</span></strong> </span>
                    </span></span></span></span></span></li>
                    <li><span><span><span style="font-family: Courier New"><span style="font-size: 10pt">
                        <span style="color: #0000ff"><strong><span>Cross-Browser Compatibility Support</span></strong>
                        </span></span></span></span></span></li>
                </ul>
            </asp:View>
        </asp:MultiView>
    </asp:Panel>
    <br />
    <asp:Panel HorizontalAlign="center" ID="AboutUsFooterPanel" runat="server">
        <div id="AboutUsDockPanel" style="text-align: center; margin-left: 160px; min-width: 20px;
            max-width: 400px; z-index: 9000;">
            <asp:HyperLink ID="AboutArtmanHyperLink" ImageUrl="~/Images/Misc/Artman.png" runat="server"
                NavigateUrl="~/Page/AboutUs.aspx?view=0" ToolTip="About Artman"></asp:HyperLink>
            <asp:HyperLink ID="AboutDeveloperHyperLink" ImageUrl="~/Images/Misc/Developer.png"
                runat="server" NavigateUrl="~/Page/AboutUs.aspx?view=1" ToolTip="About Developer"></asp:HyperLink>
            <asp:HyperLink ID="AboutFeaturesHyperLink" ImageUrl="~/Images/Misc/Features.png"
                runat="server" NavigateUrl="~/Page/AboutUs.aspx?view=2" ToolTip="About Market Features"></asp:HyperLink>
            <asp:HyperLink ID="MarketHyperLink" ImageUrl="~/Images/Misc/Market.png" runat="server"
                NavigateUrl="~/" ToolTip="Go to Market Home"></asp:HyperLink>
        </div>
        <br />
        <br />
        <span style="font-size: 10pt">Copyright© 2004-2011, Artman Systems Inc. All rights reserved.</span>
    </asp:Panel>
</asp:Content>

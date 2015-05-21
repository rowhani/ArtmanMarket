<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Gadgets.ascx.cs" Inherits="WebControls_Master_Gadgets" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%-- <%@ OutputCache Duration="600" VaryByParam="None" %> --%>
<div style="text-align: center; direction: rtl; font-family: Tahoma; font-size: 12px">
    <ajax:TabContainer ID="GadjetTabContainer1" runat="server" ActiveTabIndex="0" Width="200px"
        Style="direction: rtl; text-align: center;">
        <ajax:TabPanel ID="CurrencyTabPanel" runat="server" HeaderText="ارز" BackColor="white">
            <ContentTemplate>
                <!-- <div id='abzarak_curr' style='text-align: center'>

                    <script type='text/javascript' src='http://currency.abzarak.com/code.php?t=3&back=_00b0f0&color=_444&box=_FBF9E4&str=1111111100001001100000000000000000000000000000'></script>

                </div> -->
                <div id="abcToolsCurrency" style='text-align: center'>
                    <img src="http://abctools.ir/App_Themes/Default/img/1.gif" />

                    <script type='text/javascript' src='http://abctools.ir/Currency/Get2.aspx?m=0&c=1;4;5;2;3;6;7;8;9;10;11;12;13;14;&c1=9999FF&c2=FFFF99&c3=EEEEFF&c4=5555FF&w=183px'></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="GoldAndCoinTabPanel" runat="server" HeaderText="سکه" BackColor="white"
            Style="text-align: center">
            <ContentTemplate>
                <div id="abcToolsGold" style='text-align: center'>
                    <img src="http://abctools.ir/App_Themes/Default/img/1.gif" />

                    <script type='text/javascript' src='http://abctools.ir/Gold/Get2.aspx?m=0&c1=009900&c2=99FF99&c3=EEFFee&c4=000000&w=183px'></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="MobileTabPanel" runat="server" HeaderText="گوشي" BackColor="white">
            <ContentTemplate>
                <div id="abcToolsMobile" style='text-align: center'>
                    <img src="http://g.sefr.ir/Images/1.gif" />

                    <script type='text/javascript' src='http://g.sefr.ir/Mobile/Get.aspx?m=0&c=1&b=42;56;50;39;35;32;16;31;48;&c1=000000&c2=FFFFFF&c3=FFFFFF&c4=555555&w=183px'></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="NewsTabPanel" runat="server" HeaderText="اخبار" BackColor="white">
            <ContentTemplate>
                <div id="abcToolsNews" style='text-align: center'>
                    <img src="http://abctools.ir/App_Themes/Default/img/1.gif" />

                    <script type='text/javascript' src='http://abctools.ir/News/Get2.aspx?m=0&c=5&c1=FF9900&c2=000000&c3=FFFFFF&c4=000000&w=183px&t=3;8;11;&k='></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="RSSTabPanel" runat="server" HeaderText="خبرخوان" BackColor="white">
            <ContentTemplate>
                <div>
                    <style type="text/css">
                    .rssbox{ 
                        direction: rtl;
                        text-align: right;
                        width: 170px;
                        border: 1px solid #EDEDED;
                        padding: 5px;
                        background-color: #FFFFFF;
                        } 
                    .rsslink{
                        text-decoration: none;
                        font-family: tahoma, arial;
                        font-size: 9px;
                        color: ##000000;
                        line-height: 20px;
                        } 
                    </style>
                    <div class="rssbox">

                        <script language="javascript" src="http://www.armin3d.com/persian/webtools/rss/rss.php?rss=http%3A%2F%2Fwww.armin3d.com%2Fpersian%2Farticle%2Ffeed%2F&num=5"></script>

                    </div>
                </div>
            </ContentTemplate>
        </ajax:TabPanel>
    </ajax:TabContainer>
    <br />
    <div style='text-align: center; vertical-align: middle; width: 200px; height: 25px;
        font-weight: bold; background-color: Navy; color: White'>
        <marquee behavior="scroll" direction="right">

            <script type='text/javascript' language="javascript" src="http://www.armin3d.com/persian/webtools/quote/q1.php"></script>

        </marquee>
    </div>
    <br />
    <ajax:TabContainer ID="GadjetTabContainer2" runat="server" ActiveTabIndex="0" Width="200px"
        Style="direction: rtl; text-align: center">
        <ajax:TabPanel ID="WeatherTabPanel" runat="server" HeaderText="آب‌و‌هوا" BackColor="white">
            <ContentTemplate>
                <div style='text-align: center'>

                    <script type='text/javascript' src='http://weather.abzarak.com/code.php?x=3&back=&color=_000&c=IRXX0015'></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="ClockTabPanel" runat="server" HeaderText="ساعت" BackColor="white">
            <ContentTemplate>
                <div style='text-align: center'>

                    <script src="http://clock.abzarak.com?s=18" type="text/javascript"></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="CalendarTabPanel" runat="server" HeaderText="روزنما" BackColor="white">
            <ContentTemplate>
                <div id="abcToolsToday" style='text-align: center'>
                    <img src="http://abctools.ir/App_Themes/Default/img/1.gif" />

                    <script type='text/javascript' src='http://abctools.ir/Today/Get2.aspx?m=0&c1=FFFF55&c2=000000&c3=FFFFCC&c4=000000&w=183px'></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
        <ajax:TabPanel ID="PicOfDayTabPanel" runat="server" HeaderText="عکس روز" BackColor="white">
            <ContentTemplate>
                <div id="abcToolsPicOfDay" style='text-align: center'>
                    <img src="http://abctools.ir/App_Themes/Default/img/1.gif" />

                    <script type='text/javascript' src='http://abctools.ir/PicOfDay/Get2.aspx?m=0&c=2;4;6;7;&c1=E5E5E5&c2=787878&c3=FFFFFF&c4=000000&w=183px'></script>

                </div>
            </ContentTemplate>
        </ajax:TabPanel>
    </ajax:TabContainer>
    <br />
    <div style="text-align: center;">
        <style type="text/css">
        .mydetails
        {
            direction: rtl;
            color: #34ef6d;
            height: Auto;
            width: 195px;
            overflow: Auto;
            background-color: #000000;
            line-height: 20px;
            font-size: 12px;
            font-weight: bold;
            font-family: Tahoma;
            text-align: center;
            padding: 2px;      
        }
    </style>

        <script src="http://ParsToolBox.com/WebTools/UserDetails/" language="javascript"
            type='text/javascript'></script>

    </div>
</div>

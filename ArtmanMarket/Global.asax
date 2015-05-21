<%@ Application Language="C#" %>
<%@ Import Namespace="System.IO" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        /*Application["ShowUpperBanner"] = "Yes";
        Application["ShowGadgets"] = "Yes";
        Application["ShowAds"] = "Yes";
        Application["ShowStatistics"] = "Yes";
        Application["ShowLowerBanner"] = "Yes";*/
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        //Response.Redirect("~/Page/Errors/Error500.htm");
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

        Session["AUTH_USER"] = Request["AUTH_USER"];

        Application.Lock();
        Application["HitCounter"] = GetCounterValue();
        Application.UnLock();
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

        OnlineActiveUsers.OnlineUsersInstance.OnlineUsers.UpdateForUserLeave();
    }

    Int32 GetCounterValue()
    {
        string strPath = Server.MapPath("~/WebServices/HitCounter.txt");
        Int32 nCounter = 0;

        try
        {
            if (File.Exists(strPath))
            {
                StreamReader ctrFile = File.OpenText(strPath);
                string counterString = ctrFile.ReadLine().ToString();
                ctrFile.Close();

                nCounter = Convert.ToInt32(counterString);
            }
        }
        catch (Exception)
        {
            if (Application["HitCounter"] != null)
                return ((Int32)Application["HitCounter"]) + 1;
        }

        nCounter += 1;

        try
        {
            StreamWriter sw = new StreamWriter(new FileStream(strPath, FileMode.OpenOrCreate, FileAccess.Write));
            sw.WriteLine(nCounter.ToString());

            sw.Flush();
            sw.Close();
        }
        catch (Exception)
        {

        }

        return nCounter;
    }    
       
</script>


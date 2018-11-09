using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MainClass
/// </summary>
public class MainClass : System.Web.UI.Page
{
    public void method_signout()
    {
        Session.Remove("mySessionVar");
        Session.Remove("mySessionVar2");
        Response.Redirect("LogInPage.aspx");
    }

    public void method_launchmap()
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }

    public static string MyPassword
    {
        // I should encrypt this at some point
        get { return MyPassword; }
        set { MyPassword = "imawesome1!"; }
    }
}
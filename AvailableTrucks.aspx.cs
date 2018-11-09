using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AvailableTrucks : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {

        // when driver user name is drivers company name (Session["mySessionVar"])
        // when driver compid ID is driver (string)

        // when carrier user name is user name (Session["mySessionVar"])
        // when carrier compid ID is compid ID (Session["mySessionVar2"])

        lblusername.Text = (String)Session["mySessionVar"];
        
        if ((String)Session["mySessionVar2"] == null)
        {
            mytitle.Style.Add("display", "none");
        }
        else {
            lblcompid.Text = (String)Session["mySessionVar2"];
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }

    protected void OpenWindow(object sender, EventArgs e)
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }
}
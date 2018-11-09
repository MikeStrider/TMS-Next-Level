using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddPage : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
    }

    protected void DetailView_ItemUpdate(object sender, DetailsViewUpdatedEventArgs e)
    {
        if (e.AffectedRows == 1)
        {
            Response.Redirect("~/OrdersPage.aspx");
        }
    }

    protected void DetailView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
        {
            Response.Redirect("~/OrdersPage.aspx");
        }
    }



    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }
}
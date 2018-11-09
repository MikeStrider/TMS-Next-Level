using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class orders : MainClass
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

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string value = e.Row.Cells[8].Text;
            switch (value)
            {
                case "0":
                    HyperLink hyp = new HyperLink();
                    hyp.ID = "hypID";
                    hyp.NavigateUrl = "~/workerPostedLoads.aspx?id=" + e.Row.Cells[0].Text;
                    hyp.Text = "post load";
                    hyp.Attributes["class"] = "set3";
                    e.Row.Cells[8].Controls.Add(hyp);
                    break;
                case "1":
                    HyperLink hyp2 = new HyperLink();
                    hyp2.ID = "hypID";
                    hyp2.NavigateUrl = "~/workerPostedLoads.aspx?id=" + e.Row.Cells[0].Text + "&remove=1";
                    hyp2.Text = "remove post";
                    e.Row.Cells[8].Controls.Add(hyp2);
                    hyp2.Attributes["class"] = "set2";
                    break;
            }
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }
}

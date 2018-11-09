using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PositionHistory : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
        Label1.Text = Request.QueryString["name"];
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DateTime systemDate = DateTime.Now;
        DateTime currentTime = Convert.ToDateTime((TextBox2.Text));
        if (currentTime <= systemDate)
        {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da3 = new SqlDataAdapter("INSERT INTO Truck002 VALUES (@lastposition, @lastdateandtime, @truck, " + lblcompid.Text + ")", conn);
                da3.SelectCommand.Parameters.AddWithValue("@lastposition", TextBox1.Text);
                da3.SelectCommand.Parameters.AddWithValue("@lastdateandtime", TextBox2.Text);
                da3.SelectCommand.Parameters.AddWithValue("@truck", Label1.Text);
                DataSet ds3 = new DataSet();
                da3.Fill(ds3);
            }
            Response.Redirect("~/PositionHistory.aspx?name=" + Label1.Text);
        }
        else
        {
            Label3.Text = "Future Dates are not accepted.";
        }
    }

    protected void OpenWindow(object sender, EventArgs e)
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }
}
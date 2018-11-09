using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SetupAutoEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO AutoEmails VALUES (@email, @mins, @orderID, @lastSent)", conn);
            da2.SelectCommand.Parameters.AddWithValue("@email", TextBox1.Text);
            da2.SelectCommand.Parameters.AddWithValue("@mins", TextBox2.Text);
            da2.SelectCommand.Parameters.AddWithValue("@orderID", Request.QueryString["orderid"]);
            da2.SelectCommand.Parameters.AddWithValue("@lastSent", DateTime.Now.ToString());
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
        }
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
}
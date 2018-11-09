using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TruckDriver : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["driver"] == "brokered out")
            {
                TextBox1.Text = "";
            } else
            {
                TextBox1.Text = Request.QueryString["driver"];
            }
            Label1.Text = Request.QueryString["id"];
            Label3.Text = Request.QueryString["truck"];
            string x = Request.QueryString["truck"];
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("updateTruckDriver", conn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@id", Label1.Text);
            da.SelectCommand.Parameters.AddWithValue("@adriver", TextBox1.Text);
            da.SelectCommand.Parameters.AddWithValue("@atruck", RadioButtonList2.SelectedValue);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }


    protected void Button5_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("updateTruckDriver", conn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.AddWithValue("@id", Label1.Text);
            da.SelectCommand.Parameters.AddWithValue("@adriver", "brokered out");
            da.SelectCommand.Parameters.AddWithValue("@atruck", RadioButtonList3.SelectedValue);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports : MainClass
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

    protected void FilterDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataSourceID = "SqlDataSource1";
        Label2.BackColor = System.Drawing.Color.Lavender;
        Label3.BackColor = System.Drawing.Color.White;
        Label4.BackColor = System.Drawing.Color.White;
        Label5.BackColor = System.Drawing.Color.White;
        Label7.BackColor = System.Drawing.Color.White;
        DropDownList2.SelectedIndex = 0;

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(orders.id) AS Expr2 FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE(orders.pickuplocation = '" + DropDownList1.SelectedValue + "') AND (orders.compid = '" + lblcompid.Text + "')", conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            Label6.Text = "Total rows retrieved: " + TotalRows.ToString();
        }
    }

    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataSourceID = "SqlDataSource2";
        Label3.BackColor = System.Drawing.Color.Lavender;
        Label2.BackColor = System.Drawing.Color.White;
        Label4.BackColor = System.Drawing.Color.White;
        Label5.BackColor = System.Drawing.Color.White;
        Label7.BackColor = System.Drawing.Color.White;
        DropDownList1.SelectedIndex = 0;

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(orders.id) AS Expr1 FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE(orders.bookedby = '" + DropDownList2.SelectedValue + "') AND (orders.compid = '" + lblcompid.Text + "')", conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            Label6.Text = "Total rows retrieved: " + TotalRows.ToString();
        }
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        GridView1.DataSourceID = "SqlDataSource3";
        Label3.BackColor = System.Drawing.Color.White;
        Label2.BackColor = System.Drawing.Color.White;
        Label5.BackColor = System.Drawing.Color.White;
        Label4.BackColor = System.Drawing.Color.Lavender;
        Label7.BackColor = System.Drawing.Color.White;
        DropDownList2.SelectedIndex = 0;
        DropDownList1.SelectedIndex = 0;

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(id) AS Expr1 FROM orders WHERE compid = " + lblcompid.Text, conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            Label6.Text = "Total rows retrieved: " + TotalRows.ToString();
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        GridView1.DataSourceID = "SqlDataSource_BillToCustomer";
        Label2.BackColor = System.Drawing.Color.White;
        Label3.BackColor = System.Drawing.Color.White;
        Label4.BackColor = System.Drawing.Color.White;
        Label5.BackColor = System.Drawing.Color.Lavender;
        Label7.BackColor = System.Drawing.Color.White;
        DropDownList2.SelectedIndex = 0;
        DropDownList1.SelectedIndex = 0;

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(ordernumber) AS Expr1 FROM Billing WHERE(billto = '" + TextBox1.Text + "') and compid = " + lblcompid.Text, conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            Label6.Text = "Total rows retrieved: " + TotalRows.ToString();
        }
    }

    protected void SqlDataSource3_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

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

    protected void Button3_Click(object sender, EventArgs e)
    {
        GridView1.DataSourceID = "SqlDataSource4";
        Label2.BackColor = System.Drawing.Color.White;
        Label3.BackColor = System.Drawing.Color.White;
        Label4.BackColor = System.Drawing.Color.White;
        Label5.BackColor = System.Drawing.Color.White;
        Label7.BackColor = System.Drawing.Color.Lavender;
        DropDownList2.SelectedIndex = 0;
        DropDownList1.SelectedIndex = 0;
        txtToDate.Text = txtToDate.Text + " 23:59";

        try
        {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(id) AS Expr1 FROM orders WHERE(compid = " + lblcompid.Text + ") AND (pickupdateandtime >= '" + txtFromDate.Text + "') AND (pickupdateandtime <= '" + txtToDate.Text + "')", conn);
                conn.Open();
                int TotalRows = (int)cmd.ExecuteScalar();
                Label6.Text = "Total rows retrieved: " + TotalRows.ToString();
            }
        }
        catch
        {
            string x = txtToDate.Text;
            x = x.Substring(0, x.Length - 6);
            txtToDate.Text = x;
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(id) AS Expr1 FROM orders WHERE(compid = " + lblcompid.Text + ") AND (pickupdateandtime >= '" + txtFromDate.Text + "') AND (pickupdateandtime <= '" + txtToDate.Text + "')", conn);
                conn.Open();
                int TotalRows = (int)cmd.ExecuteScalar();
                Label6.Text = "Total rows retrieved: " + TotalRows.ToString();
            }
        }


    }
    
    protected void txtToDate_TextChanged(object sender, EventArgs e)
    {

    }
}
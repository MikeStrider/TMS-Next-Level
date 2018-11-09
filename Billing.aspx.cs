using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using System.IO;

public partial class Billing : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;

        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
        if (Request.QueryString["id"] != null)
        {

            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET tcposted = 'y' WHERE ordernumber = " + Request.QueryString["id"], conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }

        if (Request.QueryString["idpaid"] != null)
        {
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paid = 'y' WHERE ordernumber = " + Request.QueryString["idpaid"], conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }
        if (Request.QueryString["iddp"] != null)
        {
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET dpposted = 'y' WHERE ordernumber = " + Request.QueryString["iddp"], conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }

        if (!IsPostBack)
        {
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT invoicefooter FROM companyinfo WHERE compid = " + lblcompid.Text, conn);
                conn.Open();
                txtFooter.Text = (string)cmd.ExecuteScalar();
                SqlCommand cmd2 = new SqlCommand("SELECT invoiceouraddress FROM companyinfo WHERE compid = " + lblcompid.Text, conn);
                txtAddress.Text = (string)cmd2.ExecuteScalar();
            }
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv["tcposted"].ToString().Equals("y"))
            {
                e.Row.Cells[4].ForeColor = Color.Green;
                HyperLink HyperLink1 = (HyperLink)e.Row.FindControl("HyperLink1");
                HyperLink1.Enabled = false;
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv["paid"].ToString().Equals("y"))
            {
                e.Row.Cells[5].ForeColor = Color.Green;
                HyperLink HyperLink2 = (HyperLink)e.Row.FindControl("HyperLink2");
                HyperLink2.Enabled = false;
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv["dpposted"].ToString().Equals("y"))
            {
                e.Row.Cells[7].ForeColor = Color.Green;
                HyperLink HyperLink3 = (HyperLink)e.Row.FindControl("HyperLink3");
                HyperLink3.Enabled = false;
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv["dpposted"].ToString().Equals("y") && drv["paid"].ToString().Equals("y") && drv["tcposted"].ToString().Equals("y"))
            {
                e.Row.Cells[8].ForeColor = Color.Green;
                HyperLink HyperLink4 = (HyperLink)e.Row.FindControl("HyperLink4");
                HyperLink4.Enabled = false;

                LinkButton LinkButton1 = (LinkButton)e.Row.FindControl("LinkButton1");
                LinkButton1.Enabled = false;
                string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(CS))
                {
                    Label Label1 = (Label)e.Row.FindControl("Label1");
                    SqlDataAdapter da = new SqlDataAdapter("UPDATE orders SET status = 'posted' WHERE id = " + drv["ordernumber"], conn);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                }
            }
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string query = "SELECT orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.bookedby, orders.status, DispatchTable.truck, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE(orders.status = 'posted' and orders.compid = " + lblcompid.Text + ") ORDER BY orders.id";
        string connectionSql = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        StreamWriter myFile = new StreamWriter(Server.MapPath("~/BatchFiles/Export-" + lblcompid.Text + "_" + DateTime.Now.ToString("MM-dd-yyyy_HH;mm;ss") + ".txt"));

        //FileUpload1.SaveAs(Server.MapPath("~/Paperwork/" + ListBox1.SelectedValue + "-paperworkfile_1_.png"));

        using (SqlConnection connection = new SqlConnection(connectionSql))
        {
            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            myFile.WriteLine(String.Format("{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11}, {12}, {13}, {14}, {15}, {16}", "Status", "Order Number", "Pick Up Location", "Drop Off Location", "Booked By", "Truck No.", "Driver's Name", "Pick Up Scheduled", "Pick Up Arrive Time", "Pick Up Loaded", "Drop Off Scheduled", "Drop Off Arrive Time", "Drop Off Empty", "Bill To Customer", "Total Charges", "Driver Pay", "Paperwork"));
            try
            {
                while (reader.Read())
                {
                    myFile.WriteLine(String.Format("{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}, {11}, {12}, {13}, {14}, {15}, {16}",
                    reader["status"], reader["id".ToString()], reader["pickuplocation"], reader["dropofflocation"], reader["bookedby"], reader["truck"], reader["driver"], reader["pickupdateandtime"], reader["actualpickup"], reader["loaded"], reader["dropoffdateandtime"], reader["actualdropoff"], reader["empty"], reader["billto"], reader["totalcharges"], reader["driverpay"], reader["paperwork"]));
                }
            }
             finally
            {
                reader.Close();
                myFile.Close();
            }
        }

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(id) AS Expr1 FROM orders WHERE(status = 'posted' and orders.compid = " + lblcompid.Text + ")", conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            Label2.Text = "Batch File Created with " + TotalRows.ToString() + " orders.";
        }

        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE orders SET status = 'exported' WHERE status = 'posted'", conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
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

    protected void Button2_Click(object sender, EventArgs e)
    {
        string fileName = FileUpload1.FileName;
        FileUpload1.SaveAs(Server.MapPath("~/logos/" + lblcompid.Text + "-logo.png"));
        Response.Write("<script>alert('Invoice changes have been made. Company Logo has been updated.');</script>");
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE companyinfo SET invoicefooter = @invoicefooter, invoiceouraddress = @invoiceouraddress WHERE compid = " + lblcompid.Text, conn);
            da.SelectCommand.Parameters.AddWithValue("@invoicefooter", txtFooter.Text);
            da.SelectCommand.Parameters.AddWithValue("@invoiceouraddress", txtAddress.Text);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
        Response.Write("<script>alert('Invoice changes have been made. T and C text updated. Company Address updated.');</script>");
    }
}
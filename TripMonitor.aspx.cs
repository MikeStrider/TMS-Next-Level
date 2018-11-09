using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Drawing;

public partial class TripMonitor : MainClass 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LogInPage.aspx");
        }
        Label13.Text = DateTime.Now.ToString("MM/dd/yyyy HH:mm");

        if (Request.QueryString["id"] != null)
        {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("moveToDispatch2", conn);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                da.SelectCommand.Parameters.AddWithValue("@orderID", Request.QueryString["id"]);
                da.SelectCommand.Parameters.AddWithValue("@compid", lblcompid.Text);
                DataSet ds = new DataSet();
                da.Fill(ds);

                SqlDataAdapter da2 = new SqlDataAdapter("updateStatus", conn);
                da2.SelectCommand.CommandType = CommandType.StoredProcedure;
                da2.SelectCommand.Parameters.AddWithValue("@orderID", Request.QueryString["id"]);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2);

                SqlDataAdapter da3 = new SqlDataAdapter("UPDATE orders SET Posted = '0' WHERE id = " + Request.QueryString["id"], conn);
                DataSet ds3 = new DataSet();
                da3.Fill(ds3);
            }
        }
    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }


    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HyperLink HyperLink2 = (HyperLink)e.Item.FindControl("HyperLink2");
            Label actualpickupLabel = (Label)e.Item.FindControl("actualpickupLabel");
            Label Label8 = (Label)e.Item.FindControl("Label8");
            Label Label9 = (Label)e.Item.FindControl("Label9");
            Label Label10 = (Label)e.Item.FindControl("Label10");
            Label Label11 = (Label)e.Item.FindControl("Label11");
            Label Label2 = (Label)e.Item.FindControl("Label2");
            Label ordernumberlabel = (Label)e.Item.FindControl("ordernumberlabel");
            Label Label3 = (Label)e.Item.FindControl("Label3");
            System.Web.UI.WebControls.Image Image3 = (System.Web.UI.WebControls.Image)e.Item.FindControl("Image3");
            HyperLink lastpositionlabel = (HyperLink)e.Item.FindControl("lastpositionlabel");
            if (actualpickupLabel.Text == "")
            {
                HyperLink2.Enabled = false;
                Label8.Visible = false;
                Label9.Visible = false;
                Label2.Visible = false;
            }
            else
            {
                Label10.Visible = false;
                Label11.Visible = false;
                Label3.Visible = false;
            }

            if (lastpositionlabel.Text == "plz select a truck")
            {
                lastpositionlabel.Enabled = false;
            }
            
            // DISPLAY ICON FOR AUTO EMAIL PREVIOUS SETUP
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM AutoEmails WHERE orderID = " + ordernumberlabel.Text, conn);
                conn.Open();
                int TotalRows = (int)cmd.ExecuteScalar();
                if (TotalRows > 0)
                {
                    Image3.Visible = true;
                }
            }

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
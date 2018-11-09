using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Trucks : MainClass
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

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv["name"].ToString().Equals("no truck"))
            {
                HyperLink HyperLink3 = (HyperLink)e.Row.FindControl("HyperLink3");
                HyperLink3.Enabled = false;
                LinkButton LinkButton2 = (LinkButton)e.Row.FindControl("LinkButton2");
                LinkButton2.Enabled = false;
                LinkButton LinkButton1 = (LinkButton)e.Row.FindControl("LinkButton1");
                LinkButton1.Enabled = false;

            }
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void lbInsert_Click(object sender, EventArgs e)
    {
        SqlDataSource1.InsertParameters["name"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("txtName")).Text;
        SqlDataSource1.InsertParameters["trucktype"].DefaultValue = ((DropDownList)GridView1.FooterRow.FindControl("DropDownList1")).SelectedValue;
        SqlDataSource1.InsertParameters["licencesplate"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("txtplate")).Text;
        SqlDataSource1.InsertParameters["dateacquired"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("txtacquired")).Text;

        SqlDataSource1.Insert();

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da3 = new SqlDataAdapter("INSERT INTO Truck002 VALUES (@lastposition, @lastdateandtime, @name, " + lblcompid.Text + ")", conn);
            da3.SelectCommand.Parameters.AddWithValue("@lastposition", "default place holder");
            da3.SelectCommand.Parameters.AddWithValue("@lastdateandtime", "1900/01/01");
            da3.SelectCommand.Parameters.AddWithValue("@name", ((TextBox)GridView1.FooterRow.FindControl("txtName")).Text);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
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

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        map.Style["height"] = txtSetHeight.Text;
        map.Style["width"] = "100%";
    }

    protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
    {

    }

    protected void Button3_Click(object sender, EventArgs e)
    {

    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }

    protected void LinkButton1_Click1(object sender, EventArgs e)
    {

    }
}
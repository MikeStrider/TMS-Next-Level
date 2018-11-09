using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            conn.Open();

            var cmd = new SqlCommand();
            cmd.CommandText = "Select * from companyinfo";
            cmd.Connection = conn;
            var reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    if (reader.GetSqlValue(0).ToString() == lblcompid.Text)
                    {

                    }
                    else
                    {
                        ListBox1.Items.Add(reader.GetSqlValue(1).ToString());
                    }

                }
            }

            reader.Close();

            cmd.CommandText = "Select companyname, fullname from driverinfo";
            cmd.Connection = conn;
            reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    ListBox1.Items.Add(reader.GetSqlValue(0).ToString() + " - " + reader.GetSqlValue(1).ToString());
                }
            }
            reader.Close();
            conn.Close();
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        lbl_carrierdriver.Text = ListBox1.SelectedValue;
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        try
        {
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("SELECT AVG(rating.rating) AS Expr1 FROM rating WHERE(ratingto = @name)", conn);
                cmd.Parameters.AddWithValue("@name", lbl_carrierdriver.Text);
                conn.Open();
                int TotalRows = (int)cmd.ExecuteScalar();
                lbl_currentrating.Text = TotalRows.ToString();
            }
        }
        catch
        {
            lbl_currentrating.Text = "unrated";
        }
    }


    protected void OpenWindow(object sender, EventArgs e)
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {

            SqlDataAdapter da2 = new SqlDataAdapter(" DELETE FROM rating WHERE (ratingfrom = @ratingfrom AND ratingto = @ratingto)", conn);
            da2.SelectCommand.Parameters.AddWithValue("@ratingfrom", lblcompid.Text);
            da2.SelectCommand.Parameters.AddWithValue("@ratingto", lbl_carrierdriver.Text);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            SqlDataAdapter da3 = new SqlDataAdapter("INSERT INTO rating VALUES (@ratingfrom, @ratingto, @rating, @comments)", conn);
            da3.SelectCommand.Parameters.AddWithValue("@ratingfrom", lblcompid.Text);
            da3.SelectCommand.Parameters.AddWithValue("@ratingto", lbl_carrierdriver.Text);
            da3.SelectCommand.Parameters.AddWithValue("@rating", Request.Form["example1"]);
            da3.SelectCommand.Parameters.AddWithValue("@comments", TextBox1.Text);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
        }
        Response.Redirect("RatePeople.aspx");

    }

    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {

    }

    protected void TextBox2_TextChanged(object sender, EventArgs e)
    {

    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
}
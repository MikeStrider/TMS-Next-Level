using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditCarrier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            conn.Open();
            var cmd = new SqlCommand();
            cmd.CommandText = "SELECT name, email, phonenumber FROM companyinfo WHERE compid = " + (String)Session["mySessionVar2"];
            cmd.Connection = conn;
            var reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    TextBox1.Text = reader["phonenumber"].ToString();
                    TextBox2.Text = reader["email"].ToString();
                    Label3.Text = reader["name"].ToString();
                }
            }

            reader.Close();
            conn.Close();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da2 = new SqlDataAdapter("UPDATE companyinfo SET email = @email, phonenumber = @phonenumber WHERE compid = " + (String)Session["mySessionVar2"], conn);
            da2.SelectCommand.Parameters.AddWithValue("@phonenumber", TextBox1.Text);
            da2.SelectCommand.Parameters.AddWithValue("@email", TextBox2.Text);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
        }
        Response.Redirect("OrdersPage.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("INSERT INTO Notifications (name, emailurl, compid, companyName) VALUES (@name, @emailurl, " + (String)Session["mySessionVar2"] + ", @companyName)", conn);
            da.SelectCommand.Parameters.AddWithValue("@emailurl", TextBox3.Text);
            da.SelectCommand.Parameters.AddWithValue("@name", TextBox4.Text);
            da.SelectCommand.Parameters.AddWithValue("@companyName", TextBox8.Text);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
        Response.Write("<script>alert('New Contact Created');</script>");
        Response.Redirect("~/EditCarrier.aspx");
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("INSERT INTO Notifications (name, emailurl, username, password, compid, companyName) VALUES " +
                                                                             "('EDI', @emailurl, @username, @password, " + (String)Session["mySessionVar2"] + ", @companyName)", conn);
            da.SelectCommand.Parameters.AddWithValue("@emailurl", TextBox5.Text);
            da.SelectCommand.Parameters.AddWithValue("@username", TextBox6.Text);
            da.SelectCommand.Parameters.AddWithValue("@password", TextBox7.Text);
            da.SelectCommand.Parameters.AddWithValue("@companyName", TextBox9.Text);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
        Response.Write("<script>alert('New EDI Created');</script>");
        Response.Redirect("~/EditCarrier.aspx");
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("OrdersPage.aspx");
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
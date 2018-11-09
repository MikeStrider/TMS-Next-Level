using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewDriver : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            conn.Open();
            var cmd = new SqlCommand();
            cmd.CommandText = "SELECT * FROM driverinfo WHERE (userid = '" + Request.QueryString["id"] + "')";
            cmd.Connection = conn;
            var reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    txtuserid.Text = reader["userid"].ToString();
                    txtfullname.Text = reader["fullname"].ToString();
                    txtcompanyname.Text = reader["companyname"].ToString();
                    txttruckno.Text = reader["truckno"].ToString();
                    txtlocation.Text = reader["location"].ToString();
                    txtdate.Text = reader["date"].ToString();
                    txttrucktype.Text = reader["trucktype"].ToString();
                    txtlxwxh.Text = reader["lxwxh"].ToString();
                    txtemail.Text = reader["email"].ToString();
                    txtcomments.Text = reader["comments"].ToString();
                    txtphoneno.Text = reader["phoneno"].ToString();
                    var x = reader["available"].ToString();
                    if (x == "1")
                    {
                        Image1.ImageUrl = "Images/avail.png";
                    }
                    else
                    {
                        Image1.ImageUrl = "Images/notavail.png";
                    }
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtcomments.Text == "" || txtpassword.Text == "" || txtfullname.Text == "" || txtcompanyname.Text == "" || txttruckno.Text == "" || txtlocation.Text == "" || txtdate.Text == "" || txttrucktype.Text == "" || txtlxwxh.Text == "" || txtemail.Text == "" || txtphoneno.Text == "")
        {
            lblvalication.Text = "Please enter all fields / including the Password";
            lblvalication.Visible = true;
            ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel()", true);
        }
        else
        {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da3 = new SqlDataAdapter("UPDATE driverinfo SET password = @password, fullname = @fullname, available = '1', comments = @comments, companyname = @companyname, truckno = @truckno, location = @location, date = @date, trucktype = @trucktype, lxwxh = @lxwxh, email = @email, phoneno = @phoneno WHERE userid = @userid", conn);
                da3.SelectCommand.Parameters.AddWithValue("@comments", txtcomments.Text);
                da3.SelectCommand.Parameters.AddWithValue("@userid", txtuserid.Text);
                da3.SelectCommand.Parameters.AddWithValue("@password", txtpassword.Text);
                da3.SelectCommand.Parameters.AddWithValue("@fullname", txtfullname.Text);
                da3.SelectCommand.Parameters.AddWithValue("@companyname", txtcompanyname.Text);
                da3.SelectCommand.Parameters.AddWithValue("@truckno", txttruckno.Text);
                da3.SelectCommand.Parameters.AddWithValue("@location", txtlocation.Text);
                da3.SelectCommand.Parameters.AddWithValue("@date", txtdate.Text);
                da3.SelectCommand.Parameters.AddWithValue("@trucktype", txttrucktype.Text);
                da3.SelectCommand.Parameters.AddWithValue("@lxwxh", txtlxwxh.Text);
                da3.SelectCommand.Parameters.AddWithValue("@email", txtemail.Text);
                da3.SelectCommand.Parameters.AddWithValue("@phoneno", txtphoneno.Text);
                DataSet ds3 = new DataSet();
                da3.Fill(ds3);
            }
            Response.Redirect("AvailableTrucks.aspx");
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        if (txtcomments.Text == "" || txtpassword.Text == "" || txtfullname.Text == "" || txtcompanyname.Text == "" || txttruckno.Text == "" || txtlocation.Text == "" || txtdate.Text == "" || txttrucktype.Text == "" || txtlxwxh.Text == "" || txtemail.Text == "" || txtphoneno.Text == "")
        {
            lblvalication.Text = "Please enter all fields / including the Password";
            lblvalication.Visible = true;
            ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel()", true);
        } else
        {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da3 = new SqlDataAdapter("UPDATE driverinfo SET password = @password, fullname = @fullname, available = '0', comments = @comments, companyname = @companyname, truckno = @truckno, location = @location, date = @date, trucktype = @trucktype, lxwxh = @lxwxh, email = @email, phoneno = @phoneno WHERE userid = @userid", conn);
                da3.SelectCommand.Parameters.AddWithValue("@comments", txtcomments.Text);
                da3.SelectCommand.Parameters.AddWithValue("@userid", txtuserid.Text);
                da3.SelectCommand.Parameters.AddWithValue("@password", txtpassword.Text);
                da3.SelectCommand.Parameters.AddWithValue("@fullname", txtfullname.Text);
                da3.SelectCommand.Parameters.AddWithValue("@companyname", txtcompanyname.Text);
                da3.SelectCommand.Parameters.AddWithValue("@truckno", txttruckno.Text);
                da3.SelectCommand.Parameters.AddWithValue("@location", txtlocation.Text);
                da3.SelectCommand.Parameters.AddWithValue("@date", txtdate.Text);
                da3.SelectCommand.Parameters.AddWithValue("@trucktype", txttrucktype.Text);
                da3.SelectCommand.Parameters.AddWithValue("@lxwxh", txtlxwxh.Text);
                da3.SelectCommand.Parameters.AddWithValue("@email", txtemail.Text);
                da3.SelectCommand.Parameters.AddWithValue("@phoneno", txtphoneno.Text);
                DataSet ds3 = new DataSet();
                da3.Fill(ds3);
            }
            Response.Redirect("AvailableTrucks.aspx");
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("AvailableTrucks.aspx");
    }
}
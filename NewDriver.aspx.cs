using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class NewDriver : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
        using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from driverinfo WHERE userid = @userid", conn))
        {
            conn.Open();
            sqlCommand.Parameters.AddWithValue("@userid", txtuserid.Text);
            int userCount = (int)sqlCommand.ExecuteScalar();
            if (userCount > 0)
            {
                lblvalidation.Visible = true;
                lblvalidation.Text = "User Already Exists";
                ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel()", true);
            }
            else
            {
                if (txtcomments.Text == "" || txtpassword.Text == "" || txtfullname.Text == "" || txtcompanyname.Text == "" || txttruckno.Text == "" || txtlocation.Text == "" || txtdate.Text == "" || txttrucktype.Text == "" || txtlxwxh.Text == "" || txtemail.Text == "" || txtphoneno.Text == "")
                {
                    lblvalidation.Text = "Please enter all fields";
                    lblvalidation.Visible = true;
                    ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel()", true);
                }
                else
                {
                    string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
                    SqlConnection conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);

                    SqlDataAdapter da3 = new SqlDataAdapter("INSERT INTO driverinfo VALUES (@userid, @password, @fullname, @companyname, @truckno, @location, @date, 'none', '0', @trucktype, @lxwxh, @email, @phoneno, @comments)", conn2);
                    da3.SelectCommand.Parameters.AddWithValue("@userid", txtuserid.Text);
                    da3.SelectCommand.Parameters.AddWithValue("@comments", txtcomments.Text);
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
                    Response.Redirect("LogInPage.aspx");
                }
            }
        }

        using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", txtemail.Text))
        {
            mm.Subject = "Welcome to TMS Next Level";
            mm.Body = "Welcome to TMS Next Level. <br> Your Driver ID is <b>" + txtuserid.Text + "</b>. You can login at mstrong.tk or the mobile app.";
            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential("mike.strong28@gmail.com", MainClass.MyPassword);
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
        }
        Response.Redirect("LoginPage.aspx");


    }
}
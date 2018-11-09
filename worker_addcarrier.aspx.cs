using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;

public partial class worker_addcarrier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
        SqlCommand sqlCommand = new SqlCommand("SELECT * from admin", conn);
        var x = "sdf";
        conn.Open();
        var reader = sqlCommand.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                x = reader["master"].ToString();
            }
        }
        reader.Close();
        conn.Close();

        if (x == Request.QueryString["extrafield"])
        {
            int lastCompID;

            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (conn)
            {
                SqlCommand cmd = new SqlCommand("SELECT Max(compid) FROM companyinfo;", conn);
                conn.Open();
                lastCompID = (int)cmd.ExecuteScalar();
                lastCompID = lastCompID + 3;

                SqlDataAdapter da = new SqlDataAdapter("INSERT INTO companyinfo VALUES (@compid, @name, @password, @email, 'default footer', 'defaultouraddress', 'missing')", conn);
                da.SelectCommand.Parameters.AddWithValue("@compid", lastCompID);
                da.SelectCommand.Parameters.AddWithValue("@name", Request.QueryString["name"]);
                da.SelectCommand.Parameters.AddWithValue("@password", Request.QueryString["password"]);
                da.SelectCommand.Parameters.AddWithValue("@email", Request.QueryString["email"]);
                DataSet ds = new DataSet();
                da.Fill(ds);

                SqlDataAdapter da1 = new SqlDataAdapter("INSERT INTO Trucks VALUES ('no truck', '', '', 'unknown', @compid, '0', '', '10')", conn);
                da1.SelectCommand.Parameters.AddWithValue("@compid", lastCompID);
                DataSet ds1 = new DataSet();
                da1.Fill(ds1);

                SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO Truck002 VALUES ('plz select a truck', '01/01/1900', 'no truck', @compid)", conn);
                da2.SelectCommand.Parameters.AddWithValue("@compid", lastCompID);
                DataSet ds2 = new DataSet();
                da2.Fill(ds2);
            }


            using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", Request.QueryString["email"]))
            {
                mm.Subject = "Welcome to TMS Next Level";
                mm.Body = "Welcome to TMS Next Level. <br> Your Company ID is <b>" + lastCompID + "</b>. You can login at mstrong.tk.";
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
        else
        {
            Response.Write("Operation Has Failed Critially. Please go back and enter the correct Master Password. Account was NOT created.");
        }   
    }
}
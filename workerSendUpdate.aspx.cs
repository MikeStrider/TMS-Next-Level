using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class workerSendUpdate : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Request.QueryString["orderid"];
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string carrierName = "nothing";
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
        conn.Open();
        var cmd = new SqlCommand();
        cmd.CommandText = "SELECT name FROM companyinfo WHERE compid = '" + (String)Session["mySessionVar2"] + "'";
        cmd.Connection = conn;
        var reader = cmd.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                carrierName = reader["name"].ToString();
            }
        }
        reader.Close();
        conn.Close();
        using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", TextBox1.Text))
        {
            mm.Subject = "Load Update from " + carrierName + ". Order " + Label1.Text + ".";
            mm.Body = "Load Update for order " + Label1.Text + "." + System.Environment.NewLine +
                carrierName + System.Environment.NewLine +
                " Scheduled Pick Up : " + Request.QueryString["pickup"] + System.Environment.NewLine +
                " Scheduled Drop Off : " + Request.QueryString["drop"] + System.Environment.NewLine +
                " >> Truck : " + Request.QueryString["truck"] + System.Environment.NewLine +
                " >> Driver : " + Request.QueryString["driver"] + System.Environment.NewLine +
                " >> Last Update was from : " + Request.QueryString["time"] + System.Environment.NewLine +
                " >> Location : " + Request.QueryString["location"];
            mm.IsBodyHtml = false;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential("mike.strong28@gmail.com", MainClass.MyPassword);
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
        }
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/TripMonitor.aspx");
    }
}
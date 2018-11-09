using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.IO;

public partial class LogLoaded : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Label1.Text = Request.QueryString["id"];
        Label2.Text = Request.QueryString["schtime"];
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        // ADD NEW TIMES TO THE DB
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da2 = new SqlDataAdapter("UPDATE DispatchTable SET loaded = @loaded, actualpickup = @actualpickup WHERE ordernumber = " + Label1.Text, conn);
            da2.SelectCommand.Parameters.AddWithValue("@loaded", TextBox2.Text);
            da2.SelectCommand.Parameters.AddWithValue("@actualpickup", TextBox1.Text);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
        }

        // IF NOTIFICATION IS AN EDI
        if (RadioButtonList1.SelectedValue.Contains("EDI"))
        {
            string createText = "ORD*" + Label1.Text + "*214*Arrive and Empty~" + Environment.NewLine +
                          "N0*" + Label2.Text + "~" + Environment.NewLine +
                          "N1*" + TextBox1.Text + "~" + Environment.NewLine +
                          "N2*" + TextBox2.Text + "~";
            File.WriteAllText(Server.MapPath("~/EDI/testfile.txt"), createText);
            WebClient client = new WebClient();

            string ftpPassword = "nothing";
            string ftpUserName = "nothing";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            conn.Open();
            var cmd = new SqlCommand();
            cmd.CommandText = "SELECT username, password FROM Notifications WHERE emailurl = '" + RadioButtonList1.SelectedValue + "'";
            cmd.Connection = conn;
            var reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    ftpUserName = reader["username"].ToString();
                    ftpPassword = reader["password"].ToString();
                }
            }
            reader.Close();
            conn.Close();
            client.Credentials = new NetworkCredential(ftpUserName, ftpPassword);
            // NOTE * RadioButtonList1.SelectedValue includes the ftp and the folder path 
            client.UploadFile(RadioButtonList1.SelectedValue + Label1.Text + "-" + DateTime.Now.ToString("MM-dd-yyyy-HH:mm:ss") + ".txt", Server.MapPath("~/EDI/testfile.txt"));
        }
        else
        {
            // IF EMAIL SELECTED AS NOTIFICATION
            using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", RadioButtonList1.SelectedValue))
            {
                mm.Subject = "Order " + Label1.Text + " has Loaded";
                mm.Body = "The following order has loaded and left the pickup location." + System.Environment.NewLine +
                    Label1.Text + System.Environment.NewLine +
                    " >> Scheduled Time : " + Label2.Text + System.Environment.NewLine +
                    " >> Arrived at " + TextBox1.Text + System.Environment.NewLine +
                    " >> Loaded at " + TextBox2.Text;
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
        }
        Response.Redirect("~/TripMonitor.aspx");
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/TripMonitor.aspx");
    }
}
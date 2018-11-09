using Hangfire;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HangfireTesting
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)   // fire and forget
        {
            BackgroundJob.Enqueue<EmailSender>(x => x.Send("Fire and Forget Job Executed")); 
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email Sent as a background task.');", true);
        }

        protected void Button2_Click(object sender, EventArgs e)   // start the reoccuring job
        {
            RecurringJob.AddOrUpdate<EmailSender>("IDSendingEmail", x => x.Send("Recurring Job Executed"), Cron.Minutely);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Reoccurring Job started.  Will send email every 1 min.');", true);
        }

        protected void Button3_Click(object sender, EventArgs e)  // stop the reoccuring job
        {
            RecurringJob.RemoveIfExists("IDSendingEmail");
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Reoccurring Job stopped.');", true);
        }

        protected void Button4_Click(object sender, EventArgs e)    // Run a delayed job at a set time
        {
            BackgroundJob.Schedule<EmailSender>(x => x.Send("Scheduled Job Executed"), TimeSpan.FromMinutes(3));
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Scheduled Job will run 3 mins from now.');", true);
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            DateTime whatsEntered = new DateTime();
            whatsEntered = DateTime.ParseExact(TextBox1.Text, "MM/dd/yyyy HH:mm", null);

            BackgroundJob.Schedule<EmailSender>(x => x.Send("Scheduled Job for a certain time"), whatsEntered);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Scheduled Job will run at " + whatsEntered.ToString() + "');", true);
            
        }
    }

    public class EmailSender
    {
        public void Send(string msg)
        {
            using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", "mike.strong@live.ca"))
            {
                mm.Subject = "Load Update from . Order Load Update for order ";
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
    }
}
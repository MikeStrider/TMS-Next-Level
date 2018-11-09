using System;
using System.Net.Mail;
using System.Net;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Quartz.Impl;
using Quartz;

public class JobScheduler
{
    public static void Start()
    {
        //IScheduler scheduler = StdSchedulerFactory.GetDefaultScheduler();
        //scheduler.Start();

        //IJobDetail createEmailJob = JobBuilder.Create<EmailJob>().Build();
        //IJobDetail createFTPJob = JobBuilder.Create<FTPJob>().Build();

        //ITrigger trigger = TriggerBuilder.Create()
        // .WithSimpleSchedule(x => x
        //    .WithIntervalInSeconds(40)
        //    .RepeatForever())
        // .Build();

        //scheduler.ScheduleJob(createEmailJob, trigger);
        //// scheduler.ScheduleJob(createFTPJob, trigger);
    }
}

public class EmailJob : IJob
{
    public void Execute (IJobExecutionContext context)
    {
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        conn.Open();
        var cmd = new SqlCommand();
        cmd.CommandText = "SELECT AutoEmails.email, AutoEmails.mins, AutoEmails.orderID, AutoEmails.lastSent, AutoEmails.id, DispatchTable.truck, TruckLatest.lastdateandtime, TruckLatest.lastposition FROM AutoEmails LEFT OUTER JOIN DispatchTable ON AutoEmails.orderID = DispatchTable.ordernumber INNER JOIN (SELECT name, lastposition, lastdateandtime, compid FROM Truck002 AS Truck1 WHERE(lastdateandtime = (SELECT MAX(lastdateandtime) AS Expr1 FROM Truck002 AS Truck2 WHERE(name = Truck1.name) AND(compid = Truck1.compid)))) AS TruckLatest ON DispatchTable.truck = TruckLatest.name AND DispatchTable.compid = TruckLatest.compid";
        cmd.Connection = conn;
        var reader = cmd.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                // CHECK IF INTERVAL IS OVERDUE
                string interval = reader.GetSqlValue(1).ToString();
                TimeSpan interval2 = TimeSpan.FromMinutes(Convert.ToInt32(interval));
                var lastSent = reader.GetSqlValue(3).ToString();
                DateTime lastSent2 = Convert.ToDateTime(lastSent);
                DateTime nowDate = DateTime.Now;
                TimeSpan timeBetween = nowDate - lastSent2;
                string toEmail = "mike.strong@live.ca";
                if (timeBetween > interval2)
                {
                    using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", toEmail))
                    {
                        mm.Subject = "Load Update for order " + reader.GetSqlValue(2).ToString() + ".";
                        mm.Body = "Load Update for order " + reader.GetSqlValue(2).ToString() + "." + System.Environment.NewLine +
                            " >> The load is on route.  Last known location was " + reader.GetSqlValue(7).ToString() + " at " + reader.GetSqlValue(6).ToString()
                            //carrierName + System.Environment.NewLine +
                            //" Scheduled Pick Up : " + Request.QueryString["pickup"] + System.Environment.NewLine +
                            //" Scheduled Drop Off : " + Request.QueryString["drop"] + System.Environment.NewLine +
                            //" >> Truck : " + Request.QueryString["truck"] + System.Environment.NewLine +
                            //" >> Driver : " + Request.QueryString["driver"] + System.Environment.NewLine +
                            //" >> Last Update was from : " + Request.QueryString["time"] + System.Environment.NewLine +
                            //" >> Location : " + Request.QueryString["location"]
                            ;
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
                    string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
                    using (conn = new SqlConnection(CS))
                    {
                        SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO logging VALUES (@type, @details, @datetime)", conn);
                        da2.SelectCommand.Parameters.AddWithValue("@type", "Auto Email Sent");
                        da2.SelectCommand.Parameters.AddWithValue("@details", "Order " + reader.GetSqlValue(2).ToString() + " successfully sent to " + toEmail);
                        da2.SelectCommand.Parameters.AddWithValue("@datetime", DateTime.Now.ToString());
                        DataSet ds2 = new DataSet();
                        da2.Fill(ds2);

                        SqlDataAdapter da = new SqlDataAdapter("UPDATE AutoEmails SET lastSent = @lastSent WHERE id = " + reader.GetSqlValue(4).ToString(), conn);
                        da.SelectCommand.Parameters.AddWithValue("@lastSent", DateTime.Now.ToString());
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                    }
                }
            }
        }
        reader.Close();
    }
}

public class FTPJob : IJob
{
    public void Execute(IJobExecutionContext context)
    {
        WebClient request = new WebClient();
        string url = "ftp://ftp.microsoft.com/developr/fortran/" + "README.TXT";
        request.Credentials = new NetworkCredential("anonymous", "anonymous@example.com");

        try
        {
            byte[] newFileData = request.DownloadData(url);
            string fileString = System.Text.Encoding.UTF8.GetString(newFileData);
            Console.WriteLine(fileString);
        }
        catch (WebException e)
        {
            // Do something such as log error, but this is based on OP's original code
            // so for now we do nothing.
        }
    }
}


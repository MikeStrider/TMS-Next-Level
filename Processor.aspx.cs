using Hangfire;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Text;
using EdiFabric.Framework;
using EdiFabric.Framework.Readers;
using System.Reflection;
using EdiFabric.Core;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Processor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        RecurringJob.AddOrUpdate<MainProcessor>("IDSendingEmail", x => x.Send("Checking for EDI Files"), Cron.Minutely);
        ClientScript.RegisterStartupScript(GetType(), "alert", "alert('STARTED');", true);
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        RecurringJob.RemoveIfExists("IDSendingEmail");
        ClientScript.RegisterStartupScript(GetType(), "alert", "alert('STOPPED');", true);
    }
}

public class MainProcessor
{
    public void Send(string msg)
    {
        //string URL = "ftp://mikestrider.square7.ch/Outbound/";
        //NetworkCredential creds = new NetworkCredential("mikestrider", "mikemike");
        //FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(URL);
        //ftpRequest.Credentials = creds;
        //ftpRequest.Method = WebRequestMethods.Ftp.ListDirectory;
        //FtpWebResponse response = (FtpWebResponse)ftpRequest.GetResponse();
        //StreamReader streamReader = new StreamReader(response.GetResponseStream());

        ////read from FTP and get a list of paths
        //List<string> directories = new List<string>();
        //string line = streamReader.ReadLine();
        //while (!string.IsNullOrEmpty(line))
        //{
        //    directories.Add(line);
        //    line = streamReader.ReadLine();
        //}
        //streamReader.Close();

        ////sort through the list
        //for (int x = 2; x <= directories.Count - 1; x++)
        //{
        //    WebClient request = new WebClient();
        //    string URL2 = URL + directories[x];
        //    request.Credentials = creds;
        //    byte[] newFileData = request.DownloadData(URL2);
        //    string fileString = Encoding.UTF8.GetString(newFileData);

        //    //write the file to local
        //    File.WriteAllText("C:/EDI/temp.txt", fileString);

        //    var x12Stream = File.OpenRead("C:/EDI/temp.txt");
        //    List<EdiItem> x12Items;
        //    using (var ediReader = new X12Reader(x12Stream, LoadFactory, Encoding.UTF8, true))
        //    {
        //        x12Items = ediReader.ReadToEnd().ToList();
        //    }
        //    // read certain elements of the file
        //    try
        //    {
        //        var x12Transactions = x12Items.OfType<EdiFabric.Rules.X12_004010.TS204>().ToList();
        //        var ediPickUpLocation = x12Transactions[0].S5Loop1[0].N1Loop2.N3[0].AddressInformation_01 + ", " + x12Transactions[0].S5Loop1[0].N1Loop2.N4.CityName_01 + ", " + x12Transactions[0].S5Loop1[0].N1Loop2.N4.StateorProvinceCode_02;
        //        var ediPickUpDateTime = x12Transactions[0].S5Loop1[0].G62[0].Date_02 + " " + x12Transactions[0].S5Loop1[0].G62[0].Time_04;
        //        var ediDropOffLocation = x12Transactions[0].S5Loop1[1].N1Loop2.N3[0].AddressInformation_01 + ", " + x12Transactions[0].S5Loop1[1].N1Loop2.N4.CityName_01 + ", " + x12Transactions[0].S5Loop1[1].N1Loop2.N4.StateorProvinceCode_02;
        //        var ediDropOffDateTime = x12Transactions[0].S5Loop1[1].G62[0].Date_02 + " " + x12Transactions[0].S5Loop1[1].G62[0].Time_04;
        //        ediPickUpDateTime = ediPickUpDateTime.Insert(4, "/");
        //        ediPickUpDateTime = ediPickUpDateTime.Insert(7, "/");
        //        ediPickUpDateTime = ediPickUpDateTime.Insert(13, ":");
        //        ediDropOffDateTime = ediDropOffDateTime.Insert(4, "/");
        //        ediDropOffDateTime = ediDropOffDateTime.Insert(7, "/");
        //        ediDropOffDateTime = ediDropOffDateTime.Insert(13, ":");

        //        //insert into DB as an order
        //        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        //        using (SqlConnection conn = new SqlConnection(CS))
        //        {
        //            SqlDataAdapter da3 = new SqlDataAdapter("INSERT INTO [orders] ([pickupdateandtime], [dropoffdateandtime], [pickuplocation], [dropofflocation], compid, status, bookedby) VALUES (@pickupdateandtime, @dropoffdateandtime, @pickuplocation, @dropofflocation, 20045, 'available', 'Processor')", conn);
        //            da3.SelectCommand.Parameters.AddWithValue("@pickupdateandtime", ediPickUpDateTime);
        //            da3.SelectCommand.Parameters.AddWithValue("@dropoffdateandtime", ediDropOffDateTime);
        //            da3.SelectCommand.Parameters.AddWithValue("@pickuplocation", ediPickUpLocation);
        //            da3.SelectCommand.Parameters.AddWithValue("@dropofflocation", ediDropOffLocation);
        //            DataSet ds3 = new DataSet();
        //            da3.Fill(ds3);
        //            SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO logging VALUES (@type, @details, @datetime)", conn);
        //            da2.SelectCommand.Parameters.AddWithValue("@type", "Load Received via EDI");
        //            da2.SelectCommand.Parameters.AddWithValue("@details", "SUCCESS --- " + directories[x] + " --- " + fileString);
        //            da2.SelectCommand.Parameters.AddWithValue("@datetime", DateTime.Now.ToString());
        //            DataSet ds2 = new DataSet();
        //            da2.Fill(ds2);
        //        }
        //    }
        //    catch
        //    {
        //        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        //        using (SqlConnection conn = new SqlConnection(CS))
        //        {
        //            SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO logging VALUES (@type, @details, @datetime)", conn);
        //            da2.SelectCommand.Parameters.AddWithValue("@type", "Load Received via EDI");
        //            da2.SelectCommand.Parameters.AddWithValue("@details", "FAILED --- " + directories[x] + " --- failed to parse");
        //            da2.SelectCommand.Parameters.AddWithValue("@datetime", DateTime.Now.ToString());
        //            DataSet ds2 = new DataSet();
        //            da2.Fill(ds2);
        //        }
        //    }

        //}
    }

    static Assembly LoadFactory(MessageContext mc)
    {
        if (mc.Format.Equals("X12", StringComparison.Ordinal))
        {
            if (mc.Version.Equals("004010", StringComparison.Ordinal))
                return Assembly.Load("EdiFabric.Rules.X12004010");

            if (mc.Version.StartsWith("005010X2", StringComparison.Ordinal))
                return Assembly.Load("EdiFabric.Rules.Hipaa005010");
        }

        if (mc.Format.Equals("EDIFACT", StringComparison.Ordinal))
        {
            if (mc.Version.Equals("D96A", StringComparison.Ordinal))
                return Assembly.Load("EdiFabric.Rules.EdifactD96A");
        }

        throw new Exception(string.Format("Unsupported transaction: Format {0} Version {1} Transaction ID {2} .", mc.Format, mc.Version, mc.Name));
    }
}
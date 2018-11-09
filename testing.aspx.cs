using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.IO;
using System.Text;
using EdiFabric.Framework;
using EdiFabric.Framework.Readers;
using System.Reflection;
using EdiFabric.Core.Model.Edi;

public partial class testing : MainClass
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string script = "$(document).ready(function () { $('[id*=btnSubmit]').click(); });";
            ClientScript.RegisterStartupScript(this.GetType(), "load", script, true);
        }

        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT Count(id) FROM Orders", conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            Label1.Text = "Total Order Count is " + TotalRows.ToString();
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing Set tcposted = 'n', paid = 'n', dpposted ='n' WHERE ordernumber = " + TextBox5.Text, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);

            SqlDataAdapter da2 = new SqlDataAdapter("UPDATE orders Set status = 'complete' WHERE id = " + TextBox5.Text, conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            Label3.ForeColor = System.Drawing.Color.Green;
            Label3.Text = "Order Number " + TextBox5.Text + " has been UnPosted";
        }
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE orders Set status = 'available' WHERE id = " + TextBox6.Text, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
            Label4.ForeColor = System.Drawing.Color.Green;
            Label4.Text = "Order Number " + TextBox6.Text + " has been set back to Available";

            SqlDataAdapter da2 = new SqlDataAdapter("DELETE FROM DispatchTable WHERE ordernumber = " + TextBox6.Text, conn);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);

            SqlDataAdapter da3 = new SqlDataAdapter("DELETE FROM Billing WHERE ordernumber = " + TextBox6.Text, conn);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
        }
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        using (MailMessage mm = new MailMessage(txtEmail.Text, txtTo.Text))
        {
            mm.Subject = txtSubject.Text;
            mm.Body = txtBody.Text;
            if (fuAttachment.HasFile)
            {
                string FileName = Path.GetFileName(fuAttachment.PostedFile.FileName);
                mm.Attachments.Add(new Attachment(fuAttachment.PostedFile.InputStream, FileName));
            }
            mm.IsBodyHtml = false;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential(txtEmail.Text, txtPassword.Text);
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email Sent');", true);
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }

    protected void OpenWindow(object sender, EventArgs e)
    {
        method_launchmap();
    }

    protected void Button7_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(5000);
    }

    protected void Button8_Click(object sender, EventArgs e)
    {
        string createText = TextBox5.Text + "~" + TextBox6.Text + "~" + TextBox7.Text + Environment.NewLine;
        File.WriteAllText(Server.MapPath("~/EDI/testfile.txt"), createText);
        WebClient client = new WebClient();
        client.Credentials = new NetworkCredential("mikestrider", "mikemike");
        client.UploadFile("ftp://mikestrider.square7.ch/" + lblcompid.Text + "-" + DateTime.Now.ToString("MM-dd-yyyy-HH:mm:ss") + ".txt", Server.MapPath("~/EDI/testfile.txt"));
        ClientScript.RegisterStartupScript(GetType(), "alert", "alert('EDI File Sent');", true);
    }

    protected void Button9_Click(object sender, EventArgs e)
    {
        //string URL = "ftp://mikestrider.square7.ch/Outbound/";
        //NetworkCredential creds = new NetworkCredential("mikestrider", "mikemike");
        //FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(URL);
        //ftpRequest.Credentials = creds;
        //ftpRequest.Method = WebRequestMethods.Ftp.ListDirectory;
        //FtpWebResponse response = (FtpWebResponse)ftpRequest.GetResponse();
        //StreamReader streamReader = new StreamReader(response.GetResponseStream());

        //read from FTP and get a list of paths
        //List<string> directories = new List<string>();
        //string line = streamReader.ReadLine();
        //while (!string.IsNullOrEmpty(line))
        //{
        //    directories.Add(line);
        //    line = streamReader.ReadLine();
        //}
        //streamReader.Close();

        //sort through the list
        //for (int x = 2; x <= directories.Count - 1; x++)
        //{
        //    WebClient request = new WebClient();
        //    string URL2 = URL + directories[x];
        //    request.Credentials = creds;
        //    byte[] newFileData = request.DownloadData(URL2);
        //    string fileString = Encoding.UTF8.GetString(newFileData);

        //    write the file to local
        //    File.WriteAllText(Server.MapPath("~/EDI/temp.txt"), fileString);

        //    var x12Stream = File.OpenRead(Server.MapPath("~/EDI/temp.txt"));
        //    List<EdiItem> x12Items;
        //    using (var ediReader = new X12Reader(x12Stream, LoadFactory, Encoding.UTF8, true))
        //    {
        //        x12Items = ediReader.ReadToEnd().ToList();
        //    }
        //    read certain elements of the file
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

        //        insert into DB as an order
        //        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        //        using (SqlConnection conn = new SqlConnection(CS))
        //        {
        //            SqlDataAdapter da3 = new SqlDataAdapter("INSERT INTO [orders] ([pickupdateandtime], [dropoffdateandtime], [pickuplocation], [dropofflocation], compid, status, bookedby) VALUES (@pickupdateandtime, @dropoffdateandtime, @pickuplocation, @dropofflocation, " + lblcompid.Text + ", 'available', 'Processor')", conn);
        //            da3.SelectCommand.Parameters.AddWithValue("@pickupdateandtime", ediPickUpDateTime);
        //            da3.SelectCommand.Parameters.AddWithValue("@dropoffdateandtime", ediDropOffDateTime);
        //            da3.SelectCommand.Parameters.AddWithValue("@pickuplocation", ediPickUpLocation);
        //            da3.SelectCommand.Parameters.AddWithValue("@dropofflocation", ediDropOffLocation);
        //            DataSet ds3 = new DataSet();
        //            da3.Fill(ds3);
        //            SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO logging VALUES (@type, @details, @datetime)", conn);
        //            da2.SelectCommand.Parameters.AddWithValue("@type", "Load Received via EDI");
        //            da2.SelectCommand.Parameters.AddWithValue("@details", fileString);
        //            da2.SelectCommand.Parameters.AddWithValue("@datetime", DateTime.Now.ToString());
        //            DataSet ds2 = new DataSet();
        //            da2.Fill(ds2);
        //        }
        //        TextBox8.Text = TextBox8.Text + " SUCCESS - " + directories[x] + Environment.NewLine;
        //    }
        //    catch
        //    {
        //        TextBox8.Text = TextBox8.Text + " FAILED - " + directories[x] + Environment.NewLine;
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

    protected void TextBox7_TextChanged(object sender, EventArgs e)
    {

    }
}
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Invoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        Image1.ImageUrl = "~/logos/" + (String)Session["mySessionVar2"] + "-logo.png";
        Image1.Attributes.Add("width", "300");

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
        conn.Open();
        var cmd = new SqlCommand();
        cmd.CommandText = "SELECT orders.id, orders.pickupdateandtime, orders.dropoffdateandtime, orders.pickuplocation, orders.dropofflocation, orders.bookedby, orders.status, DispatchTable.truck, DispatchTable.driver, DispatchTable.actualpickup, DispatchTable.actualdropoff, DispatchTable.empty, DispatchTable.loaded, Billing.billto, Billing.totalcharges, Billing.paid, Billing.tcposted, Billing.driverpay, Billing.dpposted, Billing.paperwork FROM Billing FULL OUTER JOIN DispatchTable ON Billing.ordernumber = DispatchTable.ordernumber FULL OUTER JOIN orders ON DispatchTable.ordernumber = orders.id WHERE(orders.id = " + Request.QueryString["id"] + ") ORDER BY CASE status WHEN 'available' THEN 1 WHEN 'onRoute' THEN 2 WHEN 'complete' THEN 3 WHEN 'posted' THEN 4 WHEN 'exported' THEN 5 END, orders.id";
        cmd.Connection = conn;
        var reader = cmd.ExecuteReader();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                ordernumber.Text = reader["id"].ToString();
                billto.Text = reader["billto"].ToString();
                totalcharges.Text = reader["totalcharges"].ToString();
                totalcharges2.Text = reader["totalcharges"].ToString();
                pickuplocation.Text = reader["pickuplocation"].ToString();
                dropofflocation.Text = reader["dropofflocation"].ToString();
                truck.Text = reader["truck"].ToString();
                driver.Text = reader["driver"].ToString();
                bookedby.Text = reader["bookedby"].ToString();
            }
        }

        reader.Close();
        conn.Close();

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn2 = new SqlConnection(CS))
        {
            SqlCommand cmd2 = new SqlCommand("SELECT invoiceouraddress FROM companyinfo WHERE compid = " + (String)Session["mySessionVar2"], conn2);
            conn2.Open();
            txtAddress.Text = (string)cmd2.ExecuteScalar();
            SqlCommand cmd3 = new SqlCommand("SELECT invoicefooter FROM companyinfo WHERE compid = " + (String)Session["mySessionVar2"], conn2);
            txtCandTtext.Text = (string)cmd3.ExecuteScalar();
        }


        //var cmd2 = new SqlCommand();
        //cmd2.CommandText = "SELECT invoicefooter, invoiceouraddress FROM companyinfo WHERE compid = " + (String)Session["mySessionVar2"];
        //cmd2.Connection = conn;
        //var reader2 = cmd2.ExecuteReader();
        //if (reader2.HasRows)
        //{
        //    while (reader2.Read())
        //    {
        //        lblTandCtext.Text = reader2["invoicefooter"].ToString();
        //        lblAddress.Text = reader2["invoiceouraddress"].ToString();
        //    }
        //}

        //reader2.Close();


    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        // Create a Document object
        var document = new Document(PageSize.A4, 50, 50, 25, 25);

        // Create a new PdfWrite object, writing the output to a MemoryStream
        var output = new MemoryStream();
        var writer = PdfWriter.GetInstance(document, output);

        // Open the Document for writing
        document.Open();

        // Read in the contents of the Receipt.htm HTML template file
        string contents = File.ReadAllText(Server.MapPath("~/HTMLTemplate/invoice.htm"));

        // Replace the placeholders with the user-specified text
        contents = contents.Replace("[ORDERDATE]", ordernumber.Text);
        contents = contents.Replace("[BILLTO]", billto.Text);
        contents = contents.Replace("[BOOKEDBY]", bookedby.Text);
        contents = contents.Replace("[TRUCK]", truck.Text);
        contents = contents.Replace("[DRIVER]", driver.Text);
        contents = contents.Replace("[PICKUPLOCATION]", pickuplocation.Text);
        contents = contents.Replace("[DROPOFFLOCATION]", dropofflocation.Text);
        contents = contents.Replace("[TOTALCHARGES]", totalcharges.Text);
        contents = contents.Replace("[TOTALCHARGES2]", totalcharges.Text);
        string newString = txtAddress.Text;
        newString = newString.Replace("\r\n", "<br>");
        contents = contents.Replace("[ADDRESS]", newString);
        newString = txtCandTtext.Text;
        newString = newString.Replace("\r\n", "<br>");
        contents = contents.Replace("[TandC]", newString);

        // Uses iTextSharp and fills the PDF
        var parsedHtmlElements = HTMLWorker.ParseToList(new StringReader(contents), null);
        foreach (var htmlElement in parsedHtmlElements)
            document.Add(htmlElement as IElement);

        // Adds an image in the upper right corner
        var logo = iTextSharp.text.Image.GetInstance(Server.MapPath("~/logos/" + (String)Session["mySessionVar2"] + "-logo.png"));
        logo.SetAbsolutePosition(40, 680);
        logo.ScaleToFit(170, 170);
        document.Add(logo);

        var logo3 = iTextSharp.text.Image.GetInstance(Server.MapPath("~/Images/line2.png"));
        logo3.SetAbsolutePosition(12, 569);
        logo.ScalePercent(80);
        document.Add(logo3);

        var logo2 = iTextSharp.text.Image.GetInstance(Server.MapPath("~/Images/line2.png"));
        logo2.SetAbsolutePosition(12, 492);
        logo.ScalePercent(80);
        document.Add(logo2);

        document.Close();
        Response.ContentType = "application/pdf";
        Response.AddHeader("Content-Disposition", string.Format("attachment;filename=MikesTrucking-{0}.pdf", ordernumber.Text));
        Response.BinaryWrite(output.ToArray());
    }

    protected void OpenWindow(object sender, EventArgs e)
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }


    // *****************
    // save to a file then email
    // *****************

    protected void Button2_Click(object sender, EventArgs e)
    {
        // Create a Document object
        var document = new Document(PageSize.A4, 50, 50, 25, 25);

        // Create a new PdfWrite object, writing the output to a MemoryStream
        var output = new MemoryStream();
        var writer = PdfWriter.GetInstance(document, new FileStream(Server.MapPath("~/Invoices/MikesTrucking - " + ordernumber.Text + ".pdf"), FileMode.Create));

        // Open the Document for writing
        document.Open();

        // Read in the contents of the Receipt.htm HTML template file
        string contents = File.ReadAllText(Server.MapPath("~/HTMLTemplate/invoice.htm"));

        // Replace the placeholders with the user-specified text
        contents = contents.Replace("[ORDERDATE]", ordernumber.Text);
        contents = contents.Replace("[BILLTO]", billto.Text);
        contents = contents.Replace("[BOOKEDBY]", bookedby.Text);
        contents = contents.Replace("[TRUCK]", truck.Text);
        contents = contents.Replace("[DRIVER]", driver.Text);
        contents = contents.Replace("[PICKUPLOCATION]", pickuplocation.Text);
        contents = contents.Replace("[DROPOFFLOCATION]", dropofflocation.Text);
        contents = contents.Replace("[TOTALCHARGES]", totalcharges.Text);
        contents = contents.Replace("[TOTALCHARGES2]", totalcharges.Text);


        // Uses iTextSharp and fills the PDF
        var parsedHtmlElements = HTMLWorker.ParseToList(new StringReader(contents), null);
        foreach (var htmlElement in parsedHtmlElements)
            document.Add(htmlElement as IElement);

        // Adds an image in the upper right corner
        var logo = iTextSharp.text.Image.GetInstance(Server.MapPath("~/Images/trucklogo.jpg"));
        logo.SetAbsolutePosition(40, 680);
        logo.ScalePercent(80);
        document.Add(logo);

        var logo3 = iTextSharp.text.Image.GetInstance(Server.MapPath("~/Images/line2.png"));
        logo3.SetAbsolutePosition(12, 569);
        logo.ScalePercent(80);
        document.Add(logo3);

        var logo2 = iTextSharp.text.Image.GetInstance(Server.MapPath("~/Images/line2.png"));
        logo2.SetAbsolutePosition(12, 492);
        logo.ScalePercent(80);
        document.Add(logo2);

        document.Close();



        using (MailMessage mm = new MailMessage("mike.strong28@gmail.com", txtTo.Text))
        {
            mm.Subject = "Invoice From Mikes Trucking - " + ordernumber.Text;
            mm.Body = "Please see the attached document";
            string FileName = Server.MapPath("~/Invoices/MikesTrucking - " + ordernumber.Text + ".pdf");
            mm.Attachments.Add(new Attachment(FileName));
            mm.IsBodyHtml = false;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            NetworkCredential NetworkCred = new NetworkCredential("mike.strong28@gmail.com", MainClass.MyPassword);
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email sent.');", true);
        }
    }
}
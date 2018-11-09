using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class PostedLoads : MainClass
{
    public int theCount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("SELECT COUNT(orders.id) AS Expr1 FROM companyinfo INNER JOIN orders ON companyinfo.compid = orders.compid WHERE (orders.Posted = 1)", conn);
            conn.Open();
            int TotalRows = (int)cmd.ExecuteScalar();
            txtcount.Text = "Total Current Posted Loads Available: " + TotalRows.ToString();
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }

    protected void OpenWindow(object sender, EventArgs e)
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (CheckBox1.Checked == true)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                theCount = theCount + 1;
                HtmlTable tr = (HtmlTable)e.Item.FindControl("TR2");
                Label pickuplocationLabel = (Label)e.Item.FindControl("pickuplocationLabel");
                Label Label5 = (Label)e.Item.FindControl("Label5");

                string f = string.Format("https://maps.googleapis.com/maps/api/distancematrix/json?origins={0}&destinations={1}", pickuplocationLabel.Text, txtlocation.Text);
                var request = WebRequest.Create(f);
                // Indicate you are looking for a JSON response
                request.ContentType = "application/json; charset=utf-8";
                var response = (HttpWebResponse)request.GetResponse();

                // Read through the response
                using (var sr = new StreamReader(response.GetResponseStream()))
                {
                    // Define a serializer to read your response
                    JavaScriptSerializer serializer = new JavaScriptSerializer();

                    // Get your results
                    dynamic result = serializer.DeserializeObject(sr.ReadToEnd());

                    // Read the distance property from the JSON request
                    var distance = result["rows"][0]["elements"][0]["distance"]["text"]; // yields "1,300 KM"
                    Label5.Text = distance;
                    distance = Regex.Replace(distance, "k", "");
                    distance = Regex.Replace(distance, "m", "");
                    distance = Regex.Replace(distance, " ", "");
                    distance = Regex.Replace(distance, ",", "");
                    if (Convert.ToDecimal(distance) >= Convert.ToDecimal(txtmiles.Text))
                    {
                        tr.Visible = false;
                        theCount = theCount - 1;
                    }
                }
            }
        }
        txtcount2.Text = "Filtered total: " + theCount;
    }

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DataList1.DataSourceID = "SqlDataSource2";
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }
}
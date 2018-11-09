using System;
using System.Collections.Generic;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            lblusername.Text = (String)Session["mySessionVar"];
            lblcompid.Text = (String)Session["mySessionVar2"];
            if (lblcompid.Text == "")
            {
                Response.Redirect("LoginPage.aspx");
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

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label Label1 = (Label)e.Row.FindControl("Label1");
            Label Label5 = (Label)e.Row.FindControl("Label5");
            HyperLink lblLocation = (HyperLink)e.Row.FindControl("HyperLink3");
            string value = Label5.Text;
            if (Label1.Text == "no truck")
            {
                lblLocation.Enabled = false;
            }
            switch (value)
            {
                case "0":
                    HyperLink hyp = new HyperLink();
                    hyp.ID = "hypID";
                    if (lblLocation.Text == "default place holder" || Label1.Text == "no truck")
                    {
                        
                    } else
                    {
                        hyp.NavigateUrl = "~/workersearching.aspx?trucks=" + Label1.Text + "&turnon=1";
                    }
                    hyp.ImageUrl = "Images/off2.png";
                    hyp.ImageHeight = 30;
                    e.Row.Cells[4].Controls.Add(hyp);
                    break;
                case "1":
                    HyperLink hyp2 = new HyperLink();
                    hyp2.ID = "hypID";
                    hyp2.NavigateUrl = "~/workersearching.aspx?trucks=" + Label1.Text + "&turnoff=1";
                    hyp2.ImageUrl = "Images/on2.png";
                    hyp2.ImageHeight = 30;
                    e.Row.Cells[4].Controls.Add(hyp2);
                    break;
            }
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            Label lblSearching = (Label)row.FindControl("Label5");
            HyperLink lblLocation = (HyperLink)row.FindControl("HyperLink3");
            if (lblSearching.Text =="1")
            {
                
                Label Label8 = (Label)row.FindControl("Label8");
                Label lblmiles = (Label)row.FindControl("Label4");
                HyperLink lblLoadsFound = (HyperLink)row.FindControl("HyperLink1");
                HyperLink lblLoadsTotal = (HyperLink)row.FindControl("HyperLink2");
                int total = 0;
                if (lblLocation.Text == "plz select a location")
                {
                    lblLocation.Enabled = false;
                }
                for (var i = 0; i < GridView2.Rows.Count; i++)
                {
                    string loadName = GridView2.Rows[i].Cells[0].Text;  // load name looped
                    string f = string.Format("https://maps.googleapis.com/maps/api/distancematrix/json?origins={0}&destinations={1}", loadName, lblLocation.Text);
                    var request = WebRequest.Create(f);
                    request.ContentType = "application/json; charset=utf-8";
                    var response = (HttpWebResponse)request.GetResponse();
                    using (var sr = new StreamReader(response.GetResponseStream()))
                    {
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        dynamic result = serializer.DeserializeObject(sr.ReadToEnd());
                        var distance = result["rows"][0]["elements"][0]["distance"]["text"]; // yields "1,300 KM"
                        string t = distance;
                        distance = Regex.Replace(distance, "k", "");
                        distance = Regex.Replace(distance, "m", "");
                        distance = Regex.Replace(distance, " ", "");
                        distance = Regex.Replace(distance, ",", "");
                            if (Decimal.Parse(distance) <= Decimal.Parse(lblmiles.Text))
                            {
                                total = total + 1;
                                lblLoadsFound.Text = lblLoadsFound.Text + ": " + GridView2.Rows[i].Cells[0].Text + ", " + t + " ";
                            }


                    }
                    lblLoadsTotal.Text = ": " + total + " loads found";
                }
            }

            Label Label1 = (Label)row.FindControl("Label1");
            Label Label5 = (Label)row.FindControl("Label5");
            string value = Label5.Text;
            switch (value)
            {
                case "0":
                    HyperLink hyp = new HyperLink();
                    hyp.ID = "hypID";
                    if (lblLocation.Text == "default place holder" || Label1.Text == "no truck")
                    {

                    }
                    else
                    {
                        hyp.NavigateUrl = "~/workersearching.aspx?trucks=" + Label1.Text + "&turnon=1";
                    }
                    hyp.ImageUrl = "Images/off2.png";
                    hyp.ImageHeight = 30;
                    row.Cells[4].Controls.Add(hyp);
                    break;
                case "1":
                    HyperLink hyp2 = new HyperLink();
                    hyp2.ID = "hypID";
                    hyp2.NavigateUrl = "~/workersearching.aspx?trucks=" + Label1.Text + "&turnoff=1";
                    hyp2.ImageUrl = "Images/on2.png";
                    hyp2.ImageHeight = 30;
                    row.Cells[4].Controls.Add(hyp2);
                    break;
            }




        }
    }
}
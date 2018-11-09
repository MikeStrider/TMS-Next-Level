using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;
using System.Data;

public partial class UploadPaperwork : MainClass
{

    protected void Page_Load(object sender, EventArgs e)
    {
        lblusername.Text = (String)Session["mySessionVar"];
        lblcompid.Text = (String)Session["mySessionVar2"];
        if (lblcompid.Text == "")
        {
            Response.Redirect("LoginPage.aspx");
        }
        if (!IsPostBack)
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            conn.Open();

            var cmd = new SqlCommand();
            cmd.CommandText = "Select * from Orders WHERE status <> 'exported' AND compid = " + lblcompid.Text;
            cmd.Connection = conn;
            var reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    ListBox1.Items.Add(reader.GetSqlValue(0).ToString());
                }
            }
            reader.Close();
            conn.Close();
                     
            if (Request.QueryString["idpaper"] != null)
            {
                ListBox1.SelectedValue = Request.QueryString["idpaper"].ToString();

                if (File.Exists(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + Request.QueryString["idpaper"] + "-paperworkfile_1_.png")))
                {
                    string curItem = Request.QueryString["idpaper"];
                    labelAttachedPaperwork.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + Request.QueryString["idpaper"] + "-paperworkfile_1_.png", Request.QueryString["idpaper"] + "-paperworkfile_1_.png");
                    delete1.Text = "delete";
                }
                else
                {
                    labelAttachedPaperwork.Text = "none";
                    delete1.Text = "";
                }

                if (File.Exists(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + Request.QueryString["idpaper"] + "-paperworkfile_2_.png")))
                {
                    string curItem = Request.QueryString["idpaper"];
                    labelAttachedPaperwork0.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + Request.QueryString["idpaper"] + "-paperworkfile_2_.png", Request.QueryString["idpaper"] + "-paperworkfile_2_.png");
                    delete2.Text = "delete";
                }
                else
                {
                    labelAttachedPaperwork0.Text = "none";
                    delete2.Text = "";
                }

                if (File.Exists(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + Request.QueryString["idpaper"] + "-paperworkfile_3_.png")))
                {
                    string curItem = ListBox1.SelectedItem.ToString();
                    labelAttachedPaperwork1.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + Request.QueryString["idpaper"] + "-paperworkfile_3_.png", Request.QueryString["idpaper"] + "-paperworkfile_3_.png");
                    delete3.Text = "delete";
                }
                else
                {
                    labelAttachedPaperwork1.Text = "none";
                    delete3.Text = "";
                }

            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (labelAttachedPaperwork.Text == "none")
        {
            string fileName = FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_1_.png"));
            string curItem = ListBox1.SelectedItem.ToString();
            labelAttachedPaperwork.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_1_.png", ListBox1.SelectedValue + "-paperworkfile_1_.png");
            delete1.Text = "delete";

            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paperwork = '1 file' WHERE ordernumber = " + ListBox1.SelectedValue + " AND compid = " + lblcompid.Text, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }
        else if (labelAttachedPaperwork0.Text == "none")
        {
            string fileName = FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_2_.png"));
            string curItem = ListBox1.SelectedItem.ToString();
            labelAttachedPaperwork0.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + ListBox1.SelectedValue + "-paperworkfile_2_.png", ListBox1.SelectedValue + "-paperworkfile_2_.png");
            delete2.Text = "delete";

            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paperwork = '2 files' WHERE ordernumber = " + ListBox1.SelectedValue + " AND compid = " + lblcompid.Text, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }
        else if (labelAttachedPaperwork1.Text == "none")
        {
            string fileName = FileUpload1.FileName;
            FileUpload1.SaveAs(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_3_.png"));
            string curItem = ListBox1.SelectedItem.ToString();
            labelAttachedPaperwork1.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + ListBox1.SelectedValue + "-paperworkfile_3_.png", ListBox1.SelectedValue + "-paperworkfile_3_.png");
            delete3.Text = "delete";

            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paperwork = '3 files' WHERE ordernumber = " + ListBox1.SelectedValue + " AND compid = " + lblcompid.Text, conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (File.Exists(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_1_.png")))
        {
            string curItem = ListBox1.SelectedItem.ToString();
            labelAttachedPaperwork.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_1_.png", ListBox1.SelectedValue + "-paperworkfile_1_.png");
            delete1.Text = "delete";
        }
        else
        {
            labelAttachedPaperwork.Text = "none";
            delete1.Text = "";
        }

        if (File.Exists(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_2_.png")))
        {
            string curItem = ListBox1.SelectedItem.ToString();
            labelAttachedPaperwork0.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_2_.png", ListBox1.SelectedValue + "-paperworkfile_2_.png");
            delete2.Text = "delete";
        }
        else
        {
            labelAttachedPaperwork0.Text = "none";
            delete2.Text = "";
        }

        if (File.Exists(Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + lblcompid.Text + "-" + "-paperworkfile_3_.png")))
        {
            string curItem = ListBox1.SelectedItem.ToString();
            labelAttachedPaperwork1.Text = String.Format("<a href='{0}'>{1}</a>", "/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_3_.png", ListBox1.SelectedValue + "-paperworkfile_3_.png");
            delete3.Text = "delete";
        }
        else
        {
            labelAttachedPaperwork1.Text = "none";
            delete3.Text = "";
        }
    }


    protected void delete1_Click(object sender, EventArgs e)
    {
        string fileName = (Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_1_.png"));
        System.IO.File.Delete(fileName);
        labelAttachedPaperwork.Text = "none";
        delete1.Text = "";

        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paperwork = 'none' WHERE ordernumber = " + ListBox1.SelectedValue, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }

    }


    protected void delete2_Click(object sender, EventArgs e)
    {
        string fileName = (Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_2_.png"));
        System.IO.File.Delete(fileName);
        labelAttachedPaperwork0.Text = "none";
        delete2.Text = "";
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paperwork = '1 file' WHERE ordernumber = " + ListBox1.SelectedValue, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
    }

    protected void delete3_Click(object sender, EventArgs e)
    {
        string fileName = (Server.MapPath("~/Paperwork/" + lblcompid.Text + "-" + ListBox1.SelectedValue + "-paperworkfile_3_.png"));
        System.IO.File.Delete(fileName);
        labelAttachedPaperwork1.Text = "none";
        delete3.Text = "";
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE Billing SET paperwork = '2 files' WHERE ordernumber = " + ListBox1.SelectedValue, conn);
            DataSet ds = new DataSet();
            da.Fill(ds);
        }
    }

    protected void OpenWindow(object sender, EventArgs e)
    {
        string url = "Map.aspx";
        string s = "window.open('" + url + "', 'popup_window', 'width=790,height=1000,left=200,top=100,resizable=yes');";
        ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        method_signout();
    }
}
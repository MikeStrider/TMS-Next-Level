using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LogInPage : System.Web.UI.Page
{
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from companyinfo WHERE password = @password AND compid = @compid", conn))
            {
                conn.Open();
                sqlCommand.Parameters.AddWithValue("@compid", TextBox2.Text);
                sqlCommand.Parameters.AddWithValue("@password", TextBox3.Text);
                int userCount = (int)sqlCommand.ExecuteScalar();
                if (userCount > 0)
                {
                    Session["mySessionVar"] = TextBox1.Text;
                    Session["mySessionVar2"] = TextBox2.Text;
                    Response.Redirect("OrdersPage.aspx");
                }
                else
                {
                    lblvalidation.Visible = true;
                    lblvalidation.Text = "invalid login, please try again, or call TMS - Next Level for support";
                    ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel()", true);
                }
            }
        }catch
        {
            lblvalidation.Visible = true;
            lblvalidation.Text = "invalid login, please try again, or call TMS - Next Level for support";
            ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel()", true);
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
        using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from driverinfo WHERE password = @password AND userid = @userid", conn))
        {
            conn.Open();
            sqlCommand.Parameters.AddWithValue("@userid", TextBox4.Text);
            sqlCommand.Parameters.AddWithValue("@password", TextBox5.Text);
            int userCount = (int)sqlCommand.ExecuteScalar();
            if (userCount > 0)
            {
                Session["mySessionVar"] = TextBox4.Text;
                Response.Redirect("~/EditDriver.aspx?id=" + TextBox4.Text);
            } else {
                lblvalidation2.Visible = true;
                ClientScript.RegisterStartupScript(GetType(), "alert", "HideLabel2()", true);
            }
        }
        
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {

    }
}
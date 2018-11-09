using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class workerPostedLoads : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["remove"] == null)
        { 
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            using (conn)
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE orders SET Posted = 1 WHERE id = " + Request.QueryString["id"], conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }
        else
            {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            using (conn)
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE orders SET Posted = 0 WHERE id = " + Request.QueryString["id"], conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
            
        }
        Response.Redirect("OrdersPage.aspx");
    }
}
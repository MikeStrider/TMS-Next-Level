using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class workersearching : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["turnon"] == "1")
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            using (conn)
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Trucks SET searching = '1' WHERE name = '" + Request.QueryString["trucks"] + "'", conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }
        }
        else
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
            using (conn)
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE Trucks SET searching = '0' WHERE name = '" + Request.QueryString["trucks"] + "'", conn);
                DataSet ds = new DataSet();
                da.Fill(ds);
            }

        }
        Response.Redirect("VehicleControlBoard.aspx");
    }
}
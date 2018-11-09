using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;


[WebService(Namespace = "http://mstrong.tk")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    public WebService()
    {

    }

    [WebMethod]
    public int SetDriverAvail(string drivername, string password, string location, string datetime)
    {
        if (location == "" || datetime == "")
        {
            return 0;
        }
        else
        {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("UPDATE driverinfo SET available = '1', location = @location, date = @datetime WHERE userid = @userid and password = @password", conn);
                da.SelectCommand.Parameters.AddWithValue("@userid", drivername);
                da.SelectCommand.Parameters.AddWithValue("@location", location);
                da.SelectCommand.Parameters.AddWithValue("@password", password);
                da.SelectCommand.Parameters.AddWithValue("@datetime", datetime);
                DataSet ds = new DataSet();
                da.Fill(ds);
                using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from driverinfo WHERE password = @password AND userid = @userid", conn))
                {
                    conn.Open();
                    sqlCommand.Parameters.AddWithValue("@userid", drivername);
                    sqlCommand.Parameters.AddWithValue("@password", password);
                    int userCount = (int)sqlCommand.ExecuteScalar();
                    if (userCount > 0)
                    {
                        return 1;
                    }
                    else
                    {
                        return 0;
                    }
                }
            }
        }
    }
    
    // SoupUI or the Web Service page can accept a load
    [WebMethod]
    public string ReceiveTender(string pickupdateandtime, string dropoffdateandtime, string pickuplocation, string dropofflocation, int compid)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        SqlConnection conn = new SqlConnection(CS);
        SqlDataAdapter da = new SqlDataAdapter("INSERT INTO [orders] ([pickupdateandtime], [dropoffdateandtime], [pickuplocation], [dropofflocation], [bookedby], [status], [compid], [Posted]) VALUES (@pickupdateandtime, @dropoffdateandtime, @pickuplocation, @dropofflocation, 'Processor', 'available', @compid, '0')", conn);
        da.SelectCommand.Parameters.AddWithValue("@pickupdateandtime", pickupdateandtime);
        da.SelectCommand.Parameters.AddWithValue("@dropoffdateandtime", dropoffdateandtime);
        da.SelectCommand.Parameters.AddWithValue("@pickuplocation", pickuplocation);
        da.SelectCommand.Parameters.AddWithValue("@dropofflocation", dropofflocation);
        da.SelectCommand.Parameters.AddWithValue("@compid", compid);
        DataSet ds = new DataSet();
        da.Fill(ds);
        using (conn = new SqlConnection(CS))
        {
            SqlDataAdapter da2 = new SqlDataAdapter("INSERT INTO logging VALUES (@type, @details, @datetime)", conn);
            da2.SelectCommand.Parameters.AddWithValue("@type", "Load Received via XML");
            da2.SelectCommand.Parameters.AddWithValue("@details", pickupdateandtime + " <> " + dropoffdateandtime + " <> " + pickuplocation + " <> " + dropofflocation + " <> " + compid);
            da2.SelectCommand.Parameters.AddWithValue("@datetime", DateTime.Now.ToString());
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
        }
        return "Load Accepted.";
    }


    [WebMethod]
    public int SetDriverNotAvail(string drivername, string password)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            SqlDataAdapter da = new SqlDataAdapter("UPDATE driverinfo SET available = '0' WHERE userid = @userid AND password = @password", conn);
            da.SelectCommand.Parameters.AddWithValue("@userid", drivername);
            da.SelectCommand.Parameters.AddWithValue("@password", password);
            DataSet ds = new DataSet();
            da.Fill(ds);
            using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from driverinfo WHERE password = @password AND userid = @userid", conn))
            {
                conn.Open();
                sqlCommand.Parameters.AddWithValue("@userid", drivername);
                sqlCommand.Parameters.AddWithValue("@password", password);
                int userCount = (int)sqlCommand.ExecuteScalar();
                if (userCount > 0)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
        }
    }

    [WebMethod]
    public string GetStatus(string drivername, string password)
    {
        string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(CS))
        {
            conn.Open();
            var cmd = new SqlCommand();
            cmd.CommandText = "SELECT * FROM driverinfo WHERE(userid = @userid)";
            cmd.Parameters.AddWithValue("@userid", drivername);
            cmd.Connection = conn;
            var reader = cmd.ExecuteReader();
            int status = 0;
            string location = "sasf";
            string date = "sfdf";
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    status = Convert.ToInt32(reader["available"]);
                    date = reader["date"].ToString();
                    location = reader["location"].ToString();
                }
            }
            reader.Close();
            conn.Close();
            if (status == 1)
            {
                return "Currently Available in " + location + " as of " + date.ToString() + ".";
            }
            else
            {
                using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from driverinfo WHERE password = @password AND userid = @userid", conn))
                {
                    conn.Open();
                    sqlCommand.Parameters.AddWithValue("@userid", drivername);
                    sqlCommand.Parameters.AddWithValue("@password", password);
                    int userCount = (int)sqlCommand.ExecuteScalar();
                    if (userCount == 0)
                    {
                        return "Login Invalid";
                    }
                    else
                    {
                        return "Currently you are set to NOT available"; ;
                    }
                }
            }
        }
    }



    [WebMethod]
    public string updateVehicle(int compid, string truck, string location, string datetime)
    {
            string CS = ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(CS);
            using (SqlCommand sqlCommand = new SqlCommand("SELECT COUNT(*) from companyinfo WHERE compid = @compid", conn))
            {
                conn.Open();
                sqlCommand.Parameters.AddWithValue("@compid", compid);
                int userCount = (int)sqlCommand.ExecuteScalar();
                if (userCount == 0)
                {
                    return "Login Invalid";
                }
                else
                {
                    SqlDataAdapter da = new SqlDataAdapter("INSERT INTO Truck002 VALUES (@lastposition, @lastdateandtime, @name, @compid)", conn);
                    da.SelectCommand.Parameters.AddWithValue("@lastposition", location);
                    da.SelectCommand.Parameters.AddWithValue("@lastdateandtime", datetime);
                    da.SelectCommand.Parameters.AddWithValue("@name", truck);
                    da.SelectCommand.Parameters.AddWithValue("@compid", compid);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    return "Updated Successfully";
                }
            }
    }
}

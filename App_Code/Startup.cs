using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;
using Hangfire;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

[assembly: OwinStartup(typeof(Startup))]

public class Startup
{
    public void Configuration(IAppBuilder app)
    {

        
        GlobalConfiguration.Configuration.UseSqlServerStorage(ConfigurationManager.ConnectionStrings["TMSProgramConnectionString"].ConnectionString);
        var options = new DashboardOptions { AppPath = VirtualPathUtility.ToAbsolute("/testing.aspx") };
        app.UseHangfireDashboard("/hangfire", options);
        app.UseHangfireServer();
    }
}

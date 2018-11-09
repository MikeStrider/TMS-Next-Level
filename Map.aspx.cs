using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Map : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Request.QueryString["lat"] != null)
            {
                address.Value = Request.QueryString["lat"];
                address1.Value = Request.QueryString["long"];
                truckaddress.Value = Request.QueryString["marker"];
            } else
            {
                address.Value = "Windsor, ON";
                address1.Value = "Detroit, MI";
            }
        }
    }
}
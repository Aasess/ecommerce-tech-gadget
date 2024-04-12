using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Remove the "Username" and "isAdminLoggedIn" cookie
            if (Request.Cookies["Username"] != null)
            {
                Response.Cookies["Username"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["isAdminLoggedIn"].Expires = DateTime.Now.AddDays(-1);
            }

            // Redirect the user to the home page after logout
            Response.Redirect("~/Default");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieves value from cookies and populate input field
                HttpCookie username = Request.Cookies["Username"];
                txtUserName.Value = username?.Value;
            }
        }

        // Helper methods to set cookies 
        private void SetCookie(string name, string value, DateTime expiry)
        {
            HttpCookie cookie = new HttpCookie(name, value);
            cookie.Expires = expiry;
            Response.Cookies.Add(cookie);
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                // Check if the user is an admin (replace this with your actual admin validation logic)
                bool isAdmin = CheckAdminCredentials(txtUserName.Value, txtPassword.Value);
                    DateTime expiry = DateTime.Now.AddMinutes(5); // Set 5min expiry time

                SetCookie("Username", txtUserName.Value, expiry);
                if (isAdmin)
                {
                    SetCookie("isAdminLoggedIn", "true", expiry);

                    // Redirect to the Admin page
                    Response.Redirect("~/Admin");
                }
                else
                {
                    // Redirect to the Products page
                    Response.Redirect("~/Default");
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Redirect to the Home page i.e Default page
            Response.Redirect("~/Default");
        }

        private bool CheckAdminCredentials(string username, string password)
        {
            // Replace this with your actual database query to check admin credentials
            if (username == "admin" && password == "admin")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
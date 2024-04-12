using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Your code to process the form data goes here

            lblMessage.Text = "Your message has been sent successfully! Someone will contact you shortly";
            lblMessage.CssClass = "text-success";

          
        }

    }
}
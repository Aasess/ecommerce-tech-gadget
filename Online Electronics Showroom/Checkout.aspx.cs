using Online_Electronics_Showroom.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Checkout : System.Web.UI.Page
    {
        private Customer customer;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                customer = (Customer)Session["Customer"];
                LoadCustomerInfo();
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                GetCustomerInfo();

                // Display a message saying "Order Placed"
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Order Placed Successfully!!');", true);

                // Clear the cart and checkout form
                ClearCart();
                ClearCheckoutForm();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session.Remove("Customer");
            Response.Redirect("~/Cart");
        }

        private void LoadCustomerInfo()
        {
            if (customer != null)
            {
                txtFirstName.Text = customer.FirstName;
                txtLastName.Text = customer.LastName;
                txtEmail1.Text = customer.EmailAddress;
                txtPhone.Text = customer.Phone;
                txtAddress.Text = customer.Address;
                txtCity.Text = customer.City;
                txtZip.Text = customer.Zip;
                ddlState.SelectedValue = customer.State;
                txtShipAddress.Text = customer.ShippingAddress;
                txtShipCity.Text = customer.ShippingCity;
                ddlShipState.SelectedValue = customer.ShippingState;
                txtShipZip.Text = customer.ShippingZip;
            }
        }

        private void GetCustomerInfo()
        {
            if (customer == null) customer = new Customer();
            customer.FirstName = txtFirstName.Text;
            customer.LastName = txtLastName.Text;
            customer.EmailAddress = txtEmail1.Text;
            customer.Phone = txtPhone.Text;
            customer.Address = txtAddress.Text;
            customer.City = txtCity.Text;
            customer.State = ddlState.SelectedValue;
            customer.Zip = txtZip.Text;

            if (chkSameAsBilling.Checked)
            {
                customer.ShippingAddress = customer.Address;
                customer.ShippingCity = customer.City;
                customer.ShippingState = customer.State;
                customer.ShippingZip = customer.Zip;
            }
            else
            {
                customer.ShippingAddress = txtShipAddress.Text;
                customer.ShippingCity = txtShipCity.Text;
                customer.ShippingState = ddlShipState.SelectedValue;
                customer.ShippingZip = txtShipZip.Text;
            }
            Session["Customer"] = customer;
        }

        protected void chkSameAsBilling_CheckedChanged(object sender, EventArgs e)
        {
            rfvShipAddress.Enabled = !rfvShipAddress.Enabled;
            rfvShipCity.Enabled = !rfvShipCity.Enabled;
            rfvShipState.Enabled = !rfvShipState.Enabled;
            rfvShipZip.Enabled = !rfvShipZip.Enabled;

            txtShipAddress.Enabled = !txtShipAddress.Enabled;
            txtShipCity.Enabled = !txtShipCity.Enabled;
            ddlShipState.Enabled = !ddlShipState.Enabled;
            txtShipZip.Enabled = !txtShipZip.Enabled;
        }

        private void ClearCart()
        {
            Session.Remove("Cart");
        }

        private void ClearCheckoutForm()
        {
            // Reset the values of TextBoxes, DropDownList, etc.
            txtEmail1.Text = string.Empty;
            txtEmail2.Text = string.Empty;
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtCity.Text = string.Empty;
            ddlState.SelectedIndex = 0;
            txtZip.Text = string.Empty;

            // Clear shipping address if not same as billing
            if (!chkSameAsBilling.Checked)
            {
                txtShipAddress.Text = string.Empty;
                txtShipCity.Text = string.Empty;
                ddlShipState.SelectedIndex = 0;
                txtShipZip.Text = string.Empty;
            }

            // Clear any validation error messages
            rfvEmail1.ErrorMessage = string.Empty;
            rfvEmail2.ErrorMessage = string.Empty;
            rfvFirstName.ErrorMessage = string.Empty;
            rfvLastName.ErrorMessage = string.Empty;
            rfvPhoneNumber.ErrorMessage = string.Empty;
            rfvStreetAddress.ErrorMessage = string.Empty;
            rfvCity.ErrorMessage = string.Empty;
            rfvState.ErrorMessage = string.Empty;
            rfvZip.ErrorMessage = string.Empty;
            rfvShipAddress.ErrorMessage = string.Empty;
            rfvShipCity.ErrorMessage = string.Empty;
            rfvShipState.ErrorMessage = string.Empty;
            rfvShipZip.ErrorMessage = string.Empty;

            // Reset validation styles
            rfvEmail1.IsValid = true;
            revEmail1.IsValid = true;
            rfvEmail2.IsValid = true;
            cvEmail2.IsValid = true;
            rfvFirstName.IsValid = true;
            rfvLastName.IsValid = true;
            rfvPhoneNumber.IsValid = true;
            revPhoneNumber.IsValid = true;
            rfvStreetAddress.IsValid = true;
            rfvCity.IsValid = true;
            rfvState.IsValid = true;
            rfvZip.IsValid = true;
            rfvShipAddress.IsValid = true;
            rfvShipCity.IsValid = true;
            rfvShipState.IsValid = true;
            rfvShipZip.IsValid = true;

            // Clear checkbox for same as billing
            chkSameAsBilling.Checked = false;

            // Enable/disable shipping address controls based on the checkbox
            chkSameAsBilling_CheckedChanged(null, EventArgs.Empty);
        }
    }
}
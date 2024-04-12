using Online_Electronics_Showroom.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Cart : System.Web.UI.Page
    {
        private CartProductList cart;
        protected void Page_Load(object sender, EventArgs e)
        {
            cart = CartProductList.GetCart();
            if (!IsPostBack)
                this.DisplayCart();
        }

        private void DisplayCart()
        {
            lstCart.Items.Clear();
            CartProduct products;
            for (int i = 0; i < cart.Count; i++)
            {
                products = cart[i];
                lstCart.Items.Add(products.Display());
            }
        }

        protected void ProductRemove_Click(object sender, EventArgs e)
        {
            if (cart.Count > 0)
            {
                if (lstCart.SelectedIndex > -1)
                {
                    cart.RemoveAt(lstCart.SelectedIndex);
                    this.DisplayCart();
                }
                else
                {
                    lblErrorMessage.Text = "Please select the item you want to remove.";
                }
            }
        }

        protected void CartEmpty_Click(object sender, EventArgs e)
        {
            if (cart.Count > 0)
            {
                cart.Clear();
                lstCart.Items.Clear();
            }
        }

        protected void BtnCheckOut_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Checkout");
        }
    }
}
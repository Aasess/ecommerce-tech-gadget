using Online_Electronics_Showroom.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Products : System.Web.UI.Page
    {
        private Product selectedProduct;
        protected void Page_Load(object sender, EventArgs e)
        {
            //bind dropdown on first load; get and show product data on every load   
            if (!IsPostBack) ddlProducts.DataBind();
            selectedProduct = this.GetselectedProduct();

            // Check if selectedProduct is not null before accessing its properties
            if (selectedProduct != null)
            {
                lblName.Text = selectedProduct.Name;
                lblDescription.Text = selectedProduct.Description;
                lblUnitPrice.Text = selectedProduct.UnitPrice.ToString("c") + " each";
            }
            else
            {
                // Handle the case where selectedProduct is null
                lblName.Text = "No product selected";
                lblDescription.Text = "";
                lblUnitPrice.Text = "";
            }


            // get only first Name from cookie and set welcome message if it exists
            HttpCookie firstName = Request.Cookies["FirstName"];
            if (firstName != null)
                lblWelcome.Text = "<h4>welcome back, " + firstName.Value + "!</h4>";
        }

        private Product GetselectedProduct()
        {
            //get row from AccessDataSource based on value in dropdownlist
            DataView productsTable = (DataView)
                SqlDataSource1.Select(DataSourceSelectArguments.Empty);
            productsTable.RowFilter =
                "ProductID = '" + ddlProducts.SelectedValue + "'";

            // Check if productsTable contains any rows before accessing it
            if (productsTable.Count > 0)
            {
                DataRowView row = productsTable[0];

                //create a new product object and load with data from row
                Product b = new Product();
                b.ProductID = row["ProductID"].ToString();
                b.Name = row["Name"].ToString();
                b.Description = row["Description"].ToString();
                b.UnitPrice = (decimal)row["UnitPrice"];
                return b;
            }
            else
            {
                // Handle the case where productsTable is empty
                Console.WriteLine("No rows found in productsTable.");
                return null;
            }


        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                //get cart from session and selected Product from cart
                CartProductList cart = CartProductList.GetCart();
                CartProduct cartItem = cart[selectedProduct.ProductID];

                //if item is not in the cart then add it
                if (cartItem == null)
                {
                    cart.AddItem(selectedProduct, Convert.ToInt32(txtQuantity.Text));
                }
                //else increase the quantity for that Product
                else
                {
                    cartItem.AddQuantity(Convert.ToInt32(txtQuantity.Text));
                }
                Response.Redirect("Cart");
            }
        }
    }
}
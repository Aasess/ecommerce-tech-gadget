﻿using Online_Electronics_Showroom.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
            // Check if the query string contains the "ProductId" parameter
            if (!string.IsNullOrEmpty(Request.QueryString["ProductId"]))
            {
                // Extract the product ID from the query string
                int productId;
                if (int.TryParse(Request.QueryString["ProductId"], out productId))
                {
                    // Get the selected product based on the product ID from the query string
                    selectedProduct = GetProductById(productId);

                    // Check if selectedProduct is not null before accessing its properties
                    if (selectedProduct != null)
                    {
                        lblName.Text = selectedProduct.Name;
                        lblDescription.Text = selectedProduct.Description;
                        lblUnitPrice.Text = selectedProduct.UnitPrice.ToString("c") + " each";
                        imgProduct.ImageUrl = selectedProduct.ImageUrl;
                    }
                    else
                    {
                        // Handle the case where selectedProduct is null
                        lblName.Text = "No product found";
                        lblDescription.Text = "";
                        lblUnitPrice.Text = "";
                    }
                }
                else
                {
                    // Handle the case where the "ProductId" parameter in the query string is not a valid integer
                    lblName.Text = "Invalid product ID";
                    lblDescription.Text = "";
                    lblUnitPrice.Text = "";
                }
            }
            else
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
                    imgProduct.ImageUrl = selectedProduct.ImageUrl;
                }
                else
                {
                    // Handle the case where selectedProduct is null
                    lblName.Text = "No product selected";
                    lblDescription.Text = "";
                    lblUnitPrice.Text = "";
                }

            }

            // get only first Name from cookie and set welcome message if it exists
            HttpCookie username = Request.Cookies["Username"];
            if (username != null)
                lblWelcome.Text = "<h4>welcome back, " + username.Value + "!</h4>";
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
                b.ImageUrl = row["ImagePath"].ToString(); // Add ImagePath to Product
                return b;
            }
            else
            {
                // Handle the case where productsTable is empty
                Console.WriteLine("No rows found in products Table.");
                return null;
            }
        }

        private Product GetProductById(int productId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ProductStoreCollection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ProductID, Name, Description, UnitPrice, ImagePath FROM Products WHERE ProductID = @ProductId", con))
                {
                    cmd.Parameters.AddWithValue("@ProductId", productId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        // Create a new product object and load it with data from the database
                        Product product = new Product();
                        product.ProductID = reader["ProductID"].ToString();
                        product.Name = reader["Name"].ToString();
                        product.Description = reader["Description"].ToString();
                        product.UnitPrice = (decimal)reader["UnitPrice"];
                        product.ImageUrl = reader["ImagePath"].ToString(); // Add ImagePath to Product
                        return product;
                    }
                    else
                    {
                        // Return null if no product is found with the given product ID
                        return null;
                    }
                }
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
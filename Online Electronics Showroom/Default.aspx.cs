using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateCategories();
            }
        }

        private void PopulateCategories()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ProductStoreCollection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT categoryID, longName FROM Category", con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        int categoryId = Convert.ToInt32(reader["categoryID"]);
                        string categoryName = reader["longName"].ToString();
                        DisplayCategory(categoryId, categoryName);
                    }
                }
            }
        }

        private void DisplayCategory(int categoryId, string categoryName)
        {
            string html = "<div class='category-container'>";
            html += $"<h2>{categoryName}</h2>";
            html += "<div class='row'>";

            // Retrieve products for the current category
            DataTable productsTable = GetProductsByCategory(categoryId);
            foreach (DataRow row in productsTable.Rows)
            {
                string productName = row["Name"].ToString();
                decimal unitPrice = Convert.ToDecimal(row["UnitPrice"]);
                int quantity = Convert.ToInt32(row["Quantity"]);
                int productId = Convert.ToInt32(row["ProductID"]);

                html += "<div class='col-md-4'>";
                html += "<div class='card mb-4 shadow-sm'>";
                html += "<div class='card-body'>";
                html += $"<h3 class='card-title'>{productName}</h3>";
                html += $"<p class='card-text'>Price: ${unitPrice}</p>";
                html += $"<p class='card-text'>Quantity Available: {quantity}</p>";
                // Add a button to navigate to the Products.aspx page with the selected product's details
                html += $"<a href='Products.aspx?ProductId={productId}' class='btn btn-primary'>View Product</a>";
                html += "</div></div></div>";
            }

            html += "</div></div>";

            // Find the content placeholder in the master page and add the HTML content
            ContentPlaceHolder mainContent = (ContentPlaceHolder)Master.FindControl("mainPlaceholder");
            mainContent.Controls.Add(new LiteralControl(html));
        }

        private DataTable GetProductsByCategory(int categoryId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ProductStoreCollection"].ConnectionString;
            DataTable productsTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE CategoryID = @CategoryId", con))
                {
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    productsTable.Load(reader);
                }
            }
            return productsTable;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Online_Electronics_Showroom
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        // Button click event to add a new Category
        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string CategoryId = addcategoryID.Text;
                string shortName = addCategoryShortName.Text;
                string longName = addCategoryLongName.Text;

                // Check if CategoryId already exists
                if (IsCategoryIdExists(CategoryId))
                {
                    cvcategoryIDExists.IsValid = false;
                    return;
                }

                using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ProductstoreCollection"].ConnectionString))
                {
                    string query = "INSERT INTO [Category] ([CategoryID], [shortName], [longName]) VALUES (@CategoryID, @shortName, @longName)";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@CategoryID", CategoryId);
                    cmd.Parameters.AddWithValue("@shortName", shortName);
                    cmd.Parameters.AddWithValue("@longName", longName);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Clear the category form
                addcategoryID.Text = "";
                addCategoryShortName.Text = "";
                addCategoryLongName.Text = "";

                // Refresh the GridView and DropDownList to display the newly added Category
                GridViewCategory.DataBind();
                ddlCategory.DataBind();
            }
        }

        private bool IsCategoryIdExists(string CategoryId)
        {
            using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ProductstoreCollection"].ConnectionString))
            {
                string query = "SELECT COUNT(*) FROM [Category] WHERE [CategoryID] = @CategoryID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CategoryID", CategoryId);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        protected void cvCategoryIdExists_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = !IsCategoryIdExists(addcategoryID.Text);
        }

        protected void ctl03_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            // Rebind the DetailsView
            ctl02.DataBind();
            GridViewCategory.DataBind();

        }

        protected void ctl03_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            // Rebind the DetailsView
            ctl02.DataBind();
            sdsCategorys.DataBind();
        }

        protected void ctl03_ItemAdded(object sender, EventArgs e)
        {
            // Rebind the DetailsView
            sdsCategorys.DataBind();
            ctl02.DataBind();
        }
        protected void ctl02_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Rebind the DetailsView to display the selected book details
            ctl03.DataBind();
        }

        protected void GridViewCategory_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            // Refresh the DropDownList to reflect the changes after deletion
            ddlCategory.DataBind();
            sdsCategorys.DataBind();
            GridViewCategory.DataBind();
        }

        protected void GridViewCategory_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            // Refresh the DropDownList to reflect the changes after update
            ddlCategory.DataBind();
            sdsCategorys.DataBind();
            GridViewCategory.DataBind();
        }


        private string DatabaseErrorMessage(string message)
        {
            return "Database error: " + message;
        }
    }
}
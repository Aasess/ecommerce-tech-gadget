using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
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
            HttpCookie isAdminLoggedIn = Request.Cookies["isAdminLoggedIn"];

            if (isAdminLoggedIn != null && isAdminLoggedIn.Value == "true")
            {
                // User is logged in as admin, display admin.aspx page
            }
            else
            {
                // User is not logged in as admin, redirect to login page
                Response.Redirect("Login");
            }
        }


        // Button click event to add a new Category
        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string shortName = addCategoryShortName.Text;
                string longName = addCategoryLongName.Text;

                using (SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ProductstoreCollection"].ConnectionString))
                {
                    string query = "INSERT INTO [Category] ([shortName], [longName]) VALUES (@shortName, @longName)";

                    SqlCommand cmd = new SqlCommand(query, conn);                
                    cmd.Parameters.AddWithValue("@shortName", shortName);
                    cmd.Parameters.AddWithValue("@longName", longName);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Clear the category form
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
            //args.IsValid = !IsCategoryIdExists(addcategoryID.Text);
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

        protected void ctl03_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Update" || e.CommandName == "Insert")
            {
                FileUpload FileUpload1 = ctl03.FindControl("FileUpload1") as FileUpload;
                if (FileUpload1 != null && FileUpload1.HasFile)
                {
                    try
                    {
                        // Specify the path where you want to save the file
                        string fileName = Path.GetFileName(FileUpload1.FileName);
                        string filePath = "~/Images/" + fileName; // Assuming Images folder is in the root directory

                        // Save the file to the server
                        FileUpload1.SaveAs(Server.MapPath(filePath));

                        // Set the image path parameter for the InsertCommand or UpdateCommand
                        SqlDataSource8.InsertParameters["ImagePath"].DefaultValue = filePath;
                        SqlDataSource8.UpdateParameters["ImagePath"].DefaultValue = filePath;
                    }
                    catch (Exception ex)
                    {
                        // Handle any errors that may occur during file upload
                        // Response.Write("Error uploading file: " + ex.Message);
                    }
                }
            }
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
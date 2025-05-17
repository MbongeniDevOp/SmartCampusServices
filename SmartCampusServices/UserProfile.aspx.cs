using System;
using Npgsql;

namespace SmartCampusServices
{
    public partial class UserProfile : System.Web.UI.Page
    {
        private static readonly string _connString = GetConnectionString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            txtFullName.Text = Session["LoggedInFullName"]?.ToString();
            txtEmail.Text = Session["LoggedInEmail"]?.ToString();
            txtRole.Text = Session["LoggedInRole"]?.ToString();
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                DisplayMessage("Passwords do not match.", true);
                return;
            }

            try
            {
                using (var conn = new NpgsqlConnection(_connString))
                {
                    conn.Open();
                    string query = "UPDATE users SET email = @p_email, password = @p_password WHERE email = @p_oldEmail";

                    using (var cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("p_email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("p_password", txtNewPassword.Text.Trim());
                        cmd.Parameters.AddWithValue("p_oldEmail", Session["LoggedInEmail"]);

                        int rows = cmd.ExecuteNonQuery();
                        if (rows > 0)
                        {
                            DisplayMessage("Profile updated successfully.", false);
                            Session["LoggedInEmail"] = txtEmail.Text.Trim();
                        }
                        else
                        {
                            DisplayMessage("Failed to update profile.", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage($"Error: {ex.Message}", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            LoadUserProfile();
        }

        private static string GetConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
        }

        private void DisplayMessage(string message, bool isError)
        {
            lblMessage.CssClass = isError ? "alert alert-danger" : "alert alert-success";
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }
    }
}

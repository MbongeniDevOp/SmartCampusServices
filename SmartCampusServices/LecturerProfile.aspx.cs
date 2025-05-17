using System;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class LecturerProfile : System.Web.UI.Page
    {
        private static readonly string _connString = GetConnectionString();
        private Logger _logger = new Logger();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLecturerProfile();
                InitialiseVisibilityLinks();
            }
        }

        private void LoadLecturerProfile()
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
            LoadLecturerProfile();
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

        private void InitialiseVisibilityLinks()
        {
            try
            {
                LinkButton logout = (LinkButton)Master.FindControl("lnkLogout");
                LinkButton helloUser = (LinkButton)Master.FindControl("lnkHelloUser");
                LinkButton login = (LinkButton)Master.FindControl("lnkLogin");
                LinkButton viewSchedules = (LinkButton)Master.FindControl("lnkViewSchedules");
                LinkButton notificationBtn = (LinkButton)Master.FindControl("lnkNotifications");
                Image imgLogin = (Image)Master.FindControl("imgLogin");

                string fullName = Session["LoggedInFullName"]?.ToString();

                if (!string.IsNullOrEmpty(fullName))
                {
                    login.Visible = false;
                    viewSchedules.Visible = true;
                    logout.Visible = true;
                    helloUser.Visible = true;
                    helloUser.Text = $"Hello, {fullName}";
                    imgLogin.Visible = true;
                    notificationBtn.Visible = true;
                }
                else
                {
                    login.Visible = true;
                    viewSchedules.Visible = false;
                    logout.Visible = false;
                    helloUser.Visible = false;
                    imgLogin.Visible = false;
                    notificationBtn.Visible = false;
                }
            }
            catch (Exception ex)
            {
                _logger.LogToFile($"Error in InitialiseVisibilityLinks: {ex.Message}");
            }
        }
    }
}
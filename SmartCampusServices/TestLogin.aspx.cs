using System;
using System.Web.UI;
using Npgsql;

namespace SmartCampusServices
{
    public partial class TestLogin : System.Web.UI.Page
    {
        private static readonly Logger _logger = new Logger();
        private static readonly string _connString = GetConnectionString();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Nothing on page load
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
            {
                DisplayMessage("Please enter both email and password.", isError: true);
                _logger.LogToFile("Login attempt failed. Email or password was empty.");
                return;
            }

            _logger.LogToFile($"Login attempt for email: {email}");

            try
            {
                using (var conn = new NpgsqlConnection(_connString))
                {
                    conn.Open();
                    _logger.LogToFile("Connected to database successfully.");

                    string query = @"
            SELECT id, email, full_name, role
            FROM users
            WHERE TRIM(email) ILIKE TRIM(@p_email)
              AND TRIM(password) = TRIM(@p_password)
            LIMIT 1;
        ";

                    using (var cmd = new NpgsqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("p_email", email);
                        cmd.Parameters.AddWithValue("p_password", password);

                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string fullName = reader["full_name"]?.ToString();
                                string role = reader["role"]?.ToString();
                                DisplayMessage($"Welcome {fullName} ({role})!", isError: false);

                                // Set session variables
                                Session["LoggedInEmail"] = email;
                                Session["LoggedInPassword"] = password;
                                Session["LoggedInFullName"] = fullName;
                                Session["LoggedInRole"] = role;

                                // Redirect based on role
                                switch (role.ToLower())
                                {
                                    case "admin":
                                        _logger.LogToFile($"Admin Login successful. User: {fullName} ({role})");
                                        Response.Redirect("~/AdminLogin.aspx");
                                        break;

                                    case "lecturer":
                                        _logger.LogToFile($"Lecturer Login successful. User: {fullName} ({role})");
                                        Response.Redirect("~/LecturerPage.aspx");
                                        break;

                                    case "student":
                                        _logger.LogToFile($"Student Login successful. User: {fullName} ({role})");
                                        Response.Redirect("~/studentlogin.aspx");
                                        break;

                                    default:
                                        DisplayMessage("Invalid role specified.", isError: true);
                                        _logger.LogToFile($"Login failed due to unknown role: {role}");
                                        break;
                                }
                            }
                            else
                            {
                                DisplayMessage("Invalid email or password.", isError: true);
                                _logger.LogToFile($"Login failed. Invalid credentials for email: {email}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage($"Error: {ex.Message}", isError: true);
                _logger.LogToFile($"Exception: {ex.Message} | Stack Trace: {ex.StackTrace}");
            }
        }


        private static string GetConnectionString()
        {
            // Check for environment variable (useful for platforms like Render)
            string envConn = Environment.GetEnvironmentVariable("POSTGRES_CONNECTION");
            if (!string.IsNullOrEmpty(envConn))
                return envConn;

            // Fallback to Web.config if environment variable is not set
            return System.Configuration.ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
        }

        private void DisplayMessage(string message, bool isError)
        {
            // Update UI label based on the result (error or success)
            lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            lblMessage.Text = message;
        }
    }
}

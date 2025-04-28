using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class TestLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            Logger logger = new Logger();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both email and password.";
                logger.LogToFile("Login attempt failed. Email or password was empty.");
                return;
            }

            string connString = "Host=172.20.10.1;Port=5432;Username=postgres;Password=Smart@campus1;Database=postgres;SSL Mode=Require;Trust Server Certificate=true;";

            try
            {
                logger.LogToFile($"Login attempt for email: {email}");

                using (var conn = new NpgsqlConnection(connString))
                {
                    conn.Open();
                    logger.LogToFile("Connection to the database was successful.");

                    using (var cmd = new NpgsqlCommand("SELECT * FROM get_user_login(@p_email, @p_password)", conn))
                    {
                        cmd.Parameters.AddWithValue("p_email", email);
                        cmd.Parameters.AddWithValue("p_password", password);

                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string fullName = reader["full_name"].ToString();
                                string role = reader["role"].ToString();

                                lblMessage.ForeColor = System.Drawing.Color.Green;
                                lblMessage.Text = $"Welcome {fullName} ({role})!";
                                logger.LogToFile($"Login successful. User: {fullName} ({role})");
                            }
                            else
                            {
                                lblMessage.Text = "Invalid email or password.";
                                logger.LogToFile($"Login failed. Invalid credentials for email: {email}");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error: {ex.Message}";
                logger.LogToFile($"Error: {ex.Message} | Stack Trace: {ex.StackTrace}");
            }
        }
        
    }
}

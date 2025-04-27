using System;
using System.Collections.Generic;
using System.Linq;
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

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter both email and password.";
                return;
            }

            string connString = "Host=db.enqvqdivozqrnknsgqws.supabase.co;Port=5432;Username=postgres;Password=Smart@campus1;Database=postgres;SslMode=Require;Trust Server Certificate=true;";

            try
            {
                using (var conn = new NpgsqlConnection(connString))
                {
                    conn.Open();

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
                            }
                            else
                            {
                                lblMessage.Text = "Invalid email or password.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error: {ex.Message}";
            }
        }
    }
}
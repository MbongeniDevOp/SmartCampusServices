using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        private static readonly Logger _logger = new Logger();
        private static readonly string _connString = GetConnectionString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //try
                //{
                //    using (var conn = new NpgsqlConnection(_connString))
                //    {
                //        conn.Open();
                //        _logger.LogToFile("Connected to database successfully.");

                //        string email = Session["LoggedInEmail"]?.ToString() ?? "admin@tut.ac.za";
                //        string password = Session["LoggedInPassword"]?.ToString() ?? "admin123";

                //        string query = @"
                //        SELECT id, email, full_name, role
                //        FROM users
                //        WHERE TRIM(email) ILIKE TRIM(@p_email)
                //          AND TRIM(password) = TRIM(@p_password)
                //        LIMIT 1;";

                //        using (var cmd = new NpgsqlCommand(query, conn))
                //        {
                //            cmd.Parameters.AddWithValue("p_email", email);
                //            cmd.Parameters.AddWithValue("p_password", password);

                //            using (var reader = cmd.ExecuteReader())
                //            {
                //                if (reader.Read())
                //                {
                //                    string fullName = reader["full_name"]?.ToString();
                //                    string role = reader["role"]?.ToString();

                //                    if (!string.IsNullOrEmpty(fullName))
                //                    {
                //                        LinkButton logout = (LinkButton)Master.FindControl("lnkLogout");
                //                        LinkButton helloUser = (LinkButton)Master.FindControl("lnkHelloUser");
                //                        LinkButton login = (LinkButton)Master.FindControl("lnkLogin");
                //                        LinkButton viewSchedules = (LinkButton)Master.FindControl("lnkViewSchedules");
                //                        LinkButton imgLogin = (LinkButton)Master.FindControl("imgLogin");

                //                        login.Visible = false;
                //                        viewSchedules.Visible = true;
                //                        logout.Visible = true;
                //                        helloUser.Visible = true;
                //                        helloUser.Text = $"Hello, {fullName}";
                //                        imgLogin.Visible = true;
                //                    }
                //                }
                //                else
                //                {
                //                    DisplayMessage("Invalid email or password.", isError: true);
                //                    _logger.LogToFile($"Login failed. Invalid credentials for email: {email}");
                //                }
                //            }
                //        }
                //    }
                //}
                //catch (Exception ex)
                //{
                //    DisplayMessage($"Error: {ex.Message}", isError: true);
                //    _logger.LogToFile($"Exception: {ex.Message} | Stack Trace: {ex.StackTrace}");
                //}

                if (!IsPostBack)
                {
                    string fullName = Session["LoggedInFullName"]?.ToString();
                    if (!string.IsNullOrEmpty(fullName))
                    {
                        LinkButton logout = (LinkButton)Master.FindControl("lnkLogout");
                        LinkButton helloUser = (LinkButton)Master.FindControl("lnkHelloUser");
                        LinkButton login = (LinkButton)Master.FindControl("lnkLogin");
                        LinkButton viewSchedules = (LinkButton)Master.FindControl("lnkViewSchedules");
                        LinkButton notificationBtn = (LinkButton)Master.FindControl("lnkNotifications");
                        Image imgLogin = (Image)Master.FindControl("imgLogin");
                        bool isLoggedIn = !string.IsNullOrEmpty(fullName);
                        imgLogin.Visible = isLoggedIn;

                        login.Visible = false;
                        viewSchedules.Visible = true;
                        logout.Visible = true;
                        helloUser.Visible = true;
                        notificationBtn.Visible = true;
                        helloUser.Text = $"Hello, {fullName}";
                    }
                }
            }
        }

        private static string GetConnectionString()
        {
            string envConn = Environment.GetEnvironmentVariable("POSTGRES_CONNECTION");
            return !string.IsNullOrEmpty(envConn)
                ? envConn
                : System.Configuration.ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
        }

        private void DisplayMessage(string message, bool isError)
        {
            //lblMessage.ForeColor = isError ? System.Drawing.Color.Red : System.Drawing.Color.Green;
            //lblMessage.Text = message;
        }
    }
}

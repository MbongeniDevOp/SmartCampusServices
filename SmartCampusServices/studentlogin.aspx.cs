using Npgsql;
using System;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCampusServices
{
    public partial class studentlogin : System.Web.UI.Page
    {
        private Logger _logger = new Logger();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitialiseVisibilityLinks();
            }
        }

        private void BindScheduleTable()
        {
            // Get the connection string from the web.config file
            string connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                try
                {
                    string query = @"
                                SELECT first_name || ' ' || last_name AS student_name, date_of_birth, phone_number, enrolment_date
                                FROM students";

                    // Set up the data adapter to fetch the data
                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);  // Fill the DataTable with data from the query

                        StringBuilder sb = new StringBuilder();

                        // Start the table
                        sb.Append("<table id='scheduleTable' class='display table table-striped' style='width: 100%'>");

                        // Add the table header
                        sb.Append("<thead><tr>");
                        sb.Append("<th>Student Name</th>");
                        sb.Append("<th>Date of Birth</th>");
                        sb.Append("<th>Phone Number</th>");
                        sb.Append("<th>Enrolment Date</th>");
                        sb.Append("</tr></thead>");

                        // Add the table body with rows from the DataTable
                        sb.Append("<tbody>");
                        foreach (DataRow row in dt.Rows)
                        {
                            sb.Append("<tr>");
                            sb.AppendFormat("<td>{0}</td>", row["student_name"]); // Correct column name
                            sb.AppendFormat("<td>{0}</td>", row["date_of_birth"]); // Correct column name
                            sb.AppendFormat("<td>{0}</td>", row["phone_number"]); // Correct column name
                            sb.AppendFormat("<td>{0}</td>", row["enrolment_date"]); // Correct column name
                            sb.Append("</tr>");
                        }
                        sb.Append("</tbody>");

                        // Close the table
                        sb.Append("</table>");

                        // Output the generated table HTML into the Literal control
                        ltTableBody.Text = sb.ToString();
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogToFile($"Exception Caught: {ex.Message}");
                    Response.Write("Exception error... Refer to log file...");
                }
            }
        }

        private void InitialiseVisibilityLinks()
        {
            // Handle visibility of master page links
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
                bool isUserLoggedIn = !string.IsNullOrEmpty(fullName);
                imgLogin.Visible = isUserLoggedIn;
                notificationBtn.Visible = true;
            }
            else
            {
                login.Visible = true;
                viewSchedules.Visible = false;
                logout.Visible = false;
                helloUser.Visible = false;
            }

            // Bind schedule table
            BindScheduleTable();
        }
    }
}

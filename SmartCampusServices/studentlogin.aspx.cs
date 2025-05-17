using System;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class StudentPage
    {
        private Logger _logger = new Logger();

        // Properties to expose counts to the ASPX page
        public int CoursesCount { get; set; } = 0;
        public int ExamsCount { get; set; } = 0;
        public int AssignmentsCount { get; set; } = 0;
        public int AnnouncementsCount { get; set; } = 0;
        public string ActivitiesTableRows { get; set; } = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["LoggedInFullname"] == null)
            {
                Response.Redirect("~/TestLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
                InitialiseVisibilityLinks();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadDashboardData();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/TestLogin.aspx");
        }

        private void LoadDashboardData()
        {
            try
            {
                int studentId = Convert.ToInt32(Session["LoggedInUserID"]);

                using (var conn = new NpgsqlConnection(ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString))
                {
                    conn.Open();

                    // 1. Get counts
                    CoursesCount = GetCount(conn, $"SELECT COUNT(*) FROM enrollments WHERE student_id = {studentId}");
                    ExamsCount = GetCount(conn, $"SELECT COUNT(*) FROM exams WHERE course_id IN (SELECT course_id FROM enrollments WHERE student_id = {studentId}) AND exam_date >= CURRENT_DATE");
                    AssignmentsCount = GetCount(conn, $"SELECT COUNT(*) FROM assignments WHERE course_id IN (SELECT course_id FROM enrollments WHERE student_id = {studentId}) AND due_date >= CURRENT_DATE AND status = 'Pending'");
                    AnnouncementsCount = GetCount(conn, "SELECT COUNT(*) FROM announcements WHERE publish_date >= CURRENT_DATE");

                    // 2. Load activities table rows
                    ActivitiesTableRows = GetActivitiesTableRows(conn, studentId);
                }
            }
            catch (Exception ex)
            {
                _logger.LogToFile($"Exception in LoadDashboardData: {ex.Message}");
            }
        }

        private int GetCount(NpgsqlConnection conn, string query)
        {
            using (var cmd = new NpgsqlCommand(query, conn))
            {
                var result = cmd.ExecuteScalar();
                return result != DBNull.Value ? Convert.ToInt32(result) : 0;
            }
        }

        private string GetActivitiesTableRows(NpgsqlConnection conn, int studentId)
        {
            string query = @"
                SELECT a.activity_id, a.activity_name, a.due_date, a.status
                FROM activities a
                WHERE a.student_id = @studentId
                ORDER BY a.due_date ASC";

            using (var cmd = new NpgsqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@studentId", studentId);

                using (var reader = cmd.ExecuteReader())
                {
                    StringBuilder sb = new StringBuilder();

                    while (reader.Read())
                    {
                        sb.Append("<tr>");
                        sb.AppendFormat("<td>{0}</td>", reader["activity_id"]);
                        sb.AppendFormat("<td>{0}</td>", HttpUtility.HtmlEncode(reader["activity_name"].ToString()));
                        sb.AppendFormat("<td>{0:yyyy-MM-dd}</td>", reader["due_date"]);
                        sb.AppendFormat("<td>{0}</td>", reader["status"]);
                        sb.AppendFormat("<td><a href='ActivityDetails.aspx?id={0}' class='btn btn-info btn-sm'>View</a></td>", reader["activity_id"]);
                        sb.Append("</tr>");
                    }

                    return sb.ToString();
                }
            }
        }

        private void InitialiseVisibilityLinks()
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

            BindScheduleTable();
        }

        private void BindScheduleTable()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                try
                {
                    string query = @"
                        SELECT first_name || ' ' || last_name AS student_name, 
                               date_of_birth, 
                               phone_number, 
                               enrolment_date
                        FROM students";

                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        StringBuilder sb = new StringBuilder();

                        sb.Append("<table id='scheduleTable' class='display table table-striped' style='width: 100%'>");

                        sb.Append("<thead><tr>");
                        sb.Append("<th>Student Name</th>");
                        sb.Append("<th>Date of Birth</th>");
                        sb.Append("<th>Phone Number</th>");
                        sb.Append("<th>Enrolment Date</th>");
                        sb.Append("</tr></thead>");

                        sb.Append("<tbody>");
                        foreach (DataRow row in dt.Rows)
                        {
                            sb.Append("<tr>");
                            sb.AppendFormat("<td>{0}</td>", row["student_name"]);
                            sb.AppendFormat("<td>{0:yyyy-MM-dd}</td>", row["date_of_birth"]);
                            sb.AppendFormat("<td>{0}</td>", row["phone_number"]);
                            sb.AppendFormat("<td>{0:yyyy-MM-dd}</td>", row["enrolment_date"]);
                            sb.Append("</tr>");
                        }
                        sb.Append("</tbody>");

                        sb.Append("</table>");

                        // Ensure the Literal control is set correctly
                       // ltTableBody.Text = sb.ToString();
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogToFile($"Exception Caught: {ex.Message}");
                    Response.Write("Exception error... Refer to log file...");
                }
            }
        }
    }
}

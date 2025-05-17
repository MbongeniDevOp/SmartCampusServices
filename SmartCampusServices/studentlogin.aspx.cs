using System;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class studentlogin : Page
    {
        // Logger definition - Create a basic one if you don't have it
        private Logger _logger = new Logger();

        // Dashboard Counts
        public int CoursesCount { get; set; } = 0;
        public int ExamsCount { get; set; } = 0;
        public int AssignmentsCount { get; set; } = 0;
        public int AnnouncementsCount { get; set; } = 0;
        public string ActivitiesTableRows { get; set; } = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedInFullName"] == null)
            {
                Response.Redirect("~/TestLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadDashboardData();
                InitialiseVisibilityLinks();
                Page.DataBind(); // <-- This will bind your properties to the ASPX page
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadDashboardData();
            Page.DataBind();
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

                    CoursesCount = GetCount(conn, "SELECT COUNT(*) FROM enrollments WHERE student_id = @studentId", studentId);
                    ExamsCount = GetCount(conn, "SELECT COUNT(*) FROM exams WHERE course_id IN (SELECT course_id FROM enrollments WHERE student_id = @studentId) AND exam_date >= CURRENT_DATE", studentId);
                    AssignmentsCount = GetCount(conn, "SELECT COUNT(*) FROM assignments WHERE course_id IN (SELECT course_id FROM enrollments WHERE student_id = @studentId) AND due_date >= CURRENT_DATE AND status = 'Pending'", studentId);
                    AnnouncementsCount = GetCount(conn, "SELECT COUNT(*) FROM announcements WHERE publish_date >= CURRENT_DATE");

                    ActivitiesTableRows = GetActivitiesTableRows(conn, studentId);
                }
            }
            catch (Exception ex)
            {
                _logger.LogToFile($"Exception in LoadDashboardData: {ex.Message}");
            }
        }

        private int GetCount(NpgsqlConnection conn, string query, int studentId = 0)
        {
            using (var cmd = new NpgsqlCommand(query, conn))
            {
                if (studentId > 0)
                    cmd.Parameters.AddWithValue("@studentId", studentId);

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

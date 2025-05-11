using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class LecturerPage : System.Web.UI.Page
    {
        private static Logger _logger = new Logger();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitialiseVisibilityLinks();
            }
        }

        // Example: Get the data for Lecturer Dashboard
        [System.Web.Services.WebMethod]
        public static object GetLecturerDashboardData()
        {
            // Create a connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                try
                {
                    // Initialize response object
                    var response = new
                    {
                        Courses = 0,  // Total courses
                        Assessments = 0,  // Total pending assessments
                        Students = 0,  // Total students
                        Deadlines = 0,  // Upcoming deadlines
                        CourseList = new[] { new { CourseID = "123", CourseName = "Math 101", EnrolledStudents = 40 } } // Example Course List
                    };

                    // Example: Query to get the lecturer's assigned courses
                    string query = @"
                        SELECT course_id, course_name, 
                               (SELECT COUNT(*) FROM students WHERE course_id = courses.course_id) AS enrolled_students
                        FROM courses
                        WHERE lecturer_id = @LecturerID"; // Assume lecturer ID is fetched from session or other means

                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Processing and populating response with real data
                        var courseList = new List<object>();
                        foreach (DataRow row in dt.Rows)
                        {
                            courseList.Add(new
                            {
                                CourseID = row["course_id"],
                                CourseName = row["course_name"],
                                EnrolledStudents = row["enrolled_students"]
                            });
                        }

                        object[] vs = courseList.ToArray();
                        //response.CourseList = vs;

                        // Add logic to get the remaining dashboard data (e.g., assessments, students count)
                        return response;
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogToFile($"Exception Caught: {ex.Message}");
                    return null; // Handle exceptions
                }
            }
        }

        private void InitialiseVisibilityLinks()
        {
            // Handle visibility of master page links
            LinkButton logout = (LinkButton)Master.FindControl("lnkLogout");
            LinkButton helloUser = (LinkButton)Master.FindControl("lnkHelloUser");
            LinkButton login = (LinkButton)Master.FindControl("lnkLogin");
            //LinkButton viewCourses = (LinkButton)Master.FindControl("lnkViewCourses");
            LinkButton notificationBtn = (LinkButton)Master.FindControl("lnkNotifications");
            Image imgLogin = (Image)Master.FindControl("imgLogin");

            string fullName = Session["LoggedInFullName"]?.ToString();

            if (!string.IsNullOrEmpty(fullName))
            {
                login.Visible = false;
               // viewCourses.Visible = true;
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
                //viewCourses.Visible = false;
                logout.Visible = false;
                helloUser.Visible = false;
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Services;
using Npgsql;

namespace SmartCampusServices
{
    public partial class LecturerPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to login if no session
            if (Session["LoggedInFullname"] == null)
            {
                Response.Redirect("TestLogin.aspx");
            }
        }

        [WebMethod]
        public static object GetDashboardData(string type)
        {
            string lecturerID ="0";
            try
            {
                lecturerID = Convert.ToInt32(System.Web.HttpContext.Current.Session["LecturerID"]).ToString();
            }
            catch
            {
                return new { Error = "Session expired. Please log in again." };
            }

            var connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;

            var result = new
            {
                Courses = 0,
                Assessments = 0,
                Students = 0,
                //Deadlines = 0,
                CourseList = new List<object>()
            };

            using (var conn = new NpgsqlConnection(connStr))
            {
                conn.Open();

                int courses = ExecuteScalarInt(conn, "SELECT COUNT(*) FROM course WHERE lecturer_id = @lecturerID", lecturerID);
                int assessments = ExecuteScalarInt(conn, "SELECT COUNT(*) FROM assignments WHERE lecturer_id = @lecturerID AND status = 'Pending'", lecturerID);
                int students = ExecuteScalarInt(conn, "SELECT COUNT(DISTINCT student_id) FROM enrollments WHERE lecturer_id = @lecturerID", lecturerID);
                //int deadlines = ExecuteScalarInt(conn,
                //    "SELECT COUNT(*) FROM deadlines WHERE lecturer_id = @lecturerID AND deadline_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'",
                //    lecturerID);

                var coursesList = new List<object>();
                string sqlCourseList = @"
                    SELECT course_id, course_name, course_code, department
                    FROM course";

                using (var cmd = new NpgsqlCommand(sqlCourseList, conn))
                {
                    cmd.Parameters.AddWithValue("lecturerID", lecturerID);
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            coursesList.Add(new
                            {
                                CourseID = reader["course_id"],
                                CourseName = reader["course_name"],
                                CourseCode = reader["course_code"],
                                Department = reader["department"]
                            });
                        }
                    }
                }

                result = new
                {
                    Courses = courses,
                    Assessments = assessments,
                    Students = students,
                    //Deadlines = deadlines,
                    CourseList = coursesList
                };
            }

            return result;
        }

        private static int ExecuteScalarInt(NpgsqlConnection conn, string sql, string lecturerID)
        {
            using (var cmd = new NpgsqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("lecturerID", lecturerID);
                var val = cmd.ExecuteScalar();
                if (val != null && int.TryParse(val.ToString(), out int count))
                {
                    return count;
                }
                return 0;
            }
        }
    }
}

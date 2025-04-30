using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;
using System.Configuration;
using System.Data;

namespace SmartCampusServices
{
    public partial class ViewSchedules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Handle visibility of master page links
                LinkButton logout = (LinkButton)Master.FindControl("lnkLogout");
                LinkButton helloUser = (LinkButton)Master.FindControl("lnkHelloUser");
                LinkButton login = (LinkButton)Master.FindControl("lnkLogin");
                LinkButton viewSchedules = (LinkButton)Master.FindControl("lnkViewSchedules");
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
                }
                else
                {
                    login.Visible = true;
                    viewSchedules.Visible = false;
                    logout.Visible = false;
                    helloUser.Visible = false;
                }

                BindScheduleTable();
            }
        }

        private void BindScheduleTable()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                string query = @"
        SELECT cs.class_id, r.room_name, cs.day_of_week, cs.start_time, cs.end_time, 
               c.course_name, u.full_name AS instructor, cs.academic_year, cs.max_students
        FROM ""Class_Schedules"" cs
        JOIN ""Course"" c ON cs.course_id = c.course_id
        JOIN ""Rooms"" r ON cs.room_id = r.room_id
        JOIN users u ON cs.instructor_id = u.id";

                using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    System.Text.StringBuilder sb = new System.Text.StringBuilder();
                    foreach (DataRow row in dt.Rows)
                    {
                        sb.Append("<tr>");
                        sb.AppendFormat("<td>{0}</td>", row["class_id"]);
                        sb.AppendFormat("<td>{0}</td>", row["room_name"]);
                        sb.AppendFormat("<td>{0:dddd}</td>", Convert.ToDateTime(row["day_of_week"]));
                        sb.AppendFormat("<td>{0:HH:mm}</td>", row["start_time"]);
                        sb.AppendFormat("<td>{0:HH:mm}</td>", row["end_time"]);
                        sb.AppendFormat("<td>{0}</td>", row["course_name"]);
                        sb.AppendFormat("<td>{0}</td>", row["instructor"]);
                        sb.AppendFormat("<td>{0:yyyy}</td>", row["academic_year"]);
                        sb.AppendFormat("<td>{0}</td>", row["max_students"]);
                        sb.Append("</tr>");
                    }

                    ltTableBody.Text = sb.ToString();
                }
            }
        }

    }
}
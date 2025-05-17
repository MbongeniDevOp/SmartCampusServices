using System;
using System.Configuration;
using System.Data;
using System.Text;
using System.Web.UI.WebControls;
using Npgsql;

namespace SmartCampusServices
{
    public partial class Announcements : System.Web.UI.Page
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
            string connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                try
                {
                    string query = @"SELECT title, content, publish_date FROM announcements";

                    using (NpgsqlDataAdapter da = new NpgsqlDataAdapter(query, conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        StringBuilder sb = new StringBuilder();

                        foreach (DataRow row in dt.Rows)
                        {
                            sb.Append("<li>");
                            sb.AppendFormat("<strong>{0}</strong> - {1} <br/><em>Published on: {2}</em>",
                                row["title"],
                                row["content"],
                                Convert.ToDateTime(row["publish_date"]).ToString("yyyy-MM-dd")
                            );
                            sb.Append("</li>");
                        }

                        // Bind the Literal content and force it to render
                        ltAnnouncements.Text = sb.ToString();
                        ltAnnouncements.DataBind();
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

            // Bind the list after visibility links are initialized
            BindScheduleTable();
        }
    }
}

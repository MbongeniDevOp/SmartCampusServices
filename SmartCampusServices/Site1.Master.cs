using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCampusServices
{
    public partial class Site1 : System.Web.UI.MasterPage
    {

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("TestLogin.aspx");
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("TestLogin.aspx");
        }

        protected void lnkViewSchedules_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ViewSchedules.aspx");
        }

        protected void lnkHelloUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AdminLogin.aspx");
        }

        protected void lnkNotifications_Click(object sender, EventArgs e)
        {
        }

        protected void lnkProfile_Click(object sender, EventArgs e)
        {
            string role = Session["LoggedInRole"]?.ToString();

            // Redirect based on role
            switch (role)
            {
                case "admin":
                    Response.Redirect("~/AdminProfile.aspx");
                    break;
                case "lecturer":
                    Response.Redirect("~/LecturerProfile.aspx");
                    break;
                case "student":
                    Response.Redirect("~/UserProfile.aspx");
                    break;
                default:
                    // Optional: Redirect to a login page or error page if the role is not recognized
                    Response.Redirect("~/TestLogin.aspx");
                    break;
            }
        }
    }
}
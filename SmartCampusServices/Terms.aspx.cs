using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCampusServices
{
    public partial class Terms : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitialiseVisibilityLinks();
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
            string role = Session["LoggedInRole"]?.ToString();

            if (!string.IsNullOrEmpty(fullName) || !string.IsNullOrEmpty(role))
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
    }
}
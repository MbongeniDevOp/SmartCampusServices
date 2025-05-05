using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCampusServices
{
    public partial class homepage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

                    bool isUserLoggedIn = !string.IsNullOrEmpty(fullName);
                    imgLogin.Visible = isUserLoggedIn;

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
}
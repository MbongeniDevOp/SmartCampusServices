<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="homepage.aspx.cs" Inherits="SmartCampusServices.homepage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section style="position:relative; height: 50vh; width: 100%; padding: 0; margin: 0; overflow: hidden;">
        <!-- Background image -->
        <img class="img-fluid" src="imgs/pexels-pixabay-159213.jpg" style="width: 100vw; height: 50vh; display:block; object-fit: cover;"/>

        <!-- Icons Container (flex layout) -->
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); display: flex; gap: 150px; z-index: 5;">
            <center>
                <img class="img-fluid" src="imgs/report-svgrepo-com.svg" style="width: 150px; height: 150px;" />
            </center>
            <center>
                 <img class="img-fluid" src="imgs/announcement-megaphone-svgrepo-com.svg" style="width: 150px; height: 150px;" />
            </center>
            <center>
                <img class="img-fluid" src="imgs/exam-svgrepo-com.svg" style="width: 150px; height: 150px;" />
            </center>
            <center>
                <img class="img-fluid" src="imgs/administrator-work-svgrepo-com.svg" style="width: 150px; height: 150px;" />
            </center>
        </div>

        <!-- Overlay Heading (on top of the image) -->
        <h1 style="position: absolute; top: 80%; left: 50%; transform: translate(-50%, -50%);
            color: white; font-size: 3rem; font-weight: bold; text-shadow: 2px 2px 5px rgba(0,0,0,0.7);
            margin: 0; z-index: 10; pointer-events: none;">
            Smart Campus Services
        </h1>
    </section>

    <section style="margin-top: 0;">
        <div class="container" style="padding-top: 0; margin-top: 0;">
            <div class="row">
                <div class="col-12">
                    <center>
                        <h2>Services</h2>
                        <p><b>Our Featured Services -</b></p>
                    </center>
                </div>

                <div class="row" style="margin: 0;">
                    <div class="col-md-4">
                        <center>
                            <img class="img-fluid" src="imgs/student-dark-skin-tone-svgrepo-com.svg" width="150" height="150"/>
                            <p>Report Maintenance</p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img class="img-fluid" src="imgs/appointment-calendar-date-svgrepo-com.svg" width="150" height="150"/>
                            <p>View Examination Info</p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img class="img-fluid" src="imgs/study-student-svgrepo-com.svg" width="150" height="150"/>
                            <p>Book Study Center</p>
                        </center>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <section style="position:relative; height: 50vh; width: 100vw; padding: 0; margin: 0; overflow: hidden;">
        <img class="img-fluid" src="imgs/marvin-meyer-SYTO3xs06fU-unsplash.jpg" style="width: 100vw; height: 50vh; display:block; object-fit: cover;"/>
        <h1 style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
            color: white; font-size: 3rem; font-weight: bold; text-shadow: 2px 2px 5px rgba(0,0,0,0.7);
            margin: 0; z-index: 10; pointer-events: none;">
            Manage Core Campus Services
        </h1>
    </section>

    <section style="margin-top: 0;">
        <div class="container" style="padding-top: 0; margin-top: 0;">
            <div class="row">
                <div class="col-12">
                    <center>
                        <h2>Process</h2>
                        <p><b>Our 3 Simple Step Process -</b></p>
                    </center>
                </div>

                <div class="row" style="margin: 0;">
                    <div class="col-md-4">
                        <center>
                            <img class="img-fluid" src="imgs/account-add-avatar-person-profile-user-svgrepo-com.svg" width="150" height="150"/>
                            <p>Sign Up</p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img class="img-fluid" src="imgs/login-3-svgrepo-com.svg" width="150" height="150"/>
                            <p>Login</p>
                        </center>
                    </div>
                    <div class="col-md-4">
                        <center>
                            <img class="img-fluid" src="imgs/website-generic-svgrepo-com.svg" width="150" height="150"/>
                            <p>Visit Us</p>
                        </center>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>

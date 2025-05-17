<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="studentlogin.aspx.cs" Inherits="SmartCampusServices.StudentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card {
            cursor: pointer;
            transition: transform 0.2s ease;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .modal-body {
            max-height: 400px;
            overflow-y: auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Student Dashboard</h2>

        <div class="text-right mb-3">
            <asp:Button ID="btnRefresh" runat="server" Text="Refresh Data" CssClass="btn btn-primary" OnClick="btnRefresh_Click" />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-danger ml-2" OnClick="btnLogout_Click" />
        </div>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('courses')">
                    <h5>Enrolled Courses</h5>
                    <p class="display-4" id="coursesCount"><%= CoursesCount %></p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('exams')">
                    <h5>Upcoming Exams</h5>
                    <p class="display-4" id="examsCount"><%= ExamsCount %></p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('assignments')">
                    <h5>Assignments Pending</h5>
                    <p class="display-4" id="assignmentsCount"><%= AssignmentsCount %></p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('announcements')">
                    <h5>Announcements</h5>
                    <p class="display-4" id="announcementsCount"><%= AnnouncementsCount %></p>
                </div>
            </div>
        </div>

        <!-- Details Section -->
        <div id="detailsSection" class="mt-4"></div>

        <!-- DataTable for Student Activities or Courses -->
        <div class="card">
            <div class="card-body">
                <h4>Your Activities</h4>
                <table id="studentTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Activity ID</th>
                            <th>Activity Name</th>
                            <th>Due Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%--ActivitiesTableRows--%>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Literal Control for Schedule Table -->
        <asp:Literal ID="ltTableBody" runat="server"></asp:Literal>
    </div>

    <script>
        // Function to show detailed info based on card clicked
        function showDetails(type) {
            fetch('StudentDataHandler.ashx?type=' + type)
                .then(response => response.text())
                .then(html => {
                    document.getElementById('detailsSection').innerHTML = html;
                })
                .catch(err => {
                    document.getElementById('detailsSection').innerHTML = '<p class="text-danger">Error loading details.</p>';
                });
        }
    </script>

</asp:Content>

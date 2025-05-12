<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="studentlogin.aspx.cs" Inherits="SmartCampusServices.StudentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Additional custom styling if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Student Dashboard</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('courses')">
                    <h5>Enrolled Courses</h5>
                    <p class="display-4" id="coursesCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('exams')">
                    <h5>Upcoming Exams</h5>
                    <p class="display-4" id="examsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('assignments')">
                    <h5>Assignments Pending</h5>
                    <p class="display-4" id="assignmentsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3" onclick="showDetails('announcements')">
                    <h5>Announcements</h5>
                    <p class="display-4" id="announcementsCount">0</p>
                </div>
            </div>
        </div>

        <!-- Details Section -->
        <div id="detailsSection" class="mt-4">
            <!-- Content will be dynamically inserted here -->
        </div>




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
                        <!-- Data will be injected dynamically using JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Literal Control for Table -->
        <asp:Literal ID="ltTableBody" runat="server"></asp:Literal>
    </div>

</asp:Content>

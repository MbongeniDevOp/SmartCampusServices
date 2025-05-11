<%@ Page Title="Lecturer Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LecturerPage.aspx.cs" Inherits="SmartCampusServices.LecturerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Additional custom styling if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Lecturer Dashboard</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Assigned Courses</h5>
                    <p class="display-4" id="coursesCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Pending Assessments</h5>
                    <p class="display-4" id="assessmentsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Assigned Students</h5>
                    <p class="display-4" id="studentsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Upcoming Deadlines</h5>
                    <p class="display-4" id="deadlinesCount">0</p>
                </div>
            </div>
        </div>

        <!-- DataTable for Lecturer's Courses -->
        <div class="card">
            <div class="card-body">
                <h4>Your Courses</h4>
                <table id="lecturerTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Course ID</th>
                            <th>Course Name</th>
                            <th>Enrolled Students</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Data will be injected dynamically using JavaScript -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- JavaScript for handling DataTable and AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

    <script>
        $(document).ready(function () {
            // Initialize DataTable
            $('#lecturerTable').DataTable();

            // Load Dashboard Data for Lecturer
            loadDashboardData();
        });

        // Function to load dashboard data
        function loadDashboardData() {
            $.ajax({
                url: 'LecturerPage.aspx/GetLecturerDashboardData',  // Define this function in your code-behind
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    const data = response.d;

                    // Update the dashboard cards with counts
                    $('#coursesCount').text(data.Courses);
                    $('#assessmentsCount').text(data.Assessments);
                    $('#studentsCount').text(data.Students);
                    $('#deadlinesCount').text(data.Deadlines);

                    // Populate Lecturer's Courses Table
                    const table = $('#lecturerTable').DataTable();
                    table.clear();
                    data.CourseList.forEach(course => {
                        table.row.add([
                            course.CourseID,
                            course.CourseName,
                            course.EnrolledStudents,
                            `<button class="btn btn-sm btn-primary viewDetails" data-id="${course.CourseID}">View</button>`
                        ]);
                    });
                    table.draw();
                }
            });
        }
    </script>
</asp:Content>

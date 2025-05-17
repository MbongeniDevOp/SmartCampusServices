<%@ Page Title="Lecturer Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LecturerPage.aspx.cs" Inherits="SmartCampusServices.LecturerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 60px; /* Added padding so content isn't cut off */
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto; /* Center horizontally */
            padding: 0 15px 40px; /* Added side padding and bottom spacing */
        }

        .card {
            border-radius: 15px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            height: 100%; /* Make all cards same height in grid */
        }

        .card:hover {
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        .card-title {
            font-size: 1.5rem;
            color: #007bff;
            font-weight: bold;
        }

        .card-icon {
            font-size: 2.5rem;
            color: #007bff;
        }

        .btn-view {
            background-color: #007bff;
            border: none;
            color: white;
        }

        .btn-view:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <h2 class="text-center mb-4"><i class="fas fa-chalkboard-teacher"></i> Lecturer Dashboard</h2>

        <!-- Dashboard Summary Cards -->
        <div class="row text-center mb-5 g-3">
            <div class="col-md-3 d-flex">
                <div class="card p-3 flex-fill" onclick="loadDashboardData('courses')">
                    <div class="card-body">
                        <i class="fas fa-book card-icon"></i>
                        <h5 class="card-title">Assigned Courses</h5>
                        <p class="display-4" id="coursesCount">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex">
                <div class="card p-3 flex-fill" onclick="loadDashboardData('assessments')">
                    <div class="card-body">
                        <i class="fas fa-tasks card-icon"></i>
                        <h5 class="card-title">Pending Assessments</h5>
                        <p class="display-4" id="assessmentsCount">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex">
                <div class="card p-3 flex-fill" onclick="loadDashboardData('students')">
                    <div class="card-body">
                        <i class="fas fa-users card-icon"></i>
                        <h5 class="card-title">Assigned Students</h5>
                        <p class="display-4" id="studentsCount">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 d-flex">
                <div class="card p-3 flex-fill" onclick="loadDashboardData('deadlines')">
                    <div class="card-body">
                        <i class="fas fa-calendar-alt card-icon"></i>
                        <h5 class="card-title">Upcoming Deadlines</h5>
                        <p class="display-4" id="deadlinesCount">0</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Lecturer's Courses Table -->
        <div class="card" id="coursesTable" style="display:none;">
            <div class="card-body">
                <h4><i class="fas fa-table"></i> Your Courses</h4>
                <table class="table table-bordered table-striped table-hover" style="width:100%">
                    <thead>
                        <tr>
                            <th>Course ID</th>
                            <th>Course Name</th>
                            <th>Course Code</th>
                            <th>Department</th>
                        </tr>
                    </thead>
                    <tbody id="courseList"></tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function loadDashboardData(type) {
            $.ajax({
                type: "POST",
                url: "LecturerPage.aspx/GetDashboardData",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ type: type }),
                dataType: "json",
                success: function (response) {
                    if (response.d.Error) {
                        alert(response.d.Error);
                        return;
                    }

                    // Update counts
                    $('#coursesCount').text(response.d.Courses);
                    $('#assessmentsCount').text(response.d.Assessments);
                    $('#studentsCount').text(response.d.Students);
                    $('#deadlinesCount').text(response.d.Deadlines);

                    // Show/hide content based on clicked card
                    if (type === 'courses') {
                        $('#coursesTable').show();
                        populateCourseList(response.d.CourseList);
                    } else {
                        $('#coursesTable').hide();
                    }
                },
                error: function () {
                    alert("Failed to load dashboard data.");
                }
            });
        }

        function populateCourseList(courses) {
            var tbody = $('#courseList');
            tbody.empty();
            $.each(courses, function (i, course) {
                tbody.append('<tr><td>' + course.CourseID + '</td><td>' + course.CourseName + '</td><td>' + course.EnrolledStudents + '</td><td><button class="btn btn-primary btn-view">View</button></td></tr>');
            });
        }
    </script>
</asp:Content>
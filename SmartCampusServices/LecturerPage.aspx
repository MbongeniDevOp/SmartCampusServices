<%@ Page Title="Lecturer Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="LecturerPage.aspx.cs" Inherits="SmartCampusServices.LecturerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap & FontAwesome CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
        }

        .card {
            border-radius: 15px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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
    <div class="container dashboard-container">
        <h2 class="text-center mb-4"><i class="fas fa-chalkboard-teacher"></i> Lecturer Dashboard</h2>

        <!-- Dashboard Summary Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card p-3">
                    <div class="card-body">
                        <i class="fas fa-book card-icon"></i>
                        <h5 class="card-title">Assigned Courses</h5>
                        <p class="display-4" id="coursesCount">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <div class="card-body">
                        <i class="fas fa-tasks card-icon"></i>
                        <h5 class="card-title">Pending Assessments</h5>
                        <p class="display-4" id="assessmentsCount">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <div class="card-body">
                        <i class="fas fa-users card-icon"></i>
                        <h5 class="card-title">Assigned Students</h5>
                        <p class="display-4" id="studentsCount">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3">
                    <div class="card-body">
                        <i class="fas fa-calendar-alt card-icon"></i>
                        <h5 class="card-title">Upcoming Deadlines</h5>
                        <p class="display-4" id="deadlinesCount">0</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Lecturer's Courses Table -->
        <div class="card">
            <div class="card-body">
                <h4><i class="fas fa-table"></i> Your Courses</h4>
                <table id="lecturerTable" class="table table-bordered table-striped table-hover" style="width:100%">
                    <thead>
                        <tr>
                            <th>Course ID</th>
                            <th>Course Name</th>
                            <th>Enrolled Students</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</asp:Content>
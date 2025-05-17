<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="studentlogin.aspx.cs" Inherits="SmartCampusServices.studentlogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Student Dashboard</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnCourses">
                    <h5>Enrolled Courses</h5>
                    <p class="display-4" id="coursesCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnExams">
                    <h5>Upcoming Exams</h5>
                    <p class="display-4" id="examsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnAssignments">
                    <h5>Assignments Pending</h5>
                    <p class="display-4" id="assignmentsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnAnnouncements">
                    <h5>Announcements</h5>
                    <p class="display-4" id="announcementsCount">0</p>
                </div>
            </div>
        </div>

        <!-- DataTables -->
        <div class="card" style="display:none;">
            <div class="card-body">
                <table id="dataTable" class="table table-bordered table-striped" style="width:100%">
                    <thead>
                        <tr id="tableHeaders"></tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        let activeCardId = null;
        let table = null;

        $('.card-link').on('click', function () {
            const clickedId = this.id;

            if (activeCardId === clickedId) {
                $('#dataTable').closest('.card').toggle();
                return;
            }

            activeCardId = clickedId;
            $('#dataTable').closest('.card').show();

            if (table) {
                table.clear().destroy();
                table = null;
            }

            $('#dataTable thead').empty();
            $('#dataTable tbody').empty();

            let headers = '';
            switch (clickedId) {
                case 'btnCourses':
                    headers = `<tr><th>Course ID</th><th>Course Name</th><th>Credits</th><th>Instructor</th></tr>`;
                    loadCourses();
                    break;
                case 'btnExams':
                    headers = `<tr><th>Exam ID</th><th>Course</th><th>Date</th><th>Location</th></tr>`;
                    loadExams();
                    break;
                case 'btnAssignments':
                    headers = `<tr><th>Assignment ID</th><th>Course</th><th>Due Date</th><th>Status</th></tr>`;
                    loadAssignments();
                    break;
                case 'btnAnnouncements':
                    headers = `<tr><th>ID</th><th>Title</th><th>Publish Date</th><th>Details</th></tr>`;
                    loadAnnouncements();
                    break;
            }
            $('#dataTable thead').append(headers);
        });

        function loadCourses() {
            const data = [
                { CourseID: 101, CourseName: 'Mathematics', Credits: 3, Instructor: 'Dr. Smith' },
                { CourseID: 102, CourseName: 'Physics', Credits: 4, Instructor: 'Prof. Johnson' }
            ];
            populateTable(data, ['CourseID', 'CourseName', 'Credits', 'Instructor']);
        }

        function loadExams() {
            const data = [
                { ExamID: 201, Course: 'Mathematics', Date: '2025-06-01', Location: 'Hall A' },
                { ExamID: 202, Course: 'Physics', Date: '2025-06-15', Location: 'Hall B' }
            ];
            populateTable(data, ['ExamID', 'Course', 'Date', 'Location']);
        }

        function loadAssignments() {
            const data = [
                { AssignmentID: 301, Course: 'Mathematics', DueDate: '2025-05-30', Status: 'Pending' },
                { AssignmentID: 302, Course: 'Physics', DueDate: '2025-06-10', Status: 'Completed' }
            ];
            populateTable(data, ['AssignmentID', 'Course', 'DueDate', 'Status']);
        }

        function loadAnnouncements() {
            const data = [
                { ID: 401, Title: 'Exam Schedule Released', PublishDate: '2025-05-20', Details: 'Check the portal.' },
                { ID: 402, Title: 'Semester Break Notice', PublishDate: '2025-05-15', Details: 'Classes will resume on June 5.' }
            ];
            populateTable(data, ['ID', 'Title', 'PublishDate', 'Details']);
        }

        function populateTable(data, columns) {
            const tbody = $('#dataTable tbody');
            tbody.empty();

            data.forEach(row => {
                let tr = '<tr>';
                columns.forEach(col => {
                    tr += `<td>${row[col] !== undefined ? row[col] : ''}</td>`;
                });
                tr += '</tr>';
                tbody.append(tr);
            });

            table = $('#dataTable').DataTable({
                paging: true,
                searching: true,
                info: true,
                autoWidth: false,
                lengthChange: false
            });
        }
    </script>
</asp:Content>
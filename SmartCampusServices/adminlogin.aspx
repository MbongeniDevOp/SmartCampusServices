<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SmartCampusServices.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Admin Dashboard</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnUsers">
                    <h5>Users</h5>
                    <p class="display-4" id="usersCount">2</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnBookings">
                    <h5>Bookings</h5>
                    <p class="display-4" id="bookingsCount">2</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnMaintenance">
                    <h5>Maintenance Issues</h5>
                    <p class="display-4" id="maintenanceCount">2</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3 card-link" id="btnAnnouncements">
                    <h5>Announcements</h5>
                    <p class="display-4" id="announcementsCount">2</p>
                </div>
            </div>
        </div>

        <!-- DataTables -->
        <div class="card" style="display:none;"> <!-- initially hidden -->
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
        // Declare variables so they persist across clicks
        let activeCardId = null;
        let table = null;

        $('.card-link').on('click', function () {
            const clickedId = this.id;

            if (activeCardId === clickedId) {
                // Toggle table visibility if clicking the same card again
                $('#dataTable').closest('.card').toggle();
                return;
            }

            activeCardId = clickedId;

            // Show the table container
            $('#dataTable').closest('.card').show();

            // Destroy DataTable if it exists
            if (table) {
                table.clear().destroy();
                table = null;
            }

            // Clear thead and tbody
            $('#dataTable thead').empty();
            $('#dataTable tbody').empty();

            // Setup headers based on clicked card
            let headers = '';
            switch (clickedId) {
                case 'btnUsers':
                    headers = `<tr>
                        <th>ID</th><th>Full Name</th><th>Email</th><th>Role</th><th>Actions</th>
                    </tr>`;
                    break;
                case 'btnBookings':
                    headers = `<tr>
                        <th>Booking ID</th><th>Room Name</th><th>Booked By</th><th>Start Time</th><th>End Time</th><th>Status</th><th>Purpose</th><th>Actions</th>
                    </tr>`;
                    break;
                case 'btnMaintenance':
                    headers = `<tr>
                        <th>Issue ID</th><th>Description</th><th>Reported By</th><th>Status</th><th>Actions</th>
                    </tr>`;
                    break;
                case 'btnAnnouncements':
                    headers = `<tr>
                        <th>ID</th><th>Title</th><th>Content</th><th>Publish Date</th><th>Actions</th>
                    </tr>`;
                    break;
            }
            $('#dataTable thead').append(headers);

            // Load data into the table for the selected card
            switch (clickedId) {
                case 'btnUsers':
                    loadUsers();
                    break;
                case 'btnBookings':
                    loadBookings();
                    break;
                case 'btnMaintenance':
                    loadMaintenance();
                    break;
                case 'btnAnnouncements':
                    loadAnnouncements();
                    break;
            }
        });

        // Example dummy load functions — replace with your actual AJAX/data logic!
        function loadUsers() {
            // Example data — replace with AJAX call or server data
            const data = [
                { ID: 1, FullName: 'Alice Johnson', Email: 'alice@example.com', Role: 'Admin' },
                { ID: 2, FullName: 'Bob Smith', Email: 'bob@example.com', Role: 'User' }
            ];
            populateTable(data, ['ID', 'FullName', 'Email', 'Role']);
        }

        function loadBookings() {
            const data = [
                { BookingID: 101, RoomName: 'Room A', BookedBy: 'Alice', StartTime: '9:00 AM', EndTime: '10:00 AM', Status: 'Confirmed', Purpose: 'Meeting' },
                { BookingID: 102, RoomName: 'Room B', BookedBy: 'Bob', StartTime: '11:00 AM', EndTime: '12:00 PM', Status: 'Pending', Purpose: 'Training' }
            ];
            populateTable(data, ['BookingID', 'RoomName', 'BookedBy', 'StartTime', 'EndTime', 'Status', 'Purpose']);
        }

        function loadMaintenance() {
            const data = [
                { IssueID: 201, Description: 'AC not working', ReportedBy: 'Alice', Status: 'Open' },
                { IssueID: 202, Description: 'Projector broken', ReportedBy: 'Bob', Status: 'In Progress' }
            ];
            populateTable(data, ['IssueID', 'Description', 'ReportedBy', 'Status']);
        }

        function loadAnnouncements() {
            const data = [
                { ID: 301, Title: 'Holiday Notice', Content: 'Office closed on Friday', PublishDate: '2025-05-01' },
                { ID: 302, Title: 'New Policy', Content: 'Updated attendance policy', PublishDate: '2025-05-10' }
            ];
            populateTable(data, ['ID', 'Title', 'Content', 'PublishDate']);
        }

        // Helper function to populate table and initialize DataTables
        function populateTable(data, columns) {
            const tbody = $('#dataTable tbody');
            tbody.empty();

            data.forEach(row => {
                let tr = '<tr>';
                columns.forEach(col => {
                    tr += `<td>${row[col] !== undefined ? row[col] : ''}</td>`;
                });
                // Add Actions cell with placeholder buttons or links
                tr += `<td>
                    <button class="btn btn-sm btn-primary">Edit</button>
                    <button class="btn btn-sm btn-danger">Delete</button>
                </td>`;
                tr += '</tr>';
                tbody.append(tr);
            });

            // Initialize DataTable again
            table = $('#dataTable').DataTable({
                paging: true,
                searching: true,
                info: true,
                autoWidth: false,
                lengthChange: false,
                // Other DataTables options as needed
            });
        }
    </script>
</asp:Content>

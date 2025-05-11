<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SmartCampusServices.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Additional custom styling if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Admin Dashboard</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Users</h5>
                    <p class="display-4" id="usersCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Bookings</h5>
                    <p class="display-4" id="bookingsCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Maintenance Issues</h5>
                    <p class="display-4" id="maintenanceCount">0</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Announcements</h5>
                    <p class="display-4" id="announcementsCount">0</p>
                </div>
            </div>
        </div>

        <!-- DataTable -->
        <div class="card">
            <div class="card-body">
                <h4>Users Management</h4>
                <table id="adminTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('#adminTable').DataTable();
            loadDashboardData();
        });

        function loadDashboardData() {
            $.ajax({
                url: 'AdminLogin.aspx/GetDashboardData',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    const data = response.d;
                    $('#usersCount').text(data.Users);
                    $('#bookingsCount').text(data.Bookings);
                    $('#maintenanceCount').text(data.Maintenance);
                    $('#announcementsCount').text(data.Announcements);

                    // Populate Users Table
                    const table = $('#adminTable').DataTable();
                    table.clear();
                    data.UserList.forEach(user => {
                        table.row.add([
                            user.ID,
                            user.FullName,
                            user.Email,
                            user.Role,
                            `<button class="btn btn-sm btn-primary editUser" data-id="${user.ID}">Edit</button>
                             <button class="btn btn-sm btn-danger deleteUser" data-id="${user.ID}">Delete</button>`
                        ]);
                    });
                    table.draw();
                }
            });
        }
    </script>
</asp:Content>

<%@ Page Title="Admin Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SmartCampusServices.AdminLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Optional: Add page-specific CSS here if needed -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-4">Admin Dashboard</h2>

        <!-- Dashboard Cards -->
        <div class="row text-center mb-5">
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Users</h5>
                    <p class="display-4">12</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Profiles</h5>
                    <p class="display-4">8</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Reports</h5>
                    <p class="display-4">4</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card shadow-sm p-3">
                    <h5>Tasks</h5>
                    <p class="display-4">21</p>
                </div>
            </div>
        </div>

        <!-- DataTable -->
        <div class="card">
            <div class="card-body">
                <table id="adminTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Role</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>admin</td>
                            <td>Administrator</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>john</td>
                            <td>Editor</td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>jane</td>
                            <td>Viewer</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Use local jQuery and DataTables from Site.master -->
    <script src="datatables/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#adminTable').DataTable();
        });
    </script>
    <script>
        // Simulate fetching new notification count
        function updateNotificationCount(count) {
            const badge = document.getElementById('notifCount');
            badge.textContent = count;

            if (count > 0) {
                badge.style.display = 'inline-block';
            } else {
                badge.style.display = 'none';
            }
        }

        // Example: Set it to 5 after page load
        document.addEventListener("DOMContentLoaded", function () {
            updateNotificationCount(5); // Replace 5 with dynamic value from server
        });
    </script>

</asp:Content>

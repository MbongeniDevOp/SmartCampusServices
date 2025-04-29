<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ViewSchedules.aspx.cs" Inherits="SmartCampusServices.ViewSchedules" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="mt-3 mb-3">View Schedules</h2>

    <table id="scheduleTable" class="display table table-striped" style="width:100%">
        <thead>
            <tr>
                <th>Class ID</th>
                <th>Room</th>
                <th>Day</th>
                <th>Start Time</th>
                <th>End Time</th>
                <th>Course</th>
                <th>Instructor</th>
                <th>Year</th>
                <th>Max Students</th>
            </tr>
        </thead>
        <tbody>
            <%-- You can bind rows using C# or server-side loop --%>
            <asp:Literal ID="ltTableBody" runat="server" EnableViewState="false"></asp:Literal>
        </tbody>
    </table>

    <script src="datatables/js/dataTables.min.js"></script>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            $('#scheduleTable').DataTable();
        });
    </script>
</asp:Content>

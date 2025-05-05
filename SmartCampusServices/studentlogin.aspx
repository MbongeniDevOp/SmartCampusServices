<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="studentlogin.aspx.cs" Inherits="SmartCampusServices.studentlogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container" style="margin-top: 60px;">
        <h2 class="mt-3 mb-3">Student</h2>

        <table id="scheduleTable" class="display table table-striped" style="width: 100%">
            <thead>
                <tr>
                    <th>Student Name</th>
                    <th>Courses</th>
                    <th>Grades</th>
                    <th>Year</th>
                </tr>
            </thead>
            <tbody>
                <%-- You can bind rows using C# or server-side loop --%>
                <asp:Literal ID="ltTableBody" runat="server" EnableViewState="false"></asp:Literal>
            </tbody>
        </table>
    </div>


</asp:Content>

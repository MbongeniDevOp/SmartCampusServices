<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SmartCampusServices.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label><br /><br />
        <h2 class="mb-4">Admin Dashboard</h2>

        <!-- Fullscreen section with background image -->
        <section style="position:relative; height:70vh; width:60vw; padding:0; margin-top:20px; overflow:hidden;">
            <!-- Full-size image -->
            <img src="imgs/analytics-laptop-svgrepo-com.svg"
     style="position:absolute; top:0; left:0; width:100%; height:100%; object-fit:contain; z-index:1;" />

            <!-- Optional overlay content goes here -->
            <div style="position:absolute; top:50%; left:50%; transform:translate(-50%, -50%); z-index:2; color:white;">
                <h1>Welcome to the Admin Dashboard</h1>
            </div>
        </section>
    </div>
</asp:Content>


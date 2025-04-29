<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SmartCampusServices.AdminLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label><br /><br />

        <section style="position:relative; height: 50vh; width: 100%; padding: 0; margin: 0; overflow: hidden;">
            <!-- Background image -->

            <!-- Icons Container (flex layout) -->
            <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); display: flex; gap: 150px; z-index: 5;">
                <center>
                    <img class="img-fluid" src="imgs/administrator-work-svgrepo-com.svg" style="width: 150px; height: 150px;" />
                </center>
            </div>

            <!-- Overlay Heading (on top of the image) -->
            
        </section>
    </div>



</asp:Content>

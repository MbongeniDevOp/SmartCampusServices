<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="SmartCampusServices.Announcements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section style="position:relative; height: 50vh; width: 100%; padding: 0; margin: 0; overflow: hidden;">
        <!-- Background image -->
        <img class="img-fluid" src="imgs/pexels-pixabay-159213.jpg" style="width: 100vw; height: 50vh; display:block; object-fit: cover;"/>

        <!-- Icons Container (flex layout) -->
        <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); display: flex; gap: 150px; z-index: 5;">
            <center>
                 <img class="img-fluid" src="imgs/announcement-megaphone-svgrepo-com.svg" style="width: 150px; height: 150px;" />
            </center>
        </div>

        <!-- Overlay Heading (on top of the image) -->
        <h1 style="position: absolute; top: 80%; left: 50%; transform: translate(-50%, -50%);
            color: white; font-size: 3rem; font-weight: bold; text-shadow: 2px 2px 5px rgba(0,0,0,0.7);
            margin: 0; z-index: 10; pointer-events: none;">
            Announcements
        </h1>
    </section>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="SmartCampusServices.Announcements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section style="display: flex; height: 70vh; width: 100%; padding: 20px; box-sizing: border-box; gap: 20px;">
        
        <!-- Announcement Image Container -->
        <div style="flex: 1; display: flex; justify-content: center; align-items: center; flex-direction: column;">
            <img class="img-fluid" src="imgs/announcement-megaphone-svgrepo-com.svg" 
                 style="width: 150px; height: 150px;" />
            <h2 style="margin-top: 15px; font-size: 1.5rem; color: #333;">Announcements</h2>
        </div>

        <!-- Vertical Line -->
        <div style="border-left: 2px solid #ccc; height: 100%;"></div>

        <!-- Announcement Content -->
        <div style="flex: 3; padding-left: 20px;">
            <h3 style="margin-bottom: 10px;">Latest Announcements</h3>
            <p style="font-size: 1.1rem; line-height: 1.6;">
                Here you will find the latest updates and announcements related to Smart Campus Services.
                Stay tuned for important notices and community news. 
            </p>

            <!-- Example list of announcements -->
            <ul style="list-style-type: disc; margin-left: 20px;">
                <li>New semester registration is now open.</li>
                <li>Library hours extended during exam season.</li>
                <li>Upcoming maintenance on the campus network.</li>
            </ul>
        </div>
    </section>
</asp:Content>



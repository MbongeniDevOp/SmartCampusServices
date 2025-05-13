<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="SmartCampusServices.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section style="display: flex; height: 70vh; width: 100%; padding: 20px; box-sizing: border-box; gap: 20px;">
        
        <!-- About Image Container -->
        <div style="flex: 1; display: flex; justify-content: center; align-items: center; flex-direction: column;">
            <img class="img-fluid" src="imgs/about-icon-placeholder.svg" 
                 style="width: 150px; height: 150px;" />
            <h2 style="margin-top: 15px; font-size: 1.5rem; color: #333;">About Us</h2>
        </div>

        <!-- Vertical Line -->
        <div style="border-left: 2px solid #ccc; height: 100%;"></div>

        <!-- About Content -->
        <div style="flex: 3; padding-left: 20px;">
            <h3 style="margin-bottom: 10px;">Who We Are</h3>
            <p style="font-size: 1.1rem; line-height: 1.6;">
                Smart Campus Services is committed to enhancing the learning experience through innovative technology solutions.
                Our platform bridges the gap between administration and students, making campus life more connected and efficient.
            </p>

            <h3 style="margin-bottom: 10px; margin-top: 20px;">Our Mission</h3>
            <p style="font-size: 1.1rem; line-height: 1.6;">
                To empower educational institutions with seamless, user-friendly solutions that drive efficiency and communication.
            </p>

            <h3 style="margin-bottom: 10px; margin-top: 20px;">Our Vision</h3>
            <p style="font-size: 1.1rem; line-height: 1.6;">
                Building a smarter, more connected campus experience for the next generation of learners.
            </p>
        </div>
    </section>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="SmartCampusServices.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section style="display: flex; height: 70vh; width: 100%; padding: 20px; box-sizing: border-box; gap: 20px;">
        
        <!-- Contact Image Container -->
        <div style="flex: 1; display: flex; justify-content: center; align-items: center; flex-direction: column;">
            <img class="img-fluid" src="imgs/contact-icon-placeholder.svg" 
                 style="width: 150px; height: 150px;" />
            <h2 style="margin-top: 15px; font-size: 1.5rem; color: #333;">Contact Us</h2>
        </div>

        <!-- Vertical Line -->
        <div style="border-left: 2px solid #ccc; height: 100%;"></div>

        <!-- Contact Form Content -->
        <div style="flex: 3; padding-left: 20px;">
            <h3 style="margin-bottom: 10px;">Get in Touch</h3>
            <form style="display: grid; gap: 15px;">
                <input type="text" placeholder="Your Name" style="padding: 10px; font-size: 1rem;" />
                <input type="email" placeholder="Your Email" style="padding: 10px; font-size: 1rem;" />
                <textarea placeholder="Your Message" rows="5" style="padding: 10px; font-size: 1rem;"></textarea>
                <button type="submit" style="padding: 10px 20px; font-size: 1rem; background-color: #333346; color: white; border: none; cursor: pointer;">
                    Send Message
                </button>
            </form>
        </div>
    </section>
</asp:Content>

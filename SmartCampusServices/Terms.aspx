<%@ Page Title="Terms and Conditions" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Terms.aspx.cs" Inherits="SmartCampusServices.Terms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        body {
            background-color: #f7f9fc;
        }

        .terms-section {
            display: flex;
            min-height: 70vh;
            width: 100%;
            padding: 20px;
            gap: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            flex-wrap: wrap;
        }

        .terms-image-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-width: 250px;
        }

        .terms-image-container img {
            width: 150px;
            height: 150px;
            transition: transform 0.3s ease;
        }

        .terms-image-container img:hover {
            transform: scale(1.1);
        }

        .terms-image-container h2 {
            margin-top: 15px;
            font-size: 1.5rem;
            color: #333346;
            font-weight: 600;
            text-align: center;
        }

        .vertical-line {
            border-left: 2px solid #ccc;
            height: auto;
            min-height: 400px;
        }

        .terms-content {
            flex: 3;
            padding-left: 20px;
            max-width: 900px;
        }

        .terms-content h3 {
            margin-bottom: 10px;
            color: #333346;
            font-weight: 600;
            position: relative;
        }

        .terms-content h3::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background-color: #333346;
            bottom: -5px;
            left: 0;
        }

        .terms-content p {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 20px;
            white-space: pre-line;
        }

        .terms-content ul {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 20px;
            padding-left: 20px;
        }

        .terms-content li {
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="terms-section">
            <!-- Terms Image Container -->
            <div class="terms-image-container">
                <img class="img-fluid" src="imgs/three-squares-svgrepo-com.svg" alt="Terms Icon" />
                <h2>Terms &amp; Conditions</h2>
            </div>

            <!-- Vertical Line -->
            <div class="vertical-line"></div>

            <!-- Terms Content -->
            <div class="terms-content">
                <h3>Introduction</h3>
                <p>
                    Welcome to Smart Campus Services. By using our platform, you agree to comply with and be bound by the following terms and conditions.
                </p>

                <h3>Use of Service</h3>
                <p>
                    Our services are designed to support educational institutions in streamlining campus communication and administration. Users must ensure that their use of the platform complies with applicable laws and regulations.
                </p>

                <h3>User Responsibilities</h3>
                <ul>
                    <li>Provide accurate and truthful information when registering and using the platform.</li>
                    <li>Maintain the confidentiality of your account credentials.</li>
                    <li>Use the platform ethically and avoid any misuse or disruptive activities.</li>
                </ul>

                <h3>Limitation of Liability</h3>
                <p>
                    Smart Campus Services is not liable for any indirect, incidental, or consequential damages arising from the use or inability to use the service.
                </p>

                <h3>Changes to Terms</h3>
                <p>
                    We reserve the right to modify these terms at any time. Continued use of the platform constitutes acceptance of the updated terms.
                </p>

                <h3>Contact Us</h3>
                <p>
                    If you have any questions regarding these terms, please contact our support team.
                </p>
            </div>
        </div>
    </div>
</asp:Content>

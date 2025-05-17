<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="SmartCampusServices.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        body {
            background-color: #f7f9fc;
        }

        .about-section {
            display: flex;
            height: auto;
            min-height: 70vh;
            width: 100%;
            padding: 20px;
            gap: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .about-image-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .about-image-container img {
            width: 150px;
            height: 150px;
            transition: transform 0.3s ease;
        }

        .about-image-container img:hover {
            transform: scale(1.1);
        }

        .about-image-container h2 {
            margin-top: 15px;
            font-size: 1.5rem;
            color: #333346;
            font-weight: 600;
        }

        .vertical-line {
            border-left: 2px solid #ccc;
            height: 100%;
        }

        .about-content {
            flex: 3;
            padding-left: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-around;
        }

        .about-content h3 {
            margin-bottom: 10px;
            color: #333346;
            font-weight: 600;
            position: relative;
        }

        .about-content h3::after {
            content: '';
            position: absolute;
            width: 50px;
            height: 3px;
            background-color: #333346;
            bottom: -5px;
            left: 0;
        }

        .about-content p {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 20px;
        }

        .about-content p:last-child {
            margin-bottom: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="about-section">
            <!-- About Image Container -->
            <div class="about-image-container">
                <img class="img-fluid" src="imgs/three-squares-svgrepo-com.svg" />
                <h2>About Us</h2>
            </div>

            <!-- Vertical Line -->
            <div class="vertical-line"></div>

            <!-- About Content -->
            <div class="about-content">
                <h3>Who We Are</h3>
                <p>
                    Smart Campus Services is committed to enhancing the learning experience through innovative technology solutions.
                    Our platform bridges the gap between administration and students, making campus life more connected and efficient.
                </p>

                <h3>Our Mission</h3>
                <p>
                    To empower educational institutions with seamless, user-friendly solutions that drive efficiency and communication.
                </p>

                <h3>Our Vision</h3>
                <p>
                    Building a smarter, more connected campus experience for the next generation of learners.
                </p>
            </div>
        </div>
    </div>
</asp:Content>
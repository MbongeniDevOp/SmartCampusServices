<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Announcements.aspx.cs" Inherits="SmartCampusServices.Announcements" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /*announcement begins here*/
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        /* Announcement Container */
        .announcement-section {
            display: flex;
            flex-wrap: wrap;
            padding: 30px;
            background: #f9f9f9;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            gap: 30px;
            box-sizing: border-box;
        }

        .announcement-left {
            flex: 1 1 250px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .announcement-left img {
            width: 120px;
            height: 120px;
            margin-bottom: 15px;
        }

        .announcement-left h2 {
            font-size: 2rem;
            color: #2c3e50;
            margin: 0;
        }

        .announcement-divider {
            width: 2px;
            background: #dcdcdc;
        }

        .announcement-right {
            flex: 3 1 600px;
            display: flex;
            flex-direction: column;
        }

        .announcement-right h3 {
            font-size: 1.6rem;
            color: #34495e;
            margin-bottom: 20px;
        }

        .announcement-banner {
            background: #ffe9e9;
            color: #b10000;
            padding: 15px;
            border-radius: 10px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .announcement-controls {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
        }

        .announcement-controls input,
        .announcement-controls select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
            width: 100%;
            max-width: 250px;
        }

        .announcement-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .announcement-card {
            background: #ffffff;
            border: 1px solid #e0e0e0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            font-size: 1rem;
            line-height: 1.5;
            color: #333;
            position: relative;
        }

        .announcement-card small {
            display: block;
            font-size: 0.75rem;
            color: #888;
            margin-top: 8px;
        }

        .announcement-card .read-more {
            display: block;
            margin-top: 10px;
            color: #007bff;
            font-size: 0.85rem;
            text-decoration: none;
        }

        .load-more-btn {
            margin-top: 20px;
            padding: 12px 24px;
            background-color: #3498db;
            border: none;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            align-self: flex-start;
        }

        /* Responsive for small screens */
        @media (max-width: 768px) {
            .announcement-section {
                flex-direction: column;
                padding: 20px;
            }

            .announcement-divider {
                display: none;
            }

            .announcement-controls {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="announcement-section">
        <!-- Left Side -->
        <div class="announcement-left">
            <img src="imgs/announcement-megaphone-svgrepo-com.svg" alt="Announcement Icon" />
            <h2>Announcements</h2>
        </div>

        <!-- Divider -->
        <div class="announcement-divider"></div>

        <!-- Right Side -->
        <div class="announcement-right">
            <h3>Latest Announcements</h3>

            <!-- Important Banner -->
            <div class="announcement-banner">
                🔴 Important: Predicate day is on May 19 (Monday).
            </div>
            <div class="announcement-banner">
                🔴 Important: Campus will be closed on May 20 due to maintenance.
            </div>
            <div class="announcement-banner">
                🔴 Important: Exams commencement date, May 27th {Best of Luck!} .
            </div>

            <!-- Search and Filter -->
            <div class="announcement-controls">
                <input type="text" placeholder="Search announcements..." />
                <select>
                    <option>All Categories</option>
                    <option>Academic</option>
                    <option>Events</option>
                    <option>Technical</option>
                    <option>General</option>
                </select>
            </div>

            <!-- Announcement Cards -->
            <div class="announcement-cards">
                <div class="announcement-card">
                    🗓️ New semester registration is now open.
                    <small>Posted: May 12, 2025</small>
                    <a class="read-more" href="#">Read more</a>
                </div>
                <div class="announcement-card">
                    📚 Library hours extended during exam season.
                    <small>Posted: May 10, 2025</small>
                    <a class="read-more" href="#">Read more</a>
                </div>
                <div class="announcement-card">
                    🛠️ Upcoming maintenance on the campus network.
                    <small>Posted: May 9, 2025</small>
                    <a class="read-more" href="#">Read more</a>
                </div>
                <div class="announcement-card">
                    🧾 View the class timetable.
                    <small>Posted: May 7, 2025</small>
                    <a class="read-more" href="#">Read more</a>
                </div>
                <div class="announcement-card">
                    📢 Don’t forget to check your email for updates.
                    <small>Posted: May 5, 2025</small>
                    <a class="read-more" href="#">Read more</a>
                </div>
            </div>

            <!-- Load More Button -->
            <button class="load-more-btn">Load More</button>
        </div>
    </section>

</asp:Content>

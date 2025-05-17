using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web.Services;
using Npgsql;

namespace SmartCampusServices
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        private static readonly string connStr = ConfigurationManager.ConnectionStrings["PostgresConnection"].ConnectionString;

        [WebMethod]
        public static List<dynamic> GetBookings()
        {
            List<dynamic> bookings = new List<dynamic>();

            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = @"SELECT rb.booking_id, r.room_name, u.full_name AS booked_by, 
                                    rb.start_datetime, rb.end_datetime, rb.booking_status, rb.booking_purpose
                                FROM room_booking rb
                                JOIN rooms r ON rb.room_id = r.room_id
                                JOIN users u ON rb.user_id = u.id";

                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                using (NpgsqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        bookings.Add(new
                        {
                            BookingID = reader["booking_id"],
                            RoomName = reader["room_name"],
                            BookedBy = reader["booked_by"],
                            StartTime = reader["start_datetime"],
                            EndTime = reader["end_datetime"],
                            Status = reader["booking_status"],
                            Purpose = reader["booking_purpose"]
                        });
                    }
                }
            }
            return bookings;
        }

        [WebMethod]
        public static List<dynamic> GetUsers()
        {
            List<dynamic> users = new List<dynamic>();

            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT id, full_name, email, role FROM users";

                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                using (NpgsqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        users.Add(new
                        {
                            ID = reader["id"],
                            FullName = reader["full_name"],
                            Email = reader["email"],
                            Role = reader["role"]
                        });
                    }
                }
            }
            return users;
        }

        [WebMethod]
        public static List<dynamic> GetMaintenance()
        {
            List<dynamic> maintenanceIssues = new List<dynamic>();

            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT issue_id, description, reported_by, status FROM maintenance_requests";

                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                using (NpgsqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        maintenanceIssues.Add(new
                        {
                            IssueID = reader["issue_id"],
                            Description = reader["description"],
                            ReportedBy = reader["reported_by"],
                            Status = reader["status"]
                        });
                    }
                }
            }
            return maintenanceIssues;
        }

        [WebMethod]
        public static List<dynamic> GetAnnouncements()
        {
            List<dynamic> announcements = new List<dynamic>();

            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "SELECT id, title, content, publish_date FROM announcements";

                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                using (NpgsqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        announcements.Add(new
                        {
                            ID = reader["id"],
                            Title = reader["title"],
                            Content = reader["content"],
                            PublishDate = reader["publish_date"]
                        });
                    }
                }
            }
            return announcements;
        }

        [WebMethod]
        public static string DeleteBooking(int bookingId)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "DELETE FROM room_booking WHERE booking_id = @bookingId";
                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@bookingId", bookingId);
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0 ? "Booking deleted successfully." : "Failed to delete booking.";
                }
            }
        }

        [WebMethod]
        public static string DeleteMaintenance(int issueId)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "DELETE FROM maintenance_issues WHERE issue_id = @issueId";
                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@issueId", issueId);
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0 ? "Maintenance issue deleted successfully." : "Failed to delete maintenance issue.";
                }
            }
        }

        [WebMethod]
        public static string DeleteAnnouncement(int announcementId)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "DELETE FROM announcements WHERE id = @announcementId";
                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@announcementId", announcementId);
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0 ? "Announcement deleted successfully." : "Failed to delete announcement.";
                }
            }
        }

        [WebMethod]
        public static string UpdateBookingStatus(int bookingId, string status)
        {
            using (NpgsqlConnection conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                string query = "UPDATE room_booking SET booking_status = @status WHERE booking_id = @bookingId";
                using (NpgsqlCommand cmd = new NpgsqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@bookingId", bookingId);
                    int rows = cmd.ExecuteNonQuery();
                    return rows > 0 ? "Booking status updated successfully." : "Failed to update booking status.";
                }
            }
        }


    }
}

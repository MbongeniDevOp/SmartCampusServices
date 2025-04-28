using System;
using System.IO;
using System.Web;

namespace SmartCampusServices
{
    public class Logger
    {
        public void LogToFile(string message)
        {
            try
            {
                string projectDirectory = HttpContext.Current.Server.MapPath("~"); // Get the root of the project directory
                string logFilePath = Path.Combine(projectDirectory, "logs.txt"); // Log file in project root folder
                string logMessage = $"{DateTime.Now}: {message}";

                // Write log to file
                File.AppendAllText(logFilePath, logMessage + Environment.NewLine);
            }
            catch (Exception ex)
            {
                // In case logging fails, fallback to console or ignore silently
                Console.WriteLine($"Logging failed: {ex.Message}");
            }
        }
    }
}

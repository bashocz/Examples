using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using System.Configuration;
using System.Web.Hosting;
using log4net;
using log4net.Repository;

namespace WebMech.Web
{
    public class LogIt
    {
        private const string formatDateTimeConst = "yyyy-MM-dd_HH-mm";

        private static ILog logLogger;

        private static string logDir;
        private static string logFileName;

        static LogIt()
        {
            try
            {
                logDir = Path.Combine(HostingEnvironment.ApplicationPhysicalPath, ConfigurationSettings.AppSettings["logDir"]);
                if (!Directory.Exists(logDir))
                    Directory.CreateDirectory(logDir);

                string logFile = ConfigurationSettings.AppSettings["logFile"];
                logFile = string.Format(logFile, DateTime.Now.ToString(formatDateTimeConst));
                logFileName = Path.Combine(logDir, logFile);

                log4net.Config.XmlConfigurator.Configure(GetLogConfig());
                logLogger = LogManager.GetLogger("Log");
            }
            catch { }
        }

        /// <summary>
        /// Work around for static destructor
        /// </summary>
        private static readonly StaticDestructor sd = new StaticDestructor();

        /// <summary>
        /// Class represents static destructor.
        /// </summary>
        private class StaticDestructor
        {
            ~StaticDestructor()
            {
                log4net.LogManager.Shutdown();
            }
        }

        /// <summary>
        /// Adds appender to xml configuration for log4net.
        /// </summary>
        /// <param name="xmlDoc">A System.Xml.XmlDocument that specifies
        /// xml configuration tree.</param>
        /// <param name="rootLogNode">A System.Xml.XmlNode that specifies
        /// root appender xml node.</param>
        /// <param name="appenderName">A System.String that specifies
        /// name of appender.</param>
        /// <param name="fileName">A System.String that specifies
        /// name of log file.</param>
        /// <returns></returns>
        private static XmlElement AddAppender(XmlDocument xmlDoc, XmlNode rootLogNode, string appenderName, string fileName)
        {
            XmlElement appenderElement = xmlDoc.CreateElement("appender");
            appenderElement.SetAttribute("name", appenderName);
            appenderElement.SetAttribute("type", "log4net.Appender.FileAppender");
            XmlNode appenderNode1 = rootLogNode.AppendChild(appenderElement);

            XmlElement paramFile = xmlDoc.CreateElement("param");
            paramFile.SetAttribute("name", "File");
            paramFile.SetAttribute("value", fileName);
            appenderNode1.AppendChild(paramFile);

            XmlElement paramAppendToFile = xmlDoc.CreateElement("param");
            paramAppendToFile.SetAttribute("name", "AppendToFile");
            paramAppendToFile.SetAttribute("value", "true");
            appenderNode1.AppendChild(paramAppendToFile);

            XmlElement paramDatePattern = xmlDoc.CreateElement("param");
            paramDatePattern.SetAttribute("name", "DatePattern");
            paramDatePattern.SetAttribute("value", "yyyy.MM.dd");
            appenderNode1.AppendChild(paramDatePattern);

            XmlElement paramStaticLogFileName = xmlDoc.CreateElement("param");
            paramStaticLogFileName.SetAttribute("name", "StaticLogFileName");
            paramStaticLogFileName.SetAttribute("value", "true");
            appenderNode1.AppendChild(paramStaticLogFileName);

            XmlElement layout = xmlDoc.CreateElement("layout");
            layout.SetAttribute("type", "log4net.Layout.PatternLayout");
            XmlNode layoutNode = appenderNode1.AppendChild(layout);

            XmlElement paramConversionPattern = xmlDoc.CreateElement("param");
            paramConversionPattern.SetAttribute("name", "ConversionPattern");
            paramConversionPattern.SetAttribute("value", "%date (%-5level) - %message%newline");
            layoutNode.AppendChild(paramConversionPattern);

            return appenderElement;
        }

        /// <summary>
        /// Adds logger to xml configuration for log4net.
        /// </summary>
        /// <param name="xmlDoc">A System.Xml.XmlDocument that specifies
        /// xml configuration tree.</param>
        /// <param name="rootLogNode">A System.Xml.XmlNode that specifies
        /// root appender xml node.</param>
        /// <param name="isRoot">A System.Boolean that indicates
        /// whether it is a root.</param>
        /// <param name="levelName">A System.String that specifies
        /// level of loggining.</param>
        /// <param name="loggerName">A System.String that specifies
        /// the logger name.</param>
        /// <param name="appenderNameList">A System.String[] that specifies
        /// list of assigned appenders.</param>
        /// <returns></returns>
        private static XmlElement AddLogger(XmlDocument xmlDoc, XmlNode rootLogNode, bool isRoot, string levelName, string loggerName, string[] appenderNameList)
        {
            XmlElement root;
            XmlNode rootNode;

            if (isRoot)
            {
                root = xmlDoc.CreateElement("root");
                rootNode = rootLogNode.AppendChild(root);
            }
            else
            {
                root = xmlDoc.CreateElement("logger");
                root.SetAttribute("name", loggerName);
                rootNode = rootLogNode.AppendChild(root);
            }

            XmlElement level = xmlDoc.CreateElement("level");
            level.SetAttribute("value", levelName);
            rootNode.AppendChild(level);

            if (!isRoot)
            {
                foreach (string appenderName in appenderNameList)
                {
                    XmlElement appenderRef = xmlDoc.CreateElement("appender-ref");
                    appenderRef.SetAttribute("ref", appenderName);
                    rootNode.AppendChild(appenderRef);
                }
            }

            return root;
        }

        /// <summary>
        /// Gets xml configuration for log4net.
        /// </summary>
        /// <returns>A System.Xml.XmlElement that specifies
        /// the xml configuration for log4net.</returns>
        private static XmlElement GetLogConfig()
        {
            XmlDocument xmlDoc = new XmlDocument();

            XmlElement rootLogElement = xmlDoc.CreateElement("log4net");
            XmlNode rootLogNode = xmlDoc.AppendChild(rootLogElement);

            AddAppender(xmlDoc, rootLogNode, "LogFileAppender", logFileName);

            AddLogger(xmlDoc, rootLogNode, true, "Info", "Root", new string[] { "" });
            AddLogger(xmlDoc, rootLogNode, false, "Info", "Log", new string[] { "LogFileAppender" });

            return rootLogElement;
        }

        /// <summary>
        /// Adds information into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        public static void Info(string message)
        {
            if (logLogger != null)
                logLogger.Info(message);
        }

        /// <summary>
        /// Adds warning into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        public static void Warning(string message)
        {
            if (logLogger != null)
                logLogger.Warn(message);
        }
        /// <summary>
        /// Adds warning into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        /// <param name="ex">A System.Exception that specifies
        /// logged exception.</param>
        public static void Warning(string message, Exception ex)
        {
            if (logLogger != null)
                logLogger.Warn(message, ex);
        }

        /// <summary>
        /// Adds error into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        public static void Error(string message)
        {
            if (logLogger != null)
                logLogger.Error(message);
        }
        /// <summary>
        /// Adds error into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        /// <param name="ex">A System.Exception that specifies
        /// logged exception.</param>
        public static void Error(string message, Exception ex)
        {
            if (logLogger != null)
                logLogger.Error(message, ex);
        }

        /// <summary>
        /// Adds debug information into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        public static void Debug(string message)
        {
            if (logLogger != null)
                logLogger.Debug(message);
        }
        /// <summary>
        /// Adds debug information into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        /// <param name="ex">A System.Exception that specifies
        /// logged exception.</param>
        public static void Debug(string message, Exception ex)
        {
            if (logLogger != null)
                logLogger.Debug(message, ex);
        }

        /// <summary>
        /// Adds fatal error into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        public static void Fatal(string message)
        {
            if (logLogger != null)
                logLogger.Fatal(message);
        }
        /// <summary>
        /// Adds fatal error into log file.
        /// </summary>
        /// <param name="message">A System.String that specifies
        /// logged message.</param>
        /// <param name="ex">A System.Exception that specifies
        /// logged exception.</param>
        public static void Fatal(string message, Exception ex)
        {
            if (logLogger != null)
                logLogger.Fatal(message, ex);
        }
    }
}

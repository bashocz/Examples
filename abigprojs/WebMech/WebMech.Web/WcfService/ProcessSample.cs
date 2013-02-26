using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Configuration;
using System.Reflection;
using System.Web.Hosting;
using System.Globalization;

namespace WebMech.Web
{
    internal class StatisticSurface
    {
        private readonly string samplesDir;
        private readonly string imagesDir;

        private readonly string surfaceName;
        private readonly string imageName;
        private readonly byte[] image;
        private readonly string pointsName;
        private readonly byte[] points;

        private readonly List<Point> pointList;
        private readonly List<ParameterData> parameterList;
        private readonly List<Point> gridPointList;

        private readonly CultureInfo cultureInfo = CultureInfo.CreateSpecificCulture("en-US");

        private readonly int surfaceSize = 100;
        private double xMin, xMax, yMin, yMax, zMin, zMax;
        private double xStep, yStep, zMean;

        /// <summary>
        /// Object constructor.
        /// </summary>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        /// <param name="imageName">A System.String that specifies
        /// the file name of sample image.</param>
        /// <param name="image">A System.Byte[] that specifies
        /// byte array of image file</param>
        /// <param name="pointsName">A System.String that specifies
        /// the file name of text file with 3D points.</param>
        /// <param name="points">A System.String that specifies
        /// byte array of text file with 3D points.</param>
        /// <returns>A WebMech.Web.SampleData that specifies
        /// data object of sample.</returns>
        public StatisticSurface(string surfaceName, string imageName, byte[] image, string pointsName, byte[] points)
        {
            this.surfaceName = surfaceName;
            this.imageName = imageName;
            this.image = image;
            this.pointsName = pointsName;
            this.points = points;

            samplesDir = ConfigurationSettings.AppSettings["samplesDir"];
            imagesDir = ConfigurationSettings.AppSettings["imagesDir"];

            pointList = new List<Point>();
            parameterList = new List<ParameterData>();
            gridPointList = new List<Point>();
        }

        /// <summary>
        /// Saves image file into web page's files directory.
        /// </summary>
        private void SaveImageFile()
        {
            string dir = Path.Combine(HostingEnvironment.ApplicationPhysicalPath, imagesDir);
            dir = Path.Combine(dir, surfaceName);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            FileStream stream = new FileStream(Path.Combine(dir, imageName), FileMode.Create);
            stream.Write(image, 0, image.Length);
            stream.Close();
            stream.Dispose();
        }

        /// <summary>
        /// Saves text file into with 3D points web page's files directory.
        /// </summary>
        private void SavePointsFile()
        {
            string dir = Path.Combine(HostingEnvironment.ApplicationPhysicalPath, samplesDir);
            dir = Path.Combine(dir, surfaceName);
            if (!Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            FileStream stream = new FileStream(Path.Combine(dir, pointsName), FileMode.Create);
            stream.Write(points, 0, points.Length);
            stream.Close();
            stream.Dispose();
        }

        /// <summary>
        /// Parses line to 3D point.
        /// </summary>
        /// <param name="line">A System.String that specifies
        /// line with 3 double values separated with semicolon.</param>
        /// <returns>A WebMech.Web.Parameter that specifies
        /// row of Point table.</returns>
        private Point ParseLine(string line)
        {
            double x = 0, y = 0, z = 0;

            string[] coordinates = line.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            if (coordinates.Length == 3)
            {
                x = Convert.ToDouble(coordinates[0].Trim(), cultureInfo);
                y = Convert.ToDouble(coordinates[1].Trim(), cultureInfo);
                z = Convert.ToDouble(coordinates[2].Trim(), cultureInfo);
            }

            return new Point { x = x, y = y, z = z };
        }

        /// <summary>
        /// Parses the text file with 3D points.
        /// </summary>
        private void ParseFile()
        {
            pointList.Clear();
            xMin = yMin = zMin = int.MaxValue;
            xMax = yMax = zMax = int.MinValue;
            zMean = 0;
            MemoryStream stream = new MemoryStream();
            stream.Write(points, 0, points.Length);
            stream.Seek(0, SeekOrigin.Begin);
            StreamReader reader = new StreamReader(stream);
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                Point point = ParseLine(line);
                if (point.x < xMin) xMin = point.x;
                if (point.x > xMax) xMax = point.x;
                if (point.y < yMin) yMin = point.y;
                if (point.y > yMax) yMax = point.y;
                if (point.z < zMin) zMin = point.z;
                if (point.z > zMax) zMax = point.z;
                zMean += point.z;
                pointList.Add(point);
            }
            reader.Close();
            stream.Close();

            xStep = (xMax - xMin) / (surfaceSize - 1);
            yStep = (yMax - yMin) / (surfaceSize - 1);
            zMean /= pointList.Count;
        }

        /// <summary>
        /// Calculates statistical parameters.
        /// </summary>
        private void CalculateParameters()
        {
            parameterList.Clear();

            double variance = 0;
            double skew1 = 0, skew2 = 0;
            double kurt1 = 0, kurt2 = 0;

            for (int idx = 0; idx < pointList.Count; idx++)
            {
                variance += Math.Pow(pointList[idx].z - zMean, 2);
                skew1 += Math.Pow(pointList[idx].z - zMean, 3);
                skew2 += Math.Pow(pointList[idx].z - zMean, 2);
                kurt1 += Math.Pow(pointList[idx].z - zMean, 4);
                kurt2 += Math.Pow(pointList[idx].z - zMean, 2);
            }

            double stddev = Math.Sqrt((1.0 / pointList.Count) * variance);
            variance = variance / (pointList.Count - 1);
            double skewness = (Math.Sqrt(pointList.Count) * skew1) / Math.Pow(skew2, 1.5);
            double kurtosis = (pointList.Count * kurt1) / (Math.Pow(kurt2, 2)) - 3;

            parameterList.Add(new ParameterData { Name = "Points", Value = pointList.Count });
            parameterList.Add(new ParameterData { Name = "Z mean", Value = zMean });
            parameterList.Add(new ParameterData { Name = "Z variance", Value = variance });
            parameterList.Add(new ParameterData { Name = "Z min", Value = zMin });
            parameterList.Add(new ParameterData { Name = "Z max", Value = zMax });
            parameterList.Add(new ParameterData { Name = "Skewness", Value = skewness });
            parameterList.Add(new ParameterData { Name = "Kurtosis", Value = kurtosis });
            parameterList.Add(new ParameterData { Name = "Standard deviation", Value = stddev });
        }

        /// <summary>
        /// Normalizes zigzag 3D points into grid.
        /// </summary>
        private void Normalize()
        {
            gridPointList.Clear();
            // visualize points - initialize
            int[] pointCount = new int[surfaceSize * surfaceSize];
            for (int y = 0; y < surfaceSize; y++)
                for (int x = 0; x < surfaceSize; x++)
                {
                    gridPointList.Add(new Point { x = xMin + x * xStep, y = yMin + y * yStep, z = 0 });
                    pointCount[surfaceSize * y + x] = 0;
                }

            // visualize points - sort
            for (int idx = 0; idx < pointList.Count; idx++)
            {
                int x = (int)((pointList[idx].x - xMin + (xStep / 2)) / xStep);
                if (x < 0) x = 0;
                if (x >= surfaceSize) x = surfaceSize - 1;

                int y = (int)((pointList[idx].y - yMin + (yStep / 2)) / yStep);
                if (y < 0) y = 0;
                if (y >= surfaceSize) y = surfaceSize - 1;

                gridPointList[surfaceSize * y + x].z += pointList[idx].z;
                pointCount[surfaceSize * y + x]++;
            }

            for (int y = 0; y < surfaceSize; y++)
                for (int x = 0; x < surfaceSize; x++)
                {
                    // visualize points - Z average
                    if (pointCount[surfaceSize * y + x] > 0)
                        gridPointList[surfaceSize * y + x].z /= pointCount[surfaceSize * y + x];
                    else
                        gridPointList[surfaceSize * y + x].z = zMean;
                }
        }

        /// <summary>
        /// Saves sample to HDD, calculates statistic parameters and normalize 3D surface.
        /// </summary>
        public void Process()
        {
            SaveImageFile();
            SavePointsFile();
            ParseFile();
            CalculateParameters();
            Normalize();
        }

        /// <summary>
        /// Gets the image file name with relative path.
        /// </summary>
        public string ImageName
        {
            get { return Path.Combine(Path.Combine(imagesDir, surfaceName), imageName); }
        }

        /// <summary>
        /// Gets minimum value of X coordinate.
        /// </summary>
        public double XMin
        {
            get { return xMin; }
        }

        /// <summary>
        /// Gets maximum value of X coordinate.
        /// </summary>
        public double XMax
        {
            get { return xMax; }
        }

        /// <summary>
        /// Gets minimum value of Y coordinate.
        /// </summary>
        public double YMin
        {
            get { return yMin; }
        }

        /// <summary>
        /// Gets maximum value of Y coordinate.
        /// </summary>
        public double YMax
        {
            get { return yMax; }
        }

        /// <summary>
        /// Gets minimum value of Z coordinate.
        /// </summary>
        public double ZMin
        {
            get { return zMin; }
        }

        /// <summary>
        /// Gets maximum value of Z coordinate.
        /// </summary>
        public double ZMax
        {
            get { return zMax; }
        }

        /// <summary>
        /// Gets mean value of Z coordinate.
        /// </summary>
        public double ZMean
        {
            get { return zMean; }
        }

        /// <summary>
        /// Gets list of 3D points.
        /// </summary>
        public IList<Point> PointList
        {
            get { return pointList.AsReadOnly(); }
        }

        /// <summary>
        /// Gets list of statistic parameters.
        /// </summary>
        public IList<ParameterData> ParameterList
        {
            get { return parameterList.AsReadOnly(); }
        }

        /// <summary>
        /// Gets list of normalized 3D points.
        /// </summary>
        public IList<Point> VisualizePointList
        {
            get { return gridPointList.AsReadOnly(); }
        }
    }
}

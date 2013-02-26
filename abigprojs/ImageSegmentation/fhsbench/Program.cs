using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using ImageSegmentation.Helper;
using System.Threading;
using System.Diagnostics;
using Basho.Graphics.Segmentation;

namespace fhsbench
{
    class Program
    {
        static string reportDir = "results";
        static string reportFile = "report.txt";
        static string path = ".";

        static void Main(string[] args)
        {
            if (args.Length > 0)
                path = args[0];
            if (!Directory.Exists(path))
            {
                Console.WriteLine(string.Format("Directory '{0}' doesn't exist.", path));
                return;
            }
            reportDir = Path.Combine(path, reportDir);
            if (Directory.Exists(reportDir))
                Directory.Delete(reportDir, true);
            Thread.Sleep(1);
            Directory.CreateDirectory(reportDir);

            StringBuilder sb = new StringBuilder();
            AppendSystemInfo(sb);

            var files = Directory.GetFiles(path, "*.*")
                .Where(s => s.EndsWith(".gif") ||
                    s.EndsWith(".jpg") ||
                    s.EndsWith(".jpe") ||
                    s.EndsWith(".png") ||
                    s.EndsWith(".bmp") ||
                    s.EndsWith(".dib") ||
                    s.EndsWith(".tif") ||
                    s.EndsWith(".wmf") ||
                    s.EndsWith(".ras") ||
                    s.EndsWith(".eps") ||
                    s.EndsWith(".pcx") ||
                    s.EndsWith(".psd") ||
                    s.EndsWith(".tga"));
            foreach (string file in files)
            {
                SegmentImage(file, sb);
            }

            using (FileStream stream = new FileStream(Path.Combine(reportDir, reportFile), FileMode.Create))
            {
                using (TextWriter writer = new StreamWriter(stream))
                {
                    writer.Write(sb.ToString());
                    writer.Flush();
                }
            }
        }

        private static void AppendSystemInfo(StringBuilder sb)
        {
            sb.AppendFormat("OS: {0}", Environment.OSVersion);
            sb.AppendLine();
        }

        private static void SegmentImage(string file, StringBuilder sb)
        {
            Console.WriteLine(string.Format("proceed image: {0}", file));
            sb.AppendLine();
            sb.AppendFormat("image: {0}", Path.GetFileName(file));
            sb.AppendLine();

            string fileName = Path.GetFileNameWithoutExtension(file);
            string fileExt = Path.GetExtension(file);
            Bitmap src = new Bitmap(file);

            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_00_150" + fileExt), 0, 150, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_00_300" + fileExt), 0, 300, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_00_450" + fileExt), 0, 450, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_04_150" + fileExt), 0.4, 150, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_04_300" + fileExt), 0.4, 300, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_04_450" + fileExt), 0.4, 450, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_08_150" + fileExt), 0.8, 150, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_08_300" + fileExt), 0.8, 300, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_08_450" + fileExt), 0.8, 450, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_12_150" + fileExt), 1.2, 150, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_12_300" + fileExt), 1.2, 300, sb);
            SegmentImageParam(src, Path.Combine(reportDir, fileName + "_12_450" + fileExt), 1.2, 450, sb);
        }

        private static void SegmentImageParam(Bitmap src, string outputFile, double sigma, int k, StringBuilder sb)
        {

            BitmapData srcData = src.LockBits(new Rectangle(0, 0, src.Width, src.Height), ImageLockMode.ReadOnly, src.PixelFormat);
            int bytesPerPixel = 1;
            if (src.PixelFormat == PixelFormat.Format8bppIndexed)
                bytesPerPixel = 1;
            else if (src.PixelFormat == PixelFormat.Format24bppRgb)
                bytesPerPixel = 3;
            else if ((src.PixelFormat == PixelFormat.Format32bppRgb) || (src.PixelFormat == PixelFormat.Format32bppArgb))
                bytesPerPixel = 4;

            Bitmap dst = new Bitmap(src.Width, src.Height, src.PixelFormat);
            BitmapData dstData = dst.LockBits(new Rectangle(0, 0, dst.Width, dst.Height), ImageLockMode.WriteOnly, dst.PixelFormat);

            Stopwatch stopwatch = new Stopwatch();
            Fhs.Fhs fhs = new Fhs.Fhs();
            stopwatch.Start();
            unsafe { fhs.fhs((byte*)srcData.Scan0, src.Width, src.Height, srcData.Stride, bytesPerPixel, (byte*)dstData.Scan0, sigma, k); }
            stopwatch.Stop();

            src.UnlockBits(srcData);
            dst.UnlockBits(dstData);

            int[,] segments = ImageHelper.GetSegments(dst);
            int max = 0;
            foreach (int s in segments)
                if (s > max) max = s;

            sb.AppendFormat("sigma = {0:0.0}, k = {1}: segmentation time = {2}, segment count = {3}", sigma, k, stopwatch.Elapsed, max + 1);
            sb.AppendLine();

            Bitmap seg = ImageHelper.GetBitmap(segments);
            seg.Save(outputFile);
        }
    }
}

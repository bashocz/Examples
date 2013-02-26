using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Numerics;
using System.Threading;

namespace Fourier.Domain
{
    class Filter
    {
        private static Complex[,] GetCorners(Complex[,] signal, bool isFromCenter, double lim1, double lim2, IProgress progress, ref CancellationToken ct)
        {
            int M = signal.GetLength(0);
            int N = signal.GetLength(1);
            int M2 = (M + 1) / 2;
            int N2 = (N + 1) / 2;
            int MN2 = M2 * N2;
            double lengthMN = Math.Sqrt(M2 * M2 + N2 * N2);
            double length1 = lim1 * lengthMN;
            double length2 = lim2 * lengthMN;
            double lengthGrad = length2 - length1;

            Complex c1 = new Complex(1, 0);
            Complex[,] filter = new Complex[M, N];

            for (int x = 0; x < M2; x++)
                for (int y = 0; y < N2; y++)
                {
                    double length = Math.Sqrt(x * x + y * y);
                    double factor = 1;
                    if (length < length1)
                        factor = 0;
                    else if (length < length2)
                        factor = (length - length1) / lengthGrad;
                    if (!isFromCenter)
                        factor = 1 - factor;
                    filter[x, y] = filter[M - 1 - x, y] = filter[x, N - 1 - y] = filter[M - 1 - x, N - 1 - y] = factor * c1;
                    // application process functionality
                    progress.Progress = (x * N + y) / MN2;
                    if (ct.IsCancellationRequested)
                        return null;
                }

            return filter;
        }

        private static Complex[,] GetRectangle(Complex[,] signal, bool isFromCenter, double lim1, double lim2, IProgress progress, ref CancellationToken ct)
        {
            int M = signal.GetLength(0);
            int N = signal.GetLength(1);
            int M2 = (M + 1) / 2;
            int N2 = (N + 1) / 2;
            int MN2 = M2 * N2;
            double limM1 = lim1 * M2;
            double limN1 = lim1 * N2;
            double limM2 = lim2 * M2;
            double limN2 = lim2 * N2;
            double lengthGradM = limM2 - limM1;
            double lengthGradN = limN2 - limN1;

            Complex c1 = new Complex(1, 0);
            Complex[,] filter = new Complex[M, N];

            for (int x = 0; x < M2; x++)
                for (int y = 0; y < N2; y++)
                {
                    double factor = 1;
                    if ((x < limM1) || (y < limN1))
                        factor = 0;
                    else if ((x<limM2)&&(y<limN2))
                        factor = ((x - limM1) / lengthGradM) * ((y - limN1) / lengthGradN);
                    else if (x < limM2)
                        factor = (x - limM1) / lengthGradM;
                    else if (y < limN2)
                        factor = (y - limN1) / lengthGradN;
                    if (!isFromCenter)
                        factor = 1 - factor;
                    filter[x, y] = filter[M - 1 - x, y] = filter[x, N - 1 - y] = filter[M - 1 - x, N - 1 - y] = factor * c1;
                    // application process functionality
                    progress.Progress = (x * N + y) / MN2;
                    if (ct.IsCancellationRequested)
                        return null;
                }

            return filter;
        }

        public static Complex[,] GetFilter(Complex[,] signal, FilterType type, bool isFromCenter, double lim1, double lim2, IProgress progress, CancellationToken ct)
        {
            switch (type)
            {
                case FilterType.Rectangle:
                    return GetRectangle(signal, isFromCenter, lim1, lim2, progress, ref ct);
                case FilterType.Corner:
                    return GetCorners(signal, isFromCenter, lim1, lim2, progress, ref ct);
            }
            throw new NotImplementedException("Filter type is not implemented.");
        }

        public static Complex[,] ApplyFilter(Complex[,] signal, Complex[,] filter, IProgress progress, CancellationToken ct)
        {
            int M = signal.GetLength(0);
            int N = signal.GetLength(1);
            int MN = M * N;
            Complex[,] result = new Complex[M, N];

            for (int x = 0; x < M; x++)
                for (int y = 0; y < N; y++)
                {
                    result[x, y] = signal[x, y] * filter[x, y];
                    progress.Progress = (x * N + y) / MN;
                    // application process functionality
                    if (ct.IsCancellationRequested)
                        return null;
                }

            return result;
        }
    }
}

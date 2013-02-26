using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Numerics;
using System.Threading;

namespace Fourier.Domain
{
    class FourierTransform
    {
        #region updating progress

        private static void UpdateProgress(IProgress progress, int x, int y, int M, int N)
        {
            progress.Progress = (100 * (x * N + y)) / (M * N);
        }

        private static void UpdateProgress(IProgress progress, int x, int N)
        {
            progress.Progress = (100 * x) / N;
        }

        #endregion

        #region slow calculation

        private static Complex[,] SlowCalculation(Complex[,] f, int polarity, IProgress progress, CancellationToken ct)
        {
            int M = f.GetLength(0);
            int N = f.GetLength(1);
            double SqrtMN = 1 / Math.Sqrt(M * N);
            double Pi2 = polarity * 2 * Math.PI;

            Complex[,] F = new Complex[M, N];

            for (int k = 0; k < M; k++)
                for (int l = 0; l < N; l++)
                {
                    double kM = (double)k / (double)M;
                    double lN = (double)l / (double)N;
                    F[k, l] = 0;

                    for (int m = 0; m < M; m++)
                        for (int n = 0; n < N; n++)
                        {
                            double phi = Pi2 * ((double)m * kM + (double)n * lN);
                            Complex exp = Complex.Exp(new Complex(0, phi));
                            F[k, l] += f[m, n] * exp;
                            // application process functionality
                            if (ct.IsCancellationRequested)
                                return null;
                        }

                    F[k, l] *= SqrtMN;
                    // application process functionality
                    UpdateProgress(progress, k, l, M, N);
                }

            return F;
        }

        private static Complex[,] VerySlowCalculation(Complex[,] f, int polarity, IProgress progress, CancellationToken ct)
        {
            int M = f.GetLength(0);
            int N = f.GetLength(1);

            Complex[,] F = new Complex[M, N];

            for (int k = 0; k < M; k++)
                for (int l = 0; l < N; l++)
                {
                    F[k, l] = 0;

                    for (int m = 0; m < M; m++)
                        for (int n = 0; n < N; n++)
                        {
                            double phi = polarity * 2 * Math.PI * (((double)m * (double)k) / (double)M + ((double)n * (double)l) / (double)N);
                            Complex exp = Complex.Exp(new Complex(0, phi));
                            F[k, l] += f[m, n] * exp;
                            // application process functionality
                            if (ct.IsCancellationRequested)
                                return null;
                        }

                    F[k, l] /= Math.Sqrt(M * N);
                    // application process functionality
                    UpdateProgress(progress, k, l, M, N);
                }

            return F;
        }

        #endregion

        #region matrix calculation

        private static Complex[,] phic;
        private static Complex[,] phir;
        private static Complex[,] phicC;
        private static Complex[,] phirC;

        private static Complex[,] GetMatrixPhi(int N, CancellationToken ct)
        {
            double SqrtN = 1 / Math.Sqrt(N);
            Complex[,] matrix = new Complex[N, N];

            Complex wn = Complex.Exp(new Complex(0, (-2 * Math.PI) / N));
            for (int x = 0; x < N; x++)
                for (int y = x; y < N; y++)
                {
                    matrix[x, y] = matrix[y, x] = SqrtN * Complex.Pow(wn, x * y);
                    // application process functionality
                    if (ct.IsCancellationRequested)
                        return null;
                }
            return matrix;
        }

        private static Complex[,] GetMatrixPhiR(Complex[,] phi, CancellationToken ct)
        {
            int N = phi.GetLength(0);
            Complex[,] matrix = new Complex[N, N];

            for (int x = 0; x < N; x++)
                for (int y = 0; y < N; y++)
                {
                    matrix[x, y] = Complex.Conjugate(phi[x, y]);
                    // application process functionality
                    if (ct.IsCancellationRequested)
                        return null;
                }
            return matrix;
        }

        private static void CreateMatrixes(int M, int N, CancellationToken ct)
        {
            if (!ct.IsCancellationRequested)
                phic = GetMatrixPhi(M, ct);
            if (!ct.IsCancellationRequested)
                phicC = GetMatrixPhiR(phic, ct);
            if (!ct.IsCancellationRequested)
                phir = GetMatrixPhi(N, ct);
            if (!ct.IsCancellationRequested)
                phirC = GetMatrixPhiR(phir, ct);
        }

        private static Complex[,] MatrixCalculation(Complex[,] c, Complex[,] f, Complex[,] r, IProgress progress, CancellationToken ct)
        {
            int M = f.GetLength(0);
            int N = f.GetLength(1);

            int max = 2 * N * M;

            Complex[,] Ftemp = new Complex[M, N];
            for (int x = 0; x < M; x++)
                for (int y = 0; y < N; y++)
                {
                    Ftemp[x, y] = new Complex();
                    for (int i = 0; i < M; i++)
                        Ftemp[x, y] += c[x, i] * f[i, y];
                    // application process functionality
                    UpdateProgress(progress, x * M + y, max);
                    if (ct.IsCancellationRequested)
                        return null;
                }

            Complex[,] F = new Complex[M, N];
            for (int x = 0; x < M; x++)
                for (int y = 0; y < N; y++)
                {
                    F[x, y] = new Complex();
                    for (int i = 0; i < N; i++)
                        F[x, y] += Ftemp[x, i] * r[i, y];
                    // application process functionality
                    UpdateProgress(progress, M * N + x * M + y, max);
                    if (ct.IsCancellationRequested)
                        return null;
                }

            return F;
        }

        #endregion

        public static Complex[,] Transform(Complex[,] f, FourierType type, IProgress progress, CancellationToken ct)
        {
            switch (type)
            {
                case FourierType.SlowCalculation:
                    return SlowCalculation(f, -1, progress, ct);
                case FourierType.MatrixCalculation:
                    if ((phic == null) || (phir == null) || (phic.GetLength(0) != f.GetLength(0)) || (phir.GetLength(0) != f.GetLength(1)))
                        CreateMatrixes(f.GetLength(0), f.GetLength(1), ct);
                    return MatrixCalculation(phic, f, phir, progress, ct);
            }
            throw new NotImplementedException("Transformation type is not implemented.");
        }

        public static Complex[,] ReverseTransform(Complex[,] F, FourierType type, IProgress progress, CancellationToken ct)
        {
            switch (type)
            {
                case FourierType.SlowCalculation:
                    return SlowCalculation(F, 1, progress, ct);
                case FourierType.MatrixCalculation:
                    if ((phicC == null) || (phirC == null) || (phicC.GetLength(0) != F.GetLength(0)) || (phirC.GetLength(0) != F.GetLength(1)))
                        CreateMatrixes(F.GetLength(0), F.GetLength(1), ct);
                    return MatrixCalculation(phicC, F, phirC, progress, ct);
            }
            throw new NotImplementedException("Transformation type is not implemented.");
        }
    }
}

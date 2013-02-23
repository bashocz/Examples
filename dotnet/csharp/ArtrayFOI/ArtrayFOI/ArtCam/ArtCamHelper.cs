using System;
using System.Collections.Generic;
using System.Text;
using ArtCamSdk;

namespace Mapper.Equipment.Foi
{
    public class ArtCamHelper
    {
        CArtCam cArtCam = new CArtCam();

        private void ThrowError(string method)
        {
            int error;
            if ((error = cArtCam.GetLastError()) > 0)
                throw new ApplicationException("'" + method + "' error code = " + Enum.GetName(typeof(ARTCAMSDK_ERROR), error));
        }

        public ARTCAM_CAMERATYPE Initialize(IntPtr hWnd)
        {
            cArtCam.Initialize(hWnd);
            ThrowError("Initialize");

            return cArtCam.GetDllType();
        }

        public void Release()
        {
            cArtCam.Release();
            ThrowError("Release");
        }

        public void Close()
        {
            cArtCam.Close();
            ThrowError("Close");
        }

        public void SetPreviewWindow(IntPtr hWnd, int left, int top, int width, int height)
        {
            cArtCam.SetPreviewWindow(hWnd, left, top, left + width, top + height);
            ThrowError("SetPreviewWindow");
        }

        public void Preview()
        {
            cArtCam.Preview();
            ThrowError("Preview");
        }

        public void CallbackPreview(IntPtr hWnd, byte[] pixels)
        {
            cArtCam.CallBackPreview(hWnd, pixels, Size, 1);
            ThrowError("CallbackPreview");
        }

        public void Snapshot(byte[] pixels)
        {
            cArtCam.SnapShot(pixels, Size, 1);
            ThrowError("Snapshot");
        }

        public void SetCaptureWindow(int hTotal, int hStart, int hEffective, int vTotal, int vStart, int vEffective)
        {
            cArtCam.SetCaptureWindowEx(hTotal, hStart, hEffective, vTotal, vStart, vEffective);
            ThrowError("SetCaptureWindow");
        }

        public void SetWaitTime(int waitTimeMs)
        {
            cArtCam.SetWaitTime(waitTimeMs);
            ThrowError("SetWaitTime");
        }

        public void SetColorMode(int colorMode)
        {
            cArtCam.SetColorMode(colorMode);
            ThrowError("SetColorMode");
        }

        public int Width
        {
            get { return cArtCam.Width(); }
        }

        public int Height
        {
            get { return cArtCam.Height(); }
        }

        public int Size
        {
            get { return cArtCam.Width() * cArtCam.Height(); }
        }
    }
}

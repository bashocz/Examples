//==========================================================
//	ARTRAY Camera / Capture Module Software Developer Kit
//
//						Version 1.20		2003.9.4
//						Version 1.21		2003.9.18
//						Version 1.22		2003.10.10
//						Version 1.23		2004.1.21
//						Version 1.235		2004.3.19
//						Version 1.24		2004.7.9
//						Version 1.245		2004.8.17
//						Version 1.25		2004.9.1
//						Version 1.26		2004.10.28
//						Version 1.27		2005.3.8
//						Version 1.275		2005.5.23
//						Version 1.276		2005.6.27
//						Version 1.277		2005.12.22
//						Version 1.280		2007.8.23
//						Version 1.300		2009.4.24
//
//									(C) 2002-2005 Artray
//==========================================================

using System;
using System.Runtime.InteropServices;
using System.Text;


/// <summary>
/// Outline of ArtCam
/// </summary>
namespace ArtCamSdk
{
	public enum DLL_MESSAGE
	{
		WM_GRAPHNOTIFY = 0x8001,	// Not used in this version.
		WM_GRAPHPAINT,				// Sent to application when an image is updated.
		WM_ERROR,					// Sent to application when an error occurs
	}

	public enum ARTCAM_CAMERATYPE
	{
		ARTCAM_CAMERATYPE_DS = 1,		// DirectShow Camera
		ARTCAM_CAMERATYPE_DISABLE1		= 2,	// Invalid
		ARTCAM_CAMERATYPE_USTC			= 3,	// ARTUST
		ARTCAM_CAMERATYPE_CNV			= 4,	// ARTCNV
		ARTCAM_CAMERATYPE_DISABLE2		= 5,	// Invalid
		ARTCAM_CAMERATYPE_130MI			= 6,	// ARTCAM-130MI
		ARTCAM_CAMERATYPE_DISABLE3		= 7,	// Invalid
		ARTCAM_CAMERATYPE_200MI			= 8,	// ARTCAM-200MI
		ARTCAM_CAMERATYPE_300MI			= 9,	// ARTCAM-300MI
		ARTCAM_CAMERATYPE_150P			= 10,	// ARTCAM-150P
		ARTCAM_CAMERATYPE_320P			= 11,	// ARTCAM-320P
		ARTCAM_CAMERATYPE_DISABLE4		= 12,	// Invalid
		ARTCAM_CAMERATYPE_200SH			= 13,	// ARTCAM-200SH
		ARTCAM_CAMERATYPE_098			= 14,	// ARTCAM-098
		ARTCAM_CAMERATYPE_036MI			= 15,	// ARTCAM-036MI
		ARTCAM_CAMERATYPE_500P			= 16,	// ARTCAM-500P
		ARTCAM_CAMERATYPE_150P2			= 17,	// ARTCAM-150P2
		ARTCAM_CAMERATYPE_036MIST		= 18,	// ARTCAM-036MIST
		ARTCAM_CAMERATYPE_500MI			= 19,	// ARTCAM-500MI
		ARTCAM_CAMERATYPE_T111			= 20,	// Invalid
		ARTCAM_CAMERATYPE_T112			= 21,	// Invalid
		ARTCAM_CAMERATYPE_150P3			= 22,	// ARTCAM-150P3
		ARTCAM_CAMERATYPE_130MI_MOUT	= 23,	// ARTCAM-130MI MOUT
		ARTCAM_CAMERATYPE_150P3_MOUT	= 24,	// ARTCAM-150P3 MOUT
		ARTCAM_CAMERATYPE_267KY			= 25,	// ARTCAM-267KY
		ARTCAM_CAMERATYPE_274KY			= 26,	// ARTCAM-274KY
		ARTCAM_CAMERATYPE_625KY			= 27,	// ARTCAM-274KY
		ARTCAM_CAMERATYPE_V135MI		= 28,	// ARTCAM-V135MI
		ARTCAM_CAMERATYPE_445KY			= 29,	// ARTCAM-445KY
		ARTCAM_CAMERATYPE_098II			= 30,	// ARTCAM-098II
		ARTCAM_CAMERATYPE_MV413			= 31,	// ARTCAM-MV413USB
		ARTCAM_CAMERATYPE_OV210			= 32,	// ARTCAM-OV210
		ARTCAM_CAMERATYPE_850SH			= 33,	// ARTCAM-850SH
		ARTCAM_CAMERATYPE_1251SH		= 34,	// ARTCAM-1252SH
		ARTCAM_CAMERATYPE_D131			= 35,	// ARTCAM-D131
		ARTCAM_CAMERATYPE_900MI			= 36,	// ARTCAM-900MI
		ARTCAM_CAMERATYPE_1000MI		= 37,	// ARTCAM-1000MI
		ARTCAM_CAMERATYPE_500P2			= 38,	// ARTCAM-500P2

		// SATA Series
		ARTCAM_CAMERATYPE_SATA = 201,	// SATA CAMERA
	}

	// SATA Camera type
	public enum ARTCAM_CAMERATYPE_SATA 
	{
		ARTCAM_CAMERATYPE_SATA_LVDS		= 0,
		ARTCAM_CAMERATYPE_SATA_300MI	= 1,
		ARTCAM_CAMERATYPE_SATA_500MI	= 2,
		ARTCAM_CAMERATYPE_SATA_MV413	= 3,
		ARTCAM_CAMERATYPE_SATA_800MI	= 4,
		ARTCAM_CAMERATYPE_SATA_036MI	= 5,
		ARTCAM_CAMERATYPE_SATA_150P		= 6,
		ARTCAM_CAMERATYPE_SATA_267KY	= 6,
		ARTCAM_CAMERATYPE_SATA_274KY	= 7,
		ARTCAM_CAMERATYPE_SATA_625KY	= 8,
		ARTCAM_CAMERATYPE_SATA_130MI	= 9,
		ARTCAM_CAMERATYPE_SATA_200MI	=10,
	}


	// Error Code
	public enum ARTCAMSDK_ERROR
	{
		ARTCAMSDK_NOERROR = 0,			// Normal
		ARTCAMSDK_NOT_INITIALIZE,		// Not initialized
		ARTCAMSDK_DISABLEDDEVICE,		// Access to unavailable device was attempted
		ARTCAMSDK_CREATETHREAD,			// Failure of thread creation for capturing
		ARTCAMSDK_CREATEWINDOW,			// Window creation failed
		ARTCAMSDK_OUTOFMEMORY,			// Not enough memory for image transfer/Failure for securing memory
		ARTCAMSDK_CAMERASET,			// Error for camera (device) settings
		ARTCAMSDK_CAMERASIZE,			// Error for camera (device) size settings
		ARTCAMSDK_CAPTURE,				// Capturing failed
		ARTCAMSDK_PARAM,				// Wrong argument
		ARTCAMSDK_DIRECTSHOW,			// Directshow initialization error
		ARTCAMSDK_UNSUPPORTED,			// Not supported
		ARTCAMSDK_UNKNOWN,				// Unknow error
		ARTCAMSDK_CAPTURELOST,			// Device lost
		ARTCAMSDK_FILENOTFOUND,			// File not found
		ARTCAMSDK_FPGASET,				// FPGA settings error
		ARTCAMSDK_TRANSIMAGEFAILED,		// Failure of image transferring
	}

	// Information for transferring
	public struct GP_INFO
	{
		public int	lSize;			// size of struct sizeof(GP_INFO)
		public int	lWidth;			// Width of image
		public int	lHeight;		// Height of image
		public int	lBpp;			// Byte per pixcel
		public int	lFps;			// Frame rate (x10)
		//IntPtr	pImage;			// The pointer to the captured image
	}

	// Type of image filter
	public enum ARTCAM_FILTERTYPE
	{
		ARTCAM_FILTERTYPE_RESERVE = 0,			// Reserved
		ARTCAM_FILTERTYPE_BRIGHTNESS,			// Brightness
		ARTCAM_FILTERTYPE_CONTRAST,				// Contrast
		ARTCAM_FILTERTYPE_HUE,					// Hue
		ARTCAM_FILTERTYPE_SATURATION,			// Saturation
		ARTCAM_FILTERTYPE_SHARPNESS,			// Sharpness
		ARTCAM_FILTERTYPE_BAYER_GAIN_RGB,		// Bayer coversion color gain
		ARTCAM_FILTERTYPE_BAYER_GAIN_R,			// Color gain (red only) for bayer conversion
		ARTCAM_FILTERTYPE_BAYER_GAIN_G,			// Color gain (green only) for bayer conversion
		ARTCAM_FILTERTYPE_BAYER_GAIN_B,			// Color gain (Blue only) for bayer conversion
		ARTCAM_FILTERTYPE_BAYER_GAIN_AUTO,		// Auto white balance
		ARTCAM_FILTERTYPE_GAMMA,				// Gumma
		ARTCAM_FILTERTYPE_BAYERMODE,			// Bayer conversion mode
		ARTCAM_FILTERTYPE_GLOBAL_GAIN,			// Global gain for camera
		ARTCAM_FILTERTYPE_COLOR_GAIN_R,			// Color gain (red) for camera
		ARTCAM_FILTERTYPE_COLOR_GAIN_G1,		// Color gain (green1) for camera
		ARTCAM_FILTERTYPE_COLOR_GAIN_G2,		// Color gain (green2) for camera
		ARTCAM_FILTERTYPE_COLOR_GAIN_B,			// Color gain (blue) for camera
		ARTCAM_FILTERTYPE_EXPOSURETIME,			// Exposure time (shutter speed)
		ARTCAM_FILTERTYPE_GRAY_MODE,			// Convert mode for gray scale
		ARTCAM_FILTERTYPE_GRAY_GAIN_R,			// Color gain (red) for gray scale
		ARTCAM_FILTERTYPE_GRAY_GAIN_G1,			// Color gain (green1) for gray scale
		ARTCAM_FILTERTYPE_GRAY_GAIN_G2,			// Color gain (green2) for gray scale
		ARTCAM_FILTERTYPE_GRAY_GAIN_B,			// Color gain (blue) for gray scale
		ARTCAM_FILTERTYPE_GRAY_OFFSET_R,		// Color offset (red) for gray scale
		ARTCAM_FILTERTYPE_GRAY_OFFSET_G1,		// Color offset (green1) for gray scale
		ARTCAM_FILTERTYPE_GRAY_OFFSET_G2,		// Color offset (green2) for gray scale
		ARTCAM_FILTERTYPE_GRAY_OFFSET_B,		// Color offset (blue) for gray scale
	}

	// Pixel skipping transfer mode
	public enum SUBSAMPLE
	{
		SUBSAMPLE_1 = 0,	// Full size
		SUBSAMPLE_2,		// 1/2
		SUBSAMPLE_4,		// 1/4
		SUBSAMPLE_8,		// 1/8
		BINNING_2   = 0x10,
		BINNING_4	= 0x11,
	}

	// Auto iris mode
	public enum AI_TYPE
	{
		AI_NONE = 0,		// Invalid
		AI_EXPOSURE,		// Exposure time
		AI_GAIN,			// Gain
		AI_BOTH,			// Exposure time + Gain
	};

	// Convert mode for gray scale
	public enum GRAY_TYPE 
	{
		GRAY_NONE = 0,		// Disable (without convertion)
		GRAY_BAYERCONVERT,	// Use Gray gain and offset on Bayer image
		GRAY_GRAYSCALE,		// Use Brightness of color-converted image
	};


	// Video format
	public enum VIDEOFORMAT
	{
		VIDEOFORMAT_NTSC = 0,	// NTSC
		VIDEOFORMAT_PAL,		// PAL
		VIDEOFORMAT_PALM,		// PALM
		VIDEOFORMAT_SECAM,		// SECAM
	};

	// Sampling rate
	public enum SAMPLING_RATE
	{
		WIDE_HISPEED = 0,	// 
		WIDE_LOWSPEED,		// 
		NORMAL_HISPEED,		// 
		NORMAL_LOWSPEED,	// 
	};


	// Format for image saving
	public enum FILETYPE
	{
		FILETYPE_BITMAP = 0,
		FILETYPE_RAW,
		FILETYPE_JPEG_HIGH,
		FILETYPE_JPEG_NOMAL,
		FILETYPE_JPEG_LOW,
		FILETYPE_PNG,
		FILETYPE_TIFF,
	};



	public class ArtCam
	{
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetDllVersion")]
		public static extern int GetDllVersion ();
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetLastError")]
		public static extern int GetLastError (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Initialize")]
		public static extern int Initialize (IntPtr hWnd);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Release")]
		public static extern int Release (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Preview")]
		public static extern int Preview (int hACam);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Record")]
		public static extern int Record (int hACam, string lpAviName, int RecTime, int fShow);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_CallBackPreview")]
		public static extern int CallBackPreviewA (int hACam, IntPtr hWnd, byte[] lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_CallBackPreview")]
		public static extern int CallBackPreviewP (int hACam, IntPtr hWnd, IntPtr lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SnapShot")]
		public static extern int SnapShotA (int hACam, byte[] lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SnapShot")]
		public static extern int SnapShotP (int hACam, IntPtr lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Close")]
		public static extern int Close (int hACam);

		// 1250
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Capture")]
		public static extern int Capture (int hACam);

		// 1260
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Trigger")]
		public static extern int TriggerA (int hACam, IntPtr hWnd, byte[] lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Trigger")]
		public static extern int TriggerP (int hACam, IntPtr hWnd, IntPtr lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SaveImage")]
		public static extern int SaveImage (int hACam, string  lpSaveName, FILETYPE FileType);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetPreviewWindow")]
		public static extern int SetPreviewWindow (int hACam, IntPtr hWnd, int Left, int Top, int Right, int Bottom);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetCaptureWindow")]
		public static extern int SetCaptureWindow (int hACam, int Width, int Height, int Frame);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetCaptureWindowEx")]
		public static extern int SetCaptureWindowEx (int hACam, int HTotal, int HStart, int HEffective, int VTotal, int VStart, int VEffective);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetCaptureWindowEx")]
		public static extern int GetCaptureWindowEx (int hACam, out int HTotal, out int HStart, out int HEffective, out int VTotal, out int VStart, out int VEffective);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetColorMode")]
		public static extern int SetColorMode (int hACam, int ColorMode);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetColorMode")]
		public static extern int GetColorMode (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetCrossbar")]
		public static extern int SetCrossbar (int hACam, int Output, int Input);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetDeviceNumber")]
		public static extern int SetDeviceNumber (int hACam, int Number);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetDeviceName")]
		public static extern int GetDeviceName (int hACam, int index, StringBuilder szDeviceName, int nSize);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_StartPreview")]
		public static extern int StartPreview (int hACam);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_StopPreview")]
		public static extern int StopPreview (int hACam);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetImage")]
		public static extern int GetImageA (int hACam, byte[] lpImage, int Size, int TopDown);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetImage")]
		public static extern int GetImageP (int hACam, IntPtr lpImage, int Size, int TopDown);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Width")]
		public static extern int Width (int hACam);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Height")]
		public static extern int Height (int hACam);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Fps")]
		public static extern int Fps (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetCameraDlg")]
		public static extern int SetCameraDlg (int hACam, IntPtr hWnd);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetImageDlg")]
		public static extern int SetImageDlg (int hACam, IntPtr hWnd);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetAnalogDlg")]
		public static extern int SetAnalogDlg (int hACam, IntPtr hWnd);

		// 1230
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetIOPort")]
		public static extern int SetIOPort (int hACam, byte byteData, int longData, int Reserve);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetIOPort")]
		public static extern int GetIOPort (int hACam, out byte byteData, out int longData, int Reserve);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetFilterValue")]
		public static extern int SetFilterValue (int hACam, ARTCAM_FILTERTYPE FilterType, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetFilterValue")]
		public static extern int GetFilterValue (int hACam, ARTCAM_FILTERTYPE FilterType, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetSubSample")]
		public static extern int SetSubSample (int hACam, SUBSAMPLE SubSampleMode);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetSubSample")]
		public static extern int GetSubSample (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetWaitTime")]
		public static extern int SetWaitTime (int hACam, int WaitTime);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetWaitTime")]
		public static extern int GetWaitTime (int hACam);

		// 1240
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetMirrorV")]
		public static extern int SetMirrorV (int hACam, int Flg);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetMirrorV")]
		public static extern int GetMirrorV (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetMirrorH")]
		public static extern int SetMirrorH (int hACam, int Flg);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetMirrorH")]
		public static extern int GetMirrorH (int hACam);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBrightness")]
		public static extern int SetBrightness (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBrightness")]
		public static extern int GetBrightness (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetContrast")]
		public static extern int SetContrast (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetContrast")]
		public static extern int GetContrast (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetHue")]
		public static extern int SetHue (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetHue")]
		public static extern int GetHue (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetSaturation")]
		public static extern int SetSaturation (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetSaturation")]
		public static extern int GetSaturation (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetSharpness")]
		public static extern int SetSharpness (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetSharpness")]
		public static extern int GetSharpness (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBayerGainRGB")]
		public static extern int SetBayerGainRGB (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBayerGainRGB")]
		public static extern int GetBayerGainRGB (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBayerGainRed")]
		public static extern int SetBayerGainRed (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBayerGainRed")]
		public static extern int GetBayerGainRed (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBayerGainGreen")]
		public static extern int SetBayerGainGreen (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBayerGainGreen")]
		public static extern int GetBayerGainGreen (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBayerGainBlue")]
		public static extern int SetBayerGainBlue (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBayerGainBlue")]
		public static extern int GetBayerGainBlue (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBayerGainAuto")]
		public static extern int SetBayerGainAuto (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBayerGainAuto")]
		public static extern int GetBayerGainAuto (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGamma")]
		public static extern int SetGamma (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGamma")]
		public static extern int GetGamma (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetBayerMode")]
		public static extern int SetBayerMode (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetBayerMode")]
		public static extern int GetBayerMode (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGlobalGain")]
		public static extern int SetGlobalGain (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGlobalGain")]
		public static extern int GetGlobalGain (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetColorGainRed")]
		public static extern int SetColorGainRed (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetColorGainRed")]
		public static extern int GetColorGainRed (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetColorGainGreen1")]
		public static extern int SetColorGainGreen1 (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetColorGainGreen1")]
		public static extern int GetColorGainGreen1 (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetColorGainGreen2")]
		public static extern int SetColorGainGreen2 (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetColorGainGreen2")]
		public static extern int GetColorGainGreen2 (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetColorGainBlue")]
		public static extern int SetColorGainBlue (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetColorGainBlue")]
		public static extern int GetColorGainBlue (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetExposureTime")]
		public static extern int SetExposureTime (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetExposureTime")]
		public static extern int GetExposureTime (int hACam, out int outError);

		// 1260
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetHalfClock")]
		public static extern int SetHalfClock (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetHalfClock")]
		public static extern int GetHalfClock (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetAutoIris")]
		public static extern int SetAutoIris (int hACam, AI_TYPE Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetAutoIris")]
		public static extern int GetAutoIris (int hACam, out int outError);

		// 1275
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetSamplingRate")]
		public static extern int SetSamplingRate (int hACam, SAMPLING_RATE Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetSamplingRate")]
		public static extern int GetSamplingRate (int hACam, out int outError);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetVideoFormat")]
		public static extern int GetVideoFormat (int hACam, out int outError);

		// 1276
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_WriteSromID")]
		public static extern int WriteSromID (int hACam, int Address, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_ReadSromID")]
		public static extern int ReadSromID (int hACam, int Address, out int outError);

	
		// 1280
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetCameraInfo")]
		public static extern int GetCameraInfo (int hACam, byte[] pInfo );
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetStatus")]
		public static extern int GetStatus (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_WriteRegister")]
		public static extern int WriteRegister (int hACam, int Address, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_ReadRegister")]
		public static extern int ReadRegister (int hACam, int Address, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayMode")]
		public static extern int SetGrayMode (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayMode")]
		public static extern int GetGrayMode (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayGainR")]
		public static extern int SetGrayGainR (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayGainR")]
		public static extern int GetGrayGainR (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayGainG1")]
		public static extern int SetGrayGainG1 (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayGainG1")]
		public static extern int GetGrayGainG1 (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayGainG2")]
		public static extern int SetGrayGainG2 (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayGainG2")]
		public static extern int GetGrayGainG2 (int hACam, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayGainB")]
		public static extern int SetGrayGainB (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayGainB")]
		public static extern int GetGrayGainB (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayOffsetR")]
		public static extern int SetGrayOffsetR (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayOffsetR")]
		public static extern int GetGrayOffsetR (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayOffsetG1")]
		public static extern int SetGrayOffsetG1 (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayOffsetG1")]
		public static extern int GetGrayOffsetG1 (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayOffsetG2")]
		public static extern int SetGrayOffsetG2 (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayOffsetG2")]
		public static extern int GetGrayOffsetG2 (int hACam, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetGrayOffsetB")]
		public static extern int SetGrayOffsetB (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetGrayOffsetB")]
		public static extern int GetGrayOffsetB (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_SetCameraType")]
		public static extern int SetCameraType (int hACam, int Flg);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetCameraType")]
		public static extern int GetCameraType (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Fpga_WriteRegister")]
		public static extern int Fpga_WriteRegister (int hACam, int Address, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Fpga_ReadRegister")]
		public static extern int Fpga_ReadRegister (int hACam, int Address, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetPreviewMode")]
		public static extern int Monitor_SetPreviewMode (int hACam, int Preview);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetPreviewMode")]
		public static extern int Monitor_GetPreviewMode (int hACam, out int outError);
	
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetPreviewSize")]
		public static extern int Monitor_SetPreviewSize (int hACam, int Width, int Height);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetPreviewSize")]
		public static extern int Monitor_GetPreviewSize (int hACam, out int Width, out int Height);
	
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetColorMode")]
		public static extern int Monitor_SetColorMode (int hACam, int ColorMode);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetColorMode")]
		public static extern int Monitor_GetColorMode (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCameraClock")]
		public static extern int Monitor_SetCameraClock (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCameraClock")]
		public static extern int Monitor_GetCameraClock (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetBayerGainAuto")]
		public static extern int Monitor_SetBayerGainAuto (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetBayerGainAuto")]
		public static extern int Monitor_GetBayerGainAuto (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetBayerGainLock")]
		public static extern int Monitor_SetBayerGainLock (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetBayerGainLock")]
		public static extern int Monitor_GetBayerGainLock (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetBayerGainRed")]
		public static extern int Monitor_SetBayerGainRed (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetBayerGainRed")]
		public static extern int Monitor_GetBayerGainRed (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetBayerGainGreen")]
		public static extern int Monitor_SetBayerGainGreen (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetBayerGainGreen")]
		public static extern int Monitor_GetBayerGainGreen (int hACam, out int outError);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetBayerGainBlue")]
		public static extern int Monitor_SetBayerGainBlue (int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetBayerGainBlue")]
		public static extern int Monitor_GetBayerGainBlue (int hACam, out int outError);

		// 1282
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SaveCurrentSettings")]
		public static extern int Monitor_SaveCurrentSettings	(int hACam);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_InitRegisterSettings")]
		public static extern int Monitor_InitRegisterSettings	(int hACam, int Value);

		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorMode")]
		public static extern int Monitor_SetCrossCursorMode		(int hACam, int CursorNum, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorMode")]
		public static extern int Monitor_GetCrossCursorMode		(int hACam, int CursorNum, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorColorR")]
		public static extern int Monitor_SetCrossCursorColorR	(int hACam, int CursorNum, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorColorR")]
		public static extern int Monitor_GetCrossCursorColorR	(int hACam, int CursorNum, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorColorG")]
		public static extern int Monitor_SetCrossCursorColorG	(int hACam, int CursorNum, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorColorG")]
		public static extern int Monitor_GetCrossCursorColorG	(int hACam, int CursorNum, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorColorB")]
		public static extern int Monitor_SetCrossCursorColorB	(int hACam, int CursorNum, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorColorB")]
		public static extern int Monitor_GetCrossCursorColorB	(int hACam, int CursorNum, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorColorRGB")]
		public static extern int Monitor_SetCrossCursorColorRGB	(int hACam, int CursorNum, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorColorRGB")]
		public static extern int Monitor_GetCrossCursorColorRGB	(int hACam, int CursorNum, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorPos")]
		public static extern int Monitor_SetCrossCursorPos		(int hACam, int CursorNum, int PosX, int PosY);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorPos")]
		public static extern int Monitor_GetCrossCursorPos		(int hACam, int CursorNum, out int PosX, out int PoxY);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetCrossCursorSize")]
		public static extern int Monitor_SetCrossCursorSize		(int hACam, int CursorNum, int SizeX, int SizeY);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetCrossCursorSize")]
		public static extern int Monitor_GetCrossCursorSize		(int hACam, int CursorNum, out int SizeX, out int SizeY);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetAutoIrisMode")]
		public static extern int Monitor_SetAutoIrisMode		(int hACam, int Value);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetAutoIrisMode")]
		public static extern int Monitor_GetAutoIrisMode		(int hACam, out int outError);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_SetAutoIrisRange")]
		public static extern int Monitor_SetAutoIrisRange		(int hACam, int Min, int Max);
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_GetAutoIrisRange")]
		public static extern int Monitor_GetAutoIrisRange		(int hACam, out int Min, out int Max);
		
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_Monitor_LoadFirmware")]
		public static extern int Monitor_LoadFirmware			(int hACam, StringBuilder szFileName);
		
		
		// 1300
		[DllImport("ArtCamSdk_900MI.dll", EntryPoint = "ArtCam_GetRealExposureTime")]
		public static extern int GetRealExposureTime			(int hACam);

	}


	public class CArtCam
	{
		private int m_hACam = 0;
		public int m_Error = 1;

		public bool IsInit ()
		{
			if(0 == m_hACam)
			{
				return false;
			}
			else
			{
				return true;
			}
		}

		public int GetDllVersion ()
		{
			return (int)(short)ArtCam.GetDllVersion();
		}

		public ARTCAM_CAMERATYPE GetDllType ()
		{
			return (ARTCAM_CAMERATYPE)(ArtCam.GetDllVersion() >> 16);
		}

		public int GetLastError ()
		{
			return ArtCam.GetLastError(m_hACam);
		}


		public bool Initialize (IntPtr hWnd)
		{
			m_hACam = ArtCam.Initialize(hWnd);
			if(0 != m_hACam)
				return true;
			else
				return false;
		}

		public int Release ()
		{
			return ArtCam.Release(m_hACam);
		}


		public int Preview ()
		{
			return ArtCam.Preview(m_hACam);
		}

		public int Record (string lpAviName, int RecTime, int fShow)
		{
			return ArtCam.Record(m_hACam, lpAviName, RecTime, fShow);
		}

		public int CallBackPreview (IntPtr hWnd, byte[] lpImage, int Size, int TopDown)
		{
			return ArtCam.CallBackPreviewA(m_hACam, hWnd, lpImage, Size, TopDown);
		}

		public int CallBackPreview (IntPtr hWnd, IntPtr lpImage, int Size, int TopDown)
		{
			return ArtCam.CallBackPreviewP(m_hACam, hWnd, lpImage, Size, TopDown);
		}

		public int SnapShot (byte[] lpImage, int Size, int TopDown)
		{
			return ArtCam.SnapShotA(m_hACam, lpImage, Size, TopDown);
		}

		public int SnapShot (IntPtr lpImage, int Size, int TopDown)
		{
			return ArtCam.SnapShotP(m_hACam, lpImage, Size, TopDown);
		}

		public int Close ()
		{
			return ArtCam.Close(m_hACam);
		}


		// 1250
		public int Capture ()
		{
			return ArtCam.Capture(m_hACam);
		}


		// 1260
		public int Trigger (IntPtr hWnd, byte[] lpImage, int Size, int TopDown)
		{
			return ArtCam.TriggerA(m_hACam, hWnd, lpImage, Size, TopDown);
		}

		public int Trigger (IntPtr hWnd, IntPtr lpImage, int Size, int TopDown)
		{
			return ArtCam.TriggerP(m_hACam, hWnd, lpImage, Size, TopDown);
		}

		public int SaveImage (string  lpSaveName, FILETYPE FileType)
		{
			return ArtCam.SaveImage(m_hACam, lpSaveName, FileType);
		}


		public int SetPreviewWindow (IntPtr hWnd, int Left, int Top, int Right, int Bottom)
		{
			return ArtCam.SetPreviewWindow(m_hACam, hWnd, Left, Top, Right, Bottom);
		}

		public int SetCaptureWindow (int Width, int Height, int Frame)
		{
			return ArtCam.SetCaptureWindow(m_hACam, Width, Height, Frame);
		}

		public int SetCaptureWindowEx (int HTotal, int HStart, int HEffective, int VTotal, int VStart, int VEffective)
		{
			return ArtCam.SetCaptureWindowEx(m_hACam, HTotal, HStart, HEffective, VTotal, VStart, VEffective);
		}

		public int GetCaptureWindowEx (out int HTotal, out int HStart, out int HEffective, out int VTotal, out int VStart, out int VEffective)
		{
			return ArtCam.GetCaptureWindowEx(m_hACam, out HTotal, out HStart, out HEffective, out VTotal, out VStart, out VEffective);
		}


		public int SetColorMode (int ColorMode)
		{
			return ArtCam.SetColorMode(m_hACam, ColorMode);
		}

		public int GetColorMode ()
		{
			return ArtCam.GetColorMode(m_hACam);
		}


		public int SetCrossbar (int Output, int Input)
		{
			return ArtCam.SetCrossbar(m_hACam, Output, Input);
		}

		public int SetDeviceNumber (int Number)
		{
			return ArtCam.SetDeviceNumber(m_hACam, Number);
		}

		public int GetDeviceName (int index, StringBuilder szDeviceName, int nSize)
		{
			return ArtCam.GetDeviceName(m_hACam, index, szDeviceName, nSize);
		}


		public int StartPreview ()
		{
			return ArtCam.StartPreview(m_hACam);
		}

		public int StopPreview ()
		{
			return ArtCam.StopPreview(m_hACam);
		}

		public int GetImage (byte[] lpImage, int Size, int TopDown)
		{
			return ArtCam.GetImageA(m_hACam, lpImage, Size, TopDown);
		}

		public int GetImage (IntPtr lpImage, int Size, int TopDown)
		{
			return ArtCam.GetImageP(m_hACam, lpImage, Size, TopDown);
		}


		public int Width ()
		{
			return ArtCam.Width(m_hACam);
		}

		public int Height ()
		{
			return ArtCam.Height(m_hACam);
		}

		public int Fps ()
		{
			return ArtCam.Fps(m_hACam);
		}


		public int SetCameraDlg (IntPtr hWnd)
		{
			return ArtCam.SetCameraDlg(m_hACam, hWnd);
		}

		public int SetImageDlg (IntPtr hWnd)
		{
			return ArtCam.SetImageDlg(m_hACam, hWnd);
		}

		public int SetAnalogDlg (IntPtr hWnd)
		{
			return ArtCam.SetAnalogDlg(m_hACam, hWnd);
		}


		// 1230
		public bool SetIOPort (byte byteData, int longData, int Reserve)
		{
			if(0 != ArtCam.SetIOPort(m_hACam, byteData, longData, Reserve))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public bool GetIOPort (out byte byteData, out int longData, int Reserve)
		{
			if(0 != ArtCam.GetIOPort(m_hACam, out byteData, out longData, Reserve))
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		public int SetFilterValue (ARTCAM_FILTERTYPE FilterType, int Value)
		{
			return ArtCam.SetFilterValue(m_hACam, FilterType, Value);
		}

		public int GetFilterValue (ARTCAM_FILTERTYPE FilterType)
		{
			return ArtCam.GetFilterValue(m_hACam, FilterType, out m_Error);
		}


		public int SetSubSample (SUBSAMPLE SubSampleMode)
		{
			return ArtCam.SetSubSample(m_hACam, SubSampleMode);
		}

		public SUBSAMPLE GetSubSample ()
		{
			return (SUBSAMPLE)ArtCam.GetSubSample(m_hACam);
		}


		public int SetWaitTime (int WaitTime)
		{
			return ArtCam.SetWaitTime(m_hACam, WaitTime);
		}

		public int GetWaitTime ()
		{
			return ArtCam.GetWaitTime(m_hACam);
		}


		// 1240
		public int SetMirrorV (bool Flg)
		{
			if(Flg)
			{
				return ArtCam.SetMirrorV(m_hACam, 1);
			}
			else
			{
				return ArtCam.SetMirrorV(m_hACam, 0);
			}
		}

		public bool GetMirrorV ()
		{
			if(0 != ArtCam.GetMirrorV(m_hACam))
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		public int SetMirrorH (bool Flg)
		{
			if(Flg)
			{
				return ArtCam.SetMirrorH(m_hACam, 1);
			}
			else
			{
				return ArtCam.SetMirrorH(m_hACam, 0);
			}
		}

		public bool GetMirrorH ()
		{
			if(0 != ArtCam.GetMirrorH(m_hACam))
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		public int SetBrightness (int Value)
		{
			return ArtCam.SetBrightness(m_hACam, Value);
		}

		public int GetBrightness ()
		{
			return ArtCam.GetBrightness(m_hACam, out m_Error);
		}


		public int SetContrast (int Value)
		{
			return ArtCam.SetContrast(m_hACam, Value);
		}

		public int GetContrast ()
		{
			return ArtCam.GetContrast(m_hACam, out m_Error);
		}


		public int SetHue (int Value)
		{
			return ArtCam.SetHue(m_hACam, Value);
		}

		public int GetHue ()
		{
			return ArtCam.GetHue(m_hACam, out m_Error);
		}


		public int SetSaturation (int Value)
		{
			return ArtCam.SetSaturation(m_hACam, Value);
		}

		public int GetSaturation ()
		{
			return ArtCam.GetSaturation(m_hACam, out m_Error);
		}


		public int SetSharpness (int Value)
		{
			return ArtCam.SetSharpness(m_hACam, Value);
		}

		public int GetSharpness ()
		{
			return ArtCam.GetSharpness(m_hACam, out m_Error);
		}


		public int SetBayerGainRGB (int Value)
		{
			return ArtCam.SetBayerGainRGB(m_hACam, Value);
		}

		public int GetBayerGainRGB ()
		{
			return ArtCam.GetBayerGainRGB(m_hACam, out m_Error);
		}


		public int SetBayerGainRed (int Value)
		{
			return ArtCam.SetBayerGainRed(m_hACam, Value);
		}

		public int GetBayerGainRed ()
		{
			return ArtCam.GetBayerGainRed(m_hACam, out m_Error);
		}


		public int SetBayerGainGreen (int Value)
		{
			return ArtCam.SetBayerGainGreen(m_hACam, Value);
		}

		public int GetBayerGainGreen ()
		{
			return ArtCam.GetBayerGainGreen(m_hACam, out m_Error);
		}


		public int SetBayerGainBlue (int Value)
		{
			return ArtCam.SetBayerGainBlue(m_hACam, Value);
		}

		public int GetBayerGainBlue ()
		{
			return ArtCam.GetBayerGainBlue(m_hACam, out m_Error);
		}


		public int SetBayerGainAuto (bool Flg)
		{
			if(Flg)
			{
				return ArtCam.SetBayerGainAuto(m_hACam, 1);
			}
			else
			{
				return ArtCam.SetBayerGainAuto(m_hACam, 0);
			}
		}

		public bool GetBayerGainAuto ()
		{
			if(0 != ArtCam.GetBayerGainAuto(m_hACam, out m_Error))
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		public int SetGamma (int Value)
		{
			return ArtCam.SetGamma(m_hACam, Value);
		}

		public int GetGamma ()
		{
			return ArtCam.GetGamma(m_hACam, out m_Error);
		}


		public int SetBayerMode (int Value)
		{
			return ArtCam.SetBayerMode(m_hACam, Value);
		}

		public int GetBayerMode ()
		{
			return ArtCam.GetBayerMode(m_hACam, out m_Error);
		}


		public int SetGlobalGain (int Value)
		{
			return ArtCam.SetGlobalGain(m_hACam, Value);
		}

		public int GetGlobalGain ()
		{
			return ArtCam.GetGlobalGain(m_hACam, out m_Error);
		}


		public int SetColorGainRed (int Value)
		{
			return ArtCam.SetColorGainRed(m_hACam, Value);
		}

		public int GetColorGainRed ()
		{
			return ArtCam.GetColorGainRed(m_hACam, out m_Error);
		}


		public int SetColorGainGreen1 (int Value)
		{
			return ArtCam.SetColorGainGreen1(m_hACam, Value);
		}

		public int GetColorGainGreen1 ()
		{
			return ArtCam.GetColorGainGreen1(m_hACam, out m_Error);
		}


		public int SetColorGainGreen2 (int Value)
		{
			return ArtCam.SetColorGainGreen2(m_hACam, Value);
		}

		public int GetColorGainGreen2 ()
		{
			return ArtCam.GetColorGainGreen2(m_hACam, out m_Error);
		}


		public int SetColorGainBlue (int Value)
		{
			return ArtCam.SetColorGainBlue(m_hACam, Value);
		}

		public int GetColorGainBlue ()
		{
			return ArtCam.GetColorGainBlue(m_hACam, out m_Error);
		}


		public int SetExposureTime (int Value)
		{
			return ArtCam.SetExposureTime(m_hACam, Value);
		}

		public int GetExposureTime ()
		{
			return ArtCam.GetExposureTime(m_hACam, out m_Error);
		}


		// 1260
		public int SetHalfClock (bool Flg)
		{
			if(Flg)
			{
				return ArtCam.SetHalfClock(m_hACam, 1);
			}
			else
			{
				return ArtCam.SetHalfClock(m_hACam, 0);
			}
		}

		public bool GetHalfClock ()
		{
			if(0 != ArtCam.GetHalfClock(m_hACam, out m_Error))
			{
				return true;
			}
			else
			{
				return false;
			}
		}


		public int SetAutoIris (AI_TYPE Value)
		{
			return ArtCam.SetAutoIris(m_hACam, Value);
		}

		public AI_TYPE GetAutoIris ()
		{
			return (AI_TYPE)ArtCam.GetAutoIris(m_hACam, out m_Error);
		}


		// 1275
		public int SetSamplingRate (SAMPLING_RATE Value)
		{
			return ArtCam.SetSamplingRate(m_hACam, Value);
		}

		public SAMPLING_RATE GetSamplingRate ()
		{
			return (SAMPLING_RATE)ArtCam.GetSamplingRate(m_hACam, out m_Error);
		}

		public VIDEOFORMAT GetVideoFormat ()
		{
			return (VIDEOFORMAT)ArtCam.GetVideoFormat(m_hACam, out m_Error);
		}


		// 1276
		public int WriteSromID (int Address, int Value)
		{
			return ArtCam.WriteSromID(m_hACam, Address, Value);
		}

		public int ReadSromID (int Address)
		{
			return ArtCam.ReadSromID(m_hACam, Address, out m_Error);
		}

		
		public int GetCameraInfo (byte[] pInfo )
		{
			return ArtCam.GetCameraInfo(m_hACam, pInfo);
		}


		public int GetStatus ()
		{
			return ArtCam.GetStatus(m_hACam, out m_Error);
		}


		public int WriteRegister (int Address, int Value)
		{
			return ArtCam.WriteRegister(m_hACam, Address, Value);
		}

		public int ReadRegister (int Address)
		{
			return ArtCam.ReadRegister(m_hACam, Address, out m_Error);
		}		


		
		public int SetGrayMode (int Value)
		{
			return ArtCam.SetGrayMode(m_hACam,Value);
		}
		
		public int GetGrayMode ()
		{
			return ArtCam.GetGrayMode(m_hACam,out m_Error);
        }

		public int SetGrayGainR (int Value)
		{
			return ArtCam.SetGrayGainR(m_hACam,Value);
		}
		
		public int GetGrayGainR ()
		{
			return ArtCam.GetGrayGainR(m_hACam,out m_Error);
		}

		public int SetGrayGainG1 (int Value)
		{
			return ArtCam.SetGrayGainG1(m_hACam,Value);
		}
		
		public int GetGrayGainG1 ()
		{
			return ArtCam.GetGrayGainG1(m_hACam,out m_Error);
		}

		public int SetGrayGainG2 (int Value)
		{
			return ArtCam.SetGrayGainG2(m_hACam,Value);
		}
		
		public int GetGrayGainG2 ()
		{
			return ArtCam.GetGrayGainG2(m_hACam,out m_Error);
		}

		public int SetGrayGainB (int Value)
		{
			return ArtCam.SetGrayGainB(m_hACam,Value);
		}
		
		public int GetGrayGainB ()
		{
			return ArtCam.GetGrayGainB(m_hACam,out m_Error);
		}

		public int SetGrayOffsetR (int Value)
		{
			return ArtCam.SetGrayOffsetR(m_hACam,Value);
		}
		
		public int GetGrayOffsetR ()
		{
			return ArtCam.GetGrayOffsetR(m_hACam,out m_Error);
		}

		public int SetGrayOffsetG1 (int Value)
		{
			return ArtCam.SetGrayOffsetG1(m_hACam,Value);
		}
		
		public int GetGrayOffsetG1 ()
		{
			return ArtCam.GetGrayOffsetG1(m_hACam,out m_Error);
		}

		public int SetGrayOffsetG2 (int Value)
		{
			return ArtCam.SetGrayOffsetG2(m_hACam,Value);
		}
		
		public int GetGrayOffsetG2 ()
		{
			return ArtCam.GetGrayOffsetG2(m_hACam,out m_Error);
		}

		public int SetGrayOffsetB (int Value)
		{
			return ArtCam.SetGrayOffsetB(m_hACam,Value);
		}
		
		public int GetGrayOffsetB ()
		{
			return ArtCam.GetGrayOffsetB(m_hACam,out m_Error);
		}


		public int SetCameraType (int Flg)
		{
			return ArtCam.SetCameraType(m_hACam , Flg);
		}

		public int GetCameraType ()
		{
			return ArtCam.GetCameraType(m_hACam , out m_Error);
		}
	
		public int Fpga_WriteRegister (int Address, int Value)
		{
			return ArtCam.Fpga_WriteRegister(m_hACam, Address, Value);
		}

		public int Fpga_ReadRegister (int Address)
		{
			return ArtCam.Fpga_ReadRegister(m_hACam , Address,  out m_Error);
		}
		
		public int Monitor_SetPreviewMode (int Preview)
		{
			return ArtCam.Monitor_SetPreviewMode(m_hACam , Preview);
		}

		public int Monitor_GetPreviewMode ()
		{
			return ArtCam.Monitor_GetPreviewMode(m_hACam,  out m_Error);
		}

		
		public int Monitor_SetPreviewSize (int Width, int Height)
		{
			return ArtCam.Monitor_SetPreviewSize(m_hACam,Width, Height);
		}
        
		public int Monitor_GetPreviewSize (out int Width, out int Height)
		{
			return ArtCam.Monitor_GetPreviewSize(m_hACam, out Width, out Height);
		}
		
		public int Monitor_SetColorMode (int ColorMode)
		{
			return ArtCam.Monitor_SetColorMode(m_hACam, ColorMode);
		}

		public int Monitor_GetColorMode ()
		{
			return ArtCam.Monitor_GetColorMode(m_hACam, out m_Error);
		}

		public int Monitor_SetCameraClock (int Value)
		{
			return ArtCam.Monitor_SetCameraClock(m_hACam, Value);
		}

		public int Monitor_GetCameraClock ()
		{
			return ArtCam.Monitor_GetCameraClock(m_hACam, out m_Error);
		}

		public int Monitor_SetBayerGainAuto (int Value)
		{
			return ArtCam.Monitor_SetBayerGainAuto(m_hACam,Value);
		}

		public int Monitor_GetBayerGainAuto ()
		{
			return ArtCam.Monitor_GetBayerGainAuto(m_hACam, out m_Error);
		}

		public int Monitor_SetBayerGainLock (int Value)
		{
			return ArtCam.Monitor_SetBayerGainLock(m_hACam,Value);
		}

		public int Monitor_GetBayerGainLock ()
		{
			return ArtCam.Monitor_GetBayerGainLock(m_hACam, out m_Error);
		}
		
		public int Monitor_SetBayerGainRed (int Value)
		{
			return ArtCam.Monitor_SetBayerGainRed(m_hACam, Value);
		}
		
		public int Monitor_GetBayerGainRed ()
		{
			return ArtCam.Monitor_GetBayerGainRed(m_hACam, out m_Error);
		}


		public int Monitor_SetBayerGainGreen (int Value)
		{
			return ArtCam.Monitor_SetBayerGainGreen(m_hACam, Value);
		}
		
		public int Monitor_GetBayerGainGreen ()
		{
			return ArtCam.Monitor_GetBayerGainGreen(m_hACam, out m_Error);
		}

		
		public int Monitor_SetBayerGainBlue (int Value)
		{
			return ArtCam.Monitor_SetBayerGainBlue(m_hACam, Value);
		}
		
		public int Monitor_GetBayerGainBlue ()
		{
			return ArtCam.Monitor_GetBayerGainBlue(m_hACam, out m_Error);
		}

		public int Monitor_SaveCurrentSettings()
		{	
			return ArtCam.Monitor_SaveCurrentSettings(m_hACam);
		}

		public int Monitor_InitRegisterSettings(int Value)
		{	
			return ArtCam.Monitor_InitRegisterSettings(m_hACam, Value);
		}

		public int Monitor_SetCrossCursorMode(int CursorNum, int Value)		
		{	
			return ArtCam.Monitor_SetCrossCursorMode(m_hACam, CursorNum, Value);
		}

		public int Monitor_GetCrossCursorMode(int CursorNum)		
		{
			return ArtCam.Monitor_GetCrossCursorMode(m_hACam, CursorNum, out m_Error);
		}

		public int Monitor_SetCrossCursorColorR(int CursorNum, int Value)		
		{	
			return ArtCam.Monitor_SetCrossCursorColorR(m_hACam, CursorNum, Value);
		}

		public int Monitor_GetCrossCursorColorR(int CursorNum)		
		{
			return ArtCam.Monitor_GetCrossCursorColorR(m_hACam, CursorNum, out m_Error);
		}

		public int Monitor_SetCrossCursorColorG	(int CursorNum, int Value)		
		{	
			return ArtCam.Monitor_SetCrossCursorColorG(m_hACam, CursorNum, Value);
		}

		public int Monitor_GetCrossCursorColorG(int CursorNum)
		{
			return ArtCam.Monitor_GetCrossCursorColorG(m_hACam, CursorNum, out m_Error);
		}

		public int Monitor_SetCrossCursorColorB(int CursorNum, int Value)
		{	
			return ArtCam.Monitor_SetCrossCursorColorB(m_hACam, CursorNum, Value);
		}

		public int Monitor_GetCrossCursorColorB(int CursorNum)
		{	
			return ArtCam.Monitor_GetCrossCursorColorB(m_hACam, CursorNum, out m_Error);
		}
		public int Monitor_SetCrossCursorColorRGB(int CursorNum, int Value)
		{
			return ArtCam.Monitor_SetCrossCursorColorRGB(m_hACam, CursorNum, Value);
		}

		public int Monitor_GetCrossCursorColorRGB(int CursorNum)
		{	
			return ArtCam.Monitor_GetCrossCursorColorRGB(m_hACam, CursorNum, out m_Error);
		}

		public int Monitor_SetCrossCursorPos(int CursorNum, int PosX, int PosY)
		{	
			return ArtCam.Monitor_SetCrossCursorPos(m_hACam, CursorNum, PosX, PosY);
		}

		public int Monitor_GetCrossCursorPos(int CursorNum, out int PosX, out int PoxY)
		{	
			return ArtCam.Monitor_GetCrossCursorPos(m_hACam, CursorNum, out PosX, out PoxY);
		}

		public int Monitor_SetCrossCursorSize(int CursorNum, int SizeX, int SizeY)	
		{	
			return ArtCam.Monitor_SetCrossCursorSize(m_hACam, CursorNum, SizeX, SizeY);
		}

		public int Monitor_GetCrossCursorSize(int CursorNum, out int SizeX, out int SizeY)	
		{	
			return ArtCam.Monitor_GetCrossCursorSize(m_hACam, CursorNum, out SizeX, out SizeY);
		}

		public int Monitor_SetAutoIrisMode(int Value)
		{	
			return ArtCam.Monitor_SetAutoIrisMode(m_hACam, Value);
		}

		public int Monitor_GetAutoIrisMode()
		{	
			return ArtCam.Monitor_GetAutoIrisMode(m_hACam, out m_Error);
		}

		public int Monitor_SetAutoIrisRange(int Min, int Max)	
		{	
			return ArtCam.Monitor_SetAutoIrisRange(m_hACam, Min, Max);
		}

		public int Monitor_GetAutoIrisRange(out int Min, out int Max)
		{	
			return ArtCam.Monitor_GetAutoIrisRange(m_hACam, out Min, out Max);
		}

		public int Monitor_LoadFirmware(StringBuilder szFileName)
		{	
			return ArtCam.Monitor_LoadFirmware(m_hACam, szFileName);
		}

		public int GetRealExposureTime()
		{	
			return ArtCam.GetRealExposureTime(m_hACam);
		}

	}

}



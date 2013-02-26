using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.ObjectModel;
using System.ComponentModel;
using WebMech.WebMechService;
using System.IO;
using Kit3D.Windows.Controls;

namespace WebMech
{
    /// <summary>
    /// Class represents business logic of client application, mainly used
    /// to collect all data and bind them with GUI.
    /// </summary>
    public class DataProvider : INotifyPropertyChanged
    {
        private readonly string version = "WebMech 1.28";

        private WebMechServiceClient client;

        private ObservableCollection<SurfaceData> surfaceList;
        private ObservableCollection<SampleData> sampleList;
        private ObservableCollection<ParameterData> parameterNameList;
        private SearchFilterData surfaceFilter;
        private SearchFilterData sampleFilter;
        private PageInfoData surfacePageInfo;
        private PageInfoData samplePageInfo;

        private Visualization visualization;

        private NewSurface newSurface;

        private UploadData uploadData;

        private SurfaceData selectedSurface;
        private SampleData selectedSample;
        private int selectedSampleIndex;

        private VisualizeSurface visualize;

        public DataProvider()
        {
            client = new WebMechServiceClient();

            surfaceList = new ObservableCollection<SurfaceData>();
            sampleList = new ObservableCollection<SampleData>();
            parameterNameList = new ObservableCollection<ParameterData>();

            surfaceFilter = GetFilter();
            sampleFilter = GetFilter();
            sampleFilter.Count = 1000;

            surfacePageInfo = GetPageInfo();
            samplePageInfo = GetPageInfo();

            visualization = new Visualization();

            newSurface = new NewSurface();

            uploadData = new UploadData { Surfaces = surfaceList };

            ResetSurfaceList();
            ResetSampleList();

            RegisterCallbacks();
        }

        public event PropertyChangedEventHandler PropertyChanged;

        private void NotifyPropertyChanged(String info)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(info));
            }
        }

        public event EventHandler<OperationStartedEventArgs> OperationStarted;
        public event EventHandler<OperationCompletedEventArgs> OperationCompleted;
        public event EventHandler<OperationFailedEventArgs> OperationFailed;

        private void OperationStarting(string message)
        {
            EventHandler<OperationStartedEventArgs> operationStarted = OperationStarted;
            if (operationStarted != null)
                operationStarted(this, new OperationStartedEventArgs(message));
        }

        private void OperationFailing(string exception)
        {
            EventHandler<OperationFailedEventArgs> operationFailed = OperationFailed;
            if (operationFailed != null)
                operationFailed(this, new OperationFailedEventArgs(exception));
        }

        private void OperationFinishing()
        {
            EventHandler<OperationCompletedEventArgs> operationCompleted = OperationCompleted;
            if (operationCompleted != null)
                operationCompleted(this, new OperationCompletedEventArgs());
        }

        /// <summary>
        /// Registers WCF callback methods.
        /// </summary>
        private void RegisterCallbacks()
        {
            // WCF client callbacks
            client.AddSurfaceCompleted += new EventHandler<AddSurfaceCompletedEventArgs>(AddSurfaceWcfCompleted);
            client.DeleteSurfaceCompleted += new EventHandler<AsyncCompletedEventArgs>(DeleteSurfaceWcfCompleted);
            client.GetSurfaceListPageInfoCompleted += new EventHandler<GetSurfaceListPageInfoCompletedEventArgs>(GetSurfaceListPageInfoWcfCompleted);
            client.GetSurfaceListCompleted += new EventHandler<GetSurfaceListCompletedEventArgs>(GetSurfaceListWcfCompleted);

            client.UploadSampleCompleted += new EventHandler<UploadSampleCompletedEventArgs>(UploadSampleWcfCompleted);
            client.DeleteSampleCompleted += new EventHandler<AsyncCompletedEventArgs>(DeleteSampleWcfCompleted);
            client.GetSampleListPageInfoCompleted += new EventHandler<GetSampleListPageInfoCompletedEventArgs>(GetSampleListPageInfoWcfCompleted);
            client.GetSampleListCompleted += new EventHandler<GetSampleListCompletedEventArgs>(GetSampleListWcfCompleted);
            client.GetSampleCompleted += new EventHandler<GetSampleCompletedEventArgs>(GetSampleWcfCompleted);
        }

        /// <summary>
        /// Gets new instance of filter object.
        /// </summary>
        /// <returns>WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</returns>
        private SearchFilterData GetFilter()
        {
            SearchFilterData filter = new SearchFilterData();
            ResetFilter(filter);
            return filter;
        }

        /// <summary>
        /// Sets dafault values of filter object.
        /// </summary>
        /// <param name="filter">WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</param>
        private void ResetFilter(SearchFilterData filter)
        {
            filter.Start = 1;
            filter.Count = 10;
            filter.SearchType = SearchType.All;
            filter.LastMonths = 3;
            filter.From = DateTime.Now.Date.AddMonths(-1);
            filter.To = DateTime.Now.Date;
            filter.SortType = SortType.Date;
            filter.SortDirection = SortDirection.Descending;
        }

        /// <summary>
        /// Gets new instance of page information object.
        /// </summary>
        /// <returns>A WebMech.Web.PageInfoData that specifies
        /// data object of pagination.</returns>
        private PageInfoData GetPageInfo()
        {
            PageInfoData pageInfo = new PageInfoData();
            ResetPageInfo(pageInfo);
            return pageInfo;
        }

        /// <summary>
        /// Sets default values of page information object.
        /// </summary>
        /// <param name="pageInfo">A WebMech.Web.PageInfoData that specifies
        /// data object of pagination.</param>
        private void ResetPageInfo(PageInfoData pageInfo)
        {
            pageInfo.Start = 0;
            pageInfo.End = 0;
            pageInfo.Total = 0;
            pageInfo.IsNext = false;
            pageInfo.IsPrevious = false;
        }


        /// <summary>
        /// Resets the list of surfaces.
        /// </summary>
        private void ResetSurfaceList()
        {
            surfaceList.Clear();
            ResetPageInfo(surfacePageInfo);
            SelectedSurface = null;
        }

        /// <summary>
        /// Resets the list of samples and list of parameters.
        /// </summary>
        private void ResetSampleList()
        {
            sampleList.Clear();
            ResetPageInfo(samplePageInfo);
            SelectedSample = null;

            parameterNameList.Clear();
        }

        /// <summary>
        /// Calls AddSurface method from WCF.
        /// </summary>
        private void AddSurfaceWcf()
        {
            if ((newSurface != null) && (!string.IsNullOrEmpty(newSurface.Name)))
            {
                // show progress
                OperationStarting("Nový povrch ...");
                // call WCF method asynchronously
                client.AddSurfaceAsync(newSurface.Name);
            }
        }
        
        /// <summary>
        /// Callback of asynchronous calling AddSurface method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.AddSurfaceCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void AddSurfaceWcfCompleted(object sender, AddSurfaceCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                GetSurfaceListWcf();
            }
        }

        /// <summary>
        /// Calls DeleteSurface method from WCF.
        /// </summary>
        /// <param name="deleteSurface">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        private void DeleteSurfaceWcf(SurfaceData deleteSurface)
        {
            if (deleteSurface != null)
            {
                // show progress
                OperationStarting("Mazání povrchu ...");
                // call WCF method asynchronously
                client.DeleteSurfaceAsync(deleteSurface);
            }
        }

        /// <summary>
        /// Callback of asynchronous calling DeleteSurface method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A System.ComponentModel.AsyncCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void DeleteSurfaceWcfCompleted(object sender, AsyncCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                GetSurfaceListWcf();
            }
        }

        /// <summary>
        /// Calls GetSurfaceList method from WCF.
        /// </summary>
        private void GetSurfaceListWcf()
        {
            // show progress
            OperationStarting("Stahování ...");
            // clear surface and sample list box
            ResetSurfaceList();
            ResetSampleList();
            // call WCF method asynchronously
            client.GetSurfaceListPageInfoAsync(surfaceFilter);
        }

        /// <summary>
        /// Callback of asynchronous calling GetSurfaceListPageInfo method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.GetSurfaceListPageInfoCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void GetSurfaceListPageInfoWcfCompleted(object sender, GetSurfaceListPageInfoCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                // update surface page info
                surfacePageInfo.Start = e.Result.Start;
                surfacePageInfo.End = e.Result.End;
                surfacePageInfo.Total = e.Result.Total;
                surfacePageInfo.IsPrevious = e.Result.IsPrevious;
                surfacePageInfo.IsNext = e.Result.IsNext;
            }
            // call WCF method asynchronously
            client.GetSurfaceListAsync(surfaceFilter);
        }

        /// <summary>
        /// Callback of asynchronous calling GetSurfaceList method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.GetSurfaceListCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void GetSurfaceListWcfCompleted(object sender, GetSurfaceListCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                // update surface list box
                foreach (SurfaceData surface in e.Result)
                    surfaceList.Add(surface);
            }
            // close progress
            OperationFinishing();
        }

        /// <summary>
        /// Calls UploadSample method from WCF.
        /// </summary>
        /// <param name="surface">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        private void UploadSampleWcf(SurfaceData surface)
        {
            if (surface != null)
            {
                // show progres
                OperationStarting("Ukládání vzorku ...");
                byte[] imageArray, pointsArray;
                try
                {
                    // image file -> byte array
                    FileStream stream = uploadData.Image.OpenRead();
                    imageArray = new byte[stream.Length]; //1048575
                    stream.Read(imageArray, 0, imageArray.Length);
                    stream.Close();
                    // points file -> byte array
                    stream = uploadData.Points.OpenRead();
                    pointsArray = new byte[stream.Length]; //1048575
                    stream.Read(pointsArray, 0, pointsArray.Length);
                    stream.Close();
                }
                catch (Exception e)
                {
                    OperationFailing("Exception" + Environment.NewLine + e.Message);
                    return;
                }
                // call WCF method asynchronously
                client.UploadSampleAsync(surface, uploadData.Image.Name, imageArray, uploadData.Points.Name, pointsArray);
            }
        }

        /// <summary>
        /// Callback of asynchronous calling UploadSample method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.UploadSampleCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void UploadSampleWcfCompleted(object sender, UploadSampleCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                GetSurfaceListWcf();
            }
        }

        /// <summary>
        /// Calls DeleteSample method from WCF.
        /// </summary>
        /// <param name="deleteSample">A WebMech.Web.SampleData that specifies
        /// data object of sample.</param>
        private void DeleteSampleWcf(SampleData deleteSample)
        {
            if (deleteSample != null)
            {
                // show progress
                OperationStarting("Mazání vzorku povrchu ...");
                // call WCF method asynchronously
                client.DeleteSampleAsync(deleteSample);
            }
        }

        /// <summary>
        /// Callback of asynchronous calling DeleteSample method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A System.ComponentModel.AsyncCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void DeleteSampleWcfCompleted(object sender, AsyncCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                GetSurfaceListWcf();
            }
        }

        /// <summary>
        /// Calls GetSampleList method from WCF.
        /// </summary>
        private void GetSampleListWcf()
        {
            if (selectedSurface != null)
            {
                // show progres
                OperationStarting("Stahování ...");
                // clear sample list box
                ResetSampleList();
                // call WCF method asynchronously
                client.GetSampleListPageInfoAsync(sampleFilter, selectedSurface);
            }
        }

        /// <summary>
        /// Callback of asynchronous calling GetSampleListPageInfo method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.GetSampleListPageInfoCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void GetSampleListPageInfoWcfCompleted(object sender, GetSampleListPageInfoCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                // update surface page info
                samplePageInfo.Start = e.Result.Start;
                samplePageInfo.End = e.Result.End;
                samplePageInfo.Total = e.Result.Total;
                samplePageInfo.IsPrevious = e.Result.IsPrevious;
                samplePageInfo.IsNext = e.Result.IsNext;
            }
            // call WCF method asynchronously
            client.GetSampleListAsync(sampleFilter, selectedSurface);
        }

        /// <summary>
        /// Gets full URL of image file.
        /// </summary>
        /// <param name="appUri">A System.String that specifies
        /// application URL.</param>
        /// <param name="fileName">A System.String that specifies
        /// relative path of image file.</param>
        /// <returns>A System.String that specifies
        /// full URL of image file.</returns>
        private string GetImageUrl(string appUri, string fileName)
        {
            string imageUrl = appUri.Replace("/ClientBin/WebMech.xap", "");
            string[] xx = fileName.Split('\\');
            for (int i = 0; i < xx.Length; i++)
                imageUrl += "/" + xx[i];
            return imageUrl;
        }

        /// <summary>
        /// Callback of asynchronous calling GetSampleList method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.GetSampleListCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void GetSampleListWcfCompleted(object sender, GetSampleListCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            else
            {
                // update sample list box
                foreach (SampleData sample in e.Result)
                {
                    sample.FileName = GetImageUrl(Application.Current.Host.Source.AbsoluteUri, sample.FileName);
                    sampleList.Add(sample);

                    foreach (ParameterData parameter in sample.ParameterList)
                    {
                        bool exists = false;
                        foreach (ParameterData data in parameterNameList)
                            if (string.Compare(data.Name, parameter.Name, StringComparison.InvariantCultureIgnoreCase) == 0)
                            {
                                exists = true;
                                break;
                            }
                        if (!exists)
                            parameterNameList.Add(parameter);
                    }
                }
            }
            // close progress
            OperationFinishing();
        }

        /// <summary>
        /// Calls GetSample method from WCF.
        /// </summary>
        private void GetSampleWcf()
        {
            if (selectedSample != null)
            {
                // show progres
                OperationStarting("Stahování ...");
                // call WCF method asynchronously
                client.GetSampleAsync(selectedSample);
            }
        }

        /// <summary>
        /// Callback of asynchronous calling GetSample method from WCF.
        /// </summary>
        /// <param name="sender">A System.Object that specifies
        /// the sender.</param>
        /// <param name="e">A WebMech.WebMechService.GetSampleCompletedEventArgs that specifies
        /// the result from WCF.</param>
        private void GetSampleWcfCompleted(object sender, GetSampleCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                OperationFailing("Exception" + Environment.NewLine + e.Error.Message);
                return;
            }
            // show progres
            OperationStarting("Vykreslování ...");
            // show mesh in viewport
            visualize.ShowSample(e.Result);
            // close progress
            OperationFinishing();
        }

        /// <summary>
        /// Adds new surface.
        /// </summary>
        public void AddSurface()
        {
            AddSurfaceWcf();
        }

        /// <summary>
        /// Deletes the surface.
        /// </summary>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        public void DeleteSurface(SurfaceData surfaceData)
        {
            DeleteSurfaceWcf(surfaceData);
        }

        /// <summary>
        /// Gets list of surfaces.
        /// </summary>
        public void GetSurfaceList()
        {
            GetSurfaceListWcf();
        }

        /// <summary>
        /// Uploads new sample.
        /// </summary>
        /// <param name="surface">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        public void UploadSample(SurfaceData surface)
        {
            UploadSampleWcf(surface);
        }

        /// <summary>
        /// Deletes the sample.
        /// </summary>
        /// <param name="sampleData"></param>
        public void DeleteSample(SampleData sampleData)
        {
            DeleteSampleWcf(sampleData);
        }

        /// <summary>
        /// Gets list of samples.
        /// </summary>
        public void GetSampleList()
        {
            GetSampleListWcf();
        }

        /// <summary>
        /// Gets 3D model of sample.
        /// </summary>
        public void GetSample()
        {
            if ((selectedSample != null) && (visualize != null))
                GetSampleWcf();
        }

        /// <summary>
        /// Gets list of surfaces.
        /// </summary>
        public ObservableCollection<SurfaceData> SurfaceList
        {
            get { return surfaceList; }
        }

        /// <summary>
        /// Gets or sets selected surface.
        /// </summary>
        public SurfaceData SelectedSurface
        {
            get { return selectedSurface; }
            set
            {
                if (selectedSurface != value)
                {
                    selectedSurface = value;
                    NotifyPropertyChanged("SelectedSurface");
                }
            }
        }

        /// <summary>
        /// Gets the filter for searching of surfaces.
        /// </summary>
        public SearchFilterData SurfaceFilter
        {
            get { return surfaceFilter; }
        }

        /// <summary>
        /// Gets page information of surfaces.
        /// </summary>
        public PageInfoData SurfacePageInfo
        {
            get { return surfacePageInfo; }
        }

        /// <summary>
        /// Gets list of samples.
        /// </summary>
        public ObservableCollection<SampleData> SampleList
        {
            get { return sampleList; }
        }

        /// <summary>
        /// Gets or sets selected sample.
        /// </summary>
        public SampleData SelectedSample
        {
            get { return selectedSample; }
            set
            {
                if (selectedSample != value)
                {
                    selectedSample = value;
                    if (value == null)
                        selectedSampleIndex = 0;
                    else
                        selectedSampleIndex = sampleList.IndexOf(value) + 1;
                    NotifyPropertyChanged("SelectedSample");
                    NotifyPropertyChanged("SelectedSampleIndex");
                }
            }
        }

        /// <summary>
        /// Gets index of selected sample.
        /// </summary>
        public int SelectedSampleIndex
        {
            get { return selectedSampleIndex; }
        }

        /// <summary>
        /// Gets list of statistic parameters.
        /// </summary>
        public ObservableCollection<ParameterData> ParameterNameList
        {
            get { return parameterNameList; }
        }

        /// <summary>
        /// Gets the filter for searching of samples.
        /// </summary>
        public SearchFilterData SampleFilter
        {
            get { return sampleFilter; }
        }

        /// <summary>
        /// Gets page information of samples.
        /// </summary>
        public PageInfoData SamplePageInfo
        {
            get { return samplePageInfo; }
        }

        /// <summary>
        /// Gets binding object of visualization.
        /// </summary>
        public Visualization Visualization
        {
            get { return visualization; }
        }

        /// <summary>
        /// Gets visualization component.
        /// </summary>
        public VisualizeSurface Visualize
        {
            set { visualize = value; }
        }

        /// <summary>
        /// Gets binding object of new surface.
        /// </summary>
        public NewSurface NewSurface
        {
            get { return newSurface; }
        }

        /// <summary>
        /// Gets binding object of upload sample.
        /// </summary>
        public UploadData UploadData
        {
            get { return uploadData; }
        }

        /// <summary>
        /// Gets program version.
        /// </summary>
        public string Version
        {
            get { return version; }
        }
    }
}

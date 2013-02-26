using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.IO;
using System.Threading;

namespace WebMech.Web
{
    // NOTE: If you change the class name "WebMechService" here, you must also update the reference to "WebMechService" in Web.config.
    //[ServiceBehavior(InstanceContextMode = InstanceContextMode.PerSession)]
    public class WebMechService : IWebMechService
    {
        /// <summary>
        /// Creates web service data object from database object.
        /// </summary>
        /// <param name="surface">A WebMech.Web.Surface that specifies
        /// row of Surface table.</param>
        /// <returns>A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</returns>
        private SurfaceData SurfaceToData(Surface surface)
        {
            return new SurfaceData
            {
                Id = (int)surface.surface_id,
                Name = surface.name,
                CreationDate = surface.creation_date,
                ModificationDate = surface.modification_date,
                MeasurementCount = surface.Samples.Count()
            };
        }

        /// <summary>
        /// Creates web service data object from database obejct.
        /// </summary>
        /// <param name="sample">A WebMech.Web.Sample that specifies
        /// row of Sample table.</param>
        /// <returns>A WebMech.Web.SampleData that specifies
        /// data object of sample.</returns>
        private SampleData SampleToData(Sample sample)
        {
            return new SampleData
            {
                Id = (int)sample.sample_id,
                SurfaceId = (int)sample.surface_id,
                SampleDate = sample.sample_date,
                UploadDate = sample.upload_date,
                ModificationDate = sample.modification_date,
                FileName = sample.filename,
            };
        }

        /// <summary>
        /// Creates web service data object from database obejct.
        /// </summary>
        /// <param name="parameter">A WebMech.Web.Parameter that specifies
        /// row of Parameter table.</param>
        /// <returns>A WebMech.Web.ParamterData that specifies
        /// data object of parameter.</returns>
        private ParameterData ParameterToData(Parameter parameter)
        {
            return new ParameterData
            {
                Name = parameter.name,
                Value = parameter.value
            };
        }

        /// <summary>
        /// Creates web service data object from database obejct.
        /// </summary>
        /// <param name="statistic">A WebMech.Web.Parameter that specifies
        /// row of Statistic table.</param>
        /// <returns>A WebMech.Web.Model3DData that specifies
        /// data object of 3D model with basic statistic data and list of 3D points.</returns>
        private Model3DData StatisticToData(Statistic statistic)
        {
            return new Model3DData
            {
                Xmin = statistic.x_min,
                Xmax = statistic.x_max,
                Ymin = statistic.y_min,
                Ymax = statistic.y_max,
                Zmin = statistic.z_min,
                Zmax = statistic.z_max,
                Zmean = statistic.z_mean,
                PointList = new List<PointData>()
            };
        }

        /// <summary>
        /// Creates web service data object from database obejct.
        /// </summary>
        /// <param name="point">A WebMech.Web.Parameter that specifies
        /// row of Point table.</param>
        /// <returns>A WebMech.Web.PointData that specifies
        /// data object of point.</returns>
        private PointData PointToData(Point point)
        {
            return new PointData
            {
                X = point.x,
                Y = point.y,
                Z = point.z
            };
        }

        /// <summary>
        /// Generates LINQ which selected surfaces.
        /// </summary>
        /// <param name="db">WebMech.Web.WebMechDataContext which specifies
        /// object relation mapping to database.</param>
        /// <param name="filter">WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</param>
        /// <param name="allRows">System.Boolean that indicates
        /// whether query will contain all rows or selected rows.</param>
        /// <returns>System.Linq.IQueryable that specifies
        /// the final query to database.</returns>
        private IQueryable<Surface> GetSurfaceQuery(WebMechDataContext db, SearchFilterData filter, bool allRows)
        {
            IQueryable<Surface> query = (from s in db.Surfaces select s);

            // filtering
            if (filter.SearchType == SearchType.LastMonths)
                query = query.Where(s =>
                    s.modification_date > DateTime.Now.Date.AddMonths(-filter.LastMonths));
            else if (filter.SearchType == SearchType.DateRange)
                query = query.Where(s =>
                    (s.creation_date >= filter.From) && (s.creation_date <= filter.To));

            // sorting
            if (filter.SortType == SortType.Name)
            {
                if (filter.SortDirection == SortDirection.Ascending)
                    query = query.OrderBy(s => s.name);
                else
                    query = query.OrderByDescending(s => s.name);
            }
            else if (filter.SortType == SortType.Date)
            {
                if (filter.SortDirection == SortDirection.Ascending)
                    query = query.OrderBy(s => s.creation_date);
                else
                    query = query.OrderByDescending(s => s.creation_date);
            }
            else if (filter.SortType == SortType.NumberOfSamples)
            {
                if (filter.SortDirection == SortDirection.Ascending)
                    query = query.OrderBy(s => s.Samples.Count);
                else
                    query = query.OrderByDescending(s => s.Samples.Count);
            }

            if (allRows)
                return query;
            return query.Skip(filter.Start - 1).Take(filter.Count);
        }

        /// <summary>
        /// Add new surface into database.
        /// </summary>
        /// <param name="name">A System.String that specifies
        /// name of surface.</param>
        /// <returns>A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</returns>
        public SurfaceData AddSurface(string name)
        {
            LogIt.Info("AddSurface(Name = " + name + ")");
            WebMechDataContext db = new WebMechDataContext();

            Surface surface = new Surface();
            surface.name = name;
            surface.creation_date =
            surface.modification_date = DateTime.Now;

            db.Surfaces.InsertOnSubmit(surface);
            db.SubmitChanges();

            return SurfaceToData(surface);
        }

        /// <summary>
        /// Modifies surface name.
        /// </summary>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        public void ModifySurface(SurfaceData surfaceData)
        {
            LogIt.Info("ModifySurface(Id = " + surfaceData.Id.ToString() + ", Name = " + surfaceData.Name + ")");
            if (surfaceData != null)
            {
                WebMechDataContext db = new WebMechDataContext();

                Surface surface = db.Surfaces.Single(s => s.surface_id == surfaceData.Id);
                surface.name = surfaceData.Name;
                surface.modification_date = DateTime.Now;

                db.SubmitChanges();
            }
        }

        /// <summary>
        /// Deletes surface from database.
        /// </summary>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        public void DeleteSurface(SurfaceData surfaceData)
        {
            LogIt.Info("DeleteSurface(Id = " + surfaceData.Id.ToString() + ", Name = " + surfaceData.Name + ")");
            if (surfaceData != null)
            {
                WebMechDataContext db = new WebMechDataContext();

                Surface surface = db.Surfaces.Single(s => s.surface_id == surfaceData.Id);
                db.Surfaces.DeleteOnSubmit(surface);
                db.SubmitChanges();
            }
        }

        /// <summary>
        /// Gets surface by its ID.
        /// </summary>
        /// <param name="surfaceId">System.Int32 that specifies
        /// ID of surface.</param>
        /// <returns>A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</returns>
        public SurfaceData GetSurfaceById(int surfaceId)
        {
            LogIt.Info("GetSurfaceById(Id = " + surfaceId.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            Surface surface = db.Surfaces.Single(s => s.surface_id == surfaceId);

            return SurfaceToData(surface);
        }

        /// <summary>
        /// Gets surface by its name.
        /// </summary>
        /// <param name="name">System.String that specifies
        /// name of surface.</param>
        /// <returns>A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</returns>
        public SurfaceData GetSurfaceByName(string name)
        {
            LogIt.Info("GetSurfaceByName(Name = " + name + ")");
            WebMechDataContext db = new WebMechDataContext();

            Surface surface = db.Surfaces.Single(s => s.name == name);

            return SurfaceToData(surface);
        }

        /// <summary>
        /// Gets information about surface's pagination according to filter.
        /// </summary>
        /// <param name="filterData">WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</param>
        /// <returns>A WebMech.Web.PageInfoData that specifies
        /// data object of pagination.</returns>
        public PageInfoData GetSurfaceListPageInfo(SearchFilterData filterData)
        {
            LogIt.Info("GetSurfaceListPageInfo(SearchType = " + filterData.SearchType.ToString() + ", SortType = " + filterData.SortType.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            int total = GetSurfaceQuery(db, filterData, true).Count();
            bool isNext = (filterData.Start + filterData.Count) <= total;
            bool isPrev = filterData.Start > filterData.Count;

            return new PageInfoData
            {
                Start = filterData.Start,
                End = Math.Min(filterData.Start + filterData.Count - 1, total),
                Total = total,
                IsNext = isNext,
                IsPrevious = isPrev
            };
        }

        /// <summary>
        /// Gets list of surfaces according to filter.
        /// </summary>
        /// <param name="filterData">WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</param>
        /// <returns>A System.Collections.Generic.List that specifies
        /// list of data objects of surface.</returns>
        public List<SurfaceData> GetSurfaceList(SearchFilterData filterData)
        {
            LogIt.Info("GetSurfaceList(Start = " + filterData.Start.ToString() + ", Count = " + filterData.Count.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            List<SurfaceData> surfaceList = new List<SurfaceData>();

            IQueryable<Surface> surfaces = GetSurfaceQuery(db, filterData, false);
            foreach (Surface surface in surfaces)
                surfaceList.Add(SurfaceToData(surface));

            return surfaceList;
        }

        /// <summary>
        /// Uploads sample into database.
        /// </summary>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        /// <param name="imageName">A System.String that specifies
        /// the file name of sample image.</param>
        /// <param name="imageArray">A System.Byte[] that specifies
        /// byte array of image file</param>
        /// <param name="pointsName">A System.String that specifies
        /// the file name of text file with 3D points.</param>
        /// <param name="pointsArray">A System.String that specifies
        /// byte array of text file with 3D points.</param>
        /// <returns>A WebMech.Web.SampleData that specifies
        /// data object of sample.</returns>
        public SampleData UploadSample(SurfaceData surfaceData, string imageName, byte[] imageArray, string pointsName, byte[] pointsArray)
        {
            LogIt.Info("UploadSample(Id = " + surfaceData.Id.ToString() + ", Name = " + surfaceData.Name + ", ImageName = " + imageName + ", PointsName = " + pointsName + ")");
            WebMechDataContext db = new WebMechDataContext();

            StatisticSurface process = new StatisticSurface(surfaceData.Name, imageName, imageArray, pointsName, pointsArray);
            process.Process();

            DateTime date = DateTime.Now;
            Sample sample = new Sample();
            sample.surface_id = surfaceData.Id;
            sample.sample_date =
            sample.upload_date =
            sample.modification_date = date;
            sample.filename = process.ImageName;

            db.Samples.InsertOnSubmit(sample);
            db.SubmitChanges();

            sample = db.Samples.Single(s => s.surface_id == surfaceData.Id && s.upload_date == date);

            Statistic statistic = new Statistic();
            statistic.sample_id = sample.sample_id;
            statistic.x_min = process.XMin;
            statistic.x_max = process.XMax;
            statistic.y_min = process.YMin;
            statistic.y_max = process.YMax;
            statistic.z_min = process.ZMin;
            statistic.z_max = process.ZMax;
            statistic.z_mean = process.ZMean;

            db.Statistics.InsertOnSubmit(statistic);
            db.SubmitChanges();

            for (int idx = 0; idx < process.VisualizePointList.Count; idx++)
            {
                Point point = process.VisualizePointList[idx];
                point.sample_id = sample.sample_id;
                point.order = idx;
                db.Points.InsertOnSubmit(point);
                if ((idx % 100) == 0)
                    db.SubmitChanges();
            }
            db.SubmitChanges();

            for (int idx = 0; idx < process.ParameterList.Count; idx++)
            {
                Parameter parameter = new Parameter
                {
                    sample_id = sample.sample_id,
                    order = idx,
                    name = process.ParameterList[idx].Name,
                    value = process.ParameterList[idx].Value
                };
                db.Parameters.InsertOnSubmit(parameter);
            }
            db.SubmitChanges();

            return SampleToData(sample);
        }

        /// <summary>
        /// Modifies sample.
        /// </summary>
        /// <param name="surfaceData">A WebMech.Web.SampleData that specifies
        /// data object of sample.</param>
        /// <param name="imageName">A System.String that specifies
        /// the file name of sample image.</param>
        /// <param name="imageArray">A System.Byte[] that specifies
        /// byte array of image file</param>
        /// <param name="pointsName">A System.String that specifies
        /// the file name of text file with 3D points.</param>
        /// <param name="pointsArray">A System.String that specifies
        /// byte array of text file with 3D points.</param>
        public void ModifySample(SampleData sampleData, string imageName, byte[] imageArray, string pointsName, byte[] pointsArray)
        {
            LogIt.Info("ModifySample(Id = " + sampleData.Id.ToString() + ", ImageName = " + imageName + ", PointsName = " + pointsName + ")");
        }

        /// <summary>
        /// Delete sample from database.
        /// </summary>
        /// <param name="sampleData">A WebMech.Web.SampleData that specifies
        /// data object of sample.</param>
        public void DeleteSample(SampleData sampleData)
        {
            LogIt.Info("DeleteSample(Id = " + sampleData.Id.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            var points = (from p in db.Points
                          where p.sample_id == sampleData.Id
                          select p);
            db.Points.DeleteAllOnSubmit(points);
            db.SubmitChanges();

            var parameters = (from p in db.Parameters
                              where p.sample_id == sampleData.Id
                              select p);
            db.Parameters.DeleteAllOnSubmit(parameters);
            db.SubmitChanges();

            var statistics = (from s in db.Statistics
                              where s.sample_id == sampleData.Id
                              select s);
            db.Statistics.DeleteAllOnSubmit(statistics);
            db.SubmitChanges();

            Sample sample = db.Samples.Single(s => s.sample_id == sampleData.Id);
            db.Samples.DeleteOnSubmit(sample);
            db.SubmitChanges();
        }

        /// <summary>
        /// Gets information about sample's pagination according to filter.
        /// </summary>
        /// <param name="filterData">WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</param>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        /// <returns>A WebMech.Web.PageInfoData that specifies
        /// data object of pagination.</returns>
        public PageInfoData GetSampleListPageInfo(SearchFilterData filterData, SurfaceData surfaceData)
        {
            LogIt.Info("GetSampleListPageInfo(Id = " + surfaceData.Id.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            var totalQuery = from s in db.Samples
                             where s.surface_id == surfaceData.Id
                             orderby s.sample_date descending
                             select s;

            int total = totalQuery.Count();
            bool isNext = (filterData.Start + filterData.Count) <= total;
            bool isPrev = filterData.Start > filterData.Count;

            return new PageInfoData
            {
                Start = filterData.Start,
                End = Math.Min(filterData.Start + filterData.Count - 1, total),
                Total = total,
                IsNext = isNext,
                IsPrevious = isPrev
            };
        }

        /// <summary>
        /// Gets list of samples according to filter.
        /// </summary>
        /// <param name="filterData">WebMech.Web.SearchFilterData which specifies
        /// filter for selection of surfaces.</param>
        /// <param name="surfaceData">A WebMech.Web.SurfaceData that specifies
        /// data object of surface.</param>
        /// <returns>A System.Collections.Generic.List that specifies
        /// list of data objects of sample.</returns>
        public List<SampleData> GetSampleList(SearchFilterData filterData, SurfaceData surfaceData)
        {
            LogIt.Info("GetSampleList(Id = " + surfaceData.Id.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            var samples = (from m in db.Samples
                           where m.surface_id == surfaceData.Id
                           orderby m.sample_date descending
                           select m).Skip(filterData.Start - 1).Take(filterData.Count);

            List<SampleData> sampleList = new List<SampleData>();
            foreach (Sample sample in samples)
            {
                SampleData sampleData = SampleToData(sample);

                var parameters = (from p in db.Parameters
                                  where p.sample_id == sample.sample_id
                                  orderby p.order
                                  select p);

                sampleData.ParameterList = new List<ParameterData>();
                foreach (Parameter parameter in parameters)
                    sampleData.ParameterList.Add(ParameterToData(parameter));

                sampleList.Add(sampleData);
            }
            return sampleList;
        }

        /// <summary>
        /// Gets 3D model of sample.
        /// </summary>
        /// <param name="sampleData">A WebMech.Web.SampleData that specifies
        /// data object of sample.</param>
        /// <returns>A WebMech.Web.Model3DData that specifies
        /// data object of 3D model.</returns>
        public Model3DData GetSample(SampleData sampleData)
        {
            LogIt.Info("GetSample(Id = " + sampleData.Id.ToString() + ")");
            WebMechDataContext db = new WebMechDataContext();

            Statistic statistic = db.Statistics.Single(s => s.sample_id == sampleData.Id);
            Model3DData model3D = StatisticToData(statistic);

            var points = (from p in db.Points
                           where p.sample_id == sampleData.Id
                           orderby p.order ascending
                           select p);

            foreach (Point point in points)
                model3D.PointList.Add(PointToData(point));
            return model3D;
        }
    }
}

using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Basho.ThreadApp
{
    public class FileCopyActivity : ActivityBase
    {
        private string sourcePath = string.Empty;
        private string destPath = string.Empty;

        private string[] files;
        private int filesProcessed = 0;
        int progressStep = 0;

        public FileCopyActivity(string sourcePath, string destPath)
        {
            this.sourcePath = sourcePath;
            this.destPath = destPath;
        }

        protected override ActivityState Execute()
        {
            try
            {
                if (!Directory.Exists(destPath))
                    Directory.CreateDirectory(destPath);

                if (files == null)
                {
                    files = Directory.GetFiles(sourcePath, "*.*", SearchOption.TopDirectoryOnly);
                    progressStep = ActivityBase.MaxProgress / files.Length;
                }

                while (filesProcessed < files.Length)
                {
                    if (IsCancelPending())
                        return ActivityState.Cancelled;

                    string sourceFilePath = files[filesProcessed];
                    string destFilePath = Path.Combine(destPath, Path.GetFileName(sourceFilePath));

                    File.Copy(sourceFilePath, destFilePath, true);

                    filesProcessed++;

                    base.ChangeProgress(filesProcessed * progressStep);
                }
            }
            catch (Exception ex)
            {
                return ActivityState.Error;
            }

            base.ChangeProgress(ActivityBase.MaxProgress);

            return ActivityState.Finished;
        }

        protected override ActivityState Revert()
        {
            try
            {
                if (files != null)
                {
                    while (filesProcessed > 0)
                    {
                        if (IsCancelPending())
                            return ActivityState.Cancelled;

                        string fileName = files[filesProcessed - 1];
                        string destFilePath = Path.Combine(destPath, Path.GetFileName(fileName));
                        File.Delete(destFilePath);

                        filesProcessed--;

                        base.ChangeProgress(filesProcessed * progressStep);
                    }

                    if (filesProcessed == 0)
                    {
                        files = null;
                        progressStep = 0;
                    }
                }
            }
            catch
            {
                return ActivityState.Error;
            }

            base.ChangeProgress(ActivityBase.MaxProgress);

            return ActivityState.Finished;
        }
    }
}

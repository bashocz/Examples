using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;

namespace Basho.ThreadApp
{
    public abstract class ActivityBase : IActivity
    {
        public const int MaxProgress = 100000;

        private ActivityState state = ActivityState.Idle;
        private Thread workerThread = null;
        private ManualResetEvent stopEvent = new ManualResetEvent(true);
        private int progress;

        private void CheckIdleState()
        {
            if (state != ActivityState.Idle)
                throw new InvalidOperationException("The activity must be idle.");
        }

        private void CheckRunningState()
        {
            if (state != ActivityState.Running)
                throw new InvalidOperationException("The activity must be running.");
        }

        private void CheckFinalState()
        {
            if ((state == ActivityState.Idle) || (state == ActivityState.Running))
                throw new InvalidOperationException("The activity must be in final state.");
        }

        protected ManualResetEvent StopEvent
        {
            get { return stopEvent; }
        }

        protected void ChangeProgress(int newProgress)
        {
            progress = newProgress;
            OnProgressChanged(EventArgs.Empty);
        }

        protected bool IsCancelPending()
        {
            return stopEvent.WaitOne(0, false);
        }

        protected abstract ActivityState Execute();
        protected abstract ActivityState Revert();

        private void WorkerThreadMethod()
        {
            bool revert = (state != ActivityState.Idle);

            state = ActivityState.Running;

            OnProgressChanged(EventArgs.Empty);

            if (!revert)
                state = Execute();
            else
                state = Revert();

            workerThread = null;
            OnProgressChanged(EventArgs.Empty);
        }

        protected virtual void OnProgressChanged(EventArgs e)
        {
            if (ProgressChanged != null)
                ProgressChanged(this, e);
        }

        public void Start()
        {
            CheckIdleState();

            StartWorkerThread();
        }

        private void StartWorkerThread()
        {
            workerThread = new Thread(new ThreadStart(WorkerThreadMethod));
            stopEvent.Reset();
            workerThread.Start();
        }

        public void Stop()
        {
            CheckRunningState();

            stopEvent.Set();
        }

        public void Reset()
        {
            CheckFinalState();

            StartWorkerThread();
        }

        public ActivityState State
        {
            get { return state; }
        }

        public int Progress
        {
            get { return progress; }
        }

        public event EventHandler ProgressChanged;
    }
}

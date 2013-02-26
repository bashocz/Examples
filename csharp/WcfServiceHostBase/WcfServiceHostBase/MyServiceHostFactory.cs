using System;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Description;
using System.ServiceModel.Channels;
using System.ServiceModel.Dispatcher;

namespace WcfServiceHostBase
{
    public class MyInstanceProvider : IInstanceProvider, IContractBehavior
    {
        private readonly int _multi;

        public MyInstanceProvider(int multi)
        {
            _multi = multi;
        }

        #region IInstanceProvider Members

        public object GetInstance(InstanceContext instanceContext, Message message)
        {
            return this.GetInstance(instanceContext);
        }

        public object GetInstance(InstanceContext instanceContext)
        {
            return new MyService(_multi);
        }

        public void ReleaseInstance(InstanceContext instanceContext, object instance)
        {
        }

        #endregion

        #region IContractBehavior Members

        public void AddBindingParameters(ContractDescription contractDescription, ServiceEndpoint endpoint, BindingParameterCollection bindingParameters)
        {
        }

        public void ApplyClientBehavior(ContractDescription contractDescription, ServiceEndpoint endpoint, ClientRuntime clientRuntime)
        {
        }

        public void ApplyDispatchBehavior(ContractDescription contractDescription, ServiceEndpoint endpoint, DispatchRuntime dispatchRuntime)
        {
            dispatchRuntime.InstanceProvider = this;
        }

        public void Validate(ContractDescription contractDescription, ServiceEndpoint endpoint)
        {
        }

        #endregion
    }

    public class MyServiceHost : ServiceHost
    {
        public MyServiceHost(int multi, Type t, Uri[] baseAddresses)
            : base(t, baseAddresses)
        {
            foreach (var cd in ImplementedContracts.Values)
            {
                cd.Behaviors.Add(new MyInstanceProvider(multi));
            }
        }
    }

    public class MyServiceHostFactory : ServiceHostFactory
    {
        private const int _multi = 10;

        protected override ServiceHost CreateServiceHost(Type t, Uri[] baseAddresses)
        {
            return new MyServiceHost(_multi, t, baseAddresses);
        }

        public override ServiceHostBase CreateServiceHost
                (string service, Uri[] baseAddresses)
        {
            Console.WriteLine("MyService is creating.");

            ServiceHost serviceHost = new MyServiceHost(_multi, typeof(MyService), baseAddresses);

            serviceHost.Opening += new EventHandler(serviceHost_Opening);
            serviceHost.Opened += new EventHandler(serviceHost_Opened);
            serviceHost.Closing += new EventHandler(serviceHost_Closing);
            serviceHost.Closed += new EventHandler(serviceHost_Closed);
            serviceHost.Faulted += new EventHandler(serviceHost_Faulted);
            serviceHost.UnknownMessageReceived += new EventHandler<UnknownMessageReceivedEventArgs>(serviceHost_UnknownMessageReceived);

            Console.WriteLine("MyService is created.");

            return serviceHost;
        }

        void serviceHost_Opening(object sender, EventArgs e)
        {
            Console.WriteLine("MyService is opening.");
        }

        void serviceHost_Opened(object sender, EventArgs e)
        {
            Console.WriteLine("MyService is opened.");
        }

        void serviceHost_Closing(object sender, EventArgs e)
        {
            Console.WriteLine("MyService is closing.");
        }

        void serviceHost_Closed(object sender, EventArgs e)
        {
            Console.WriteLine("MyService is closed.");
        }

        void serviceHost_Faulted(object sender, EventArgs e)
        {
            Console.WriteLine("MyService is faulted.");
        }

        void serviceHost_UnknownMessageReceived(object sender, UnknownMessageReceivedEventArgs e)
        {
            Console.WriteLine("MyService is received unknown message.");
        }
    }
}

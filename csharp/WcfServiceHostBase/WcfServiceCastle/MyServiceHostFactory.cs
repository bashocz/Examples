using System;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Description;
using System.ServiceModel.Channels;
using System.ServiceModel.Dispatcher;
using Castle.Core;
using Castle.Windsor;
using Castle.MicroKernel.Registration;
using Castle.Facilities.TypedFactory;

namespace WcfServiceCastle
{
    public class MyInstanceProvider : IInstanceProvider, IContractBehavior
    {
        private readonly IServiceFactory _factory;

        public MyInstanceProvider(IServiceFactory factory)
        {
            _factory = factory;
        }

        #region IInstanceProvider Members

        public object GetInstance(InstanceContext instanceContext, Message message)
        {
            return this.GetInstance(instanceContext);
        }

        public object GetInstance(InstanceContext instanceContext)
        {
            return _factory.GetMyServiceCastle();
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
        public MyServiceHost(IServiceFactory factory, Type t, Uri[] baseAddresses)
            : base(t, baseAddresses)
        {
            foreach (var cd in ImplementedContracts.Values)
            {
                cd.Behaviors.Add(new MyInstanceProvider(factory));
            }
        }
    }

    public interface IServiceFactory
    {
        IMyServiceCastle GetMyServiceCastle();
    }

    public class MyServiceHostFactory : ServiceHostFactory
    {
        protected override ServiceHost CreateServiceHost(Type t, Uri[] baseAddresses)
        {
            return new MyServiceHost(Factory, t, baseAddresses);
        }

        public override ServiceHostBase CreateServiceHost
                (string service, Uri[] baseAddresses)
        {
            Console.WriteLine("MyService is creating.");

            ServiceHost serviceHost = new MyServiceHost(Factory, typeof(MyServiceCastle), baseAddresses);

            serviceHost.Opening += new EventHandler(serviceHost_Opening);
            serviceHost.Opened += new EventHandler(serviceHost_Opened);
            serviceHost.Closing += new EventHandler(serviceHost_Closing);
            serviceHost.Closed += new EventHandler(serviceHost_Closed);
            serviceHost.Faulted += new EventHandler(serviceHost_Faulted);
            serviceHost.UnknownMessageReceived += new EventHandler<UnknownMessageReceivedEventArgs>(serviceHost_UnknownMessageReceived);

            Console.WriteLine("MyService is created.");

            return serviceHost;
        }

        IWindsorContainer _container;
        IWindsorContainer Container
        {
            get { return _container ?? (_container = GetContainer()); }
        }

        private IWindsorContainer GetContainer()
        {
            IWindsorContainer container = new WindsorContainer();

            container.AddFacility<TypedFactoryFacility>();

            container.Register(Component.For<ILogger>().ImplementedBy<Logger>().LifestyleSingleton());
            container.Register(Component.For<IMyServiceCastle>().ImplementedBy<MyServiceCastle>().Named("MyServiceCastle").LifestyleSingleton());
            container.Register(Component.For<IServiceFactory>().AsFactory().LifestyleSingleton());

            return container;
        }

        IServiceFactory _factory;
        IServiceFactory Factory
        {
            get { return _factory ?? (_factory = Container.Resolve<IServiceFactory>()); }
        }

        ILogger _logger;
        ILogger Logger
        {
            get { return _logger ?? (_logger = Container.Resolve<ILogger>()); }
        }

        void serviceHost_Opening(object sender, EventArgs e)
        {
            Logger.Message("MyService is opening.");
        }

        void serviceHost_Opened(object sender, EventArgs e)
        {
            Logger.Message("MyService is opened.");
        }

        void serviceHost_Closing(object sender, EventArgs e)
        {
            Logger.Message("MyService is closing.");
        }

        void serviceHost_Closed(object sender, EventArgs e)
        {
            Logger.Message("MyService is closed.");
        }

        void serviceHost_Faulted(object sender, EventArgs e)
        {
            Logger.Message("MyService is faulted.");
        }

        void serviceHost_UnknownMessageReceived(object sender, UnknownMessageReceivedEventArgs e)
        {
            Logger.Message("MyService is received unknown message.");
        }
    }
}

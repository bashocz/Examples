namespace CastleWindsorDemo
{
    public class Dependency1 : IDependency1
    {
        public IDependency3 SomeDependency { get; set; }
    }
}

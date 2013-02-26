using System;

namespace CastleWindsorDemo
{
    public class Main : IMain
    {
        #region constructor

        public Main(IDependency1 dependency1, IDependency2 dependency2)
        {
            _object1 = dependency1;
            _object2 = dependency2;
        }

        #endregion

        #region private fields

        private IDependency1 _object1;
        private IDependency2 _object2;

        #endregion

        #region public methods

        public void DoSomething()
        {
            _object1.SomeDependency.WriteSomethingOnConsole();
            _object2.SomeOtherDependency.PostSomethingOnConsole();
        }

        #endregion
    }
}

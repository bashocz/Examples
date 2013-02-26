using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OperationAPI
{
    class Program
    {
        interface IOperation
        {
            Func<object, bool> CanExecute { get; }
            void Execute(object o);
        }

        abstract class BaseOperation : IOperation
        {
            private Func<object, bool> _canExecute = (o) =>
            {
                return true;
            };
            public Func<object, bool> CanExecute
            {
                get { return _canExecute; }
                set { _canExecute = value; }
            }

            public abstract void Execute(object obj);

            //public BlockOperation If
            //{
            //    get { return new BlockOperation(); }
            //}


        }

        class BlockOperation : BaseOperation, IOperation
        {
            public BaseOperation Block(params IOperation[] os)
            {
                if ((os == null) || (os.Length == 0))
                    throw new ArgumentException();

                _os = new List<IOperation>(os);
                return this;
            }

            private List<IOperation> _os;
            public override void Execute(object obj)
            {
                foreach (IOperation o in _os)
                {
                    if (o.CanExecute(obj))
                        o.Execute(obj);
                }
            }
        }

        class IfOperation : BlockOperation, IOperation
        {
            public BlockOperation If(Func<object, bool> iff)
            {
                CanExecute = iff;
                return this;
            }

            public override void Execute(object obj)
            {
                while (CanExecute(obj))
                    base.Execute(obj);
            }
        }

        class LoopOperation : BlockOperation, IOperation
        {
            public BlockOperation While(Func<object, bool> loop)
            {
                CanExecute = loop;
                return this;
            }

            public override void Execute(object obj)
            {
                while (CanExecute(obj))
                    base.Execute(obj);
            }
        }

        class AnyOperation : BaseOperation, IOperation
        {
            public BaseOperation Can(Func<object, bool> can)
            {
                CanExecute = can;
                return this;
            }

            public override void Execute(object obj)
            {
                //
            }
        }

        static void Main(string[] args)
        {
            int i = 3;
            new BlockOperation()
            .Block(
                new AnyOperation(),
                new LoopOperation()
                .While((o) =>
                {
                    return i-- > 0;
                })
                .Block(
                    new AnyOperation(),
                    new IfOperation()
                    .If((o) =>
                    {
                        if (o != null)
                            return true;
                        return false;
                    })
                    .Block(
                        new AnyOperation(),
                        new AnyOperation()
                        .Can((o) =>
                        {
                            return false;
                        })
                    )
                )
            );
        }
    }
}

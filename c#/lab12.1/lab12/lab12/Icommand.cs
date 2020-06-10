using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    interface ICommand
    {
        void Execute();
    }
    class MoveUpCommand : ICommand
    {
        ICircle shape;

        public MoveUpCommand(ICircle shape)
        {
            this.shape= shape;
        }

        public void Execute()
        {
            if (shape == null) return;
            CirAdapter adapter = new CirAdapter(shape.Shape);
            adapter.MoveUp();
        }
    }

    class MoveRightCommand : ICommand
    {
        ICircle shape;

        public MoveRightCommand(ICircle shape)
        {
            this.shape = shape;
        }

        public void Execute()
        {
            CirAdapter adapter = new CirAdapter(shape.Shape);
            adapter.MoveRight();
        }
    }

    class MoveDownCommand : ICommand
    {
        ICircle shape;

        public MoveDownCommand(ICircle shape)
        {
            this.shape = shape;
        }

        public void Execute()
        {
            CirAdapter adapter = new CirAdapter(shape.Shape);
            adapter.MoveDown();
        }
    }

    class MoveLeftCommand : ICommand
    {
        ICircle shape;

        public MoveLeftCommand(ICircle shape)
        {
            this.shape = shape;
        }

        public void Execute()
        {
            CirAdapter adapter = new CirAdapter(shape.Shape);
            adapter.MoveLeft();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    abstract class State
    {
        public abstract void Handle(ShapeContext shapeContext);
    }

    class MovingState : State
    {
        public override void Handle(ShapeContext shapeContext)
        {
            //shapeContext.ReturnBackColor();
            shapeContext.ShapeState = new RestState();
        }
    }

    class RestState : State
    {
        public override void Handle(ShapeContext shapeContext)
        {
            //shapeContext.ChangeColor();
            shapeContext.ShapeState = new MovingState();
        }
    }
}

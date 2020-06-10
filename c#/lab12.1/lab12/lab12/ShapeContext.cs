using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    class ShapeContext
    {
        public State ShapeState { get; set; }

        public ShapeContext(State shapeState)
        {
            ShapeState = shapeState;
            //TimerSet();
        }

        
        

        public void Request(Shape _shape)
        {
            //shape = _shape;
            ShapeState.Handle(this);
        }
    }
}

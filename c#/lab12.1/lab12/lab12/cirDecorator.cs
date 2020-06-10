using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    class cirDecorator:ElDecor
    {
        public cirDecorator(ICircle circle):base(circle)
        {
            
            circle.Shape.Opacity = 0.5;
            circle.Shape.StrokeThickness = 5;
        }
        public override Ellipse GetCir()
        {
            return base.GetCir();
        }
        
    }
}

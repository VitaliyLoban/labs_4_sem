using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    class Figure
    {
        private Circle circle;
        private Square square;
        public Figure(FigureFactory factory)
        {
            circle = factory.CreateCircle();
            square = factory.CreateSquare();
        }
        public Ellipse getCircle()
        {
            return circle.DrawCircle();
        }
        public Rectangle getSquary()
        {
            return square.DrawSquare();
        }
    }
}

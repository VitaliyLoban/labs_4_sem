using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class BlueFigure:FigureFactory
    {
        public override Circle CreateCircle()
        {
            return new BlueSircle();
        }

        public override Square CreateSquare()
        {
            return new BlueSquare();
        }
    }
}

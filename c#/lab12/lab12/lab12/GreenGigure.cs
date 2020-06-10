using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class GreenGigure:FigureFactory
    {
        public override Circle CreateCircle()
        {
            return new GreenCircle();
        }

        public override Square CreateSquare()
        {
            return new GreenSquare();
        }
    }
}

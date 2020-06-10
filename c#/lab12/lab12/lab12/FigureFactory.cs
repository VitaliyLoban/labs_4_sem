using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    abstract class FigureFactory
    {
        public abstract Circle CreateCircle();
        public abstract Square CreateSquare();
    }
}

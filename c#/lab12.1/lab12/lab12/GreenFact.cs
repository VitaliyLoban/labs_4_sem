using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class GreenFact:IFigure
    {
        public ISquare CreateSq()
        {
            return new GreenSq();
        }
        public ICircle CreateCr()
        {
            return new GreenCr();
        }
    }
}

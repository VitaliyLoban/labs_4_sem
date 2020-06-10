using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class BlueFact:IFigure
    {
        public ISquare CreateSq()
        {
            return new BlueSq();
        }
        public ICircle CreateCr()
        {
            return new BlueCr();
        }
    }
}

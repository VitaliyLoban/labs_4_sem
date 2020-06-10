using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace decor
{
    class BlueCircle : Circle
    {
        public BlueCircle():base("Синий круг")
        {

        }
        public override int Rad()
        {
            return 10;
        }
    }
}

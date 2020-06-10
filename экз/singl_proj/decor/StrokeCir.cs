using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace decor
{
    class StrokeCir : Decor
    {
        public StrokeCir(Circle circle) : base(circle.Name+" c обводкой",circle)
        {
        }

        public override int Rad()
        {
            return circle.Rad() + 10;
        }
    }
}

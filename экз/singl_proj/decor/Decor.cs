using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace decor
{
    abstract class Decor : Circle
    {
        protected Circle circle;
        public Decor(string n, Circle circle) : base(n)
        {
            this.circle = circle;
        }

    }
}

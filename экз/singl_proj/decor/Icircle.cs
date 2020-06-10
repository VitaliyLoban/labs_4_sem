using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace decor
{
    abstract class Circle
    {
        string name;
        public Circle(string n)
        {
            Name = n;
        }

        public string Name { get => name; set => name = value; }
        public abstract int Rad();
    }
}

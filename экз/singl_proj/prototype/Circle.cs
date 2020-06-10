using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace prototype
{
    class Circle:Ifigure
    {
        int R;

        public Circle(int k)
        {
            R1 = k;
        }

        public int R1 { get => R; set => R = value; }

        public Ifigure Clone()
        {
            return new Circle(R1);
        }

        public string GetInf()
        {
            return $"Круг радиусом:{R}";
        }
        
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class Creator
    {
        public ComplexObject complexObject(ComplexObjBuild k)
        {
            k.CreateComOb();
            k.SetCircle();
            k.SetSquare();
            return k.ComplexObject;
        }
    }
}

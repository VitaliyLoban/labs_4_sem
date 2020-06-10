using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    abstract class ComplexObjBuild
    {

        public ComplexObject ComplexObject { get; private set; }
        public void CreateComOb()
        {
            ComplexObject = new ComplexObject();
            
        }
        public abstract Ellipse SetCircle();
        public abstract Rectangle SetSquare();
    }
}

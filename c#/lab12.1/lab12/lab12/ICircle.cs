using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    interface ICircle
    {
        Ellipse Shape { get; set; }
        Ellipse GetCir();
    }
}

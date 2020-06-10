using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    interface IPageBuilder
    {
        Ellipse AddCir();
        Rectangle AddSqu();
    }
}

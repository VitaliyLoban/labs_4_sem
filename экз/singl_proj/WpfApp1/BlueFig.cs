using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfApp1
{
    class BlueFig:Ifigure
    {
        public Iscuare GetScuare()
        {
            return new BlueSq();
        }
        public Icircle GetCircle()
        {
            return new BlueCir();
        }
    }
}

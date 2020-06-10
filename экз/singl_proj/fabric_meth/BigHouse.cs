using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace fabric_meth
{
    class BigHouse : House
    {
        public BigHouse(TextBlock k)
        {
            k.Text+="Big\n";
        }
    }
}

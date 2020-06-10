using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace fabric_meth
{
    class SmallHouse : House
    {
        public SmallHouse(TextBlock k)
        {
            k.Text+="Small\n";

        }
    }
}

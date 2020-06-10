using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace fabric_meth
{
    class SmallHouseDev : Developer
    {
        public SmallHouseDev(string k) : base(k)
        {
        }

        public override House Create(TextBlock k)
        {
            return new SmallHouse(k);
        }
    }
}

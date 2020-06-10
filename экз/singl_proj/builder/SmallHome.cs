using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace builder
{
    class SmallHome:HomeBuider
    {
        public override void SetDoor()
        {
            this.Home.Doors = new Doors { Door = 4 };
        }
        public override void SetRoof()
        {
            
        }
        public override void SetWind()
        {
            this.Home.Windows = new Windows { Window = 4 };
        }
    }
}

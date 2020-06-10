using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace builder
{
    class BigHome:HomeBuider
    {
        public override void SetDoor()
        {
            this.Home.Doors = new Doors { Door = 16 };
        }
        public override void SetRoof()
        {
            this.Home.Roof = new Roof { roof = "Крыша" };
        }
        public override void SetWind()
        {
            this.Home.Windows = new Windows { Window = 20 };
        }
    }
}

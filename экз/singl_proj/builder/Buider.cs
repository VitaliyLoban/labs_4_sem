using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace builder
{
    class Buider
    {
        public Home build(HomeBuider k)
        {
            k.CreateHome();
            k.SetDoor();
            k.SetRoof();
            k.SetWind();
            return k.Home;
        }
    }
}

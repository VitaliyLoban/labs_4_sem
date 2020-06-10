using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace builder
{
    abstract class HomeBuider
    {
        public Home Home { get; private set; }
        public void CreateHome()
        {
            Home = new Home();
        }
        public abstract void SetWind();
        public abstract void SetDoor();
        public abstract void SetRoof();

    }
}

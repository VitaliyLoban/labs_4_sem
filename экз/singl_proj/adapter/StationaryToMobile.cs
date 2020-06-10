using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace adapter
{
    class StationaryToMobile : IStationary
    {
        Smartphone Smartphone;

        public StationaryToMobile(Smartphone k)
        {
            Smartphone = k;
        }

        public string Use_s()
        {
            return Smartphone.Use_m();
        }
    }
}

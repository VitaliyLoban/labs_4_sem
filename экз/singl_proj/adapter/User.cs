using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace adapter
{
    class User
    {
        public string Serfing(IStationary stationary)
        {
            return stationary.Use_s();
        }
    }
}

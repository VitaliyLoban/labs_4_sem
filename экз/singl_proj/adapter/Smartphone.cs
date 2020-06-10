using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace adapter
{
    class Smartphone : IMobile
    {
        public string Use_m()
        {
            return "Испльзуем смартфон";
        }
    }
}

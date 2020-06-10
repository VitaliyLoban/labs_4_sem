using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace adapter
{
    class Computer : IStationary
    {
        public string Use_s()
        {
            return "Используем компрьютер";
        }
    }
}

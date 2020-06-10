using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace builder
{
    class Home
    {
        public Roof Roof { get; set; }
        public Windows Windows { get; set; }
        public Doors Doors { get; set; }
        public override string ToString()
        {
            StringBuilder k = new StringBuilder();
            if (Roof != null)
                k.Append(Roof.roof + '\n');
            if (Windows != null)
                k.Append(Windows.Window + " окон\n");
            if (Doors != null)
                k.Append(Doors.Door + " дверей\n");
            return k.ToString();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace list_of_comp
{
    public class Computer
    {
        int memory;
        string processor;
        string monitor;

        public Computer(int memory, string processor, string monitor)
        {
            this.Memory = memory;
            this.Processor = processor;
            this.Monitor = monitor;
        }

        public int Memory { get => memory; set => memory = value; }
        public string Processor { get => processor; set => processor = value; }
        public string Monitor { get => monitor; set => monitor = value; }
    }
}

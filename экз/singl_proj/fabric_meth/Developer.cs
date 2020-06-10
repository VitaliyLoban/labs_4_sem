using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace fabric_meth
{
    abstract class Developer
    {
        private string name;

        public Developer(string k)
        {
            Name = k;
        }
        public abstract House Create(TextBlock k);
        public string Name { get => name; set => name = value; }
    }
}

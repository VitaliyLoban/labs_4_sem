using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class Map : IComponent
    {
        static private List<IComponent> components = new List<IComponent>();
        public string NameOb { get; set; }
        static public void add(IComponent component)
        {
            components.Add(component);
        }
        static public IComponent find(String name)
        {
            IComponent component = components.Where(p => p.NameOb == name).First();
            return component;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Shapes;

namespace lab12
{
    class ElDecor : ICircle
    {
        protected readonly ICircle circle;

        public Ellipse Shape { get => circle.Shape; set => circle.Shape = value as Ellipse; }
        public ElDecor(ICircle circle)
        {
            this.circle = circle;
        }
        public virtual Ellipse GetCir()
        {
            return circle.GetCir();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Shapes;

namespace lab12
{
    class CirAdapter:IAdapt
    {
        private readonly Shape el;

        public CirAdapter(Shape el)
        {
            this.el = el;
        }
        public void MoveUp()
        {
            Thickness thickness = el.Margin;
            thickness.Top -= 10;
            el.Margin = thickness;
        }

        public void MoveDown()
        {
            Thickness thickness = el.Margin;
            thickness.Top += 10;
            el.Margin = thickness;
        }

        public void MoveLeft()
        {
            Thickness thickness = el.Margin;
            thickness.Left -= 10;
            el.Margin = thickness;
        }

        public void MoveRight()
        {
            Thickness thickness = el.Margin;
            thickness.Left += 10;
            el.Margin = thickness;
        }
    }
}

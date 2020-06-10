using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media;
using System.Windows.Shapes;

namespace lab12
{
    class GreenCr:ICircle
    {
        Ellipse k;
        public Ellipse Shape { get => k; set => k = value as Ellipse; }
        Random kr = new Random();
        public GreenCr()
        {
            k = GetCir() as Ellipse;
        }
        public Ellipse GetCir()
        {
            Ellipse k1 = new Ellipse();
            k1.Width = 50;
            k1.Height = 50;
            k1.Fill = Brushes.Green;
            k1.Stroke = Brushes.Black;
            k1.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            k1.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            return k1;
        }
    }
}

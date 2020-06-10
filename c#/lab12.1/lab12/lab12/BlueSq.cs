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
    class BlueSq : ISquare
    {
        Random kr = new Random();
        public Rectangle GetSq()
        {
            Rectangle k = new Rectangle();
            k.Width = 60;
            k.Height = 50;
            k.Fill = Brushes.Blue;
            k.Stroke = Brushes.Black;
            k.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            k.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            return k;
        }
    }
}

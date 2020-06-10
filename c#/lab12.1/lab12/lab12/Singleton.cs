using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Shapes;

namespace lab12
{
    public sealed class Singleton
    {
        private static Singleton _instance;
        private Singleton(Grid grid)
        {
            Ellipse k = new Ellipse();
            k.Fill = Brushes.GreenYellow;
            k.Stroke = Brushes.Black;
            k.HorizontalAlignment = System.Windows.HorizontalAlignment.Center;
            k.VerticalAlignment = System.Windows.VerticalAlignment.Center;
            k.Width = 150;
            k.Height = 130;
            grid.Children.Add(k);
        }
        public static Singleton SingltonOn(Grid grid)
        {
            return _instance ?? (_instance = new Singleton(grid));
        }
    }
}

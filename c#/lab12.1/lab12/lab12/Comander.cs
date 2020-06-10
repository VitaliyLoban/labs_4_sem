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
    class Comander:IPageBuilder
    {
        static Random kr = new Random();
        int margleft = kr.Next(93, 600);
        int margtop = kr.Next(0, 300);
        public Ellipse AddCir()
        {
            Ellipse k = new Ellipse();
            k.Width = 80;
            k.Height = 80;
            k.Fill = Brushes.Red;
            k.Stroke = Brushes.Black;
            k.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            k.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            k.Margin = new Thickness(margleft, margtop, 0, 0);
            return k;
            
        }
        public Rectangle AddSqu()
        {
            Rectangle k = new Rectangle();
            k.Width = 50;
            k.Height = 50;
            k.Fill = Brushes.Yellow;
            k.Stroke = Brushes.Black;
            k.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            k.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            k.Margin = new Thickness(margleft , margtop , 0, 0);
            return k;
        }


    }
}

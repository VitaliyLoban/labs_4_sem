using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;
using System.Windows.Shapes;

namespace lab12
{
    class BlueSircle:Circle
    {

        public override Ellipse DrawCircle()
        {
            Ellipse squareBlue = new Ellipse();
            squareBlue.Width = 50;
            squareBlue.Height = 50;
            squareBlue.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            squareBlue.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            squareBlue.Fill = Brushes.Blue;
            return squareBlue;
        }
    }
}
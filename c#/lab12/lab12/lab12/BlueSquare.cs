using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;
using System.Windows.Shapes;

namespace lab12
{
    class BlueSquare:Square
    {
        public override Rectangle DrawSquare()
        {
            Rectangle squareBlue= new Rectangle();
            squareBlue.Width = 50;
            squareBlue.Height = 50;
            squareBlue.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            squareBlue.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            squareBlue.Fill = Brushes.Blue;
            return squareBlue;
        }
    }
}

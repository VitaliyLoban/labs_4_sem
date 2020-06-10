using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;
using System.Windows.Shapes;

namespace lab12
{
    class BlueComObBuild:ComplexObjBuild
    {
        public override Ellipse SetCircle()
        {
            Ellipse ell = new Ellipse();
            ell.Width = 80;
            ell.Height = 70;
            ell.Fill = Brushes.Blue;
            ell.Stroke = Brushes.Black;
            this.ComplexObject.cir = new BuildCircle { el = ell };
            return ell;
        }
        public override Rectangle SetSquare()
        {
            Rectangle re = new Rectangle();
            re.Width = 50;
            re.Height = 50;
            re.Stroke = Brushes.Black;
            re.Fill = Brushes.Blue;
            this.ComplexObject.sq = new BuildSquare { rec = re };
            return re;
        }
    }
}

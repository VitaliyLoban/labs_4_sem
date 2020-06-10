using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;
using System.Windows.Shapes;

namespace lab12
{
    class GreenComObBuild : ComplexObjBuild
    {
        public override Ellipse SetCircle()
        {
            Ellipse ell = new Ellipse();
            ell.Width = 120;
            ell.Height = 120;
            ell.Stroke = Brushes.Black;
            ell.Fill = Brushes.Green;
            this.ComplexObject.cir = new BuildCircle { el = ell };
            return ell;
        }
        public override Rectangle SetSquare()
        {
            Rectangle re = new Rectangle();
            re.Width = 150;
            re.Height = 50;
            re.Stroke = Brushes.Black;
            re.Fill = Brushes.Green;
            this.ComplexObject.sq = new BuildSquare { rec = re };
            return re;
        }
    }
}

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
    [Serializable]
    class BlueCr:Prototype<BlueCr>,ICircle,IComponent
    {
        Ellipse el;
        
        public Ellipse Shape { get => el; set => el = value as Ellipse; }
        public string NameOb { get; set; }

        Random kr = new Random();
        private void SetElementToClone(object sender, RoutedEventArgs e)
        {
            MainWindow.K = this;
        }
        public BlueCr()
        {
            el = GetCir() as Ellipse;
            
            this.NameOb = ("Круг " + Count.coun++).ToString();
            Map.add(this);
        }
        public Ellipse GetCir()
        {

            Ellipse el1 = new Ellipse();
            el1.Width = 50;
            el1.Height = 50;
            el1.Fill = Brushes.Blue;
            el1.Stroke = Brushes.Black;
            el1.HorizontalAlignment = System.Windows.HorizontalAlignment.Left;
            el1.VerticalAlignment = System.Windows.VerticalAlignment.Top;
            el1.MouseDown += SetElementToClone;

            return el1;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media.Imaging;

namespace ado_net
{
    class Students
    {
        BitmapImage im;
        string name;

        public Students(BitmapImage im, string name)
        {
            this.Im = im;
            this.Name = name;
        }

        public BitmapImage Im { get => im; set => im = value; }
        public string Name { get => name; set => name = value; }
    }
}

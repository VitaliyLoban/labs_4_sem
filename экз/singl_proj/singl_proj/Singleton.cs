using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace singl_proj
{
    class Singleton
    {
        private static Singleton instance;
        private Singleton(TextBlock k)
        {
            string z = "Singleton";
            k.Text += z;
        }

        public static Singleton GetInstatce(TextBlock k)
        {
            if (instance == null)
                instance = new Singleton(k);
            return instance;
        }
    }
}

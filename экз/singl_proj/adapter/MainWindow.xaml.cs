using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace adapter
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            User k = new User();
            Computer z = new Computer();
            t1.Text+=k.Serfing(z)+"\n----\n";
            Smartphone zz = new Smartphone();
            IStationary stationary = new StationaryToMobile(zz);
            t1.Text += k.Serfing(stationary) + "\n----\n";
        }
    }
}

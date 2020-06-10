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

namespace builder
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            Buider k = new Buider();
            HomeBuider z = new BigHome();
            Home home = k.build(z);
            t1.Text += home.ToString()+"\n-----------------\n";
            HomeBuider z1 = new SmallHome();
            Home home1 = k.build(z1);
            t1.Text += home1.ToString() + "\n-----------------\n";
        }
    }
}

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

namespace decor
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            Circle k = new BlueCircle();
            t1.Text += $"{k.Name} ,радиусом {k.Rad()}"+"\n-----------\n";
            k = new StrokeCir(k);
            t1.Text += $"{k.Name} ,радиусом {k.Rad()}" + "\n-----------\n";
        }
    }
}

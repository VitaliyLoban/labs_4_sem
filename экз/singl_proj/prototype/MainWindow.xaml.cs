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

namespace prototype
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Circle k;
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Cr_Click(object sender, RoutedEventArgs e)
        {
            k = new Circle(10);
            t1.Text += k.GetInf() +'\n';
        }

        private void Cl_Click(object sender, RoutedEventArgs e)
        {
            t1.Text+=k.Clone().GetInf()+'\n';
        }
    }
}

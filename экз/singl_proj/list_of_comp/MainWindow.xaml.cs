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

namespace list_of_comp
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public List<Computer> comp_list = new List<Computer>();
        public MainWindow()
        {
            InitializeComponent();
            Computer k = new Computer(11, "Icore 7", "HP");
            Computer k1 = new Computer(31, "Icore 8", "Asus");
            Computer k2 = new Computer(61, "Icore 9", "Acer");
            Computer k3 = new Computer(91, "Icore 10", "Lenovo");

            comp_list.Add(k);
            comp_list.Add(k1);
            comp_list.Add(k2);
            comp_list.Add(k3);
            //DataContext = comp_list;
            list1.ItemsSource = comp_list;
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            
            //list1.ItemsSource = comp_list;
            //list1.DisplayMemberPath= "Monitor"


        }
    }
}

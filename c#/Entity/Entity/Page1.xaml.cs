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
using System.Data.Entity;

namespace Entity
{
    /// <summary>
    /// Логика взаимодействия для Page1.xaml
    /// </summary>
    public partial class Page1 : Page
    {
        public Page1()
        {
            InitializeComponent();
            EntityContext eCont = new EntityContext();
            DataGrid1.ItemsSource = eCont.TeachSet.ToList();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Window1 window = new Window1(DataGrid1);
            window.Show();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Window2 window = new Window2(DataGrid1);
            window.Show();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Window3 window = new Window3(DataGrid1);
            window.Show();
        }
    }
}

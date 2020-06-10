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

namespace Entity
{
    /// <summary>
    /// Логика взаимодействия для Page2.xaml
    /// </summary>
    public partial class Page2 : Page
    {
        public Page2()
        {
            InitializeComponent();
            EntityContext entityContext = new EntityContext();
            DataGrid1.ItemsSource = entityContext.SubSet.ToList();
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Window5 window = new Window5(DataGrid1);
            window.Show();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Window6 window = new Window6(DataGrid1);
            window.Show();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Window7 window = new Window7(DataGrid1);
            window.Show();
        }
 
    }
}

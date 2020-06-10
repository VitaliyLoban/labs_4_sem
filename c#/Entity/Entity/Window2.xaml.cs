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
using System.Windows.Shapes;

namespace Entity
{
    /// <summary>
    /// Логика взаимодействия для Window2.xaml
    /// </summary>
    public partial class Window2 : Window
    {
        DataGrid dataGrid;
        public Window2(DataGrid dataGrid)
        {
            InitializeComponent();
            this.dataGrid = dataGrid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            EntityContext entityContext = new EntityContext();
            Teachers teachers = entityContext.TeachSet.Where(p => p.nameSurname == tbDelete.Text).FirstOrDefault();
            entityContext.TeachSet.Remove(teachers);
            entityContext.SaveChanges();
            MessageBox.Show("Teacher is deleted");
            dataGrid.ItemsSource = entityContext.TeachSet.ToList();
        }
    }
}

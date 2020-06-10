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
    /// Логика взаимодействия для Window6.xaml
    /// </summary>
    public partial class Window6 : Window
    {
        DataGrid dataGrid;
        public Window6(DataGrid dataGrid)
        {
            InitializeComponent();
            this.dataGrid = dataGrid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            EntityContext entityContext = new EntityContext();
            Subjects subjects = entityContext.SubSet.Where(p => p.name == tbDelete.Text).FirstOrDefault();
            entityContext.SubSet.Remove(subjects);
            entityContext.SaveChanges();
            MessageBox.Show("Subject is deleted");
            dataGrid.ItemsSource = entityContext.TeachSet.ToList();
        }
    }
}

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
    /// Логика взаимодействия для Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        DataGrid dataGrid;
        public Window1(DataGrid dataGrid)
        {
            InitializeComponent();
            this.dataGrid = dataGrid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            using (EntityContext entityContext = new EntityContext())
            {
                Teachers teacher = new Teachers(tbNameSurname.Text, tbSubName.Text, Convert.ToInt32(tbLectureCount.Text), Convert.ToInt32(tbLectureHallNumber.Text));
                entityContext.TeachSet.Add(teacher);
                entityContext.SaveChanges();
                MessageBox.Show("Teacher is added");
                dataGrid.ItemsSource = entityContext.TeachSet.ToList();
            }
        }
    }
}

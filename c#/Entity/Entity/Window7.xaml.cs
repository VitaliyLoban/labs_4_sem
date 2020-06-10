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
    /// Логика взаимодействия для Window7.xaml
    /// </summary>
    public partial class Window7 : Window
    {
        DataGrid dataGrid;
        public Window7(DataGrid dataGrid)
        {
            InitializeComponent();
            this.dataGrid = dataGrid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            EntityContext context = new EntityContext();
            Subjects teachers = context.SubSet.Where(p => p.name == tbName.Text).FirstOrDefault();
            teachers.dayName = tbDayname.Text;
            teachers.lectureHallNumber = Convert.ToInt32( tbLectureHallNumber.Text);
            context.SaveChanges();
            MessageBox.Show("Teachers updated");
            dataGrid.ItemsSource = context.SubSet.ToList();
        }
    }
}

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
    /// Логика взаимодействия для Window3.xaml
    /// </summary>
    public partial class Window3 : Window
    {
        DataGrid dataGrid;
        public Window3(DataGrid dataGrid)
        {
            InitializeComponent();
            this.dataGrid = dataGrid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            EntityContext context = new EntityContext();
            Teachers teachers = context.TeachSet.Where(p => p.nameSurname == tbName.Text).FirstOrDefault();
            teachers.lectureCount = Convert.ToInt32( tbLectureCount.Text);
            teachers.nameSurname = tbNameSurname.Text;
            teachers.studentCount = Convert.ToInt32( tbLectureHallNumber.Text);
            context.SaveChanges();
            MessageBox.Show("Teachers updated");
            dataGrid.ItemsSource = context.TeachSet.ToList();
        }
    }
}

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
    /// Логика взаимодействия для Window5.xaml
    /// </summary>
    public partial class Window5 : Window
    {
        DataGrid dataGrid;
        public Window5(DataGrid dataGrid)
        {
            InitializeComponent();
            this.dataGrid = dataGrid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            using (EntityContext entityContext = new EntityContext())
            {
                Subjects subjects = new Subjects(tbNameSurname.Text, tbSubName.Text, Convert.ToInt32(tbLectureHallNumber.Text));
                entityContext.SubSet.Add(subjects);
                entityContext.SaveChanges();
                MessageBox.Show("Subject is added");
                dataGrid.ItemsSource = entityContext.TeachSet.ToList();
            }
        }
    }
}

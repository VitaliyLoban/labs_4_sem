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
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace lab_7
{
    /// <summary>
    /// Логика взаимодействия для Page4.xaml
    /// </summary>
    public partial class Page4 : Page
    {
        INFO inf = new INFO();
        public Page4()
        {

            InitializeComponent();
            INFO.connection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString);
            INFO.connection.Open();
            INFO.data = new SqlDataAdapter("select * from letor", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid2.ItemsSource = INFO.data_s.Tables[0].DefaultView;
            INFO.data = new SqlDataAdapter("select * from Discipline", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid1.ItemsSource = INFO.data_s.Tables[0].DefaultView;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string db_change = $"update Discipline set lector='{lect.Text}',name_disc='{disc.Text}',semestr={sem.Text},kyrs={kyrs.Text},spec='{spec.Text}'," +
                $"num_lect={num_lect.Text},num_labs={num_lab.Text},num_stud={num_stud.Text} where name_disc='{disc.Text}'";

            using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString))
            {
                thisConnection.Open();
                SqlCommand command = new SqlCommand(db_change, thisConnection);
                int number = command.ExecuteNonQuery();
                MessageBox.Show($"Изменено объектов: {number}");

            }
            INFO.data = new SqlDataAdapter("select * from Discipline", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid1.ItemsSource = INFO.data_s.Tables[0].DefaultView;
            INFO.data = new SqlDataAdapter("select * from letor", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid2.ItemsSource = INFO.data_s.Tables[0].DefaultView;
        }
    }
}

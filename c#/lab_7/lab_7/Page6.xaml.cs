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
    /// Логика взаимодействия для Page6.xaml
    /// </summary>
    public partial class Page6 : Page
    {
        INFO inf = new INFO();
        public static string sort_lect;
        public static string sort_disc;
        public Page6()
        {
            InitializeComponent();
            INFO.connection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString);
            INFO.connection.Open();
            INFO.data = new SqlDataAdapter("select * from letor", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid2.ItemsSource = INFO.data_s.Tables[0].DefaultView;
            INFO.data = new SqlDataAdapter("select * from Discipline ", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid1.ItemsSource = INFO.data_s.Tables[0].DefaultView;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            //using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString))
            //{
            //    thisConnection.Open();
            //    SqlCommand command = new SqlCommand(sort_disc, thisConnection);

            //}
            INFO.data = new SqlDataAdapter($"select * from Discipline order by {sort_disc}", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid1.ItemsSource = INFO.data_s.Tables[0].DefaultView;
            ////////
            INFO.data = new SqlDataAdapter($"select * from letor order by {sort_lect}", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid2.ItemsSource = INFO.data_s.Tables[0].DefaultView;
        }

        private void ComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            switch(disc_sort.SelectedIndex)
            {
                case 0: sort_disc= $"lector";
                    break;
                case 1:sort_disc= $"name_disc";
                    break;
                case 2:
                    sort_disc = $"semestr";
                    break;
                case 3:
                    sort_disc = $"kyrs";
                    break;
                case 4:
                    sort_disc = $"spec";
                    break;
                case 5:
                    sort_disc = $"num_lect";
                    break;
                case 6:
                    sort_disc = $"num_labs";
                    break;
                case 7:
                    sort_disc = $"num_stud";
                    break;

            }
        }

        private void lect_sort_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            switch(lect_sort.SelectedIndex)
            {
                case 0:sort_lect = "lector_name";
                    break;
                case 1:
                    sort_lect = "pulpit";
                    break;
                case 2:
                    sort_lect = "auditorium";
                    break;
            }
        }
    }
}

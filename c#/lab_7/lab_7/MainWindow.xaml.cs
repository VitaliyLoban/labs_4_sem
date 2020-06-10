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
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    /// 
    public class INFO
    {
        public static SqlConnection connection;
        public static SqlDataAdapter data;
        public static DataSet data_s;
    }
    public partial class MainWindow : Window
    {
        //Page1 page1 = new Page1();
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            //string db_add = $"INSERT INTO letor values('{lect.Text}','{pulpit.Text}',{Convert.ToInt32(audit.Text)})  "+
            //   $"INSERT INTO Discipline values('{lect.Text}','{namedisc.Text}',{Convert.ToInt32(sem.Text)},{Convert.ToInt32(kyrs.Text)},'{spec.Text}',{Convert.ToInt32(numlect.Text)},{Convert.ToInt32(numlab.Text)},{Convert.ToInt32(numstud.Text)})   ";
            //using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString))
            //{
            //    thisConnection.Open();
            //    SqlCommand command = new SqlCommand(db_add, thisConnection);    
            //    int number = command.ExecuteNonQuery();
            //    MessageBox.Show($"Добавлено объектов: {number}");

            //}
            //string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page1();
        }

        private void MenuItem_Click_1(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page2();
        }

        private void MenuItem_Click_2(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page3();
        }

        private void MenuItem_Click_3(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page4();
        }

        private void MenuItem_Click_4(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page4();
        }

        private void MenuItem_Click_5(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page6();
        }

        private void MenuItem_Click_6(object sender, RoutedEventArgs e)
        {
            frame1.Content = new Page6();
        }
    }
}

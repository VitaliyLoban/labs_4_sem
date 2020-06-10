using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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

namespace ado_net
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        List<Students> q = new List<Students>();
        //List<UriComponents.> l = new List<Uri>();



        string k = @"Data Source=klon\sqlexpress;Initial Catalog=ado_db;Integrated Security=True";
        public MainWindow()
        {
            InitializeComponent();
            //q.Add(new Students(new BitmapImage(new Uri(@"C:\Users\loban\Downloads\Jdbc\1.jpg")), "qwe"));
            //q.Add(new Students(new BitmapImage(new Uri(@"C:\Users\loban\Downloads\Jdbc\2.jpg")), "qwe"));
            //q.Add(new Students(new BitmapImage(new Uri(@"C:\Users\loban\Downloads\Jdbc\3.jpg")), "qwe"));
            //foreach (var x in q)
            //{
            //    l.Add(x.UriSource);
            //}

            //my.Source = q[1];
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(k))
            {
                con.Open();
                SqlCommand ad = new SqlCommand("Select * from Srud", con);
                SqlDataReader read = ad.ExecuteReader();

                while (read.Read())
                {
                    q.Add(new Students(new BitmapImage(new Uri($@"{read.GetValue(1)}")), $"{read.GetValue(0)}"));
                }
                dg.ItemsSource = q;



            }
        }
    }
}

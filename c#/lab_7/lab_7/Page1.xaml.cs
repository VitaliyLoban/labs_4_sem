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
    /// Логика взаимодействия для Page1.xaml
    /// </summary>
    public partial class Page1 : Page
    {
        INFO inf = new INFO();
        //DataGrid DataGrid1;
        //DataGrid DataGrid2;
        public Page1()
        {
            InitializeComponent();
            INFO.connection=new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString);
            INFO.connection.Open();
            INFO.data = new SqlDataAdapter("select * from letor", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid2.ItemsSource = INFO.data_s.Tables[0].DefaultView;
            INFO.data = new SqlDataAdapter("select * from Discipline", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid1.ItemsSource = INFO.data_s.Tables[0].DefaultView;
            //this.DataGrid1 = DataGrid1;
            //this.DataGrid2 = DataGrid2;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string db_add =$"INSERT INTO Discipline values('{lect.Text}','{namedisc.Text}',{Convert.ToInt32(sem.Text)},{Convert.ToInt32(kyrs.Text)},'{spec.Text}',{Convert.ToInt32(numlect.Text)},{Convert.ToInt32(numlab.Text)},{Convert.ToInt32(numstud.Text)})   ";
            using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString))
            {
                thisConnection.Open();
                SqlCommand command = new SqlCommand(db_add, thisConnection);
                int number = command.ExecuteNonQuery();
                MessageBox.Show($"Добавлено объектов: {number}");

            }
            INFO.data = new SqlDataAdapter("select * from Discipline", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid1.ItemsSource = INFO.data_s.Tables[0].DefaultView;
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            string db_add = $"INSERT INTO letor values('{lect1.Text}','{pulpit.Text}',{Convert.ToInt32(audit.Text)})  ";
            using (SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["conect"].ConnectionString))
            {
                thisConnection.Open();
                SqlCommand command = new SqlCommand(db_add, thisConnection);
                int number = command.ExecuteNonQuery();
                MessageBox.Show($"Добавлено объектов: {number}");

            }

            INFO.data = new SqlDataAdapter("select * from letor", INFO.connection);
            INFO.data_s = new DataSet();
            INFO.data.Fill(INFO.data_s);
            Datagrid2.ItemsSource = INFO.data_s.Tables[0].DefaultView;
        }

        private void lect_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (Int32.TryParse(e.Text, out val))
            {
                e.Handled = true; 
            }
        }

        private void namedisc_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void kyrs_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (!Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        //private void Label_PreviewTextInput(object sender, TextCompositionEventArgs e)
        //{
        //    int val;
        //    if (!Int32.TryParse(e.Text, out val))
        //    {
        //        e.Handled = true;
        //    }
        //}

        private void sem_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (!Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void spec_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void numlect_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (!Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void numlab_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (!Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void numstud_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (!Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void lect1_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void pulpit_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }

        private void audit_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int val;
            if (!Int32.TryParse(e.Text, out val))
            {
                e.Handled = true;
            }
        }
    }
}

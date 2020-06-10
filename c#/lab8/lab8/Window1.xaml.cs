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
using System.Data.Entity;

namespace lab8
{
    /// <summary>
    /// Логика взаимодействия для Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        List<Hostel> select = new List<Hostel>();
        Model1 db;
        int z;
        int p;
        public Window1()
        {
            InitializeComponent();
            db = new Model1();
            db.Student.Load();
            db.Hostels.Load();
            studentsDataGrid.DataContext = db.Student.ToList();
            hostelDataGrid.DataContext = db.Hostels.ToList();
            Page3.onStudentRequest += GetStudent;
            Page3.onLoad += load;
            Page1.onLoad += load;
            Page2.onLoad += load;
        }

        private void load()
        {
            studentsDataGrid.DataContext = db.Student.ToList();
            hostelDataGrid.DataContext = db.Hostels.ToList();
        }

        private void GetStudent()
        {
            try
            {
                if (studentsDataGrid.SelectedItems.Count < 1)
                {
                    throw new Exception("Select student");
                }
                else
                {
                    //Page3.MyStudet = (Students)studentsDataGrid.SelectedItem;
                    foreach (Students k in studentsDataGrid.SelectedItems)
                    {
                        z = k.Id;
                    }
                    Page3.MyStudet = db.Student.Find(z);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {

            System.Windows.Data.CollectionViewSource studentsViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("studentsViewSource")));
            // Загрузите данные, установив свойство CollectionViewSource.Source:
            // studentsViewSource.Source = [универсальный источник данных]
            System.Windows.Data.CollectionViewSource hostelViewSource = ((System.Windows.Data.CollectionViewSource)(this.FindResource("hostelViewSource")));
            // Загрузите данные, установив свойство CollectionViewSource.Source:
            // hostelViewSource.Source = [универсальный источник данных]
        }

        private void ad_st_Click(object sender, RoutedEventArgs e)
        {
            fr.Content = new Page1();
            studentsDataGrid.DataContext = db.Student.ToList();
            hostelDataGrid.DataContext = db.Hostels.ToList();
        }

        private void ad_host_Click(object sender, RoutedEventArgs e)
        {
            fr.Content = new Page2();
            studentsDataGrid.DataContext = db.Student.ToList();
            hostelDataGrid.DataContext = db.Hostels.ToList();
        }

        private void del_st_Click(object sender, RoutedEventArgs e)
        {
            if (studentsDataGrid.SelectedItems.Count < 1)
                return;
            foreach(Students k in studentsDataGrid.SelectedItems)
            {
                z = k.Id;
            }
            //int index = studentsDataGrid.SelectedIndex;//dataGridView1.SelectedRows[0].Index;
            Students st = db.Student.Find(z);
            db.Student.Remove(st);
            db.SaveChanges();
            MessageBox.Show("Student deleted");
            studentsDataGrid.DataContext = db.Student.ToList();
            hostelDataGrid.DataContext = db.Hostels.ToList();
        }

        private void del_host_Click(object sender, RoutedEventArgs e)
        {
            if (hostelDataGrid.SelectedItems.Count < 1)
                return;
            foreach (Hostel k in hostelDataGrid.SelectedItems)
            {
                p = k.Id;
            }
            Hostel st = db.Hostels.Find(p);
            db.Hostels.Remove(st);
            db.SaveChanges();
            MessageBox.Show("Hostel deleted");
            studentsDataGrid.DataContext = db.Student.ToList();
            hostelDataGrid.DataContext = db.Hostels.ToList();
        }

        private void ch_st_Click(object sender, RoutedEventArgs e)
        {
            //if (studentsDataGrid.SelectedItems.Count < 1)
            //    return;
            //foreach (Students k in studentsDataGrid.SelectedItems)
            //{
            //    z = k.Id;
            //}
            //Students st = db.Student.Find(z);
            Page3 pag = new Page3();
            fr.Content = pag;
            //pag.name.Text = st.Name;
            //pag.age.Text = st.Age.ToString();
            //pag.sname.Text = st.S_name;
            //pag.lis.SelectedItem = st.Hostels;

            
            //st.Name = pag.name.Text;
            //st.Age = Convert.ToInt32(pag.age.Text);
            //st.S_name = pag.sname.Text;
            //foreach (Hostel item in pag.lis.SelectedItems)
            //{
            //    select.Add(item);
            //}
            //st.Hostels = select;
            //db.Entry(st).State = EntityState.Modified;
            //db.SaveChanges();
            //MessageBox.Show("Информация обновлена");
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            var query = db.Student.OrderBy(u => u.Name);
            studentsDataGrid.DataContext = db.Student.ToList();

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            var query = db.Student.OrderByDescending(u => u.Name);
            studentsDataGrid.DataContext = db.Student.ToList();
        }
    }
}

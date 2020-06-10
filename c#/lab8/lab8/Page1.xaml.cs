using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Data.Entity;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace lab8
{
    /// <summary>
    /// Логика взаимодействия для Page1.xaml
    /// </summary>
    public partial class Page1 : Page
    {
        Model1 db;
        List<Hostel> select = new List<Hostel>();
        List<string> k = new List<string>();
        public Page1()
        {
            InitializeComponent();
            db = new Model1();

            List<Hostel> hostels = db.Hostels.ToList();
            //foreach(var a in hostels)
            //{
            //    k.Add(a.Name);
            //}
            lis.ItemsSource = hostels;
            lis.DisplayMemberPath = "Name";
            
        }
        public delegate void MethodContainer();
        public static event MethodContainer onLoad;
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            using (var trans = db.Database.BeginTransaction())
            {
                try
                {
                    Students stud = new Students();
                    stud.S_name = sname.Text;
                    stud.Name = name.Text;
                    stud.Age = Convert.ToInt32(age.Text);
                    //stud.Hostels = lis.SelectedItems.ToString();
                    select.Clear();
                    foreach (Hostel item in lis.SelectedItems)
                    {
                        select.Add(item);
                    }
                    stud.Hostels = select;
                    db.Student.Add(stud);
                    db.SaveChanges();
                    MessageBox.Show("Student added");
                    onLoad();
                    trans.Commit();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    trans.Rollback();
                }
            }
            
            //studentsDataGrid.DataContext = db.Student.ToList();
            //hostelDataGrid.DataContext = db.Hostels.ToList();
        }
    }
}

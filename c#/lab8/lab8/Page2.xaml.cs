﻿using System;
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

namespace lab8
{
    /// <summary>
    /// Логика взаимодействия для Page2.xaml
    /// </summary>
    public partial class Page2 : Page
    {
        Model1 db;
        public Page2()
        {
            InitializeComponent();
            db = new Model1();
        }
        public delegate void MethodContainer();
        public static event MethodContainer onLoad;
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Hostel hostel = new Hostel();
            hostel.Name = name_h.Text;
            hostel.Student = new List<Students>();
            db.Hostels.Add(hostel);
            db.SaveChanges();
            MessageBox.Show("Team added");
            onLoad();
            //studentsDataGrid.DataContext = db.Student.ToList();
            //hostelDataGrid.DataContext = db.Hostels.ToList();
        }
    }
}
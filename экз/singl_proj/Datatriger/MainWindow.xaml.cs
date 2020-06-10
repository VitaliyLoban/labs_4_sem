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

namespace Datatriger
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        //string MyVal ;
        public MainWindow()
        {
            InitializeComponent();
            // MyVal = "10";
            DataContext = new Good();
            
        }
        //public bool IsGood { get; set;  }

        private void kr2_TextChanged(object sender, TextChangedEventArgs e)
        {
            //int a = 0;
            //if(Int32.TryParse(kr2.Text, out a))
            //{
            //    if (a < 0)
            //        IsGood = false;
            //    else
            //        IsGood = true;
            //    DataContext = IsGood;
            //}
        }
    }
}

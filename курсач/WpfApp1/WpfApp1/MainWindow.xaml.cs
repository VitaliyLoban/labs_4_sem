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


using System.Text.RegularExpressions;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    /// 
   
    
    


    public partial class MainWindow : Window
    {
        bool isEnter=false;
    


        
        private void Window_PreviewDragOver(object sender, DragEventArgs e)
        {

        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
        
        
        private void register_click(object sender, RoutedEventArgs e)
        {
            
                MessageBox.Show("1");
        }

        private void signin_click(object sender, RoutedEventArgs e)
        {
            using (Model1 bd_us = new Model1())
            {
                foreach (User a in bd_us.User)
                {
                    if (login.Text == a.Login && pass.Password == a.Password.ToString())
                    {
                        isEnter = true;
                        MessageBox.Show("Welcome");
                        break;
                    }
                    
                }
                if (isEnter == false)
                    MessageBox.Show("uncorect");
            }
        }
    }
}

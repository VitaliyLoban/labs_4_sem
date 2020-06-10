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

namespace lab12
{
    /// <summary>
    /// Логика взаимодействия для Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        Random kr = new Random();
        public Window1()
        {
            InitializeComponent();
        }
        //public void Add(int figure, int count)
        //{
        //    switch (figure)
        //    {
        //        case 0:
        //            for (int i = 0; i < count; i++)
        //            {
        //                Rectangle k = new Rectangle();
        //                k.Width = 50;
        //                k.Height = 50;
        //                k.Stroke = Brushes.Black;
        //                k.VerticalAlignment = VerticalAlignment.Top;
        //                k.HorizontalAlignment = HorizontalAlignment.Left;
        //                k.Fill = Brushes.Blue;
        //                k.Margin = new Thickness(kr.Next(93,600), kr.Next(0, 300), 0,0 );
        //                gr.Children.Add(k);
        //            }break;
        //    }
        //}
        Shape z;
        void IsClick(object sender, RoutedEventArgs e)
        {
            z = sender as Shape;
        }
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            MainWindow klon = new MainWindow();
            if(klon.ShowDialog()==true&& klon.count.Text!=String.Empty)
            {
                Figure Blue = new Figure(new BlueFigure());
                Figure Green = new Figure(new GreenGigure());
                switch (klon.ch.SelectedIndex)
                {
                    case 0:
                        for(int i=0;i<Convert.ToInt32(klon.count.Text);i++ )
                        {
                            Rectangle qw = Blue.getSquary();
                            qw.Margin=new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            qw.MouseDown += IsClick;
                            gr.Children.Add(qw);
                            qw.Stroke = Brushes.Black;
                        }
                        break;
                    case 1:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            Rectangle qw = Green.getSquary();
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            qw.MouseDown += IsClick;
                            gr.Children.Add(qw);
                            qw.Stroke = Brushes.Black;
                        }
                        break;
                    case 2:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            Ellipse qw = Blue.getCircle();
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            qw.MouseDown += IsClick;
                            gr.Children.Add(qw);
                            qw.Stroke = Brushes.Black;
                        }
                        break;
                    case 3:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            Ellipse qw = Green.getCircle();
                            qw.MouseDown += IsClick;
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            gr.Children.Add(qw);
                            qw.Stroke = Brushes.Black;
                        }
                        break;

                }
            }
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Creator k = new Creator();
            ComplexObjBuild build = new GreenComObBuild();
            ComplexObject GrCom = k.complexObject(build);
            gr.Children.Add(build.SetCircle());
            gr.Children.Add(build.SetSquare());
            build = new BlueComObBuild();
            ComplexObject BlCom = k.complexObject(build);
            gr.Children.Add(build.SetCircle());
            gr.Children.Add(build.SetSquare());
        }
    }
}

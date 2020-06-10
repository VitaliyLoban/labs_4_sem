using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading;
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

namespace lab12
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    /// 
    public static class Count
    {
        public static int coun = 0;
    }
    public partial class MainWindow : Window
    {
        private static ICircle k;
        Random kr = new Random();
        private ShapeContext shapeContext;
        private Pult cc;
        private Caretaker taker;
        internal static ICircle K { get => k; set => k = value; }

        public MainWindow()
        {
            InitializeComponent();
            cc = new Pult();
            shapeContext = new ShapeContext(new RestState());
            taker = new Caretaker();
        }
        //private void SetElToClone(object sender, RoutedEventArgs e)
        //{

        //    K=this;
        //    //var z=k.Clone().GetCir();
        //    //z.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
        //    //gr.Children.Add(z);
        //}
        private void Button_Click(object sender, RoutedEventArgs e)
        {

            Add klon = new Add();
            if (klon.ShowDialog() == true && klon.count.Text != String.Empty)
            {
                IFigure grenFig = new GreenFact();
                IFigure blueFig = new BlueFact();
                switch (klon.ch.SelectedIndex)
                {
                    case 0:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            var qw = blueFig.CreateSq().GetSq();
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);

                            gr.Children.Add(qw);

                        }
                        break;
                    case 1:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            var qw = grenFig.CreateSq().GetSq();
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            gr.Children.Add(qw);
                        }
                        break;
                    case 2:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            var qw = blueFig.CreateCr().GetCir();
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            //qw.MouseDown += SetElToClone;
                            gr.Children.Add(qw);
                        }
                        break;
                    case 3:
                        for (int i = 0; i < Convert.ToInt32(klon.count.Text); i++)
                        {
                            var qw = grenFig.CreateCr().GetCir();
                            qw.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                            gr.Children.Add(qw);
                        }
                        break;

                }
            }
        }
        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            try
            {
                MessageBox.Show((Map.find(find.Text).NameOb).ToString());
            }
            catch (Exception ex)
            {
                MessageBox.Show("Данный элемент не найден");
            }
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Comander com = new Comander();
            if (f1.IsChecked.Value)
                gr.Children.Add(com.AddCir());
            if (f2.IsChecked.Value)
                gr.Children.Add(com.AddSqu());

        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            if (K is BlueCr)
            {
                var z=(K as BlueCr).Clone().GetCir();
                z.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
                gr.Children.Add(z);
            }
        }

        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            Singleton sq = Singleton.SingltonOn(gr);

        }

        private void Button_Click_5(object sender, RoutedEventArgs e)
        {
            //Ellipse z = K.Shape;
            //z.Margin=new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
            cirDecorator dec = new cirDecorator(k);
            
            var p = dec.Shape;
            p.Margin = new Thickness(kr.Next(93, 600), kr.Next(0, 300), 0, 0);
            gr.Children.Add(p);
        }

        private void Window_KeyDown(object sender, KeyEventArgs e)
        {
            switch (e.Key)
            {
                case Key.W:
                    {
                        cc.SetCommand(new MoveUpCommand(K));
                        break;
                    }
                case Key.A:
                    {
                        cc.SetCommand(new MoveLeftCommand(K));
                        break;
                    }
                case Key.D:
                    {
                        cc.SetCommand(new MoveRightCommand(K));
                        break;
                    }
                case Key.S:
                    {
                        cc.SetCommand(new MoveDownCommand(k));
                        break;
                    }
            }
            cc.PressButton();
            shapeContext.Request(K.Shape);
            BackgroundWorker worker = new BackgroundWorker();
            shapeContext.Request(K.Shape);
        }
        void SaveMemento()
        {
            taker.MementoState = CreateMemento();
        }
        MementoState CreateMemento()
        {
            return new MementoState(new Thickness(K.Shape.Margin.Left, K.Shape.Margin.Top, 0, 0));
        }

        private void Button_Click_6(object sender, RoutedEventArgs e)
        {
            if (K == null) return;
            SaveMemento();
        }

        private void Button_Click_7(object sender, RoutedEventArgs e)
        {
            if (taker.MementoState != null)
            {
                K.Shape.Margin = taker.MementoState.State;
            }
        }
    }
}

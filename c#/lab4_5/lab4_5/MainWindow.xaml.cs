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
using Microsoft.Win32;
using System.IO;
using System.Globalization;
using System.Text.RegularExpressions;

namespace lab4_5
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    
    public partial class MainWindow : Window
    {
        static int count = 0;
        string filepath;
        static int klk = 0;
        List<string> files = new List<string>();
        public MainWindow()
        {
            count++;
            InitializeComponent();

            App.LanguageChanged += LanguageChanged;

            CultureInfo currLang = App.Language;

            //Заполняем меню смены языка:
           // m_lang.Items.Clear();
            m_lang.SelectionChanged += ChangeLanguageClick;
            foreach (var lang in App.Languages)
            {
                ComboBoxItem menuLang = new ComboBoxItem();
                menuLang.Tag = lang;
                menuLang.Content = lang.DisplayName;
                m_lang.Items.Add(menuLang);
            }
        }

        private void LanguageChanged(Object sender, EventArgs e)
        {
            CultureInfo currLang = App.Language;
            

            //Отмечаем нужный пункт смены языка как выбранный язык
            foreach (ComboBoxItem i in m_lang.Items)
            {
                CultureInfo ci = i.Tag as CultureInfo;
            }
        }

        private void ChangeLanguageClick(Object sender, EventArgs e)
        {
            ComboBox mi = sender as ComboBox;
            if (mi != null)
            {
                ComboBoxItem lang = mi.SelectedItem as ComboBoxItem;
                CultureInfo lan = lang.Tag as CultureInfo;
                if (lang != null)
                {
                    App.Language = lan;
                }
            }

        }

        private void mytxt_TextChanged_1(object sender, TextChangedEventArgs e)
        {
            Regex ak = new Regex(@"\W+");
            string txt = new TextRange(mytxt.Document.ContentStart, mytxt.Document.ContentEnd).Text;          
            w_count.Content = ((ak.Matches(txt)).Count).ToString();
            s_count.Content = txt.Length - 2;
        }

        private void ToggleButton_Checked(object sender, RoutedEventArgs e)
        {
            //mytxt.FontStyle = FontStyles.Italic;

            mytxt.Selection.ApplyPropertyValue(TextElement.FontStyleProperty, FontStyles.Italic);
        }

        private void ToggleButton_Checked_1(object sender, RoutedEventArgs e)
        {
            //mytxt.FontWeight=FontWeights.Bold;
            
            mytxt.Selection.ApplyPropertyValue(TextElement.FontWeightProperty, FontWeights.Bold);
        }

        private void ToggleButton_Checked_2(object sender, RoutedEventArgs e)
        {
            
            //kkk.TextDecorations = TextDecorations.Underline;
            mytxt.Selection.ApplyPropertyValue(Inline.TextDecorationsProperty, TextDecorations.Underline);
        }

        private void ToggleButton_Unchecked(object sender, RoutedEventArgs e)
        {
            //mytxt.FontStyle = FontStyles.Normal;
            mytxt.Selection.ApplyPropertyValue(TextElement.FontStyleProperty, FontStyles.Normal);

        }

        private void ToggleButton_Unchecked_1(object sender, RoutedEventArgs e)
        {
           // mytxt.FontWeight = FontWeights.Normal;
            mytxt.Selection.ApplyPropertyValue(TextElement.FontWeightProperty, FontWeights.Normal);

        }

        private void ToggleButton_Unchecked_2(object sender, RoutedEventArgs e)
        {
            // kkk.TextDecorations = null;
            mytxt.Selection.ApplyPropertyValue(Inline.TextDecorationsProperty, null);

        }

        private void fontcolor_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            
            if (fontcolor.SelectedItem.ToString().Contains("Red") || fontcolor.SelectedItem.ToString().Contains("Красный"))
                mytxt.Selection.ApplyPropertyValue(TextElement.ForegroundProperty, Brushes.Red);
            if (fontcolor.SelectedItem.ToString().Contains("Yellow") || fontcolor.SelectedItem.ToString().Contains("Желтый"))
                mytxt.Selection.ApplyPropertyValue(TextElement.ForegroundProperty, Brushes.Yellow);
            if (fontcolor.SelectedItem.ToString().Contains("Black") || fontcolor.SelectedItem.ToString().Contains("Черный"))
                mytxt.Selection.ApplyPropertyValue(TextElement.ForegroundProperty, Brushes.Black);
            if (fontcolor.SelectedItem.ToString().Contains("Green") || fontcolor.SelectedItem.ToString().Contains("Зеленый"))
                mytxt.Selection.ApplyPropertyValue(TextElement.ForegroundProperty, Brushes.Green);


        }

      

        private void slider1_ValueChanged(object sender, RoutedPropertyChangedEventArgs<double> e)
        {
            if(mytxt!=null)
                mytxt.Selection.ApplyPropertyValue(TextElement.FontSizeProperty, wid.Value);
        }

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "Rich Text Format (*.rtf)|*.rtf|All files (*.*)|*.*";

            if (dlg.ShowDialog() == true)
            {
                if (files.Count<5)
                {
                    files.Add(dlg.FileName);
                }
                else
                {
                    files.RemoveAt(0);
                    files.Add(dlg.FileName);
                }
                //files.Add(dlg.FileName);
                
                sav.ItemsSource = null;
                sav.ItemsSource = files;
                FileStream fileStream = new FileStream(dlg.FileName, FileMode.Open);
                TextRange range = new TextRange(mytxt.Document.ContentStart, mytxt.Document.ContentEnd);
                range.Load(fileStream, DataFormats.Rtf);
            }
            filepath = dlg.FileName;
            this.Title = Title+"        " ;
            
        }

        private void dad(object sender, DragEventArgs e)
        {
            if(e.Data.GetDataPresent(DataFormats.FileDrop))
            {
                string[] files =(string[])e.Data.GetData(DataFormats.FileDrop);
                FileStream fileStream = new FileStream(files[0], FileMode.Open);
                TextRange range = new TextRange(mytxt.Document.ContentStart, mytxt.Document.ContentEnd);
                range.Save(fileStream, DataFormats.Rtf);
                fileStream.Close();

            }
        }

        private void MenuItem_Click_1(object sender, RoutedEventArgs e)
        {
            SaveFileDialog dlg = new SaveFileDialog();
            dlg.Filter = "Rich Text Format (*.rtf)|*.rtf|All files (*.*)|*.*";
            if (dlg.ShowDialog() == true)
            {
                FileStream fileStream = new FileStream(dlg.FileName, FileMode.Create);
                TextRange range = new TextRange(mytxt.Document.ContentStart, mytxt.Document.ContentEnd);
                range.Save(fileStream, DataFormats.Rtf);
            }
        }

        private void MenuItem_Click_2(object sender, RoutedEventArgs e)
        {
            
            MainWindow k = new MainWindow();
            k.Title = "window " + count;
            k.Show();
        }

        private void m_lang_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void font_chng(object sender, SelectionChangedEventArgs e)
        {
            
            //mytxt.CaretPosition.Parent
            mytxt.Selection.ApplyPropertyValue(Inline.FontFamilyProperty, font.SelectedItem);
            
        }

        private void mytxt_SelectionChanged(object sender, RoutedEventArgs e)
        {
            if (!mytxt.Selection.IsEmpty)
            {
                if ((mytxt.Selection.GetPropertyValue(Run.FontWeightProperty) is FontWeight))
                {
                    bol.IsChecked = (((FontWeight)
                    mytxt.Selection.GetPropertyValue(Run.FontWeightProperty))== FontWeights.Bold);
                }
                if ((mytxt.Selection.GetPropertyValue(Run.FontStyleProperty) is FontStyle))
                {
                    ital.IsChecked = (((FontStyle)
                    mytxt.Selection.GetPropertyValue(Run.FontStyleProperty))
                    == FontStyles.Italic);
                }
                if ((mytxt.Selection.GetPropertyValue(Run.TextDecorationsProperty) is TextDecorationCollection))
                {
                    und.IsChecked = (((TextDecorationCollection)
                    mytxt.Selection.GetPropertyValue(Run.TextDecorationsProperty))
                    == TextDecorations.Underline);
                }
                if ((mytxt.Selection.GetPropertyValue(Run.FontFamilyProperty) is FontFamily))
                {
                    font.SelectedItem = (FontFamily)mytxt.Selection.GetPropertyValue(Run.FontFamilyProperty);
                }
                if ((mytxt.Selection.GetPropertyValue(Run.FontSizeProperty) is double))
                {
                    wid.Value = (double)mytxt.Selection.GetPropertyValue(Run.FontSizeProperty);
                }
                if ((mytxt.Selection.GetPropertyValue(Run.ForegroundProperty) is Brush))
                {
                    string color = ((Brush)mytxt.Selection.GetPropertyValue(Run.ForegroundProperty)).ToString();
                    switch (color)
                    {
                        case "#FFFFFF00": fontcolor.SelectedIndex = 0; break;
                        case "#FF000000": fontcolor.SelectedIndex = 1; break;
                        case "#FFFF0000": fontcolor.SelectedIndex = 2; break;
                        case "#FF008000": fontcolor.SelectedIndex = 3; break;
                    }
                }
           
            }
        }

        private void tem_changed(object sender, SelectionChangedEventArgs e)
        {
            
            switch (tem.SelectedIndex)
            {
                case  0:
                    this.Resources = new ResourceDictionary() { Source = new Uri("Resources/Dictionary3.xaml",UriKind.Relative) };
                    break;
                case 1:
                    this.Resources = new ResourceDictionary() { Source = new Uri("Resources/Dictionary2.xaml", UriKind.Relative) };
                    break;
                case 2:
                    this.Resources = new ResourceDictionary() { Source = new Uri("Resources/Dictionary1.xaml", UriKind.Relative) };
                    break;

            }
        }

        private void sav_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (sav.SelectedIndex == 0)
            {
                MainWindow k = new MainWindow();
                k.Title = "window " + count;
                FileStream fileStream = new FileStream(files[0], FileMode.Open);
                TextRange range = new TextRange(k.mytxt.Document.ContentStart, k.mytxt.Document.ContentEnd);
                range.Load(fileStream, DataFormats.Rtf);
                k.Show();
            }
            if (sav.SelectedIndex == 1)
            {
                MainWindow k = new MainWindow();
                k.Title = "window " + count;
                FileStream fileStream = new FileStream(files[1], FileMode.Open);
                TextRange range = new TextRange(k.mytxt.Document.ContentStart, k.mytxt.Document.ContentEnd);
                range.Load(fileStream, DataFormats.Rtf);
                k.Show();
            }
            if (sav.SelectedIndex == 2)
            {
                MainWindow k = new MainWindow();
                k.Title = "window " + count;
                FileStream fileStream = new FileStream(files[2], FileMode.Open);
                TextRange range = new TextRange(k.mytxt.Document.ContentStart, k.mytxt.Document.ContentEnd);
                range.Load(fileStream, DataFormats.Rtf);
                k.Show();
            }
            if (sav.SelectedIndex == 3)
            {
                MainWindow k = new MainWindow();
                k.Title = "window " + count;
                FileStream fileStream = new FileStream(files[3], FileMode.Open);
                TextRange range = new TextRange(k.mytxt.Document.ContentStart, k.mytxt.Document.ContentEnd);
                range.Load(fileStream, DataFormats.Rtf);
                k.Show();
            }
            if (sav.SelectedIndex == 4)
            {
                MainWindow k = new MainWindow();
                k.Title = "window " + count;
                
                FileStream fileStream = new FileStream(files[4], FileMode.Open);
                TextRange range = new TextRange(k.mytxt.Document.ContentStart, k.mytxt.Document.ContentEnd);
                range.Load(fileStream, DataFormats.Rtf);
                k.Show();
            }

        }

        private void Window_Closed(object sender, EventArgs e)
        {
            count--;
        }
    }
}

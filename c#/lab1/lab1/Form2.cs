using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace lab1
{
    public partial class Form2 : Form
    {
        List<string> list = new List<string>();
        Random rnd = new Random();
        public Form2()
        {
            
            InitializeComponent();
        }

        public void button5_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox1.Clear();
                list.Clear();
                int i = 0;
                string z = "Student № ";
                while (i < Convert.ToInt32(textBox1.Text))
                {
                    list.Add(z + rnd.Next(10, 100) + "\n");
                    i++;
                }
                foreach (var a in list)
                {
                    richTextBox1.Text += a;
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }
        }

        public void button1_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Clear();
                var k = list.OrderBy(s => s);
                foreach (var a in k)
                {
                    richTextBox2.Text += a;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Clear();
                var k = list.OrderByDescending(s => s);
                foreach (var a in k)
                {
                    richTextBox2.Text += a;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }

        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Clear();
                var k = list.Max(s => s);
                richTextBox2.Text = k;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }

        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Clear();
                var k = list.Min(s => s);
                richTextBox2.Text = k;
            } 
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Clear();
                var k = list.First();
                richTextBox2.Text = k;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            try
            {
                richTextBox2.Clear();
                var k = list.Last();
                richTextBox2.Text = k;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex);
            }
            finally
            {

            }
        }

        private void toolTip1_Popup(object sender, PopupEventArgs e)
        {
            
        }
    }
}

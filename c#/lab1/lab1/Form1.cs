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
    public partial class Form1 : Form
    {
        public string s;
        public Form1()
        {
            InitializeComponent();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            label4.Text = "+";
        }

        private void button8_Click(object sender, EventArgs e)
        {
            label4.Text = "-";
        }

        private void button9_Click(object sender, EventArgs e)
        {
            label4.Text = "*";
        }

        private void button10_Click(object sender, EventArgs e)
        {
            label4.Text = "/";
        }

        private void button11_Click(object sender, EventArgs e)
        {
            label4.Text = "^";
        }

        public void button12_Click(object sender, EventArgs e)
        {
                s = textBox6.Text;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            double z=0;
            try
            {
                if (label4.Text == "+")
                    z = Convert.ToInt32(textBox4.Text) + Convert.ToInt32(textBox5.Text);
                if (label4.Text == "-")
                    z = Convert.ToInt32(textBox4.Text) - Convert.ToInt32(textBox5.Text);
                if (label4.Text == "*")
                    z = Convert.ToInt32(textBox4.Text) * Convert.ToInt32(textBox5.Text);
                if (label4.Text == "/")
                    z = Convert.ToInt32(textBox4.Text) / Convert.ToInt32(textBox5.Text);
                if (label4.Text == "^")
                    z = Math.Pow(Convert.ToInt32(textBox4.Text), Convert.ToInt32(textBox5.Text));
                textBox6.Text = Convert.ToString(z);
            }
            catch(Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message);
            }
            finally
            {
                
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            textBox4.Text = s;
        }


    }
}

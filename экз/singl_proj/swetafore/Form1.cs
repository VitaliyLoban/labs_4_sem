using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace swetafore
{
    public partial class Form1 : Form
    {
        int ticks = 0;
        public Form1()
        {
            InitializeComponent();
            timer1.Start();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            switch (ticks % 3)
            {
                case 0:
                    button1.BackColor = Color.Red;
                    button2.BackColor = Color.White;
                    button3.BackColor = Color.White;
                    break;
                case 1:
                    button1.BackColor = Color.White;
                    button2.BackColor = Color.Yellow;
                    button3.BackColor = Color.White;
                    break;
                case 2:
                    button1.BackColor = Color.White;
                    button2.BackColor = Color.White;
                    button3.BackColor = Color.Green;
                    break;
            }
            ticks++;
        }


        private void button1_Click(object sender, EventArgs e)
        {

        }
    }
}


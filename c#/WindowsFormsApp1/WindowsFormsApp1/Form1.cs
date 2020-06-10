using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.Windows.Forms;
using System.IO;

namespace WindowsFormsApp1
{
    [Serializable]
    public partial class Form1 : Form
    {
        bool isGood = false;
        List<Discipline> mylist = new List<Discipline>();
        public Discipline di;
        public Form1()
        {
            InitializeComponent();
        }

        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void progressBar1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                isGood = true;
                di = new Discipline()
                {
                    name = textBox1.Text,
                    semester = Convert.ToInt32(textBox2.Text),
                    kyrs = trackBar1.Value,
                    specialization = textBox4.Text,
                    numberOfLections = Convert.ToInt32(textBox5.Text),
                    numberOflabs = Convert.ToInt32(textBox6.Text),
                    typeOfControls = textBox9.Text,
                    numberOfStudents = Convert.ToInt32(textBox8.Text),

                    lector = new lector()
                    {
                        kafedra = textBox7.Text,
                        FullName = textBox11.Text,
                        clas = Convert.ToInt32(textBox10.Text),
                    },
                    litlist = new litlist()
                    {
                        name = textBox12.Text,
                        author = textBox14.Text,
                        year = Convert.ToInt32(numericUpDown1.Value),
                    }
                };

                mylist.Add(di);
                richTextBox1.Text = di.ToString();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {

            try
            {
                if (isGood==false)
                    MessageBox.Show("Сперва добавте информацию");
                else
                {
                    XmlSerializer formater = new XmlSerializer(typeof(List<Discipline>));
                    using (FileStream fs = new FileStream("discipline.xml", FileMode.Create))
                    {
                        formater.Serialize(fs, mylist);
                    }
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline>newDiscipline = (List<Discipline>)formatter.Deserialize(fs);

                foreach (var i in newDiscipline)
                {
                    listBox1.Items.Add(i.ToString());
                }


            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
        }

        private void trackBar1_MouseUp(object sender, MouseEventArgs e)
        {
            label15.Text = Convert.ToString(trackBar1.Value);
        }

#region проверка вводы цифровых значений
        private void textBox2_KeyPress(object sender, KeyPressEventArgs e)
        {
            if(char.IsDigit(e.KeyChar))           
                return;
            else
                e.Handled = true;
           
        }

        private void textBox5_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (char.IsDigit(e.KeyChar))
                return;
            else
                e.Handled = true;
        }

        private void textBox6_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (char.IsDigit(e.KeyChar))
                return;
            else
                e.Handled = true;
        }

        private void textBox8_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (char.IsDigit(e.KeyChar))
                return;
            else
                e.Handled = true;
        }

        private void textBox10_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (char.IsDigit(e.KeyChar))
                return;
            else
                e.Handled = true;
        }

       #endregion

#region проверка на пустую строку



        private void textBox1_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox1.Text))
            {
                errorProvider1.SetError(textBox1, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox2_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox2.Text))
            {
                errorProvider1.SetError(textBox2, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox4_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox4.Text))
            {
                errorProvider1.SetError(textBox4, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox5_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox5.Text))
            {
                errorProvider1.SetError(textBox5, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox6_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox6.Text))
            {
                errorProvider1.SetError(textBox6, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox9_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox9_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox9.Text))
            {
                errorProvider1.SetError(textBox9, "заполните строку");
            }
        }

        private void textBox8_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox8.Text))
            {
                errorProvider1.SetError(textBox8, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox12_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox12.Text))
            {
                errorProvider1.SetError(textBox12, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox14_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox14.Text))
            {
                errorProvider1.SetError(textBox14, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox7_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox7.Text))
            {
                errorProvider1.SetError(textBox7, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox11_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox11.Text))
            {
                errorProvider1.SetError(textBox11, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox10_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(textBox10.Text))
            {
                errorProvider1.SetError(textBox10, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }
        #endregion

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }
    }
}

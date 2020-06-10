using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Windows.Forms;
using System.Xml.Serialization;
using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

namespace WindowsFormsApp1
{
    [Serializable]
    public partial class Form1 : Form
    {

        bool isGood = false;
        List<Discipline> mylist = new List<Discipline>();
        public Discipline di;
        Timer timer;
        
         
        public Form1()
        {
            InitializeComponent();

            timer = new Timer() { Interval = 1000 };
            timer.Tick += timer1_Tick;
            timer.Start();
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
                var result = new List<ValidationResult>();
                var context = new ValidationContext(di);
                if(!Validator.TryValidateObject(di,context,result,true))
                {
                    foreach(var error in result)
                    {
                        throw new Exception(error.ErrorMessage);
                    }
                }

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

                //newDiscipline.Find(x => x.lector.FullName == "");

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
            Regex reg = new Regex(@"\d+", RegexOptions.IgnoreCase);
            if (reg.IsMatch(textBox1.Text))
            {
                errorProvider1.SetError(textBox1, "Неверный формaт");
            }
            else if (string.IsNullOrEmpty(textBox1.Text))
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
            Regex reg = new Regex(@"\d+", RegexOptions.IgnoreCase);
            if (reg.IsMatch(textBox4.Text))
            {
                errorProvider1.SetError(textBox4, "Неверный формaт");
            }
            else if (string.IsNullOrEmpty(textBox4.Text))
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
            Regex reg = new Regex(@"\d+", RegexOptions.IgnoreCase);
            if (reg.IsMatch(textBox12.Text))
            {
                errorProvider1.SetError(textBox12, "Неверный формaт");
            }
            if (string.IsNullOrEmpty(textBox12.Text))
            {
                errorProvider1.SetError(textBox12, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox14_Validating(object sender, CancelEventArgs e)
        {
            Regex reg = new Regex(@"\d+", RegexOptions.IgnoreCase);
            if(reg.IsMatch(textBox14.Text))
            {
                errorProvider1.SetError(textBox14, "Неверный формaт");
            }
            else if (string.IsNullOrEmpty(textBox14.Text))
            {
                errorProvider1.SetError(textBox14, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox7_Validating(object sender, CancelEventArgs e)
        {
            Regex reg = new Regex(@"\d+", RegexOptions.IgnoreCase);
            if (reg.IsMatch(textBox7.Text))
            {
                errorProvider1.SetError(textBox7, "Неверный формaт");
            }
            else if (string.IsNullOrEmpty(textBox7.Text))
            {
                errorProvider1.SetError(textBox7, "заполните строку");
            }
            else
                errorProvider1.Clear();
        }

        private void textBox11_Validating(object sender, CancelEventArgs e)
        {
            Regex reg = new Regex(@"\d+", RegexOptions.IgnoreCase);
            if (reg.IsMatch(textBox11.Text))
            {
                errorProvider1.SetError(textBox11, "Неверный формaт");
            }
            else if (string.IsNullOrEmpty(textBox11.Text))
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



        private void ЛекторуToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            Form2 qqq = new Form2();
            qqq.Show();
        }

        private void семеструToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form3 z = new Form3();
            z.Show();

        }

        private void курсуToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form4 z = new Form4();
            z.Show();
        }

        private void нескоькоКритериевToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form5 z = new Form5();
            z.Show();
        }

        private void количествуЛекцийToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form6 z = new Form6();
            z.Show();
        }

        private void видуКонтроляToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form7 z = new Form7();
            z.Show();
        }

        private void сохранитьToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Сохранение происходит автоматически(при закрытии вкладок)");
        }

        private void оПрограммеToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Версия проекта: 7.09 reborn\nРазработчик: Лобан В.С.");
        }

        private void toolStripLabel1_Click(object sender, EventArgs e)
        {
            Form5 qq = new Form5();
            qq.Show();
        }

        private void toolStripLabel2_Click(object sender, EventArgs e)
        {
            Form6 qq = new Form6();
            qq.Show();
        }

        private void toolStripLabel3_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
        }

        private void toolStripLabel4_Click(object sender, EventArgs e)
        {
            mylist.Clear();
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            kkk.Text = DateTime.Now.ToLongTimeString();
            kkk1.Text= DateTime.Now.ToLongDateString();
            kkk3.Text = Convert.ToString(mylist.Count);
        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Text.RegularExpressions;
using System.Xml.Serialization;

namespace WindowsFormsApp1
{
    public partial class Form3 : Form
    {
        List<Discipline> mylist1 = new List<Discipline>();
        List<Discipline> mylist2 = new List<Discipline>();
        List<Discipline> mylist = new List<Discipline>();
        public Form3()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            richTextBox1.Clear();
            mylist1.Clear();
            string k = textBox1.Text;
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);
                foreach (Discipline a in newDiscipline)
                {
                    if (a.semester == Convert.ToInt32(k))
                        mylist1.Add(a);
                }
                foreach (var a in mylist1)
                {
                    richTextBox1.Text += a.ToString();
                }

            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (char.IsDigit(e.KeyChar))
                return;
            else
                e.Handled = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            richTextBox2.Clear();
            mylist2.Clear();
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);
                Regex reg = new Regex(@"[2-4]", RegexOptions.IgnoreCase);
                foreach (var q in newDiscipline)
                {
                    if (reg.IsMatch(Convert.ToString(q.semester)))
                        mylist2.Add(q);
                }
                foreach (var aq in mylist2)
                {
                    richTextBox2.Text += aq.ToString();
                }
            }
        }

        private void Form3_FormClosing(object sender, FormClosingEventArgs e)
        {
            foreach (var a in mylist1)
                mylist.Add(a);
            foreach (var a in mylist2)
                mylist.Add(a);
            XmlSerializer formater = new XmlSerializer(typeof(List<Discipline>));
            using (FileStream fs = new FileStream("E:\\Information\\semestrFound.xml", FileMode.Create))
            {
                formater.Serialize(fs, mylist);
            }
        }
    }
}

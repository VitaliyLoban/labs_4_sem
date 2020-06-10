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
    public partial class Form2 : Form
    {
        List<Discipline> mylist = new List<Discipline>();
        List<Discipline> mylist1 = new List<Discipline>();
        List<Discipline> mylist2 = new List<Discipline>();
        List<Discipline> mylist3 = new List<Discipline>();
        public Form2()
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
                    if (a.lector.FullName == k)
                        mylist1.Add(a);
                }
                foreach(var a in mylist1)
                {
                    richTextBox1.Text += a.ToString();
                }

            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            richTextBox2.Clear();
            mylist2.Clear();
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);
                Regex reg = new Regex(@"\w*А\.С\.\w*",RegexOptions.IgnoreCase);
                foreach(var q in newDiscipline)
                {
                    if (reg.IsMatch(q.lector.FullName))
                        mylist2.Add(q);
                }
                foreach (var aq in mylist2)
                {
                    richTextBox2.Text += aq.ToString();
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            richTextBox3.Clear();
            mylist3.Clear();
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);
                Regex reg = new Regex(@"^\w{4}\s", RegexOptions.IgnoreCase);
                foreach (var q in newDiscipline)
                {
                    if (reg.IsMatch(q.lector.FullName))
                        mylist3.Add(q);
                }
                foreach (var aq in mylist3)
                {
                    richTextBox3.Text += aq.ToString();
                }
            }

        }

        private void Form2_FormClosing(object sender, FormClosingEventArgs e)
        {
            foreach (var a in mylist1)
                mylist.Add(a);
            foreach (var a in mylist2)
                mylist.Add(a);
            foreach (var a in mylist3)
                mylist.Add(a);
            XmlSerializer formater = new XmlSerializer(typeof(List<Discipline>));
            using (FileStream fs = new FileStream("E:\\Information\\lectorFound.xml", FileMode.Create))
            {
                formater.Serialize(fs, mylist);
            }
        }
    }
}

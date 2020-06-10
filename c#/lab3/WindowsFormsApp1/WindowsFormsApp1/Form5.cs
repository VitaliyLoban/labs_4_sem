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
    public partial class Form5 : Form
    {
        List<Discipline> mylist1 = new List<Discipline>();
        List<Discipline> mylist2 = new List<Discipline>();
        List<Discipline> mylist3 = new List<Discipline>();
        public Form5()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            bool t1, t2, t3;
            richTextBox1.Clear();
            mylist1.Clear();
            mylist2.Clear();
            mylist3.Clear();
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);
                if (textBox1.Text.Equals("") == true)
                {
                    t1 = false;
                    foreach (var a in newDiscipline)
                        mylist1.Add(a);
                }
                else
                {
                    t1 = true;
                    Regex reg = new Regex(@"[" + textBox1.Text + "]", RegexOptions.IgnoreCase);
                    foreach (var q in newDiscipline)
                    {
                        if (reg.IsMatch(Convert.ToString(q.kyrs)))
                            mylist1.Add(q);
                    }
                }
                if (textBox2.Text.Equals("") == true)
                {
                    t2 = false;
                    foreach (var a in mylist1)
                        mylist2.Add(a);
                }
                else
                {
                    t2 = true;
                    Regex reg1 = new Regex(@"[" + textBox2.Text + "]", RegexOptions.IgnoreCase);
                    foreach (var q in mylist1)
                    {
                        if (reg1.IsMatch(Convert.ToString(q.semester)))
                            mylist2.Add(q);
                    }
                }
                if (textBox3.Text.Equals("") == true)
                {
                    t3 = false;
                    foreach (var a in mylist2)
                        mylist3.Add(a);
                }
                else
                {
                    t3 = true;
                    Regex reg2 = new Regex(@textBox3.Text, RegexOptions.IgnoreCase);
                    foreach (var q in mylist2)
                    {
                        if (reg2.IsMatch(q.specialization))
                            mylist3.Add(q);
                    }
                }
                if(t1==false && t2==false &&t3==false)
                {
                    richTextBox1.Text = "Поиск не дал результатов";
                }
                else
                {
                    foreach (var a in mylist3)
                        richTextBox1.Text += a.ToString();
                }
                if (mylist3.Count == 0)
                    richTextBox1.Text = "Поиск не дал результатов";
            }

        }

        private void Form5_FormClosing(object sender, FormClosingEventArgs e)
        {
            XmlSerializer formater = new XmlSerializer(typeof(List<Discipline>));
            using (FileStream fs = new FileStream("E:\\Information\\massFound.xml", FileMode.Create))
            {
                formater.Serialize(fs, mylist3);
            }
        }
    }
}

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
    public partial class Form4 : Form
    {

        List<Discipline> mylist1 = new List<Discipline>();
        List<Discipline> mylist2 = new List<Discipline>();
        List<Discipline> mylist3 = new List<Discipline>();
        public Form4()
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
                Regex reg = new Regex(@"["+k+"]", RegexOptions.IgnoreCase);
                foreach (var q in newDiscipline)
                {
                    if (reg.IsMatch(Convert.ToString(q.kyrs)))
                        mylist1.Add(q);
                }
                foreach (var aq in mylist1)
                {
                    richTextBox1.Text += aq.ToString();
                }
            }
        }

        private void Form4_FormClosing(object sender, FormClosingEventArgs e)
        {
            XmlSerializer formater = new XmlSerializer(typeof(List<Discipline>));
            using (FileStream fs = new FileStream("E:\\Information\\kyrsFound.xml", FileMode.Create))
            {
                formater.Serialize(fs, mylist1);
            }
        }
    }
}

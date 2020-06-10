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
    public partial class Form6 : Form
    {
        List<Discipline> mylist = new List<Discipline>();
        public Form6()
        {
            InitializeComponent();
        }

        private void Form6_Load(object sender, EventArgs e)
        {
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);

                var mylista = newDiscipline.OrderBy(t => t.numberOfLections);
                foreach (var a in mylista)
                    mylist.Add(a);
                foreach(var a in mylist )
                    richTextBox1.Text += a.ToString();
            }

        }

        private void Form6_FormClosing(object sender, FormClosingEventArgs e)
        {
            XmlSerializer formater = new XmlSerializer(typeof(List<Discipline>));
            using (FileStream fs = new FileStream("E:\\Information\\numOfLections.xml", FileMode.Create))
            {
                formater.Serialize(fs, mylist);
            }
        }
    }
}

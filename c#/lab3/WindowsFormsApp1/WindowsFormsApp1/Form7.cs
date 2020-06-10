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
    public partial class Form7 : Form
    {
        List<Discipline> mylist1 = new List<Discipline>();
        public Form7()
        {
            InitializeComponent();
        }

        private void Form7_Load(object sender, EventArgs e)
        {
            using (FileStream fs = new FileStream("discipline.xml", FileMode.Open))
            {
                XmlSerializer formatter = new XmlSerializer(typeof(List<Discipline>));
                List<Discipline> newDiscipline = (List<Discipline>)formatter.Deserialize(fs);

                var mylista = newDiscipline.OrderByDescending(t => t.typeOfControls);
                foreach (var a in mylista)
                    mylist1.Add(a);
                foreach(var a in mylist1)                    
                    richTextBox1.Text += a.ToString();
            }
        }

        private void Form7_FormClosing(object sender, FormClosingEventArgs e)
        {
            XmlSerializer formater1 = new XmlSerializer(typeof(List<Discipline>));
            using (FileStream ofs = new FileStream("E:\\Information\\typeOfControl.xml", FileMode.Create))
            {
                formater1.Serialize(ofs, mylist1);
            }
        }
    }
}

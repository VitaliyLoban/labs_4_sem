using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1
{
    
    public class litlist
    {
        public string name { get; set; }
        public string author { get; set; }
        public int year { get; set; }


        public litlist()
        {

        }

        public litlist(string name, string author, int year)
        {
            this.name = name;
            this.author = author;
            this.year = year;
        }

    }
}

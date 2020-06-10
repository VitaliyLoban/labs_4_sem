using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApp1
{
    
    public class lector
    {
        public string kafedra { get; set; }
        public string FullName { get; set; }
        public  int clas { get; set; }

        public lector(string kafedra, string fullName, int clas)
        {
            this.kafedra = kafedra;
            FullName = fullName;
            this.clas = clas;
        }
        public lector()
        {

        }


        
    }
}

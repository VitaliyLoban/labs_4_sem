using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.ComponentModel.DataAnnotations;

namespace WindowsFormsApp1
{
    
    public class Discipline
    {
        [Required]
        [RegularExpression(@"\w+",ErrorMessage ="Неверный формат")]
        public string name { get; set; }
        public int semester { get; set; }
        public int kyrs { get; set; }
        public string specialization { get; set; }
        public int numberOfLections { get; set; }
        public int numberOflabs { get; set; }
        public string typeOfControls { get; set; }
        public int numberOfStudents { get; set; }
        public litlist litlist;
        public lector lector;


        public Discipline()
        {

        }

        public Discipline(string name, int semester, int kyrs, string specialization, int numberOfLections, int numberOflabs, string typeOfControls, int numberOfStudents, litlist litlist, lector lector)
        {
            this.name = name;
            this.semester = semester;
            this.kyrs = kyrs;
            this.specialization = specialization;
            this.numberOfLections = numberOfLections;
            this.numberOflabs = numberOflabs;
            this.typeOfControls = typeOfControls;
            this.numberOfStudents = numberOfStudents;
            this.litlist = litlist;
            this.lector = lector;
        }

        public override string ToString()
        {
            return "Имя дисциплины:  "+this.name+" \n" +"семестр :"+ this.semester + " \n" + "курс :" + this.kyrs + " \n" + "специальность :" + this.specialization
                + " \n" + "кол-во лекций :" + this.numberOfLections + " \n" + "кол-во лаб :" + this.numberOflabs + " \n" + "тип контроля :" + this.typeOfControls + " \n" + "кол-во студентов :" + this.numberOfStudents
                + " \n" + "кафедра :" + this.lector.kafedra + " \n" + "ФИО :" + this.lector.FullName + " \n" + "Кабинет :" + this.lector.clas + " \n" + "Название :" + this.litlist.name
                + " \n" + "Авор :" + this.litlist.author + " \n" + "Год издания :" + this.litlist.year+" \n\n";
        }






    }
}

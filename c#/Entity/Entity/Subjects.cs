namespace Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Subjects
    {
        public Subjects()
        {
        }

        public Subjects(string name, string dayName, int lectureHallNumber)
        {
            this.name = name;
            this.dayName = dayName;
            this.lectureHallNumber = lectureHallNumber;
        }

        [Key]
        [StringLength(25)]
        public string name { get; set; }

        [Required]
        public string dayName { get; set; }

        public int lectureHallNumber { get; set; }
    }
}

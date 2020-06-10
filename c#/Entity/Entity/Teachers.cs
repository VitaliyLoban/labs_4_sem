namespace Entity
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Teachers
    {
        public Teachers()
        {
        }

        public Teachers(string nameSurname, string subject, int lectureCount, int studentCount)
        {
            this.nameSurname = nameSurname;
            this.subject = subject;
            this.lectureCount = lectureCount;
            this.studentCount = studentCount;
        }

        [Required]
        public string nameSurname { get; set; }

        [Key]
        [StringLength(25)]
        public string subject { get; set; }

        public int lectureCount { get; set; }

        public int studentCount { get; set; }
    }
}

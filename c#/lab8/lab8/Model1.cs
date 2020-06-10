namespace lab8
{
    using System;
    using System.Data.Entity;
    using System.Linq;

    public class Model1 : DbContext
    {
        public Model1() : base("name=Model1")
        { }
        public DbSet<Hostel> Hostels{ get; set; }
        public DbSet<Students> Student { get; set; }

    }

}
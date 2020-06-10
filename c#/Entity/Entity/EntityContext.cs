using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;

namespace Entity
{
    public class EntityContext : DbContext
    {
        public EntityContext() : base("Subjects")
        {
        }
        private DbSet<Subjects> subSet;
        private DbSet<Teachers> teachSet;
        public DbSet<Subjects> SubSet { get => subSet; set => subSet = value; }
        public DbSet<Teachers> TeachSet { get => teachSet; set => teachSet = value; }
        public interface IRepository<T> where T  :  class
        {
        IEnumerable<T> GetAll();
        T Get(int id);
        void Create(T item);
        void Update(T item);
        void Delete(int id);
        }
}
}

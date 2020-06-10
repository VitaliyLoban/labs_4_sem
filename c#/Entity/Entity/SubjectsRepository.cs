using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class SubjectsRepository : EntityContext.IRepository<Subjects>
    {
        private EntityContext entityContext;
        public SubjectsRepository(EntityContext context)
        {
            this.entityContext = context;
        }
        public IEnumerable<Subjects> GetAll()
        {
            return entityContext.SubSet;
        }
        public Subjects Get(int id)
        {
            return entityContext.SubSet.Find(id);
        }
        public void Create(Subjects subject)
        {
            entityContext.SubSet.Add(subject);
        }
        public void Update(Subjects subject)
        {
            entityContext.Entry(subject).State = EntityState.Modified;
        }
        public void Delete(int id)
        {
            Subjects subject = entityContext.SubSet.Find(id);
            if (subject != null)
                entityContext.SubSet.Remove(subject);
        }
    }
}
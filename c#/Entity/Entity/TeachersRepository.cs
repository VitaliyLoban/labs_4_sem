using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class TeachersRepository : EntityContext.IRepository<Teachers>
    {
        private EntityContext entityContext;
        public TeachersRepository(EntityContext context)
        {
            this.entityContext = context;
        }
        public IEnumerable<Teachers> GetAll()
        {
            return entityContext.TeachSet;
        }
        public Teachers Get(int id)
        {
            return entityContext.TeachSet.Find(id);
        }
        public void Create(Teachers teacher)
        {
            entityContext.TeachSet.Add(teacher);
        }
        public void Update(Teachers teacher)
        {
            entityContext.Entry(teacher).State = EntityState.Modified;
        }
        public void Delete(int id)
        {
            Teachers teacher = entityContext.TeachSet.Find(id);
            if (teacher != null)
                entityContext.TeachSet.Remove(teacher);
        }
    }
}
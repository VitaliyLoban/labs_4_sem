using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class UnitOfWork : IDisposable
    {
        EFGenericRepository<Teachers> genericRepository = new EFGenericRepository<Teachers>(new EntityContext());
        private EntityContext db = new EntityContext();
        private SubjectsRepository subjectsRepository;
        private TeachersRepository teachersRepository;
        public SubjectsRepository Students
        {
            get
            {
                if (subjectsRepository == null) subjectsRepository = new SubjectsRepository(db);
                return subjectsRepository;
            }
        }
        public TeachersRepository Teachers
        {
            get
            {
                if (teachersRepository == null) teachersRepository = new TeachersRepository(db);
                return teachersRepository;
            }
        }
        public void Save()
        {
            db.SaveChanges();
        }
        public void Dispose()
        {
            db.Dispose();
        }
    }
}

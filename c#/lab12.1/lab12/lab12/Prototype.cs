using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    [Serializable]
    public abstract class Prototype<T>
    { // поверхностное копирование 
        public virtual T Clone() { return (T)MemberwiseClone(); }
        // глубокое копирование 
        public virtual T DeepCopy()
        {
            using (var stream = new MemoryStream())
            {
                var context = new StreamingContext(StreamingContextStates.Clone);
                var formatter = new BinaryFormatter { Context = context };
                formatter.Serialize(stream, this);
                stream.Position = 0;
                T obj = (T)formatter.Deserialize(stream);
                return obj;
            }
        }
    }
}

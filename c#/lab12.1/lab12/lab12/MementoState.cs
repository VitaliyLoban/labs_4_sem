using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace lab12
{
    class MementoState
    {
        public Thickness State { get; private set; }

        public MementoState(Thickness state)
        {
            State = state;
        }
    }

    class Caretaker
    {
        public MementoState MementoState { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace lab12
{
    class Pult
    {
        ICommand command;

        public Pult()
        {
        }

        public void SetCommand(ICommand _command)
        {
            command = _command;
        }

        public void PressButton()
        {
            command.Execute();
        }
    }
}

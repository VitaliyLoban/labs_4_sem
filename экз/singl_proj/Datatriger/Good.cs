using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Datatriger
{
    class Good : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;
        bool good;
        string myValue;

        public Good()
        {
            IsGood = false;
        }

        public bool IsGood
        {
            get => good;
            set
            {
                if(PropertyChanged != null)
                {
                    good = value;
                    PropertyChanged(this, new PropertyChangedEventArgs("IsGood"));
                }
            }
        }

        public string MyValue
        {
            get => myValue;
            set
            {
                PropertyChanged(this, new PropertyChangedEventArgs("MyValue"));
                int a = 0;
                if (Int32.TryParse(value, out a))
                {
                    if (a < 0)
                        IsGood = false;
                    else
                        IsGood = true;
                }
                myValue = value;
            }
        }
    }
}

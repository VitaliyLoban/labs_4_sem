using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
namespace OOP_lab_10E
{
    class ViewModel : INotifyPropertyChanged
    {
        private Prod selectedProd;
        private int col;
        public ObservableCollection<Prod> prods { get; set; }
        public ObservableCollection<Prod> prodsS { get; set; }
        public int Col
        {
            get {return col; }
            set { col = value; OnPropertyChanged("Col"); }
        }
        private int price;
        public int Price
        {
            get { return price; }
            set { price = value; OnPropertyChanged("Price"); }
        }
        public Prod SelectedProd
        {
            get { return selectedProd; }
            set
            {
                selectedProd = value;
                OnPropertyChanged("SelectedPhone");
            }
        }

        public DelegatCommand AddCommand
        {
            get
            {
                prodsS = new ObservableCollection<Prod>();
                return new DelegatCommand((obj) =>
                { prodsS.Add(selectedProd);MessageBox.Show("Товар добавлен на склад"); });
            }
        }
        public DelegatCommand DeletCommand
        {
            get
            {
                return new DelegatCommand((obj) =>
                { prodsS.Remove(selectedProd);MessageBox.Show("Товар удалён со склада"); });
            }
        }
        public DelegatCommand Update
        {
            get
            {
                return new DelegatCommand((obj) =>
                {
                    SelectedProd.Count = Convert.ToInt32(col);
                    SelectedProd.Price = Convert.ToInt32(price);
                });
            }
        }
        public ViewModel()
        {
            using (Model1 db = new Model1())
            {
                prods = new ObservableCollection<Prod>();

                foreach (Prod i in db.Prod)
                {
                    prods.Add(i);
                }
            };
        }
        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged([CallerMemberName]string prop = "")
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(prop));
        }
    }
}

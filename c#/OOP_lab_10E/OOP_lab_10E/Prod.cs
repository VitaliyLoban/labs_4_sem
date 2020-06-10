namespace OOP_lab_10E
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;
    using System.Runtime.CompilerServices;

    [Table("Prod")]
    public partial class Prod : INotifyPropertyChanged
    {
        private int id1;
        public int id { get { return id1; } set { id1 = value; OnPropertyChanged("id"); } }
        private string vid;
        public string VID { get { return vid; } set { vid = value;OnPropertyChanged("VID"); } }
        private string naimemovanie;
        public string Naimemovanie { get { return naimemovanie; } set { naimemovanie = value; OnPropertyChanged("Naimemovanie"); } }
        private string articul;
        public string Articul { get { return articul; } set { articul = value;OnPropertyChanged("Articul"); } }
        private float ?price;
        public float? Price { get { return price; } set { price = value;OnPropertyChanged("Price"); } }
        public int ?count;
        public int? Count { get { return count ; } set { count = value; OnPropertyChanged("Count"); } }

        public event PropertyChangedEventHandler PropertyChanged;
        public void OnPropertyChanged([CallerMemberName]string prop = "")
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(prop));
        }
    }
}

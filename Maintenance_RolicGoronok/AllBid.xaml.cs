using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Maintenance_RolicGoronok
{
    /// <summary>
    /// Interaction logic for AllBid.xaml
    /// </summary>
    public partial class AllBid : Page
    {
        MaintenanceDataContext dc = new MaintenanceDataContext();
        int id;
        public AllBid()
        {
            InitializeComponent();
            Loaded += AllBid_Loaded;
        }

        private void AllBid_Loaded(object sender, RoutedEventArgs e)
        {
            lvAppeal.ItemsSource = dc.Bids.Select(b => new {Номер= b.Id, Клиент = b.Appeal.Client.Surname, Модель = b.Appeal.Car.Model.Name, ГосНомер = b.Appeal.Car.Number, Дата = b.Appeal.dateAppeal.Day+"-"+b.Appeal.dateAppeal.Month+"-"+b.Appeal.dateAppeal.Year });
        }

        private void lvAppeal_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Regex myReg = new Regex(@"\d+");

            Match match = myReg.Match(lvAppeal.SelectedItem.ToString());

            int.TryParse(match.Value, out id);


            dg.ItemsSource = dc.Works.Where(w => w.BidId == id).Select(w => new { Неисправность = w.Attire.Malfunction.Name, Услуга = w.Attire.ServicesInfo.Name, Цена = w.Attire.ServicesInfo.Price, Работник = w.Attire.Employee.Surname, Дата = w.Bid.FinishDate });
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
    /// Interaction logic for SecondQuery.xaml
    /// </summary>
    public partial class SecondQuery : Page
    {
        MaintenanceDataContext dc = new MaintenanceDataContext();
        public SecondQuery()
        {
            InitializeComponent();
            info.Text = "Марка и год выпуска автомобиля данного владельца";
            listOwner.ItemsSource = dc.Owners.OrderBy(o => o.Surname).Select(o=> o.Surname+" "+ o.Name[0]+"."+o.Patronymic[0]);
        }

        private void do_Click(object sender, RoutedEventArgs e)
        {
            dg.ItemsSource = dc.Cars.Where(c => c.Owner.Surname == personSurname.Text).Select(a => new {Марка =  a.Model.Name,Год =  a.ProductionYear.Year });
        }

       

        private void listOwner_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            dg.ItemsSource = dc.Cars.Where(c => c.Owner.Surname + " " + c.Owner.Name[0] + "." + c.Owner.Patronymic[0] == listOwner.SelectedItem.ToString()).Select(a => new { Марка = a.Model.Name, Год = a.ProductionYear.Year });
        }
    }
}

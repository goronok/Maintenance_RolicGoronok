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
    /// Логика взаимодействия для MalfunctionsPage.xaml
    /// </summary>
    public partial class MalfunctionsPage : Page
    {
        MaintenanceDataContext dc = new MaintenanceDataContext();
        public MalfunctionsPage()
        {
            InitializeComponent();
            info.Text = "Перечень устраненных неисправностей в автомобиле данного владельца";
            listOwner.ItemsSource = dc.Owners.OrderBy(o => o.Surname).Select(o => o.Surname + " " + o.Name[0] + "." + o.Patronymic[0]);
        }

        private void do_Click(object sender, RoutedEventArgs e)
        {
            dg.ItemsSource = dc.Works.Where(w => w.Bid.Appeal.Car.Owner.Surname == personSurname.Text).Select(w => new { Дата = w.Bid.FinishDate, Неисправность = w.Attire.Malfunction.Name });
        }

        private void listOwner_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            dg.ItemsSource = dc.Works.Where(w => w.Bid.Appeal.Car.Owner.Surname+" "+ w.Bid.Appeal.Car.Owner.Name[0]+"."+w.Bid.Appeal.Car.Owner.Patronymic[0] == listOwner.SelectedItem.ToString())
                .Select(w => new { Дата = w.Bid.FinishDate, Неисправность = w.Attire.Malfunction.Name });
        }
    }
}

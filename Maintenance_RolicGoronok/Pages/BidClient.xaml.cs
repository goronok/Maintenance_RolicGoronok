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
    /// Interaction logic for Bid.xaml
    /// </summary>
    public partial class BidClient : Page
    {
        MaintenanceDataContext dc = new MaintenanceDataContext();
        List<int> idEmp = new List<int>();
        List<int> idMun = new List<int>();
        public BidClient()
        {
            InitializeComponent();
            Loaded += Bid_Loaded;
        }

        // При загрузке Page
        private void Bid_Loaded(object sender, RoutedEventArgs e)
        {
            client.ItemsSource = dc.Clients.Select(p => new { Фамилия = p.Surname + " " + p.Name[0] + "." + p.Patronymic[0] }).Select(p => p.Фамилия);
            avto.ItemsSource = dc.Cars.Select(c => c.Number);

            dgMalfun.ItemsSource = dc.Malfunctions.Select(m => new { Неисправность = m.Name }).OrderBy(m=> m.Неисправность);

            dgEmp.ItemsSource = dc.Employees.Select(em => new { Работник = em.Surname + " " + em.Name[0] + "." + em.Patronymic[0], Специальность = em.Specialitie.Name });

        }//Bid_Loaded

        // При нажатии на кнопку новый авто
        private void addClient_Click(object sender, RoutedEventArgs e)
        {
            new AddNewClient().ShowDialog();
            client.ItemsSource = dc.Clients.Select(p => new { Фамилия = p.Surname + " " + p.Name[0] + "." + p.Patronymic[0] }).OrderBy(p => p.Фамилия).Select(p => p.Фамилия);
        }//addClient_Click

        // При нажатии на кнопку новый авто
        private void addCar_Click(object sender, RoutedEventArgs e)
        {
            new AddNewCar().ShowDialog();
            avto.ItemsSource = dc.Cars.Select(c => c.Number);
        }

        // При выборе Номера автомобиля в comboBox avto
        private void avto_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            dgAvto.ItemsSource = dc.Cars.Where(c => c.Number == avto.SelectedItem.ToString()).Select(c => new { Модель = c.Model.Name, Цвет = c.Color, Владелец = c.Owner.Surname });
        }//avto_SelectionChanged


        // При выборе Клиента в comboBox client
        private void client_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            dgClient.ItemsSource = dc.Clients.Where(p => p.Surname + " " + p.Name[0] + "." + p.Patronymic[0] == client.SelectedItem.ToString()).Select(p => new { Паспорт = p.Passport, Рожден = p.BirthDate.Day + "." + p.BirthDate.Month + "." + p.BirthDate.Year });
        }//client_SelectionChanged

        private void dg_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            FrameworkElement element = dgEmp.Columns[0].GetCellContent(e.Row);
            if (element.GetType() == typeof(CheckBox))
            {
                FrameworkElement surname = dgEmp.Columns[1].GetCellContent(e.Row);
                int id = dc.Employees.Where(em => em.Surname + " " + em.Name[0] + "." + em.Patronymic[0] == ((TextBlock)surname).Text).Select(em => em.Id).Single();
                idEmp.Add(id);
            }//if
        }//dg_RowEditEnding

        private void dgMalfun_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {
            FrameworkElement element = dgMalfun.Columns[0].GetCellContent(e.Row);
            if (element.GetType() == typeof(CheckBox))
            {
                FrameworkElement malf = dgMalfun.Columns[1].GetCellContent(e.Row);
                int id = dc.Malfunctions.Where(m => m.Name == ((TextBlock)malf).Text).Select(em => em.Id).Single();
                idMun.Add(id);
            }//if
        }//dgMalfun_RowEditEnding
    }
}

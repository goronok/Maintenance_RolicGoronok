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
        List<Garbs> listGarbs = new List<Garbs>();

        int AppealNewId, BidNewId;
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

            lvMalfun.ItemsSource = dc.Malfunctions.OrderBy(m =>  m.Name).Select(m=> m.Name);

            lvEmpl.ItemsSource = dc.Employees.Select(em =>  em.Surname + " " + em.Name[0] + "." + em.Patronymic[0]);

            lvServices.ItemsSource = dc.ServicesInfos.OrderBy(s=> s.Name).Select(s => s.Name);
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


        // Собираем данные о наряде в коллекцию
        private void add_Click(object sender, RoutedEventArgs e)
        {
            int MalfunId = dc.Malfunctions.Where(m => m.Name == lvMalfun.SelectedItem.ToString()).Select(m => m.Id).Single();

            int EmployeeId = dc.Employees.Where(em => em.Surname+" "+em.Name[0]+"."+em.Patronymic[0] == lvEmpl.SelectedItem.ToString()).Select(em => em.Id).Single();

            int ServecId = dc.ServicesInfos.Where(s => s.Name == lvServices.SelectedItem.ToString()).Select(s => s.Id).Single();

            Garbs garb = new Garbs(MalfunId, lvMalfun.SelectedItem.ToString(), EmployeeId, lvEmpl.SelectedItem.ToString(), ServecId, lvServices.SelectedItem.ToString() );
            
            listGarbs.Add(garb);

            dgattire.ItemsSource = null;
            dgattire.ItemsSource = listGarbs;
        }

        private void addBids_Click(object sender, RoutedEventArgs e)
        {
            AddAppeal();
            AddBids();
            AddAttire();
        }

        private void AddAttire()
        {
            for (int i = 0; i < listGarbs.Count; i++)
            {
                Attire attire = new Attire();
                attire.MalfunctionId = listGarbs[i].MalfunId;
                attire.ServicesInfoId = listGarbs[i].ServecId;
                attire.EmployeeId = listGarbs[i].EmployeeId;

                List<Attire> listAttire = new List<Attire>();

                listAttire.Add(attire);

                // Добавляем запись в базу
                dc.GetTable<Attire>().InsertAllOnSubmit(listAttire);
                SubmitChanges();

                int AttireNewId = listAttire[0].Id;

                Work work = new Work();

                work.AttireId = AttireNewId;
                work.BidId = BidNewId;

                List<Work> listWork = new List<Work>();

                listWork.Add(work);

                // Добавляем запись в базу
                dc.GetTable<Work>().InsertAllOnSubmit(listWork);
                SubmitChanges();

            }
        }

        private void AddBids()
        {
            Bid bid = new Bid();

            bid.AppealId = AppealNewId;
            bid.FinishDate = dateTo.SelectedDate.Value;

            List<Bid> listBid = new List<Bid>();

            listBid.Add(bid);

            // Добавляем запись в базу
            dc.GetTable<Bid>().InsertAllOnSubmit(listBid);
            SubmitChanges();

            BidNewId = listBid[0].Id;
        }

        private void AddAppeal()
        {
            Appeal appeal = new Appeal();

            appeal.dateAppeal = dateFrom.SelectedDate.Value;
            appeal.CarId = dc.Cars.Where(c => c.Number == avto.SelectedItem.ToString()).Select(c => c.Id).Single();
            appeal.ClientId = dc.Clients.Where(cl => cl.Surname + " " + cl.Name[0] + "." + cl.Patronymic[0] == client.SelectedItem.ToString()).Select(cl => cl.Id).Single();

            List<Appeal> listAppeal = new List<Appeal>();

            listAppeal.Add(appeal);

            // Добавляем запись в базу
            dc.GetTable<Appeal>().InsertAllOnSubmit(listAppeal);
            SubmitChanges();
            AppealNewId = listAppeal[0].Id;
        }//AddAppeal



        private void SubmitChanges()
        {
            try
            {
                dc.SubmitChanges();
            }
            catch (Exception f)
            {
                MessageBox.Show(f.Message);
                dc.SubmitChanges();
            }//try-catch
        }

        
            

    }
}

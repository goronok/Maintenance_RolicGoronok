using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace Maintenance_RolicGoronok
{
    class CreateAndInsertTable
    {
        public SqlConnection Connect = new SqlConnection();
        public SqlCommand Command = new SqlCommand();


        private static readonly string nameDBase = "Service";   // Имя нашей базы


        // При запуске программа подключается к базе master
        public void StartConnection()
        {
            try
            {
                Connect.ConnectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=master;Integrated Security=true; Encrypt=False; TrustServerCertificate=True; User ID=sa;Password=Aa1234568";
                Connect.Open();
            }
            catch
            {
                // Если подключение не возможно идет задержка
                MessageBox.Show("Не удалось подключится к базе master");
            }// catch

            connection();
        }// StartConnection


        // Подключения к базе nameDBase в нашем случае Service
        public void connection()
        {
            // Выполняет запрос существует ли база Service
            // Если ее нет создает базу Service
            Command = new SqlCommand("if db_id('" + nameDBase + "') is null create database " + nameDBase, Connect);
            Command.ExecuteNonQuery();

            Disconnect();             // Отключения от базы master

            try
            {
                if (Connect.State == ConnectionState.Closed)
                {
                    Connect.ConnectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=" + nameDBase + ";Integrated Security=true; Encrypt=False; TrustServerCertificate=True; User ID=sa;Password=Aa1234568";
                    Connect.Open();
                    // Если соединение проходит успешно
                    MessageBox.Show("Соединение с базой " + nameDBase + " прошло успешно (открыто)");
                }
                else { MessageBox.Show("Соединение с базой " + nameDBase + " уже открыто"); } // Если соединение с этой базой есть
            }
            catch
            {
                // Если подключение не возможно идет задержка
                MessageBox.Show("Не удалось подключится к базе " + nameDBase);
            }

            // Вызываем метод для создания таблиц в базу nameDBase
            CreatTable();


        }// connection

        // Закрытие соединения
        public void Disconnect() { Connect.Close(); }


        // Создание таблиц для базы Service
        public void CreatTable()
        {
            const string path = @"..\..\CreateAndInsertSecond.sql"; // Путь к файлу создания таблиц

            try
            {
                string comm;
                using (var sr = new StreamReader(path, Encoding.Default))
                {
                    comm = sr.ReadToEnd();
                }//using

                Command = new SqlCommand(comm, Connect);
                Command.ExecuteNonQuery();
                MessageBox.Show("Таблицы созданы и заполнены");
            }
            catch (Exception ex) { MessageBox.Show(ex.Message); }

        }//CreatTable

    }
}


-- специальности работников
if OBJECT_ID ('Specialitie') is null begin
create table Specialitie(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(50)	not null,					-- специальность
	constraint Specialitie_PK primary key (Id)				-- первичный ключ по ид
);
INSERT INTO [dbo].[Specialitie] ([Name])
     VALUES
          ('автослесарь'),
		  ('автоэлектрик'),
		  ('автомаляр'),
		  ('автомойщик'),
		  ('автомеханик'),
		  ('автошпаклевщик'),
		  ('автожестянщик'),
		  ('полировщик автомобилей')
end

-- разряды работников
if OBJECT_ID ('Categorie') is null begin
create table Categorie(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(50)	not null,					-- разряд
	constraint Categorie_PK primary key (Id)				-- первичный ключ по ид
);
INSERT INTO [dbo].[Categorie] ([Name])
     VALUES
           ('Первая'),
		   ('Вторая'),
		   ('Третья'),
		   ('Четвертая'),
		   ('Пятая'),
		   ('Шестая'),
		   ('Седьмая'),
		   ('Восьмая')
end

-- неисправности
if OBJECT_ID ('Malfunction') is null begin
create table Malfunction(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(100)	not null,					-- наименование неисправности
	constraint Malfunction_PK primary key (Id)				-- первичный ключ по ид
);
INSERT INTO [dbo].[Malfunction] ([Name])
     VALUES
           ('Двигатель не вращается при попытке запуска'),
		   ('Двигатель вращается, но не запускается'),
		   ('Трудный запуск холодного двигателя'),
		   ('Трудный запуск горячего двигателя'),
		   ('Шум и неровное вращение стартера'),
		   ('Двигатель запускается, но тут же останавливается'),
		   ('Двигатель в масле'),
		   ('Неравномерная частота вращения холостого хода'),
		   ('Пропуски зажигания на холостом ходу'),
		   ('Пропуски зажигания под нагрузкой'),
		   ('Падение оборотов при ускорении'),
		   ('Нестабильная работа двигателя'),
		   ('Двигатель останавливается'),
		   ('Потеря мощности двигателя'),
		   ('Хлопки двигателя в глушитель'),
		   ('Детонационные стуки двигателя при разгоне'),
		   ('Индикатор «низкое давление масла»'),
		   ('Большой расход топлива'),
		   ('Утечка топлива и запах от топлива'),
		   ('Перегрев'),
		   ('Двигатель не прогревается'),
		   ('Малое усилие выключения сцепления'),
		   ('Нечеткое включение передач'),
		   ('Пробуксовка сцепления'),
		   ('Вибрации при включении сцепления'),
		   ('Дребезжание в коробке передач'),
		   ('Шум в зоне сцепления'),
		   ('Педаль сцепления не возвращается в исходное положение'),
		   ('Большое усилие на педали сцепления'),
		   ('Ударные шумы на малых скоростях'),
		   ('Лязгающий звук при ускорении и замедлении'),
		   ('Щелкающий звук в поворотах'),
		   ('Шум на одной отдельной передаче'),
		   ('Шум на всех передачах'),
		   ('Выключение передач'),
		   ('Автомобиль при торможении ведет в сторону'),
		   ('Шум при торможении'),
		   ('Пульсация усилия на педали тормоза'),
		   ('Повышенное усилие торможения'),
		   ('Повышенный ход педали тормоза'),
		   ('Вибрация колес'),
		   ('Повышенное усилие на рулевом колесе'),
		   ('Повышенный шум с переда автомобиля'),
		   ('Плохая устойчивость рулевого управления'),
		   ('Дрожание рулевого колеса при торможении'),
		   ('Излишний крен в поворотах и при торможении'),
		   ('Пятнистый износ шин'),
		   ('Щелкающие звуки в паре рейка - шестерня'),
		   ('Переменное усилие нажатия на педаль тормоза'),
		   ('Заедание и недостаточное действие тормозов'),
		   ('Задержка торможения'),
		   ('Повышенный износ шин')
		   
end


-- перечень услуг
if OBJECT_ID ('ServicesInfo') is null begin
create table ServicesInfo(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(100)	not null,					-- наименование услуги
	Price		int				not null,					-- стоимость услуги
	constraint ServicesInfo_PK primary key (Id)			    -- первичный ключ по ид
);
INSERT INTO [dbo].[ServicesInfo]  ([Name] ,[Price])
     VALUES
           ('Ремонт двигателя',5000 ),
		   ('Замена двигателя',10000 ),
		   ('Ремонт кузова',4000 ),
		   ('Покраска',3000 ),
		   ('Шиномонтаж', 2000),
		   ('Ремонт ходовой', 4500),
		   ('Ремонт трансмиссии',3500 )
end

-- Владелец
if OBJECT_ID ('Owner') is null begin
create table Owner(
	Id			int				not null	identity(1,1),	-- ид
	Surname		nvarchar(50)	not null,					-- фамилия
	Name		nvarchar(50)	not null,					-- имя
	Patronymic	nvarchar(50),								-- отчество
	[Address]	nvarchar(200)	not null,					-- адрес прописки
	constraint  Owner_PK primary key (Id)					-- первичный ключ по ид
);
INSERT INTO [dbo].[Owner] ([Surname]  ,[Name] ,[Patronymic]  ,[Address])
     VALUES
           ('Яровой','Алексей','Сергеевич','Независимости 15/82'),
		   ('Кузьмин','Сергей','Ефимович','230 стрелковой дивизии 42/15'),
		   ('Миронов','Александр','Александрович','Ильича 185/99'),
		   ('Незнайка','Федор','Александрович','Ильича 10/15'),
		   ('Киров','Емельян','Федорович','Ильича 15/77')
end

-- модели автомобилей
if OBJECT_ID ('Model') is null begin
create table Model(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(50)	not null,					-- модель
	constraint Model_PK primary key (Id)					-- первичный ключ по ид
);
INSERT INTO [dbo].[Model] ([Name])
     VALUES 
   	       ('Acura'),
		   ('Alfa Romeo'),
		   ('Alpina'),
		   ('Alpine'),
		   ('Aro'),
		   ('Asia'),
		   ('Aston Martin'),
		   ('Audi'),
		   ('Austin'),
		   ('BAW'),
		   ('Beijing'),
		   ('Bentley'),
		   ('BMW'),
		   ('Brilliance'),
		   ('Bristol'),
		   ('Bugatti'),
		   ('Buick'),
		   ('BYD'),
		   ('Богдан'),
		   ('Vector'),
		   ('Venturi'),
		   ('Volkswagen'),
		   ('Volvo'),
		   ('Vortex'),
		   ('Wartburg'),
		   ('Westfield'),
		   ('Wiesmann'),
		   ('Wuling'),
		   ('ВАЗ'),
		   ('Geely'),
		   ('Geo'),
		   ('GMC'),
		   ('Great Wall')
end

-- машины
if OBJECT_ID ('Car') is null begin
create table Car(
	Id				int				not null	identity(1,1),	-- ид
	ModelId			int				not null,					-- модель
	ProductionYear	date			not null,					-- год выпуска
	Number			nvarchar(8)		not null,					-- гос номер
	Color			nvarchar(25)	not null,					-- цвет
	OwnerId			int				not null,					-- владелец 
	constraint Car_PK		primary key (Id),								-- первичный ключ по ид
	constraint CarOwner_FK	foreign key (OwnerId) references Owner(Id),	    -- внешний ключ к таблице личных данных владельца
	constraint CarModel_FK foreign key (ModelId) references Model(Id)		-- внешний ключ к таблице моделей автомобиля
);
INSERT INTO [dbo].[Car]([ModelId] ,[ProductionYear] ,[Number] ,[Color]  ,[OwnerId])
     VALUES
           (5, '2005-10-08', 'АН5678НА', 'Зеленый', 2),
		   (1, '2017-01-15', 'ЕН1935НА', 'Красный', 3),
		   (3, '2012-10-30', 'АН2837НА', 'Белый', 1)
		   
end


-- Клиенты
if OBJECT_ID ('Client') is null begin
create table Client(
	Id			int				not null	identity(1,1),	-- ид
	Surname		nvarchar(50)	not null,					-- фамилия
	Name		nvarchar(50)	not null,					-- имя
	Patronymic	nvarchar(50),								-- отчество
	BirthDate	date			not null,					-- дата рождения
	[Address]	nvarchar(200)	not null,					-- адрес прописки
	Passport	nvarchar(8)		not null,					-- Серия и номер паспорта
	License     nvarchar(15)    not null,                   -- Серия права
	Phone       nvarchar(15),                               -- Телефон
	constraint Client_PK primary key (Id)					-- первичный ключ по ид
);
INSERT INTO [dbo].[Client] ([Surname] ,[Name],[Patronymic] ,[BirthDate] ,[Address] ,[Passport], [License])

     VALUES
           ('Горонков','Александр','Александрович','1985-10-08','230 стрелковоймдивизии 39/9','ВЕ123963','48 17 8956')
end


--Обращения  на станцию техобслуживания 
if OBJECT_ID ('Appeal') is null begin
create table Appeal(
	Id			int				not null	identity(1,1),	-- ид
	dateAppeal	date			not null,					-- дата обращения
	CarId       int             not null,                   -- ид машины
	ClientId    int             not null,                   -- ид клиента
	constraint Appeal_PK primary key (Id),					            			-- первичный ключ по ид
	constraint AppealCar_FK	foreign key (CarId) references Car(Id),	   			    -- внешний ключ к таблице машины	
	constraint AppealClient_FK	foreign key (ClientId) references Client(Id)	    -- внешний ключ к таблице Клиенты
);
INSERT INTO [dbo].[Appeal] ([dateAppeal] ,[CarId] ,[ClientId])
     VALUES
           ('2017-06-24', 1, 1)
end

-- работники
if OBJECT_ID ('Employee') is null begin
create table Employee(
	Id				int	not null	identity(1,1),			-- ид
	Surname		nvarchar(50)	not null,					-- фамилия
	Name		nvarchar(50)	not null,					-- имя
	Patronymic	nvarchar(50),								-- отчество
	SpecialityId	int	not null,							-- специальность
	CategoryId		int	not null,							-- категория
	Experience		int	not null,							-- стаж
	IsWorking		bit	not null	default(1),				-- работает ли (1 - работает, 0 - уволен)
	constraint Employee_PK				primary key (Id),											-- первичный ключ по ид
	constraint EmployeeSpeciality_FK	foreign key (SpecialityId)	references Specialitie(Id),	-- внешний ключ к специальностям
	constraint EmployeeCategory_FK		foreign key (CategoryId)	references Categorie(Id)		-- внешний ключ к категориям
);
INSERT INTO [dbo].[Employee] ([Surname]  ,[Name] ,[Patronymic] ,[SpecialityId]  ,[CategoryId],[Experience])
     VALUES
           ('Орлов','Генадий','Владимирович',1,1,7)
end


-- Заявка  на устранения неисправности и услуги  
if OBJECT_ID ('Bid') is null begin
create table Bid(
	Id			int				not null	identity(1,1),	-- ид
	AppealId    int             not null,                   -- ид Обращения    
	FinishDate	date			not null,				    -- дата выдачи заказа
	Finish      bit             not null default(0),        -- Завершено или нет (архив)
	constraint Bid_PK primary key (Id),					            -- первичный ключ по ид
	constraint BidAppeal_FK	foreign key (AppealId) references Appeal(Id)	    -- внешний ключ к таблице обращения	
);
INSERT INTO [dbo].[Bid] ([AppealId] ,[FinishDate])
     VALUES
           (1,'2017-06-25')
end



-- Наряд
if OBJECT_ID ('Attire') is null begin
create table Attire(
	Id			     int				not null	identity(1,1),	-- ид
	MalfunctionId    int                not null,                   -- ид Неисправности    
	ServicesInfoId   int                not null,                   -- ид Услуги    
	EmployeeId     	 int      			not null,					-- ид работника
	constraint Attire_PK primary key (Id),					            -- первичный ключ по ид
	constraint AttireMalfunction_FK	foreign key (MalfunctionId) references Malfunction(Id),	    -- внешний ключ к таблице неисправности
	constraint AttireServicesInfo_FK	foreign key (ServicesInfoId) references ServicesInfo(Id),	    -- внешний ключ к таблице неисправности
	constraint AttireEmployee_FK	foreign key (EmployeeId) references Employee(Id)	            -- внешний ключ к таблице работники
); 
INSERT INTO [dbo].[Attire] ([MalfunctionId] ,[ServicesInfoId] ,[EmployeeId])
     VALUES
           (2,2,1)
end


-- Работы
if OBJECT_ID ('Work') is null begin
create table Work(
	Id			     int				not null	identity(1,1),	-- ид
	BidId            int                not null,                   -- ид Заявки    
	AttireId         int                not null,                   -- ид Наряда    
	constraint Work_PK primary key (Id),					            			-- первичный ключ по ид
	constraint WorkBid_FK	foreign key (BidId) references Bid(Id),	   			    -- внешний ключ к таблице неисправности
	constraint WorkAttire_FK	foreign key (AttireId) references Attire(Id)	    -- внешний ключ к таблице неисправности
); 
INSERT INTO [dbo].[Work] ([BidId] ,[AttireId])
     VALUES
           (1,1)
end




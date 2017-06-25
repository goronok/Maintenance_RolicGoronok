
-- специальности работников
if OBJECT_ID ('Specialitie') is null begin
create table Specialitie(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(50)	not null,					-- специальность
	constraint Specialitie_PK primary key (Id)				-- первичный ключ по ид
);
end

-- разряды работников
if OBJECT_ID ('Categorie') is null begin
create table Categorie(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(50)	not null,					-- разряд
	constraint Categorie_PK primary key (Id)				-- первичный ключ по ид
);
end

-- неисправности
if OBJECT_ID ('Malfunction') is null begin
create table Malfunction(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(100)	not null,					-- наименование неисправности
	constraint Malfunction_PK primary key (Id)				-- первичный ключ по ид
);
end

-- перечень услуг
if OBJECT_ID ('ServicesInfo') is null begin
create table ServicesInfo(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(100)	not null,					-- наименование услуги
	Price		int				not null,					-- стоимость услуги
	constraint ServicesInfo_PK primary key (Id)			    -- первичный ключ по ид
);
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
end

-- модели автомобилей
if OBJECT_ID ('Model') is null begin
create table Model(
	Id			int				not null	identity(1,1),	-- ид
	Name		nvarchar(50)	not null,					-- модель
	constraint Model_PK primary key (Id)					-- первичный ключ по ид
);
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
	constraint Client_PK primary key (Id)					-- первичный ключ по ид
);
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
end


-- Заявка  на устранения неисправности и услуги  
if OBJECT_ID ('Bid') is null begin
create table Bid(
	Id			int				not null	identity(1,1),	-- ид
	AppealId    int             not null,                   -- ид Обращения    
	FinishDate	date			not null,				    -- дата выдачи заказа\
	Finish      bit             not null default(0),        -- Завершено или нет (архив)
	constraint Bid_PK primary key (Id),					            -- первичный ключ по ид
	constraint BidAppeal_FK	foreign key (AppealId) references Appeal(Id)	    -- внешний ключ к таблице обращения	
);
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
end




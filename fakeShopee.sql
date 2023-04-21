Create database FakeShopee
GO
USE FakeShopee
GO
SET Dateformat dmy
Go

CREATE TABLE category(
	cId int IDENTITY(1,1) PRIMARY KEY not null,
	cName nvarchar(50) NULL,
	cImage nvarchar(max),
	createAt date DEFAULT(getdate()),
	updateAt date NULL,
)
GO

create table accountpay(
	id int IDENTITY(1,1) PRIMARY KEY not null,
	payId nvarchar (50),
	payName nvarchar (50),
	payEmail nvarchar (50),
	payPassword nvarchar(50),
)
GO

create table [role](
	idRole int IDENTITY PRIMARY KEY not null,
	nameRole nvarchar(50)
)
go

create table [user](
	uId int IDENTITY PRIMARY KEY not null,
	uName varchar(50) ,
	uFullName nvarchar(50),
	uEmail varchar(50),
	uAddress nvarchar(150),
	uPassword varchar(500),
	uPhone char(11),
	eWallet int references accountPay(id),
	idRole int references role(idRole),
	isAccountGoogle int,
	uImage nvarchar(max),
	createAt date DEFAULT(getdate())
)
go

CREATE TABLE dbo.shop(
	 shopId int IDENTITY(1,1) PRIMARY KEY not null, 
	 shopName NVARCHAR(50) unique,
	 uId int references [user](uId),
	 cateId int references category(cId),
	 eWallet int references accountpay(id),
	 shopImage NVARCHAR(max),
	 shopDecription NVARCHAR(500),
	 shopAddress nvarchar(500),
	 createAt date,
	 updateAt date,
	 isActive bit,
	 isDelete bit
)
GO

create table dbo.orderStatus(
	id int primary key,
	statusName nvarchar(20)
)
go
CREATE TABLE dbo.product(
	pId int IDENTITY(1,1) PRIMARY KEY not null,
	pName nvarchar(50) NULL,
	pPrice float  ,
	pImage nvarchar(500) NULL,
	pDescription nvarchar(500) NULL,
	pQuantity int NULL,
	cateId int references category(cId),
	shopId int references shop(shopId),
	createAt date DEFAULT(getdate()),
	updateAt date NULL

)
GO

Create table dbo.[order](
	orderId [int] IDENTITY(1,1) PRIMARY KEY not null,
	[uId] int references [user](uId),
	shopId int references shop(shopId),
	uName nvarchar(50),
	--[deliveryId] int references [user](uId),
	uPhone char(11),
	uAddress nvarchar(500),
	isPaidBefore bit,
	[status] int references OrderStatus(id),
	amountFromUser float,

	createAt DATETIME DEFAULT(getdate()),
)
GO
create table dbo.delivery(
	dId int identity primary key,
	[uId] int references [user]([uId]),
	dDescription nvarchar(100),
	dPrice float,
	--dStatus int references statusShip(id),
	createdAt date,
	updatedAt date
)
go

create table dbo.orderdetail(
	id [int] IDENTITY(1,1) PRIMARY KEY not null,
	orderId int references [order](orderId),
	productId int references product(pId),
	[count] int,
	shipPrice float ,
	totalPrice float,
	createAt date DEFAULT(getdate())	,
)
GO


create table dbo.cart(
	cartId int identity(1,1) primary key,
	[uId] int references [user](uId),
	shopId int references Shop(shopId)
	)
	go

create table dbo.cartItems(
	id int identity(1,1) primary key,
	cartId int references cart(cartId),
	productId int references product(pId),
	[count] int,
	totalPrice float
)
go

insert into [role] values ('user')
insert into [role] values ('admin')
insert into [role] values ('seller')
insert into [role] values ('shipper')
go

insert into [user] values ('dinhhai50', N'Trần Đình Hải', 'haitranvipqt@gmail.com', N'Quãng Ngãi', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234756283', null, 2,0, '', DEFAULT)
insert into [user] values ('dinhhai251', N'Trần Đình Hải', 'haitd2425@gmail.com', N'Quãng Ngãi', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0383534267', null, 1,0, null, DEFAULT)
insert into [user] values ('sinhhung253', N'Nguyễn Sinh Hùng', 'hungns254@gmail.com', N'Quãng Ngãi', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234753456', null, 1,0, null, DEFAULT)
insert into [user] values ('thanhda258', N'Nguyễn Thành Đa', 'dant3974@gmail.com', N'Bình Định', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234756349', null, 1,0, null, DEFAULT)
insert into [user] values ('thanhdanh257', N'Nguyễn Thanh Danh', 'danhnt2943@gmail.com', N'Long An', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234753582', null, 1,0, null, DEFAULT)
insert into [user] values ('khacduong269', N'Nguyễn Khắc Dương', 'duongnk9573@gmail.com', N'Lâm Đồng', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234783045', null, 1,0, null, DEFAULT)
insert into [user] values ('minhtrung274', N'Phạm Minh Trung', 'trungpm3894@gmail.com', N'Đà Lạt', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234753468', null, 1,0, null, DEFAULT)
insert into [user] values ('nhatkhai356', N'Nguyễn Nhật Khải', 'khainn5039@gmail.com', N'Cà Mau', '$2a$12$UJlJDs3P74KeR/93P9OzOemy.FNqfCjmTXQVB6dkUnosrkS6BGdrS', '0234756794', null, 1,0, null, DEFAULT)
go

Insert into category Values (N'Đồ Điện Tử',N'https://ucarecdn.com/1bfb5493-6878-4cd3-8b85-823fd35f8752/images' ,Default,NULL)
Insert into category Values (N'Quần Áo',N'https://ucarecdn.com/8b0db3f7-191e-46bb-bacd-02cef2872d78/images', Default,NULL)
Insert into category Values (N'Giày Dép',N'https://ucarecdn.com/87efc5f2-1077-45a8-b00c-1976b73ecf81/images', Default,NULL)
Insert into category Values (N'Mỹ Phẩm',N'https://ucarecdn.com/38bed410-13df-4929-9c66-da8f1d8f7d1f/images', Default,NULL)
Insert into category Values (N'Phụ Kiện Thời Trang', N'https://ucarecdn.com/e3b92064-2e1a-43a4-ae9a-667bdc2800dd/images', Default,NULL)
Insert into category Values (N'Nước giải nhiệt',N'https://ucarecdn.com/eb65fddb-480e-410e-8698-7add6b64d6ff/images', Default,NULL)
Insert into category Values (N'Thú nhồi bông',N'https://ucarecdn.com/1c4f8dfb-f4ea-43c2-97a6-2e1699af0590/images', Default,NULL)
go

insert into shop values (N'Cửa hàng đồ điện tử', 2,1, null, N'https://ucarecdn.com/795e7254-b16f-491a-8323-9fa512062edc/cuahangdientugiadung.jpg', N'Cửa hàng bán đồ điện tử',null, default, null, 1, 0)
insert into shop values (N'Cửa hàng quần áo', 3,2, null, N'https://ucarecdn.com/b23cab67-6a8a-45ad-95a6-1d49d76361df/quanao.jpg', N'Cửa hàng bán quần áo nam nữ',null, default, null, 1, 0)
insert into shop values (N'Cửa hàng giày dép', 6,3, null, N'https://ucarecdn.com/28426ab5-0272-473c-afdd-606e18c64321/top10diachimuagiaydepnamdepnhattaitphcm5.jpg', N'Cửa hàng bán giày dép',null, default, null, 1, 0)
insert into shop values (N'Cửa hàng mỹ phẩm', 7,4, null, N'https://ucarecdn.com/8303a711-daed-4445-b53c-67f32ab83092/kinhnghiemmoshopmypham2006.jpg', N'Cửa hàng bán mỹ phẩm',null, default, null, 1, 0)
insert into shop values (N'Cửa hàng phụ kiện thời trang', 8,5, null, N'https://ucarecdn.com/7653a7db-1231-4007-bf77-e1146b74d641/cuahangphukienthoitrang.jpg', N'Cửa hàng bán phụ kiện thời trang',null, default, null, 1, 0)
insert into shop values (N'Cửa hàng bán bia', 4,6, null, N'https://ucarecdn.com/1c29fe16-6b6a-449e-b824-16e2652ab681/c4.jpg', N'Cửa hàng bán bia lon',null, default, null, 1, 0)
insert into shop values (N'Cửa hàng thú nhồi bông', 5,7, null, N'https://ucarecdn.com/2a68eaf6-cbc5-4417-8dbb-4a344c42309e/csenmin.jpg', N'Cửa hàng bán thú nhồi bông',null, default, null, 1, 0)
go

insert into product values(N'Ổ cắm điện rời dạng hình chữ nhật', '140000', 'https://ucarecdn.com/2fa5862f-39c1-43ba-87a1-8cb42571560f/7d50b47f57337157b557b488024e6180.jpg', N'Ổ điện cắm rời hình chữ nhật tiện lợi cho sinh viên, gia đình có thể mang theo mọi nơi', 30, 1, 1, DEFAULT, NULL)
insert into product values(N'Ổ cắm điện rời dạng tròn', '60000', 'https://ucarecdn.com/a0eb8f0d-69e7-4b4a-83aa-d43c004f657a/bd69e56307cfabb0f7d8e2749f48ecc3', N'Ổ điện cắm rời hình tròn tiện lợi, gọn nhẹ', 30, 1, 1, DEFAULT, NULL)
insert into product values(N'Nồi cơm điện Hotwell', '500000', 'https://ucarecdn.com/49e38595-0678-43ee-a2f3-2ef800e4a41a/rc18h2trang.jpg', N'Nồi cơm điện cơ truyền thống rẻ, nấu cơm nhanh, dễ mang đi vệ sinh', 30, 1, 1, DEFAULT, NULL)
insert into product values(N'Lò nướng 10L SunHouse SHD4206', '2200000', 'https://ucarecdn.com/76c391db-4490-4ba2-b91d-60b536055dd4/SHD42068.jpg', N'Lò nướng dung tích lên đến 10L của SunHouse phù hợp cho mọi gia đình', 30, 1, 1, DEFAULT, NULL)
insert into product values(N'Tủ Lạnh Mini Aqua AQR-95AR', '2500000', 'https://ucarecdn.com/05548741-19e5-4e08-9b82-fa43c34cfc32/tulanhaqua1.jpg', N'Tủ lạnh mini dành cho sinh viên ở trọ giá cả phải chăng dung tích lên đến 90L', 30, 1, 1, DEFAULT, NULL)

insert into product values(N'Áo thun dài tay bigsize', '380000', 'https://ucarecdn.com/a49b3676-0523-44ea-a5e7-5481d711627a/16.jpg', N'Áo thun dài tay dành cho các bạn trẻ mang đi chơi đi du lịch', 30, 2, 2, DEFAULT, NULL)
insert into product values(N'Áo thun nữ thêu hình mặt mèo ở tay áo', '200000', 'https://ucarecdn.com/8fadbcb9-abff-4b8c-9eb8-72deeac305b1/7573aothunnutheuhinhmatmeootayao1.jpg', N'Áo thun thêu hình mặt mèo ở tay áo cực dễ thương dành cho các bạn nữ', 30, 2, 2, DEFAULT, NULL)
insert into product values(N'Áo sơ mi dài tay', '300000', 'https://ucarecdn.com/5acdeba6-99e7-425a-b2c7-b44deae94378/cl8a3947_copy.jpg', N'Áo sơ mi tay dài dành cho nam, lịch sự gọn gàng mặc đi làm, dự tiệc, đi chơi đều được', 30, 2, 2, DEFAULT, NULL)
insert into product values(N'Chân váy voan họa tiết hoa', '250000', 'https://ucarecdn.com/af0f0348-3b4c-45c9-aef6-49fc55f8117e/O1CN01xTczhh1NsIM3x2cS7_22090695116250cib.jpg', N'Chân váy voan lưng thun với họa tiết hoa đầy xinh xắn thích hợp cho các bạn nữ phối đồ đi du lịch xa gần', 30, 2, 2, DEFAULT, NULL)
insert into product values(N'Quần tây nam', '190000', 'https://ucarecdn.com/c63eb86d-efa6-449a-9a4f-0725899623a7/dsc07563_25a6ab3ee1fd41d385d70b59478d5d52_master.jpg', N'Quần tây nam màu đen lịch lãm dành để đi làm, dự tiệc', 30, 2, 2, DEFAULT, NULL)

insert into product values(N'Giày Converse 1970s High Black White cổ cao', '650000', 'https://ucarecdn.com/88a24fec-4f47-4eac-92c7-6aed2f0ad13c/giayconversechuck1970highblackwhitedentrangcocaodepchat9.jpg', N'Giày Converse cổ cao thích hợp cho học sinh sinh viên mang đi học, đi chơi', 30, 3, 3, DEFAULT, NULL)
insert into product values(N'Giày Thể Thao Nam BN0135', '300000', 'https://ucarecdn.com/6064b653-fdc8-40cf-a076-1999f1fb77af/giaythethaonambn0135101.jpg', N'Giày thể thao dành cho nam mã BN0135', 30, 3, 3, DEFAULT, NULL)
insert into product values(N'Giày McQueen White', '1000000', 'https://ucarecdn.com/fc8e6b99-8a68-473a-90c2-8aa37c43c958/giaymcqueenwhitetranggotdenbancaocaprep11depchat600x6001.jpg', N'Giày McQueen White màu trắng gót đen dành cho nữ dáng vẻ cực đẹp', 30, 3, 3, DEFAULT, NULL)
insert into product values(N'Dép Leo Rubber', '300000', 'https://ucarecdn.com/657e3086-8d92-4871-b7c7-1baa9a999585/DSCF0512_700x.jpg', N'Dép Leo Rubber màu đen, dáng vẻ đơn gian tiện lợi mang đi khắp mọi nơi', 30, 3, 3, DEFAULT, NULL)
insert into product values(N'Dép tổ ong Trường Sơn', '100000', 'https://ucarecdn.com/66e11527-fe50-41f5-a732-9380ade5a3a5/Deptoong.jpg', N'Dép tổ ong truyền thống của Việt Nam chắc đã không còn xa lạ gì với các thế hệ 8x 9x, dép cực bền bỉ phù hợp mang đi khắp nơi', 30, 3, 3, DEFAULT, NULL)

insert into product values(N'Phấn Nước Gilaa Kiềm Dầu Và Dưỡng Da', '330000', 'https://ucarecdn.com/b8ccdbf3-9e45-4dea-a2d7-ead4331e7231/phannuocgilaakiemdauvaduongda2naturalbeige13g10_img_358x358_843626_fit_center.jpg', N'Phấn nước có thể phủ và dưỡng da dành cho các chị em', 30, 4, 4, DEFAULT, NULL)
insert into product values(N'Kem Nền Che Khuyết điểm', '40000', 'https://ucarecdn.com/4d8deaa2-81b1-4c05-8434-ab267c30e671/c958098cfe1928e5b157e1d3129b1311.jpg', N'Kem nền che khuyết điểm BB Cream Lameila Light Concealer Foundation', 30, 4, 4, DEFAULT, NULL)
insert into product values(N'Nước Tẩy Trang Garnier', '200000', 'https://ucarecdn.com/08de1d1c-7a31-4afb-8df6-618a73c7b3e7/promotionsautonuoctaytranggarnierdanhchodadauvamun400ml_oyQcTy7wdQRCiWry_img_358x358_843626_fit_center.png', N'Nước Tẩy Trang Garnier Dành Cho Da Dầu Và Mụn 400ml', 30, 4, 4, DEFAULT, NULL)
insert into product values(N'Son kem Blackrouge', '30000', 'https://ucarecdn.com/2dee6594-e318-4fc8-ab61-8fe51636f8f9/Sb2fa086a800b427e9cbec8d29a7c0560Tjpg_460x460q80.jpg', N'Son kem cực rẻ', 30, 4, 4, DEFAULT, NULL)
insert into product values(N'Sữa Rửa Mặt Trắng Da Ngọc Trai Nivea 100Gr', '75000', 'https://ucarecdn.com/78d40896-b528-4007-aaa0-fe12ffedabc2/30221161_3aff6721d3db4c5a85f3ec6ed84afebc_master.jpg', N'Sữa rửa mặt tốt cho làn da bạn', 30, 4, 4, DEFAULT, NULL)

insert into product values(N'Kính Mát Cao Cấp Nam Nữ', '800000', 'https://ucarecdn.com/97cc91b3-113b-4df0-9fba-8ff1465724db/gongkinhpapas100_b3b550090d584cf39a238b8a3f0c390f_master.jpg', N'Kính Mát Cao Cấp Nam Nữ Gentle Monster PAPAS Chuẩn Auth', 30, 5, 5, DEFAULT, NULL)
insert into product values(N'TÚI XÁCH NỮ THỜI TRANG CAO CẤP ELLY', '1200000', 'https://ucarecdn.com/c907baeb-59fb-48fc-a245-c3528fec215a/TuixachnuthoitrangcaocapELLYEL523.jpg', N'Túi xách nữ thời trang cao cấp', 30, 5, 5, DEFAULT, NULL)
insert into product values(N'Dây chuyền bạc nữ cá tính khắc tên', '350000', 'https://ucarecdn.com/bdc10650-326e-4e3f-97a4-0349a43882f2/daychuyenbaccatinhkhactenDCN0423.jpg', N'Dây chuyền bạc nữ cá tính có khắc tên phù hợp làm quà tặng người thân, người yêu', 30, 5, 5, DEFAULT, NULL)
insert into product values(N'Lắc tay bạc nữ đẹp hình trái tim', '220000', 'https://ucarecdn.com/8308437d-1d0b-47a1-986a-42196ae819c6/lactaybacnudephinhtraitimltn0178.jpg', N'Lắc tay bạc hình trái tim đáng yêu', 30, 5, 5, DEFAULT, NULL)
insert into product values(N'Đồng hồ nam chính hãng Lobinni', '2500000', 'https://ucarecdn.com/d966cf69-cadf-4a41-bea6-d910df264d45/dongholobinnino3001v1avt6.jpg', N'Đồng hồ nam lịch lãm quý phái dành cho các quý ông', 30, 5, 5, DEFAULT, NULL)

insert into product values(N'Bia lon 333', '3500', 'https://ucarecdn.com/64a947b6-479c-405f-925b-2e9f4affb47d/bia333lon330ml3700x4671.jpg', N'Uống là quên mô tả', 30, 6, 6, DEFAULT, NULL)
insert into product values(N'Bia Heneken lon', '4000', 'https://ucarecdn.com/b70b0926-a1a6-4411-83d3-8dc467d5d3e9/biaheinekensleek330ml202003250703333577.JPG', N'Người mua không quan tâm mục này', 30, 6, 6, DEFAULT, NULL)
insert into product values(N'Bia Budweiser', '5000', 'https://ucarecdn.com/07377f98-2376-4a08-affc-e6b67067b7cf/BIABUDWEISER330ML.jpg', N'Sản phẩm không dành cho trẻ em', 30, 6, 6, DEFAULT, NULL)
insert into product values(N'Rượu vang Ý', '200000', 'https://ucarecdn.com/dfe810bc-c60a-4b68-adc3-d4829533e31d/Masseto.jpg', N'Bán bia rượu cho người dưới 18 tuổi là vi phạm pháp luật', 30, 6, 6, DEFAULT, NULL)
insert into product values(N'Rượu Spirytus Rektyfikowany', '800000', 'https://ucarecdn.com/b40a9313-9f18-4c30-9f5b-7a90388f0a1a/SpirytusRektyfikowanychairuouconongdoconcaonhatthegioi2.jpg', N'Thích hợp cho người trên 18 tuổi', 30, 6, 6, DEFAULT, NULL)

insert into product values(N'Gối ôm lợn hồng', '300000', 'https://ucarecdn.com/773cbde0-7d9d-431e-9de6-61111f93b2eb/gaubonggoiomlonhongsieuxinhsieucutethunhoibonglonhongsieudangyeugaubongsangtrongdochoithubong.png', N'Gối ôm lợn hồng cực mềm êm dành cho con trẻ ôm ngủ', 30, 7, 7, DEFAULT, NULL)
insert into product values(N'Sóc bông', '570000', 'https://ucarecdn.com/c7886b56-6c9a-4800-858d-62d08e673dec/f462ab93f16419e9eda42cdb6a516372.jpg', N'Sóc nhồi bông cực dễ thương', 30, 7, 7, DEFAULT, NULL)
insert into product values(N'Creeper nhồi bông', '250000', 'https://ucarecdn.com/47199746-e9a8-444d-b9c0-97262be47d8c/images', N'Thú nhồi bông đến từ Mincraft', 30, 7, 7, DEFAULT, NULL)
insert into product values(N'Khủng long mập', '600000', 'https://ucarecdn.com/a6d6176c-ce2b-4526-bdc2-27b9415d22c2/thunhoibongkhunglongmaphong.jpg', N'Khủng long mập ú', 30, 7, 7, DEFAULT, NULL)
insert into product values(N'Gấu Bông Brown', '350000', 'https://ucarecdn.com/a69d2fba-5c49-44ee-93f9-b4fb85cbf3a4/d60ae086729baf388560cb6323d5c24ejpg.webp', N'Gấu Bông Brown cao 1M vải cao cấp', 30, 7, 7, DEFAULT, NULL)
go

insert into orderStatus values (1,N'Chờ xác nhận')
insert into orderStatus values (2,N'Chờ lấy hàng')
insert into orderStatus values (3,N'Đang giao')
insert into orderStatus values (4,N'Đã giao')
insert into orderStatus values (5,N'Đã hủy')
insert into orderStatus values (6,N'Trả hàng')
go
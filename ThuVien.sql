CREATE DATABASE library
GO
USE library
go
-- Tạo bảng Category - loại sách
CREATE TABLE Category (
    CategoryId SMALLINT PRIMARY KEY,
    Name NVARCHAR(250) NOT NULL,
    Status BIT
);
-- Tạo bảng Position - vị trí
CREATE TABLE Position (
    PositionId SMALLINT PRIMARY KEY,
    Shelf SMALLINT,
    Floor SMALLINT,
    Status BIT
);
-- Tạo bảng Language - ngôn ngữ
CREATE TABLE Language(
    LanguageId SMALLINT PRIMARY KEY,
    Name NVARCHAR(250),
    Description NVARCHAR(250),
    Status BIT
);
-- Tạo bảng Book - sách
CREATE TABLE Book (
    BookId INT PRIMARY KEY,
    Title NVARCHAR(250),
    Description NVARCHAR(2000),
    Author NVARCHAR(250),
    Publisher NVARCHAR(250),
    PageNumber int,
    Price int,
    CategoryId SMALLINT,
    PositionId SMALLINT,
    LanguageId SMALLINT,
    CONSTRAINT FK_Book_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId),
    CONSTRAINT FK_Book_Position FOREIGN KEY (PositionId) REFERENCES Position(PositionId),
    CONSTRAINT FK_Book_Language FOREIGN KEY (LanguageId) REFERENCES Language(LanguageId),
    Status BIT
);
-- Tạo bảng Book - sách
CREATE TABLE Image(
    ImageId int PRIMARY KEY,
    BookId int,
    Path VARCHAR(1000),
    CONSTRAINT FK_Image_Book FOREIGN KEY (BookId) REFERENCES Book(BookId),
    Status BIT
);
-- Tạo bảng Book - sách
CREATE TABLE Copy(
    CopyId int PRIMARY KEY,
    BookId int,
    Durability Decimal(4,1),
    Description NVARCHAR(2000),
    borrow_status TINYINT,
    CONSTRAINT FK_Copy_Book FOREIGN KEY (BookId) REFERENCES Book(BookId),
    Status BIT
);
-- Tạo bảng Book - sách
CREATE TABLE Staff (
    StaffId SMALLINT PRIMARY KEY,
    Name NVARCHAR(100),
    ID VARCHAR(12),
    Gender BIT,
    Email VARCHAR(100),
    Phone VARCHAR(12),
    Address NVARCHAR(500),
    Position NVARCHAR(50),
    StartDay DATE,
    Status BIT
);
-- Tạo bảng Book - sách
CREATE TABLE Account(
    AccountId INT PRIMARY KEY,
    StaffId SMALLINT,
    Password VARCHAR(100),
    CONSTRAINT FK_Account_Staff FOREIGN KEY (StaffId) REFERENCES Staff(StaffId),
    Status BIT
)
-- Tạo bảng Book - sách
CREATE TABLE Login(
    LoginId INT PRIMARY KEY,
    AccountId INT,
    Login_date DATE,
    CONSTRAINT FK_Login_Account FOREIGN KEY (AccountId) REFERENCES Account(AccountId),
    Status BIT
)
-- Tạo bảng Book - sách
CREATE TABLE Borrower(
    BorrowerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Gender BIT,
    Email VARCHAR(100),
    Phone VARCHAR(12),
    Address NVARCHAR(500),
    StartDay DATE,
    account_balance int,
    Status BIT
);
CREATE TABLE Borrowing(
    BorrowingId INT PRIMARY KEY,
    BorrowerID INT,
    StaffId SMALLINT,
    Borrowed_date DATE,
    Appointment_date DATE,
    CONSTRAINT FK_Borrowing_Borrower FOREIGN KEY  (BorrowerID) REFERENCES Borrower(BorrowerID),
    CONSTRAINT FK_Borrowing_Staff FOREIGN KEY  (StaffID) REFERENCES Staff(StaffID),
    Status BIT
)
CREATE TABLE Borrowing_detail(
    Borrowing_detailId INT PRIMARY KEY,
    BorrowingId INT,
    CopyId INT,
    Return_date DATE,
    Durability Decimal(4,1),
    Description NVARCHAR(2000),
    borrow_status TINYINT,
    CONSTRAINT FK_Borrowing_detail_Copy FOREIGN KEY (CopyId) REFERENCES Copy(CopyId),
    CONSTRAINT FK_Borrowing_detail_Book FOREIGN KEY (BorrowingId) REFERENCES Borrowing(BorrowingId),
    Status BIT
)

INSERT INTO Category (CategoryId, Name, Status) 
VALUES
    (1, N'Tiểu thuyết', 1),
    (2, N'Kinh tế', 1),
    (3, N'Tâm lý học', 1),
    (4, N'Kỹ năng sống', 1),
    (5, N'Văn học nghệ thuật', 1),
    (6, N'Thiếu nhi', 1),
    (7, N'Tâm linh', 1),
    (8, N'Lịch sử', 1),
    (9, N'Khoa học', 1),
    (10, N'Triết học', 1);
GO
DELETE from Category
INSERT INTO Position (PositionId, Shelf, Floor, Status)
VALUES 
    (1, 1, 1, 1),
    (2, 1, 2, 1),
    (3, 1, 3, 1),
    (4, 1, 4, 1),
    (5, 2, 1, 1),
    (6, 2, 2, 1),
    (7, 2, 3, 1),
    (8, 2, 4, 1),
    (9, 3, 1, 1),
    (10, 3, 2, 1),
    (11, 3, 3, 1),
    (12, 3, 4, 1)
GO
INSERT INTO Language (LanguageId, Name, Description, Status) 
VALUES
    (1, N'Tiếng Việt', N'Vietnamese', 1),
    (2, N'Tiếng Anh', N'English', 1),
    (3, N'Tiếng Pháp', N'French', 1),
    (4, N'Tiếng Nhật', N'Japanese', 1),
    (5, N'Tiếng Hàn', N'Korean', 1);
GO
INSERT INTO Book (BookId, Title, Description, Author, Publisher, PageNumber, Price, CategoryId, PositionId, LanguageId, Status)
VALUES 
    (1, N'Suy Ngẫm Đầu Tiên Vào Buổi Sáng', N'Mỗi ngày của bạn bắt đầu bằng việc xem tin tức và kiểm tra email – và chắc hẳn bạn cũng đồng tình với tôi rằng đây không phải là cách khởi đầu đầy cảm hứng. Suy Ngẫm Đầu Tiên Vào Buổi Sáng là những phát biểu của Osho về nhiều chủ đề khác nhau, được tuyển chọn đặc biệt cho độc giả đọc vào buổi sáng, sau khi thức giấc.', N'Osho', N'NXB Hồng Đức', 432, 120000, 4, 1, 1, 1),
    (2, N'Muôn Kiếp Nhân Sinh 1', N'“Muôn kiếp nhân sinh tập 1” là tác phẩm do Giáo sư John Vũ - Nguyên Phong viết từ năm 2017 và hoàn tất đầu năm 2020 ghi lại những câu chuyện, trải nghiệm tiền kiếp kỳ lạ từ nhiều kiếp sống của người bạn tâm giao lâu năm, ông Thomas – một nhà kinh doanh tài chính nổi tiếng ở New York. Những câu chuyện chưa từng tiết lộ này sẽ giúp mọi người trên thế giới chiêm nghiệm, khám phá các quy luật về luật Nhân quả và Luân hồi của vũ trụ giữa lúc trái đất đang gặp nhiều tai ương, biến động, khủng hoảng từng ngày.',N'Nguyên Phong', N'NXB Tổng hợp TP.HCM', 408, 180000, 4, 1, 1, 1),
    (3,N'YÊU (Yêu trong tỉnh thức, Gắn bó trong niềm tin)',N'Những người đói khát trong nhu cầu, những người luôn kỳ vọng ở tình yêu chính là những người đau khổ nhất. Hai kẻ đói khát tìm thấy nhau trong một mối quan hệ yêu đương cùng những kỳ vọng người kia sẽ mang đến cho mình thứ mình cần – về cơ bản sẽ nhanh chóng thất vọng về nhau và cùng mang đến ngục tù khổ đau cho nhau. Trong cuốn sách Yêu, Osho - bậc thầy tâm linh, người được tôn vinh là một trong 1000 người kiến tạo của thế kỷ 20 – đã đưa ra những kiến giải sâu sắc về nhu cầu tâm lý có sức mạnh lớn nhất của nhân loại và “chỉ cho chúng ta cách trải nghiệm tình yêu”.',N'Osho',N'NXB Hồng Đức',350,140000,10,2,1,1),
    (4,N'Trò Chuyện Với Vĩ Nhân',N'“Trò chuyện với vĩ nhân” tổng hợp những câu chuyện của thiền sư Osho về 20 triết gia, nhà tư tưởng, đạo sư lỗi lạc nhất lịch sử. Danh sách những bậc vĩ nhân Osho bàn đến rất đa dạng: Ở phương Đông có Lão Tử, Trang Tử; phương Tây có Socrates, Pythagoras, J. Krishnamurtri, Heraclitus, những nhà lãnh đạo tôn giáo như Phật Thích Ca Mâu Ni, Bồ Đề Đạt Ma, Jesus Christ… Dưới ngòi bút sắc sảo của Osho, cuộc đời, tư tưởng và hành trình giác ngộ của những bậc vĩ nhân hiện lên đầy sống động. Ông kể về thời thơ ấu bất hạnh của Krishnamurti, cái chết của Socrates, cuộc gặp gỡ giữa Khổng Tử với Lão Tử hay khoảnh khắc chứng ngộ của ni sư Chiyono.',N'Osho',N'NXB Hồng Đức',392,160000,10,1,1,1),
    (5,N'Suy Ngẫm Cuối Cùng Vào Buổi Tối',N'Chìm vào giấc ngủ trước màn hình tivi hay máy vi tính như nhiều người đang làm ngày nay không phải là cách thoải mái để kết thúc một ngày dài bận rộn. Những gì chúng ta làm vào buổi tối có thể ảnh hưởng xấu và làm rối loạn giấc ngủ, cũng như giấc mơ của ta. Suy ngẫm cuối cùng vào buổi tối đề cập đến nhiều chủ đề khác nhau, được tuyển chọn đặc biệt để đọc vào buổi tối. Cuốn sách sẽ cho bạn một lựa chọn khác để kết thúc một ngày với một chút hương vị thiền để vượt qua đêm dài.',N'Osho',N'NXB Hồng Đức',424,110000,10,1,1,1),
    (6,N'Từ Bi: Trên Cả Trắc Ẩn Và Yêu Thương',N'Từ bi là một thứ tình thương mát lành, là sự chia sẻ niềm vui của bản thân đến với vạn vật. Từ bi giúp ta trở thành đóa hoa sen, vượt lên vũng bùn của thế giới ham muốn, dục vọng và sự giận dữ. Dẫn dắt người đọc qua câu chuyện về cuộc đời Đức Phật, Chúa Jesus và những hiểu biết về Thiền đạo, Osho đặt ra thách thức cho các giả định về từ bi là gì và gạt bỏ những sai lầm, định kiến, khám phá ý nghĩa thực sự ẩn sau đó. "Từ bi không phải là cái mà chúng ta vẫn gọi là tình yêu. Nó mang yếu tố cốt lõi của tình yêu nhưng lại không phải là tình yêu như chúng ta vẫn biết”, Osho viết.',N'',N'NXB Hồng Đức',224,100000,10,1,1,1);

GO
--Đã chạy 10/04/2023
INSERT INTO Copy (CopyId, BookId, Durability, Description, borrow_status, Status) 
VALUES
    (1, 1, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (2, 1, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (3, 1, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (4, 1, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (5, 1, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (6, 2, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (7, 2, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (8, 2, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (9, 2, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (10, 2, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (11, 3, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (12, 3, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (13, 3, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (14, 3, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (15, 3, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (16, 4, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (17, 4, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (18, 4, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (19, 4, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (20, 4, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (21, 5, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (22, 5, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (23, 5, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (24, 5, 100.0, N'Còn nguyên vẹn, mới', 0, 1),
    (25, 5, 100.0, N'Còn nguyên vẹn, mới', 0, 1);
GO
INSERT INTO Staff (StaffId, Name, ID, Gender, Email, Phone, Address, Position, StartDay, Status) 
VALUES
    (111, N'Nguyễn Văn Lâm', '033201002648', 1, 'nguyenlam0612@gmail.com', '0123456789', N'Hà Nội', N'ql', '2022-01-01', 1),
    (112, N'Nguyễn Quân', '033201004576', 1, 'nguyenquan@gmail.com', '0242888567', N'Hà Nội', N'nv', '2022-02-01', 1),
    (113, N'Nguyễn Anh Tuấn', '033201002647', 1, 'nguyentuan@gmail.com', '0926480989', N'Hà Nội', N'nv', '2022-02-01', 1);
GO
INSERT INTO Account (AccountId, StaffId, Password, Status) 
VALUES
    (1, 111, 'lam123', 1),
    (2, 112, 'quan123', 1),
    (3, 113, 'tuan123', 1);
GO
INSERT INTO Borrower (BorrowerID, Name, Gender, Email, Phone, Address, StartDay, account_balance, Status) 
VALUES
    (1, N'Nguyễn Văn Lâm', 1, 'nguyenlam@gmail.com', '0987654321', N'Yên Mỹ, Hưng Yên', '2022-01-01', 200000, 1),
    (2, N'Ngô Thị Thanh Tâm', 0, 'thanhtam@gmail.com', '0639840676', N'Hà Đông, Hà Nội', '2022-02-01', 20000, 1),
    (3, N'Nguyễn Văn Thành', 1, 'vanthanh@gmail.com', '0442562746', N'Văn Giang, Hưng Yên', '2022-03-01', 200000, 1),
    (4, N'Nguyễn Hữu Linh', 1, 'nguyenhuulinh@gmail.com', '0151424553', N'Yên Mỹ, Hưng Yên', '2022-03-01', 200000, 1),
    (5, N'Nguyễn Huyền Trang', 0, 'huyentrang@gmail.com', '0157496655', N'Khoái Châu, Hưng Yên', '2022-03-01', 200000, 1),
    (6, N'Đỗ Thị Yến', 0, 'dothiyen@gmail.com', '0595364433', N'Văn Lâm, Hưng Yên', '2022-03-01', 200000, 1),
    (7, N'Lê Văn Tới', 1, 'levantoi@gmail.com', '0446798663', N'Lục Ngạn, Bắc Giang', '2022-03-01', 200000, 1),
    (8, N'Nguyễn Quân', 1, 'nguyenquan@gmail.com', '0737000535', N'Khoái Châu, Hưng Yên', '2022-03-01', 200000, 1),
    (9,N'Đàm Duy Ninh',1,'duyninh@gmail.com','0681357557',N'Văn Giang, Hưng Yên','2022-03-01',200000,1),
    (10,N'Nguyễn Thị Thu',0,'thunguyen@gmail.com','',N'Kim Động, Hưng Yên','2022-02-01',200000,1),
    (11,N'Thái Bình An',1,'binhan@gmail.com','0167518852',N'Tiên Lữ, Hưng Yên','2022-02-01',200000,1);
GO
--Đã chạy 11/04/2023

------------------------------------------------
INSERT INTO Book (BookId, Title, Description, Author, Publisher, PageNumber, Price, CategoryId, PositionId, LanguageId, Status)
VALUES 
(7,N'123',N'123',N'',N'',10,100,6,8,1,1),
(8,N'123',N'123',N'',N'',10,100,6,8,1,1);
----------------------------------------------

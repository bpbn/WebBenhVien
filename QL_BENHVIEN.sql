CREATE DATABASE QL_BENHVIEN
GO
USE QL_BENHVIEN
GO

CREATE TABLE CHITIETBACSI(
	MABACSI			VARCHAR(10) NOT NULL,
	HOCHAM			NVARCHAR(50),
	GIOITHIEU		NVARCHAR(MAX),
	GIOITINH		NVARCHAR(3),
	HINHANH			VARCHAR(MAX),

	CONSTRAINT P_CHITIETBACSI PRIMARY KEY(MABACSI)
)

CREATE TABLE HOCVI(
	MAHOCVI			VARCHAR(10) NOT NULL,
	TENHOCVI		NVARCHAR(50),
	BACHOCVI		INT,

	CONSTRAINT P_HOCVI PRIMARY KEY(MAHOCVI)
)

CREATE TABLE CHITIETHOCVI(
	MABACSI			VARCHAR(10) NOT NULL,
	MAHOCVI			VARCHAR(10) NOT NULL,

	CONSTRAINT P_CHITIETHOCVI PRIMARY KEY(MABACSI,MAHOCVI)
)

CREATE TABLE BENHNHAN(
	MABENHNHAN		VARCHAR(10) NOT NULL,
	TENBENHNHAN		NVARCHAR(30),
	NGAYSINH		DATE,
	GIOITINH		NVARCHAR(3),
	SDT				CHAR(10),
	DIACHI			NVARCHAR(100),

	CONSTRAINT P_BENHNHAN PRIMARY KEY(MABENHNHAN)
)

CREATE TABLE PHIEUHEN(
	MAPHIEUHEN		VARCHAR(10) NOT NULL,
	NGAYKHAM		DATE,
	KHUNGGIOKHAM	NVARCHAR(5),
	MANHANVIEN		VARCHAR(10),
	VANDESUCKHOE	NVARCHAR(MAX),
	TENBENHNHAN		NVARCHAR(30),
	NGAYSINH		DATE,
	GIOITINH		NVARCHAR(3),
	SDT				CHAR(10),
	DIACHI			NVARCHAR(100),

	CONSTRAINT P_PHIEUHEN PRIMARY KEY(MAPHIEUHEN)
)

CREATE TABLE NHANVIEN(
	MANHANVIEN		VARCHAR(10) NOT NULL,
	TENNHANVIEN		NVARCHAR(30),
	CHUCVU			NVARCHAR(20),
	MATAIKHOAN		VARCHAR(10),

	CONSTRAINT P_NHANVIEN PRIMARY KEY(MANHANVIEN)
)

CREATE TABLE BENH(
	MABENH			VARCHAR(10) NOT NULL,
	TENBENH			NVARCHAR(30),

	CONSTRAINT P_BENH PRIMARY KEY(MABENH)
)

CREATE TABLE THUOC(
	MATHUOC			VARCHAR(10) NOT NULL,
	TENTHUOC		NVARCHAR(50),
	QCDONGGOI		NVARCHAR(30),
	DVT				NVARCHAR(20),
	TONKHO  		INT,

	CONSTRAINT P_THUOC PRIMARY KEY(MATHUOC)
)


CREATE TABLE PHONGKHAM(
	MAPHONG			VARCHAR(10) NOT NULL,
	TENPHONG		NVARCHAR(50),
	VITRI			NVARCHAR(30),

	CONSTRAINT P_PHONGKHAM PRIMARY KEY(MAPHONG)
)

CREATE TABLE PHIEUKHAM(
	MAPHIEUKHAM		VARCHAR(10) NOT NULL,
	MABENHNHAN		VARCHAR(10),
	TONGTIEN		INT,
	MAPHONG			VARCHAR(10),
	TRANGTHAIHEN	NVARCHAR(20),
	MANHANVIEN		VARCHAR(10),

	CONSTRAINT P_PHIEUKHAM PRIMARY KEY(MAPHIEUKHAM)
)


CREATE TABLE TOATHUOC(
	MATOATHUOC		VARCHAR(10) NOT NULL,
	MAPHIEUKHAM		VARCHAR(10),
	MANHANVIEN			VARCHAR(10),
	NGAYLAP			DATE,
	TONGTIEN		INT,
	LOIDAN			NVARCHAR(100),

	CONSTRAINT P_TOATHUOC PRIMARY KEY(MATOATHUOC)
)


CREATE TABLE CHITIETCHUANDOAN(
	MATOATHUOC		VARCHAR(10) NOT NULL,
	MABENH			VARCHAR(10) NOT NULL,

	CONSTRAINT P_CHITIETCHUANDOAN PRIMARY KEY(MATOATHUOC, MABENH)
)

CREATE TABLE CHITIETTOATHUOC(
	MATOATHUOC		VARCHAR(10) NOT NULL,
	MATHUOC			VARCHAR(10) NOT NULL,
	DONGIA			INT,
	SOLUONG			INT,
	GHICHU			NVARCHAR(100),

	CONSTRAINT P_CHITIETTOATHUOC PRIMARY KEY(MATOATHUOC, MATHUOC)
)

CREATE TABLE TAIKHOAN(
	MATAIKHOAN		VARCHAR(10) NOT NULL,
	TENTAIKHOAN		VARCHAR(20) NOT NULL,
	MATKHAU			VARCHAR(20),
	LOAITAIKHOAN    NVARCHAR(10),

	CONSTRAINT P_TAIKHOAN PRIMARY KEY(MATAIKHOAN)
)

CREATE TABLE LICHLAMVIEC(
	MALICH			VARCHAR(10) NOT NULL,
	MABACSI			VARCHAR(10),
	NGAYLAM			DATE,
	CALAM			NVARCHAR(5),
	PHONGLAMVIEC	VARCHAR(10),

	CONSTRAINT P_LICHLAMVIEC PRIMARY KEY(MALICH)
)
go

ALTER TABLE NHANVIEN
ADD CONSTRAINT F_NV_TK FOREIGN KEY(MATAIKHOAN) REFERENCES TAIKHOAN(MATAIKHOAN)

ALTER TABLE CHITIETHOCVI
ADD CONSTRAINT F_CTHV_BS FOREIGN KEY(MABACSI) REFERENCES CHITIETBACSI(MABACSI);
ALTER TABLE CHITIETHOCVI
ADD CONSTRAINT F_CTHV_HV FOREIGN KEY(MAHOCVI) REFERENCES HOCVI(MAHOCVI);

ALTER TABLE PHIEUHEN
ADD CONSTRAINT F_PHIEUHEN_BS FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);

ALTER TABLE PHIEUKHAM
ADD CONSTRAINT F_PHIEUKHAM_PHONG FOREIGN KEY(MAPHONG) REFERENCES PHONGKHAM(MAPHONG);
ALTER TABLE PHIEUKHAM
ADD CONSTRAINT F_PHIEUKHAM_NV FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);
ALTER TABLE PHIEUKHAM
ADD CONSTRAINT F_PHIEUKHAM_BN FOREIGN KEY(MABENHNHAN) REFERENCES BENHNHAN(MABENHNHAN);

ALTER TABLE TOATHUOC
ADD CONSTRAINT F_TT_BS FOREIGN KEY(MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);
ALTER TABLE TOATHUOC
ADD CONSTRAINT F_TT_PK FOREIGN KEY(MAPHIEUKHAM) REFERENCES PHIEUKHAM(MAPHIEUKHAM);

ALTER TABLE CHITIETCHUANDOAN 
ADD CONSTRAINT F_CTCD_TT FOREIGN KEY(MATOATHUOC) REFERENCES TOATHUOC(MATOATHUOC);
ALTER TABLE CHITIETCHUANDOAN 
ADD CONSTRAINT F_CTCD_BENH FOREIGN KEY(MABENH) REFERENCES BENH(MABENH);

ALTER TABLE CHITIETTOATHUOC
ADD CONSTRAINT F_CTTT_TT FOREIGN KEY(MATOATHUOC) REFERENCES TOATHUOC(MATOATHUOC);
ALTER TABLE CHITIETTOATHUOC 
ADD CONSTRAINT F_CTTT_THUOC FOREIGN KEY(MATHUOC) REFERENCES THUOC(MATHUOC);

ALTER TABLE LICHLAMVIEC
ADD CONSTRAINT F_LICH_BS FOREIGN KEY(MABACSI) REFERENCES BACSI(MABACSI);


INSERT INTO CHITIETBACSI VALUES (
        'BS0001',
        N'Phó giáo sư', 
        N'TTƯT.PGS.TS Triệu Triều Dương là chuyên gia hàng đầu ngành phẫu thuật tiêu hóa: phẫu thuật thực quản, dạ dày, ruột, gan mật tụy, đại trực tràng, hậu môn, sàn chậu…. \nSau khi tốt nghiệp bác sĩ đa khoa tại Học viện Quân Y năm 1985, bác sĩ Triều Dương tiếp tục tham gia các khóa đào tạo sau đại học tại Học viện Quân Y (1989), nghiên cứu sinh năm 1996 và đào tạo chuyên sâu về Phẫu thuật nội soi tại Bệnh viện Việt Đức (1992), tại Thái Lan (1996), tại Hàn Quốc, Pháp (2004), tại Singapore (2007); Đào tạo phẫu thuật lạnh tại Ucraina (2007) và Đào tạo ghép gan – tụy tại Hàn Quốc (2017)…\nPGS Dương thường xuyên tham dự các hội nghị hội thảo, tập huấn ngắn hạn trong nước và quốc tế về phẫu thuật ung thư đường tiêu hóa, phẫu thuật nội soi nâng cao. PGS Triệu Triều Dương có gần 40 năm kinh nghiệm trong lĩnh vực nội soi và phẫu thuật ổ bụng. “Bàn tay vàng” của ông đã giúp hàng nghìn người cải thiện sức khỏe và chất lượng sống. Với những cống hiến to lớn cho nền y học nước nhà, PGS.TS.BSCC Triệu Triều Dương nhận được nhiều Bằng khen của Thủ tướng Chính phủ, Bộ trưởng Bộ Y tế, Bộ trưởng Bộ Quốc phòng, đạt danh hiệu Chiến sĩ thi đua cấp Bộ, cấp viện nhiều năm liên tục, Bằng khen tuổi trẻ sáng tạo thủ đô, Kỷ niệm chương “Vì sự nghiệp Khoa học và Công nghệ”… \nĐặc biệt, TTƯT.PGS.TS Triệu Triều Dương vinh dự được Chủ tịch nước tặng Huân chương chiến công hạng Nhất (2004), Huân chương Quân kỳ quyết thắng (2014), Huân chương bảo vệ tổ quốc hạng Nhì (2022), Thầy thuốc ưu tú (2007). Trong suốt chặng đường sự nghiệp vinh quang của mình, PGS Triệu Triều Dương giữ nhiều chức vụ quan trọng: Chủ nhiệm khoa Ngoại nhân dân (2000), Chủ nhiệm khoa Ngoại Tổng hợp (B15) (2003), Viện trưởng Viện phẫu thuật tiêu hóa kiêm chủ nhiệm khoa gan mật tụy (2016), chủ nhiệm khoa phẫu thuật hậu môn trực tràng và sàn chậu (B3C). Phó chủ bộ môn Ngoại tiêu hóa, Giảng viên bộ môn Ngoại tiêu hóa, Chuyên viên Kỹ thuật Cục Quân Y – chuyên ngành Phẫu thuật Tiêu hóa, Bệnh viện Trung ương Quân đội 108…\nHiện nay, với vai trò là Giám đốc khối Ngoại, TTƯT.PGS.TS Triệu Triều Dương tiếp tục cùng đội ngũ chuyên gia hàng đầu tại Bệnh viện Đa khoa Tâm Anh Hà Nội góp phần mang đến chất lượng thăm khám và điều trị hiệu quả cho người bệnh.', 
        N'Nam', 
        N'BS0001.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0002',
        N'Phó giáo sư', 
        N'PGS.TS.BS.CKII Trần Văn Hinh được biết đến là một trong những chuyên gia hàng đầu trong lĩnh vực tiết niệu và ghép thận tại Việt Nam. Với hơn 30 năm kinh nghiệm trong ngành Y, PGS Hinh cập nhật và làm chủ các kỹ thuật cao trong điều trị. Ông đã thực hiện thành công trên 1000 trường hợp với các kỹ thuật: ghép thận, tán sỏi thận qua da, tán sỏi niệu quản ngược dòng, nội soi cắt u tuyến tiền liệt, nội soi ổ bụng cắt thận và cắt u tuyến thượng thận…\nSau khi tốt nghiệp Bác sĩ Nội trú Ngoại khoa tại Học viện Quân Y, bác sĩ Trần Văn Hinh tham gia nghiên cứu sinh tiến sĩ Ngoại khoa. Ông tiếp tục con đường nâng cao năng lực chuyên môn, cập nhật các kỹ thuật cao trong điều trị cho người bệnh như kỹ thuật tán sỏi qua da, nội soi lưỡng cực, các tiến bộ trong chẩn đoán và điều trị bệnh lý Nam khoa tại các cơ sở y học lớn trong nước và quốc tế như: Mayo Clinic (Hoa Kỳ), Trung tâm đào tạo phẫu thuật nội soi IRCAD (Đài Loan), Lisbon (Bồ Đào Nha), trường Đại học Y Hà Nội…\nBên cạnh công tác thăm khám điều trị cho người bệnh, PGS Trần Văn Hinh dành thời gian và tâm huyết thực hiện nhiều nghiên cứu khoa học như: một số yếu tố nguy cơ và ứng dụng kỹ thuật cao trong điều trị bệnh sỏi tiết niệu, ứng dụng kỹ thuật cắt lưỡng cực, bốc hơi tổ chức và laser điều trị bệnh u lành tuyến tiền liệt, ung thư bàng quang. Ngoài ra, ông còn xuất bản nhiều đầu sách, giáo trình trong lĩnh vực tiết niệu thận học như Bệnh sỏi đường tiết niệu, Nhiễm khuẩn niệu, Chẩn đoán và điều trị bệnh sỏi đường tiết niệu, Triệu chứng bệnh học ngoại tiết niệu…\nVới những nỗ lực không ngừng nghỉ trong sự nghiệp chữa bệnh cứu người của mình, PGS.TS.BS.CKII Trần Văn Hinh vinh dự nhận được nhiều Bằng khen của Thủ tướng Chính phủ, Bộ Quốc phòng, Bộ Y tế, Trung ương Đoàn, UBND tỉnh…\nHiện nay, PGS.TS.BS.CKII Trần Văn Hinh với vai trò là Trưởng khoa Tiết niệu – Nam học, Bệnh viện Đa khoa Tâm Anh Hà Nội, đồng thời là Phó Chủ tịch kiêm Tổng Thư ký Hội Tiết niệu – Thận học Việt Nam, luôn dành thời gian và tâm sức giúp người bệnh khỏe mạnh, nâng cao chất lượng sống nhờ phát hiện chính xác và điều trị bằng các kỹ thuật hiện đại, ít xâm lấn.', 
        N'Nam', 
        N'BS0002.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0003',
        N'Null', 
        N'Đam mê bộ môn sinh học và nghiên cứu cấu tạo cơ thể người từ lúc nhỏ, cùng tấm lòng thích giúp đỡ mọi người, chàng thanh niên Nguyễn Văn Nghĩa khi ấy ấp ủ ước mơ theo đuổi sự nghiệp thầy thuốc chữa bệnh cứu người.\nƯớc mơ đã trở thành hiện thực khi Nguyễn Văn Nghĩa đậu trường Đại học Y Dược Cần Thơ. Những tháng ngày gắn bó với giảng đường đại học, sinh viên Nguyễn Văn Nghĩa miệt mài học tập, nghiên cứu, rèn luyện, trau dồi kiến thức và kỹ năng chuyên môn. Sau khi tốt nghiệp bác sĩ đa khoa năm 2020, bác sĩ Nghĩa học tiếp chương trình bác sĩ nội trú tại Đại học Y Dược Cần Thơ rồi xuất sắc nhận cùng lúc hai tấm bằng thạc sĩ y khoa và bác sĩ chuyên khoa I năm 2023.\nTrong quãng thời gian học tập, ThS.BS.CKI Nguyễn Văn Nghĩa có cơ hội tiếp xúc với nhiều chuyên khoa khác nhau. Nhờ đó, bác sĩ bén duyên với ngành Tiết niệu. Bác sĩ Nguyễn Văn Nghĩa chia sẻ: “Các bệnh tiết niệu thường phát triển âm thầm, khó phát hiện, nhiều người không có điều kiện tầm soát bệnh sớm nên bệnh dễ bị bỏ quên, đến khi phát hiện thì bệnh đã trở nặng, ảnh hưởng nghiêm trọng chất lượng cuộc sống”. Càng nghiên cứu, học tập và tiếp xúc với nhiều người bệnh, bác sĩ càng nhiệt huyết với lĩnh vực này.\nBên cạnh thế mạnh điều trị các bệnh niệu nữ và niệu học chức năng như bàng quang thần kinh, tiểu không tự chủ, các triệu chứng đường tiểu dưới, sa tạng chậu ở phụ nữ, bế tắc đường ra của bàng quang…; bác sĩ Nguyễn Văn Nghĩa còn thành thạo các kỹ thuật điều trị trị sỏi tiết niệu như tán sỏi ngoài cơ thể, tán sỏi nội soi…\nKhông chỉ đặt tâm huyết trong điều trị bệnh, bác sĩ Nguyễn Văn Nghĩa còn năng nổ trong công tác nghiên cứu khoa học. Chính nỗ lực này đã giúp bác sĩ vinh dự đạt giải thưởng Báo cáo viên triển vọng của Hội Y học giới tính Việt Nam năm 2023.\nHiện, bác sĩ Nguyễn Văn Nghĩa đang sát cánh cùng đội ngũ bác sĩ, chuyên gia tại Đơn vị Niệu Nữ, khoa Tiết niệu, Trung tâm Tiết niệu – Thận học – Nam khoa, Bệnh viện Đa khoa Tâm Anh TP.HCM, giúp người bệnh không chỉ vượt qua các vấn đề sức khỏe mà còn giúp họ cải thiện chất lượng cuộc sống.', 
        N'Nam', 
        N'BS0003.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0004',
        N'Null', 
        N'Dược sĩ Tống Văn Khải tốt nghiệp Dược sĩ tại Đại học Miền Đông. Vào năm 2017, Dược sĩ Tống Văn Khải tiếp tục hoàn thành khóa đào tạo chuyên sâu Định hướng chuyên khoa kiểm soát nhiễm khuẩn tại Đại học Y khoa Phạm Ngọc Thạch.\nVới sự nỗ lực, cống hiến không ngừng nghỉ trong lĩnh vực triển khai, quản lý, giám sát công tác kiểm soát nhiễm khuẩn bệnh viện, vào năm 2018, Dược sĩ Tống Văn Khải được Bộ trưởng Bộ Y tế tặng bằng khen vì có thành tích trong công tác kiểm soát nhiễm khuẩn.\nDược sĩ Tống Văn Khải từng đảm trách nhiều vai trò quan trọng như Phó Trưởng khoa Kiểm soát nhiễm khuẩn tại Bệnh viện Đa khoa Thống Nhất, Trưởng khoa Kiểm soát nhiễm khuẩn tại Bệnh viện Đa khoa Thống Nhất, đóng góp cho hoạt động kiểm soát nhiễm khuẩn noi chung tại bệnh viện.', 
        N'Nam', 
        N'BS0004.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0005',
        N'Null', 
        N'Với mong muốn được giúp đỡ, chăm sóc sức khỏe cho nhiều người, bác sĩ Đỗ Thanh Thư chọn ngành Y để theo đuổi và phát triển sự nghiệp. Bác sĩ Thanh Thư luôn tâm niệm: “Chữa trị cho người bệnh như chính người nhà của mình”.\nTốt nghiệp ngành Bác sĩ Đa khoa Trường Đại học Y khoa Phạm Ngọc Thạch, bác sĩ Thanh Thư tiếp tục theo học bác sĩ nội trú chuyên ngành Tai Mũi Họng tại chính ngôi trường này. Trong quá trình học bác sĩ nội trú, bác sĩ Thanh Thư có nhiều cơ hội thực hành và học hỏi kinh nghiệm tại các bệnh viện lớn như: Bệnh viện Tai Mũi Họng TP.HCM, Bệnh viện Thống Nhất, Bệnh viện Nhi Đồng 1, Bệnh viện Nhân Dân Gia Định.Suốt thời gian học tập và làm việc, bác sĩ Thanh Thư luôn tìm tòi, học hỏi để phát triển chuyên môn, cập nhật nhiều kiến thức mới; tham gia các khóa học đào tạo chuyên sâu về tai mũi họng, tham gia hỗ trợ giảng dạy kỹ năng thực hành lâm sàng tai mũi họng cho sinh viên y trường Đại học Y khoa Phạm Ngọc Thạch.\nBác sĩ Thanh Thư từng có kinh nghiệm làm việc với vai trò bác sĩ điều trị tai mũi họng tại Bệnh viện Nhân Dân 115. Từ tháng 04.2024, bác sĩ Thanh Thư công tác tại Bệnh viện Đa khoa Tâm Anh TP.HCM với vai trò bác sĩ điều trị tai mũi họng.', 
        N'Nữ', 
        N'BS0005.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0006',
        N'Null', 
        N'Năm 1993, THS.BS.CKII Huỳnh Thị Thanh Trang tốt nghiệp Bác sĩ đa khoa tại Đại học Y dược TP.HCM. Sau đó, Bác sĩ Thanh Trang tiếp tục hoàn thành văn bằng Thạc sĩ Y học chuyên ngành Huyết học tại Đại học Y dược TP.HCM vào năm 2002 và tốt nghiệp Bác sĩ chuyên khoa II chuyên ngành Quản lý y tế tại Đại học Y dược Cần Thơ, vào năm 2013.\nTrong suốt quá trình công tác. với tinh thần không ngừng nâng cao trình độ chuyên môn, Thạc sĩ, Bác sĩ Chuyên khoa 2 Thanh Trang tiếp tục tham gia nhiều khóa đào tạo chuyên ngành như: Hướng dẫn triển khai hoạt động An toàn người bệnh tại bệnh viện, Tổng quan về Quản lý chất lượng bệnh viện, Đánh giá viên đánh giá chất lượng bệnh viện, Kiểm soát nhiễm khuẩn cơ bản…\nSau hơn 30 năm công tác, ThS.BS.CKII Huỳnh Thị Thanh Trang đã nhận được nhiều bằng khen, danh hiệu uy tín như Danh hiệu Thầy Thuốc Ưu Tú vào năm 2014, Bằng khen do Ủy ban Nhân dân TP.HCM trao tặng vào các năm 2012, 2014, 2016, 2018, 2020, đạt giải 2 Hội thi Sáng tạo kỹ thuật TP.HCM năm 2019. Bên cạnh đó, ThS.BS.CKII Thanh Trang còn có nhiều công trình nghiên cứu, khảo sát, bài báo được đăng trên các tạp chí, tập san Y học.', 
        N'Nữ', 
        N'BS0006.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0007',
        N'Null', 
        N'Tốt nghiệp trường Đại học Y Hà Nội, bác sĩ Trần Kim Oanh nguyên là Trưởng khoa Tim mạch và Rối loạn chuyển hóa bệnh viện Nội tiết Trung Ương. Với trên 30 năm kinh nghiệm khám chữa bệnh, bác sĩ Oanh được coi là chuyên gia trong chuyên ngành Nội tiết – Đái tháo đường, chuyên điều trị các bệnh về tim mạch liên quan đến Rối loạn chuyển hóa. \nSong song với công tác khám chữa bệnh, Bác sĩ Oanh còn tham gia vào công tác đào tạo khi nhận nhiệm vụ giảng dạy đại học và sau đại học tại bệnh viện Nội tiết Trung ương. Bác sĩ Trần Kim Oanh từng tham gia đề tài Nghiên cứu khoa học cấp nhà nước đề tài KC10 và chủ nhiệm đề tài cấp cơ sở. Bác sĩ Trần Kim Oanh đã 2 lần vinh dự nhận bằng khen của Bộ trưởng bộ Y Tế và là chiến sĩ thi đua cấp cơ sở. Hiện tại BSCKII Trần Kim Oanh là bác sĩ khoa Nội tiết – Đái tháo đường Bệnh viện đa khoa Tâm Anh Hà Nội. ', 
        N'Nữ ', 
        N'BS0007.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0008',
        N'Null', 
        N'ThS.BS Trần Đức Minh là một bác sĩ đã có nhiều năm kinh nghiệm trong nghề với chuyên môn về khám, điều trị và can thiệp các bệnh lý Tim mạch.\nThS.BS Trần Đức Minh không ngừng học hỏi và áp dụng những kỹ thuật, phương pháp trị liệu mới giúp cho bệnh nhân bảo vệ sức khỏe của mình trước những nguy hiểm của bệnh tim mạch. Không chỉ là bác sĩ giỏi chuyên môn, đam mê sáng tạo và có tinh thần trách nhiệm, bác sĩ Minh còn tích cực tham gia công tác tư vấn khám chữa cho bệnh nhân. \nBác sĩ Minh hiện được rất nhiều bệnh nhân và đồng nghiệp tin tưởng. Hiện tại Bác sĩ Minh đang công tác tại Khoa Tim mạch, Bệnh viện Đa khoa Tâm Anh Hà Nội.', 
        N'Nam', 
        N'BS0008.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0009',
        N'Null', 
        N'“Giúp bệnh nhân khỏi bệnh, lấy lại sự tự tin về ngoại hình, cải thiện chất lượng sống luôn là mục tiêu tôi hướng tới”, bác sĩ CKI Võ Thị Tường Duy chia sẻ về điều bản thân tâm huyết nhất trong cuộc đời làm nghề y.\nTừ lý tưởng đi đến hành động\nSinh ra trong gia đình có truyền thống hành nghề Y – Dược, chị đã ý thức được “làm thầy thuốc để cứu người”. Từ nhỏ, bác sĩ Võ Thị Tường Duy sớm nuôi ước mơ trở thành thầy thuốc, tự nhủ bản thân cố gắng học giỏi để theo đuổi ngành Y. Mọi nỗ lực được đền đáp khi chị trúng tuyển vào ngành Y đa khoa – Đại học Y Dược TPHCM và tốt nghiệp vào năm 2016.\nNgay từ lúc ngồi trên ghế giảng đường, bác sĩ Duy được tiếp cận chuyên ngành Da liễu. Trong quá trình thực hành lâm sàng, bác sĩ gặp nhiều trường hợp mắc các bệnh mạn tính về da: vảy nến, lupus, bạch biến… Người mắc những bệnh này chịu những nỗi đau cả thể xác lẫn tinh thần, luôn co cụm, tự ti, hạn chế tiếp xúc với những người xung quanh. Những hình ảnh đó cứ thôi thúc bác sĩ Duy quyết định học chuyên sâu về lĩnh vực Da liễu – Thẩm mỹ Da để giúp người bệnh nhiều hơn.\nTrong quá trình làm việc, gặp nhiều ca bệnh khó, bác sĩ Duy chưa bao giờ đầu hàng mà luôn kiên nhẫn với những thử thách, tận tâm trong công tác điều trị. Thậm chí, có những ca bệnh nhiều nơi không phát hiện ra nhưng chị đã giúp người bệnh hồi phục. Điển hình như trường hợp bệnh nhân nam mắc viêm gan siêu vi B có triệu chứng đau nhức các khớp trên toàn bộ tứ chi, 2 chi dưới xuất hiện nhiều vết ban đỏ. Người bệnh đã đi điều trị ở nhiều nơi, ghé đến hầu như tất cả các khoa về xương khớp, thần kinh tại TPHCM, tuy nhiên bệnh vẫn không được cải thiện. Người bệnh có cơ duyên khi đăng ký khám với bác sĩ Duy, chị nhận thấy đây là một ca hồng ban nút trên bệnh nhân viêm gan siêu vi B. Sau khi được điều chỉnh đơn thuốc, người bệnh nhanh chóng hồi phục sức khỏe.', 
        N'Nữ', 
        N'BS0009.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0010',
        N'Null', 
        N'Với sự kỳ diệu của y học hiện đại, bằng tình yêu thương vô bờ bến và tâm huyết cống hiến với nghề, suốt hơn 30 qua, TS.BS Cam Ngọc Phượng không nhớ mình đã dốc sức chăm sóc, ôm ấp, vỗ về, yêu thương và trao tặng cuộc sống kỳ diệu cho bao nhiêu trẻ sinh non, trong đó có những thiên thần chào đời chỉ bằng một gang tay.\nMỗi ngày chứng kiến những thiên thần chưa đủ ngày, đủ tháng phải trải qua những ngày đầu tiên của cuộc đời trong lồng kính, từng phút đấu tranh chênh vênh giữa mong manh hai bờ sinh – tử, bác sĩ Ngọc Phượng luôn trăn trở, nghiên cứu và học tập với tâm niệm, làm thế nào để phát hiện và xử trí bệnh lý bẩm sinh sớm nhất, áp dụng phương pháp chăm sóc và điều trị tối ưu nhất để các em sớm trở về bên vòng tay bố mẹ thật khỏe mạnh, thông minh.', 
        N'Nữ', 
        N'BS0010.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0011',
        N'Phó giáo sư', 
        N'Phó Giáo sư, Tiến sĩ, Bác sĩ Trần Ngọc Hữu tốt nghiệp Bác sĩ Y khoa tại Trường Đại học Y Dược TP.HCM (1) từ năm 1979. Sau đó, PGS Ngọc Hữu hoàn thành chương trình đào tạo Thạc sĩ chuyên ngành Quản lý Chăm sóc sức khỏe ban đầu tại trường Đại học Mahidol, Thái Lan vào năm 1997, và chương trình đào tạo Tiến sĩ chuyên ngành Vệ sinh học Xã hội và Tổ chức Y tế tại Viện Vệ sinh Dịch tễ Trung ương vào năm 2002. Năm 2012, Tiến sĩ, Bác sĩ Ngọc Hữu chính thức được bổ nhiệm chức danh Phó Giáo sư.\nTrong suốt quá trình nghiên cứu và công tác từ năm 1979 đến hiện nay, PGS.TS.BS Trần Ngọc Hữu đã có nhiều đóng góp to lớn cho nền y học nước nhà, đặc biệt là lĩnh vực y tế dự phòng, vắc xin. Phó giáo sư Ngọc Hữu đã triển khai nhiều đề tài, công trình nghiên cứu khoa học trong và ngoài nước có giá trị. Các đề tài nghiên cứu khoa học điển hình như: “Nghiên cứu đặc điểm dịch tễ học, lâm sàng và vi rút học của Cúm A/H1N1 đại dịch 2009 đề xuất biện pháp phòng chống”, “Đánh giá tính an toàn của vắc xin AgrippalTM S1 phòng cúm trên người Việt Nam tình nguyện”, “Hiệu quả và an toàn của vắc xin mới ngừa sốt xuất huyết bốn týp trên trẻ em khỏe mạnh từ 2 đến 14 tuổi ở châu Á thực hiện tại Mỹ Tho và Long Xuyên”, “Đánh giá các liệu trình chủng ngừa các vắc xin phế cầu khác nhau trên trẻ em”….\nCác Công trình khoa học bao gồm: “Immunogenicity and reactogenicity of ten-valent versus 13-valent pneumococcal conjugate vaccines among infants in Ho Chi Minh City, Vietnam: a randomised controlled trial”, “Three Decades of Dengue Surveillance in Five Highly Endemic South East Asian Countries: A Descriptive Review”, “Efficacy and Long-Term Safety of a Dengue Vaccine in Regions of Endemic Disease” trên tạp chí The  New England Journal of medicine, “Clinical efficacy and safety of a novel tetravalent dengue vaccine in healthy children in Asia: a phase 3, randomised, observer-masked, placebo-controlled trial” trên tạp chí The Lancet…\nPhó Giáo sư, Tiến sĩ, Bác sĩ Trần Ngọc Hữu từng giữ nhiều vị trí quan trọng trong hơn 40 năm công tác như: Giám đốc Trung tâm Y tế Dự phòng tỉnh Long An; Giám đốc Bệnh viện Đa khoa tỉnh Long An; Giám đốc Sở Y tế Long An; Giám đốc Viện Pasteur TP.HCM; Phó Chủ tịch Hội Y học Dự phòng Việt Nam; Phó Chủ tịch Hội đồng Đạo đức trong Nghiên cứu Y sinh học Quốc gia.\nHiện nay, PGS.TS.BS Trần Ngọc Hữu đang giữ vai trò Quản lý Thử nghiệm lâm sàng Vắc xin tại Trung tâm Đào tạo & Nghiên cứu Khoa học, Bệnh viện Đa khoa Tâm Anh TP.HCM.', 
        N'Nam', 
        N'BS0011.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0012',
        N'Null', 
        N'BS Nguyễn Thị Liên Hương đã có hơn 20 năm kinh nghiệm trong lĩnh vực Mô phôi học. Bên cạnh công tác chuyên môn, bác sĩ Liên Hương còn dành nhiều thời gian cho hoạt động nghiên cứu khoa học và đóng góp nhiều công trình nghiên cứu, bài báo khoa học trong lĩnh vực Mô phôi học. \nKhông chỉ là một bác sĩ tài năng với nhiều công trình nghiên cứu có giá trị, TS.BS Liên Hương còn là Giảng viên kiêm nhiệm bộ môn Mô – Công nghệ Phôi tại Đại học Y Hà Nội. Nhiều thế hệ bác sĩ ưu tú của ngành Mô phôi học Việt Nam đã được tiếp lửa yêu nghề và trưởng thành dưới sự hướng dẫn của TS.BS Nguyễn Thị Liên Hương.\nSau nhiều năm công tác tại Bệnh viện Phụ sản Trung ương, bác sĩ Liên Hương chính thức trở thành một thành viên của Trung tâm Hỗ trợ sinh sản, Bệnh viện Đa khoa Tâm Anh Hà Nội với vị trí Phó Giám đốc Trung tâm, phụ trách LAB IVF. “Là một đơn vị được đầu tư mạnh mẽ và toàn diện, đặc biệt hệ thống phòng LAB tại IVFTA sở hữu những thiết bị, công nghệ hiện đại nhất trong ngành hỗ trợ sinh sản. Đội ngũ chuyên viên LAB IVFTA đáp ứng được những tiêu chuẩn cao về trình độ chuyên môn và luôn giữ vững cái tâm với nghề, luôn nỗ lực chắt chiu cơ hội làm mẹ, làm cha cho những gia đình hiếm muộn.” – bác sĩ Liên Hương chia sẻ.', 
        N'Nữ', 
        N'BS0012.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0013',
        N'Phó giáo sư', 
        N'Với kinh nghiệm hơn 30 năm trong ngành Giải phẫu bệnh, PGS.TS.BS Trịnh Tuấn Dũng hiện đang nắm giữ cương vị Giám đốc Trung tâm Giải phẫu bệnh & Tế bào của Bệnh viện Đa khoa Tâm Anh, Chủ tịch Hội Giải phẫu bệnh – Tế bào học Việt Nam. Ông là một chuyên gia hàng đầu về Giải phẫu bệnh & Tế bào học, không chỉ của Việt Nam mà ở tầm quốc tế, giàu kinh nghiệm trong việc đánh giá và đọc kết quả giải phẫu bệnh & tế bào học chuẩn xác, giúp chẩn đoán sớm các bệnh lý ung thư. \nTrong suốt quá trình công tác, PGS.TS.BS Trịnh Tuấn Dũng luôn tận tâm, say mê và dành nhiều thời gian, công sức đầu tư nghiên cứu những công trình khoa học mang giá trị ứng dụng cao. Tiêu biểu phải kể đến những đề tài từ cấp Bộ Quốc phòng, cấp Nhà nước tới cấp cơ sở, cùng 168 bài báo khoa học đã công bố, trong đó có 8 bài công bố ở nước ngoài và nhiều cuốn sách, giáo trình quan trọng về Giải phẫu bệnh khác.\nXuất thân từ Quân đội, được đào tạo và rèn luyện trong Quân đội hơn 40 năm, trước khi trở thành bác sĩ, Phó giáo sư Trịnh Tuấn Dũng đã có 3 năm làm chiến sĩ công tác tại Lữ đoàn Tăng thiết giáp 215. Hoàn thành nghĩa vụ quân sự, với mong muốn được góp phần đẩy lùi các bệnh hiểm nghèo, đặc biệt là bệnh ung thư, ông quyết tâm theo học ngành Giải phẫu bệnh mặc dù thời điểm đó số lượng bác sĩ theo học và công tác trong ngành này không nhiều. Ông thi đỗ vào Học viện Quân y và sau 6 năm miệt mài học tập, ông tốt nghiệp Bác sĩ loại ưu và được chọn về công tác tại Bệnh viện Trung ương Quân đội 108. \nTốt nghiệp Bác sĩ chuyên khoa sơ bộ, rồi chuyên khoa cấp I tại Đại học Y Hà Nội, nhưng với  PGS.TS.BS Trịnh Tuấn Dũng là chưa đủ. Càng học ông càng thấy kiến thức y khoa thật mênh mông rộng lớn. Với niềm đam mê cùng khát khao chữa bệnh cứu người, ông quyết tâm thi đỗ nghiên cứu sinh Tiến sĩ, và sau 5 năm miệt mài học tập, nghiên cứu, ông đã bảo vệ thành công luận án Tiến sĩ Y học được Hội đồng đánh giá xuất sắc. \nTrở về Bệnh viện Trung ương Quân đội 108 công tác, PGS.TS.BS Trịnh Tuấn Dũng được bổ nhiệm làm phó Khoa Giải phẫu bệnh (tháng 10/2000), rồi gần 7 năm sau đó (tháng 6/2007) ông được bổ nhiệm làm Trưởng khoa. \nTừ năm 2012 đến nay, ông còn là Chuyên viên duy nhất của Cục Quân y Bộ Quốc phòng về Giải phẫu bệnh & Tế bào học, thường xuyên được mời tham gia khám chữa bệnh cho các cán bộ cao cấp của Đảng, Nhà nước và Quân đội. Tháng 12/2012, tại Đại hội toàn quốc của Hội Giải phẫu bệnh – Tế bào Việt nam, ông được bầu làm Chủ tịch Hội và liên tục đảm nhiệm trọng trách đó cho tới nay. \nHoàn thành xuất sắc những nhiệm vụ được giao, PGS.TS.BS Trịnh Tuấn Dũng được nhà nước ghi nhận những cống hiến to lớn cho nền Y học, trao tặng Giải thưởng Hồ Chí Minh về KH-CN (01/2017); 4 Bằng khen của Bộ Quốc phòng; 2 Bằng khen của Chủ tịch Tổng hội Y học Việt Nam cùng rất nhiều giải thưởng khác.\nĐể liên tục cập nhật những kiến thức và kỹ thuật tiên tiến, góp phần chẩn đoán và điều trị hiệu quả nhất cho người bệnh, bên cạnh trau dồi kiến thức từ các chương trình đào tạo chuyên môn trong nước và liên tục nỗ lực tự đào tạo, PGS.TS.BS Trịnh Tuấn Dũng còn tham gia nhiều khóa đào tạo chuyên sâu và nâng cao tại Mỹ, Hungary, Nhật, Singapore…\nTừ tháng 01/2020, PGS.TS.BS Trịnh Tuấn Dũng được mời về làm việc tại Bệnh viện Đa khoa Tâm Anh. Hiện nay, ông có mối quan hệ thân thiết với nhiều đồng nghiệp là các Giáo sư hàng đầu của nhiều nước trên thế giới.', 
        N'Nam', 
        N'BS0013.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0014',
        N'Null', 
        N'Với kinh nghiệm trên 20 năm trong lĩnh vực chẩn đoán hình ảnh, đồng thời từng đảm nhận nhiều vị trí quan trọng tại bệnh viện tuyến đầu trên cả nước, TS.BS Nguyễn Duy Trinh đã chẩn đoán thành công nhiều ca bệnh khó, phức tạp, đặc biệt các bệnh lý đau cột sống, khớp vai, đau do thần kinh ngoại biên… trên các thiết bị máy móc hiện đại như: Siêu âm, Cắt lớp vi tính, cộng hưởng từ..\nSau những nỗ lực không ngừng nghỉ trong lĩnh vực Chẩn đoán hình ảnh, TS.BS Nguyễn Duy Trinh vinh dự được Bộ Y Tế trao tặng bằng khen Danh hiệu chiến sĩ thi đua cấp cơ sở. Bên cạnh đó, TS.BS Nguyễn Duy Trinh còn đóng góp các công trình nghiên cứu đề tài khoa học, sách chuyên ngành cùng các bài báo có giá trị thực tiễn.\nNgoài công tác khám chữa bệnh, TS Nguyễn Duy Trình còn tham gia giảng dạy, bồi dưỡng kiến thức cho các bác sĩ tại các tỉnh giúp đẩy mạnh và phát triển lĩnh vực chẩn đoán hình ảnh. TS Duy Trinh góp phần không nhỏ giúp các bác sĩ cập nhật kiến thức và sử dụng máy móc thiết bị một cách hiệu quả nhằm đưa ra những chẩn đoán chính xác và kịp thời, giúp người bệnh có thể rút ngắn thời gian điều trị.', 
        N'Nam', 
        N'BS0014.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0015',
        N'Null', 
        N'BS.CKII Trần Thị Thanh Trúc có gần 15 năm kinh nghiệm thực tiễn và đạt được nhiều thành tựu nhất định trong ngành y, đặc biệt là lĩnh vực nội tim mạch. Tốt nghiệp bác sĩ Y khoa tại Đại học Y Dược TP.HCM vào năm 2005 và tiếp tục hoàn thành văn bằng Thạc sĩ, bác sĩ Trần Thị Thanh Trúc đã không ngừng học hỏi, cập nhật những kiến thức mới và nâng cao nghiệp vụ để cung cấp dịch vụ thăm khám, chẩn đoán, điều trị và tư vấn sức khỏe toàn diện cho bệnh nhân. ', 
        N'Nữ', 
        N'BS0015.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0016',
        N'Null', 
        N'Suốt hơn 20 năm học tập, nghiên cứu và công tác trong lĩnh vực y khoa, bác sĩ Huỳnh Văn Mười Một đã tích lũy được nhiều kinh nghiệm khi từng tiếp cận và giải quyết rất nhiều trường hợp cấp cứu Nội, Ngoại khoa, Nhi khoa… Sau khi tốt nghiệp Đại học Y Dược TP.HCM, Bác sĩ Mười Một tiếp tục theo học để lấy các chứng chỉ ngắn hạn, trong đó có chứng chỉ về Bệnh lý cơ xương khớp và Phục hồi chức năng – vốn rất hữu ích cho công việc chuyên môn của bác sĩ sau này.', 
        N'Nam', 
        N'BS0016.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0017',
        N'Null', 
        N'Với 14 năm kinh nghiệm trong lĩnh vực khám và điều trị về các bệnh lý tim mạch, bác sĩ Nguyễn Đức Hưng là một trong những thầy thuốc luôn được bệnh nhân tin tưởng khi thăm khám và điều trị tại Khoa Tim mạch, Bệnh viện Đa khoa Tâm Anh, Hà Nội.\nTốt nghiệp Trường Đại học Y Hà Nội, bác sĩ Nguyễn Đức Hưng đã đăng ký tham gia các khóa đào tạo của các Viện Tim mạch trong và ngoài nước để trau dồi thêm kiến thức, kỹ năng chuyên môn nhằm mang lại những phác đồ điều trị tiên tiến đến với người bệnh trong quá trình khám chữa bệnh.\nBên cạnh sự tận tâm trong chăm sóc và điều trị cho bệnh nhân, bác sĩ Nguyễn Đức Hưng cũng rất tích cực tham gia các hoạt động nghiên cứu khoa học. Bác sĩ đã thực hiện những đề tài có tính giá trị thực tiễn cao và nhận được nhiều giải thưởng tại những cuộc thi nghiên cứu khoa học uy tín của ngành Y tế. ', 
        N'Nam', 
        N'BS0017.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0018',
        N'Null', 
        N'Với nhiều năm kinh nghiệm trong lĩnh vực Tiết Niệu – Nam khoa, Ths.Bs Nguyễn Tân Cương được đồng nghiệp đánh giá cao và đông đảo bệnh nhân hết lòng tin tưởng để gửi gắm những vấn đề “khó nói” của mình. Bản thân Ths.Bs Tân Cương cũng luôn nỗ lực trau dồi chuyên môn, cập nhật những kiến thức mới, tích cực tham gia các hiệp hội trong nước và quốc tế để có thể đưa ra phác đồ điều trị ưu việt cho từng bệnh nhân, giúp họ cải thiện chất lượng cuộc sống, tìm thấy niềm hạnh phúc lứa đôi.\nThs.Bs Tân Cương có nhiều năm công tác tại chuyên khoa Tiết Niệu – Nam học của các bệnh viện uy tín ở khu vực TP.HCM như Bệnh viện Đại học Y Dược TP.HCM và một số bệnh viện quốc tế khác. Hiện tại, Ths.Bs Tân Cương đang công tác tại Bệnh viện Đa khoa Tâm Anh TP.HCM với vai trò bác sĩ khoa Ngoại Tiết niệu.', 
        N'Nam', 
        N'BS0018.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0019',
        N'Null', 
        N'Phòng LAB được ví như “trái tim” của một trung tâm Hỗ trợ sinh sản bởi đó chính là nơi thực hiện các kỹ thuật vô cùng phức tạp trong thụ tinh nhân tạo, thụ tinh ống nghiệm IVF. Với nhiều năm kinh nghiệm, Thạc sĩ Nguyễn Ngọc Quỳnh đã làm chủ nhiều kỹ thuật hiện đại, tăng khả năng có con của các cặp vợ chồng vô sinh hiếm muộn đã tăng lên gấp nhiều lần. Thạc sĩ Nguyễn Ngọc Quỳnh luôn làm việc với tâm niệm: “Nỗ lực của chúng tôi là mang tiếng cười trẻ thơ đến mọi nhà, đồng thời kết hợp theo dõi và chăm sóc sức khỏe toàn diện cho trẻ em.”', 
        N'Nữ', 
        N'BS0019.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0020',
        N'Null', 
        N'Hơn 15 năm trước, khi lĩnh vực điều trị các bệnh lý nam khoa, hiếm muộn nam vẫn đang bị bỏ quên, ThS.BS.CKII Dương Quang Huy có cơ duyên tiếp cận sớm với các chương trình đào tạo chuyên sâu ở quốc tế, đặc biệt là Chương trình đào tạo sức khỏe nam giới tại trường Đại học Dược John Hopkins – Hoa Kỳ.\nVới thâm niên 15 năm công tác tại các bệnh viện lớn khu vực phía Nam, thực hiện thành công nhiều ca mổ phức tạp như: Vi phẫu tích mô tinh hoàn tìm tinh trùng (micro-Tese), vi phẫu nối ống dẫn tinh & mào tinh, chỉnh hình cơ quan sinh dục nam, tạo hình khiếm khuyết cơ quan sinh dục, ung thư cơ quan sinh dục nam… ThS.BS.CKII Dương Quang Huy trở thành một trong số ít chuyên gia đặt nền móng đầu tiên cho sự phát triển của lĩnh vực này như ngày nay.\nKhông chỉ tận tâm đồng hành cùng từng bệnh nhân, giúp những nam giới vô sinh hiếm muộn có con “chính chủ”, giảm nguy cơ phải xin tinh trùng từ nguồn hiến tặng, ThS.BS.CKII Dương Quang Huy tâm niệm luôn nỗ lực hơn thế để góp phần cải thiện chất lượng cuộc sống của nam giới ngay cả sau khi điều trị.\nThS.BS.CKII Dương Quang Huy cũng say mê nghiên cứu khoa học với nhiều đề tài nghiên cứu trong nước và quốc tế, thường xuyên cập nhật những phương pháp hiện đại nhất trong khám và điều trị các bệnh lý nam khoa, vô sinh nam, đồng thời chia sẻ những kinh nghiệm hay cùng đồng nghiệp trong và ngoài nước, đào tạo phát triển đội ngũ bác sĩ trẻ.', 
        N'Nam', 
        N'BS0020.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0021',
        N'Null', 
        N'Tốt nghiệp chuyên ngành bác sĩ đa khoa loại giỏi tại khoa Y – Đại học Tây Nguyên, Bác sĩ Lê Xuân Nguyên có cơ duyên làm việc tại các bệnh viện lớn về sản khoa trên cả nước như bệnh viện Từ Dũ, phòng khám IVFMD Nam Sài Gòn…\nDù tuổi đời, tuổi nghề còn rất trẻ, nhưng với sự ham học hỏi và tận tâm, bác sĩ Lê Xuân Nguyên được đánh giá là một bác sĩ giỏi, có năng lực và sẽ vươn xa trong ngành Vô sinh hiếm muộn. ', 
        N'Nam', 
        N'BS0021.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0022',
        N'Null', 
        N'BS.CKI Nguyễn Phạm Thùy Linh có hơn 12 năm kinh nghiệm thăm khám và điều trị trong lĩnh vực Nội tim mạch nhi. Sau khi tốt nghiệp Đại học Y khoa Phạm Ngọc Thạch, bác sĩ Nguyễn Phạm Thùy Linh tham gia các khóa tu nghiệp tại Malaysia và Hàn Quốc về lĩnh vực Tim mạch nhi. Bác sĩ Nguyễn Phạm Thùy Linh gắn bó với Bệnh viện tim Tâm Đức TP.HCM trong suốt thời gian dài, đồng thời trở thành thành viên Hội Tim mạch Việt Nam và Phân hội Siêu âm tim Việt Nam. \nDành tình yêu đặc biệt đối với các em nhỏ không may bị bệnh tim bẩm sinh, bác sĩ Nguyễn Phạm Thùy Linh chia sẻ: “Nếu chỉ còn một ngày để sống, hãy để tôi chăm sóc những em bé bị tim bẩm sinh. Các bé sinh ra đã không được may mắn. Bằng sự chăm sóc đúng cách với trái tim chân thành, hy vọng tôi sẽ giúp giảm đi nỗi đau trong những trái tim không lành lặn ấy”.', 
        N'Nữ', 
        N'BS0022.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0023',
        N'Null', 
        N'BS.CKII Ngô Trường Sơn có gần 20 năm kinh nghiệm điều trị ung thư và được đào tạo bài bản chuyên môn ở trong nước cũng như quốc tế. Sau khi tốt nghiệp chuyên ngành đa khoa tại Đại học Y Hà Nội – Ngôi trường đào tạo y khoa danh tiếng hàng đầu cả nước, bác sĩ Sơn tiếp tục hoàn thành xuất sắc khóa đào tạo bác sĩ nội trú và bác sĩ chuyên khoa II tại đây. Không dừng lại ở đó, với mong muốn học tập và cập nhật những phác đồ hiện đại nhất giúp người bệnh ung thư kiểm soát và điều trị hiệu quả, bác sĩ Sơn đã tham gia nhiều chương trình đào tạo nâng cao tại các quốc gia có nền y học phát triển như: Mỹ, Đan Mạch, Tây Ban Nha, Singapore…\nTrong suốt quá trình công tác và học tập, bác sĩ đã áp dụng nhiều kỹ thuật công nghệ cao về xạ trị và hóa chất vào điều trị các bệnh lý ung thư. Cùng với công tác khám chữa bệnh bác sĩ Sơn còn tham gia đào tạo, giảng dạy, chỉ đạo tuyến, viết sách chuyên ngành và nghiên cứu khoa học. Nhờ thành tích xuất sắc trong công tác giảng dạy và điều trị bác sĩ Sơn nhận được nhiều bằng khen của lãnh đạo các cấp. Bác sĩ Sơn cũng luôn được người bệnh yêu quý bởi sự gần gũi và giản dị.', 
        N'Nam', 
        N'BS0023.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0024',
        N'Null', 
        N'Tốt nghiệp Á khoa tại đại học y khoa Phạm Ngọc Thạch năm 1998 với tấm bằng loại Giỏi, BS.CKII Lê Thanh Hùng được giữ lại làm giảng viên tại trường. Bác sĩ Thanh Hùng đã có 23 năm kinh nghiệm giảng dạy và thực hành trong lĩnh vực Sản Phụ khoa, tu nghiệp nội trú tại Bệnh viện Pellegrin-Bordeaux-Pháp. Bác sĩ Thanh Hùng từng phụ trách nhiều ca sinh và mổ khó như song thai, tiền sản giật, nhau tiền đạo, vết mổ lấy thai nhiều lần…\nĐể giúp sản phụ vượt qua những khó khăn trong quá trình sinh nở, Bác sĩ Thanh Hùng thường dành nhiều thời gian trò chuyện cùng sản phụ, giúp họ giảm bớt lo âu. Trong từng ca mổ khó, Bác sĩ Thanh Hùng luôn tập trung cao độ để đảm bảo sự an toàn cho cả mẹ và bé. Bác sĩ Thanh Hùng cũng từng là bác sĩ đại diện cho Việt Nam góp mặt trong chương trình 4 Babies A Second, một phóng sự của kênh truyền hình National Geographic năm 2015 về các ca sinh tại nhiều quốc gia trên thế giới.', 
        N'Nam', 
        N'BS0024.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0025',
        N'Null', 
        N'Là một trong những bác sĩ trẻ tài năng của khoa Tiết niệu – Nam học, Bệnh viện Đa khoa Tâm Anh Hà Nội, ThS.BS Tạ Ngọc Thạch luôn muốn tiếp cận và áp dụng nhiều phương pháp, kỹ thuật khám, chữa bệnh tiên tiến để cứu chữa cho nhiều người bệnh. \nTốt nghiệp Đại học Y Dược Thái Nguyên, chàng sinh viên y khoa đến từ “Thủ đô Chè Việt Nam”, với tinh thần ham học, đã chuẩn bị hành trang lên Hà Nội, tiếp tục chinh phục lĩnh vực chuyên khoa Ngoại, và bắt đầu bén duyên với ngành Nam học từ đây. Năm 2015, anh được trao tặng danh hiệu Chiến sĩ thi đua cấp cơ sở khi đóng góp nhiều đề tài nghiên cứu khoa học mang tính ứng dụng cao như: “Đánh giá kết quả điều trị cắt túi mật qua phẫu thuật nội soi tại BV Gang thép Thái Nguyên”; “Kết quả ghép thận ở bệnh nhân suy thận mạn giai đoạn cuối từ người cho sống tại BV TƯ Thái Nguyên”…', 
        N'Nam', 
        N'BS0025.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0026',
        N'Null', 
        N'Với hơn 20 năm công tác trong ngành Y, TS.BS Chế Đình Nghĩa được biết đến là một trong những chuyên gia hàng đầu Việt Nam trong lĩnh vực Chấn thương chỉnh hình và Phẫu thuật tạo hình. Bác sĩ Đình Nghĩa đã giúp nhiều bệnh nhân thoát khỏi những cơn đau đớn, phục hồi khả năng vận động và tránh được nhiều biến chứng nguy hiểm nhờ đường mổ nhỏ, ít đau đớn, giảm tỷ lệ nhiễm trùng, rút ngắn thời gian và tăng khả năng hồi phục…\nSau khi tốt nghiệp Đại học Y Hà Nội (2001), bác sĩ Đình Nghĩa tiếp tục tham gia đào tạo Thạc sĩ Ngoại khoa tại trường (2007) và Tiến sĩ Y học tại Viện Nghiên cứu Khoa học Y Dược Lâm sàng 108 (2019). Hơn 20 năm nghiên cứu và làm việc, Bác sĩ Đình Nghĩa đã điều trị thành công nhiều ca bệnh khó trong lĩnh vực vi phẫu như: trồng nối lại chi thể đứt rời, điều trị các tổn thương liệt đám rối cánh tay, điều trị liệt mặt, tạo hình tuyến vú sau phẫu thuật đoạn vú ung thư, siêu vi phẫu thuật nối thông bạch mạch – tĩnh mạch và chuyển ghép vi phẫu hạch bạch huyết điều trị phù bạch mạch chi thể, chuyển ghép vạt xương mác phục hồi mất đoạn xương sau cắt bỏ khối U vùng đầu mặt, chi thể… \nNgoài ra, bác sĩ Đình Nghĩa dành thời gian tham gia nghiên cứu khoa học, góp phần vào sự tiến bộ chung của ngành. Một số đề tài như nghiên cứu đặc điểm chẩn đoán và kết quả điều trị phẫu thuật tổn thương động mạch chi dưới bằng ghép tĩnh mạch tự thân tại Bệnh viện Việt Đức, nghiên cứu ứng dụng kỹ thuật vi phẫu trong trồng nối chi thể đứt rời… và nhiều báo cáo khoa học về vi phẫu tạo hình. Các nghiên cứu và báo cáo được đánh giá cao, đóng góp không nhỏ vào sự phát triển của nền y học hiện đại. ', 
        N'Nam', 
        N'BS0026.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0027',
        N'Giáo sư', 
        N'Với hơn 40 năm kinh nghiệm trong lĩnh vực Nội hô hấp, đồng thời từng đảm nhận nhiều vị trí quan trọng tại các bệnh viện lớn hàng đầu cả nước, TTND.GS.TS.BS Ngô Quý Châu hiện đang là Giám đốc chuyên môn, kiêm cố vấn chuyên môn khoa Nội hô hấp, Bệnh viện Đa khoa Tâm Anh, Hà Nội. Tên tuổi TTND.GS.TS.BS Ngô Quý Châu không chỉ vang danh trong nước mà còn “phủ sóng” sang cả các nước châu  Âu – nơi vốn có nền y học hiện đại nhất thế giới. Các thành tựu mà Giáo sư Ngô Quý Châu đạt được, cùng những cống hiến của ông cho nền Y khoa nước nhà như khẳng định thêm cho câu nói: “Trong lĩnh vực Nội tổng hợp nói chung và Phổi – Hô hấp nói riêng, giáo sư Ngô Quý Châu xứng đáng là cây đa cây đề”. \nNăm 1977, cậu học trò Ngô Quý Châu thi đỗ vào trường Đại học Y khoa Hà Nội. Từ quê hương Bắc Giang, chàng trai trẻ khăn gói ra Hà Nội bắt đầu sự nghiệp học tập, tìm tòi và nghiên cứu. Năm 1983, chàng bác sĩ trẻ Ngô Quý Châu xuất sắc nhận bằng loại giỏi – phần thưởng xứng đáng cho những nỗ lực và cố gắng của ông suốt những năm tháng ngồi giảng đường Đại học Y Hà Nội. \nĐủ điều kiện thi tuyển khóa đào tạo bác sĩ nội trú chuyên khoa I, bác sĩ Ngô Quý Châu tiếp tục chinh phục bầu trời tri thức tại Bệnh viện Bạch Mai – Bộ môn Nội Tổng hợp, Trường Đại học Y Hà Nội. Trong số các bác sĩ nội trú khóa đào tạo lúc bấy giờ, ông là người duy nhất được chuyển thẳng làm nghiên cứu sinh. Ba năm miệt mài nghiên cứu, năm 1992, Ngô Quý Châu đã bảo vệ thành công luận án Tiến sĩ về đề tài ung thư phổi khi mới 32 tuổi. Ông chính là vị bác sĩ trẻ nhất của Việt Nam nhận bằng Tiến sĩ Y khoa lúc bấy giờ.  \nKhông dừng lại ở việc trau dồi kiến thức ở môi trường đào tạo trong nước, bác sĩ Ngô Quý Châu còn có khoảng thời gian dài sang Pháp nghiên cứu và thực tập trong nhiều chuyên ngành y khoa: ung thư học, bệnh phổi nghề nghiệp và môi trường… Năm 1995, ông là người Việt Nam đầu tiên thi đỗ vào khóa học Liên các trường đại học của Pháp chuyên sâu về phổi và được Bộ Y tế cho phép tiếp tục học ở Pháp thêm 4 năm nữa. Cuối năm 1999, ông trở lại Việt Nam và công tác tại Bệnh viện Bạch Mai, Hà Nội.', 
        N'Nam', 
        N'BS0027.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0028',
        N'Giáo sư', 
        N'NGND.GS.TS.BS Trần Quán Anh là người đầu tiên đặt nền móng cho ngành Nam học Việt Nam.\nÔng là Tổng Thư ký Hội Tiết niệu – Thận học Việt Nam, Hội viên Hội Tiết niệu thế giới (S.I.U), là người khởi xướng xây dựng phân khoa nam học, thuộc Khoa tiết niệu, Bệnh viện Việt – Đức, Hà Nội. Từng tham gia nhiều hội nghị quốc tế về nam học tại nhiều quốc gia trên thế giới, Giáo sư Trần Quán Anh tiến hành hàng chục công trình nghiên cứu quý giá gây dựng cho bộ môn khoa học từ non trẻ đến gặt hái được những thành tựu to lớn ở Việt Nam hiện nay.\nHơn nửa thế kỷ cống hiến hết mình cho nền Y học nước nhà, lúc đất nước có chiến tranh, không ngồi yên ở trường đại học, hay phòng nghiên cứu, bác sĩ Trần Quán Anh đã xông pha khắp các vùng đất ác liệt như Hà Tĩnh, Quảng Bình, Quảng Trị… để phục vụ các thương bệnh binh; có nhiều binh trạm số lượng chiến sĩ bị thương hơn 1000 người, người bác sĩ trẻ ấy và các đồng nghiệp phải đã việc không ngừng nghỉ trong suốt nhiều ngày đêm dưới hầm tối với ánh sáng “phòng mổ” chỉ từ những chiếc đèn pha xe đạp. Thậm chí tay không dám ngưng một phút vì “nếu bác sĩ phẫu thuật nghỉ ngơi là đồng nghĩa với chấp nhận đồng đội của mình hy sinh”.\nGác lại những hồi ức tuổi trẻ ở chiến trường, bom đạn, nơi ông là một người lính cầm dao mổ để cứu chữa thương, bệnh binh, hòa bình lập lại, Giáo sư dành trọn vẹn tình yêu tâm sức và quyết gắn bó thuỷ chung với nghề Y. Ông trở thành một trong những người đặt nền móng đầu tiên xây dựng ngành tiết niệu nam học ở Việt Nam và góp phần rất lớn vào sự phát triển của ngành nam học ngày nay. ', 
        N'Nam', 
        N'BS0028.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0029',
        N'Null', 
        N'ThS.BS.CKII Trần Anh Vũ tốt nghiệp Thạc sĩ Chấn thương chỉnh hình, Đại học Y Dược TP. HCM, từng tu nghiệp tại Pháp và Tây Ban Nha để nâng cao kiến thức và kỹ năng trong lĩnh vực Chấn thương chỉnh hình. Bác sĩ Anh Vũ đã điều trị thành công cho rất nhiều trường hợp gặp phải các chấn thương thể thao từ nhẹ đến nghiêm trọng, giúp bệnh nhân phục hồi nhanh chóng và trở lại với đam mê thể thao.\nBác sĩ Anh Vũ có thời gian 5 năm làm việc tại khoa Chấn thương chỉnh hình, Bệnh viện Nguyễn Tri Phương (TP. HCM) trước khi gia nhập Bệnh viện Đa khoa Tâm Anh TP. HCM với vai trò Trưởng khoa Y học thể thao và Nội soi, Trung tâm Chấn thương Chỉnh hình.', 
        N'Nam', 
        N'BS0029.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0030',
        N'Null', 
        N'BS.CKI Hồ Thị Khánh Quyên tốt nghiệp và nhận Bằng chuyên khoa cấp I Sản Phụ khoa tại Đại học Y Dược Cần Thơ. Ngoài ra, bác sĩ còn đạt được các chứng nhận về phẫu thuật nội soi cơ bản trong phụ khoa, soi cổ tử cung, kỹ thuật bơm tinh trùng vào buồng tử cung, cấy và rút que tránh thai IMPLANON NXT và là hội viên hội Nội tiết sinh sản và Vô sinh TPHCM (HOSREM). Với 14 năm kinh nghiệm làm việc tại bệnh viện Đa Khoa tỉnh Kiên Giang và bệnh viện Đa khoa Hoàn Mỹ Sài Gòn cùng phương châm “Đừng cố gắng trở thành người thành công, hãy cố gắng là người có giá trị”, bác sĩ Khánh Quyên luôn nỗ lực để tận tay chào đón những thiên thần bé nhỏ và mang lại niềm hạnh phúc cho các sản phụ.', 
        N'Nữ', 
        N'BS0030.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0031',
        N'Null', 
        N'Xuất thân từ Đại học Y Dược Huế, BS.CKI Nguyễn Quang Nhật có gần 10 năm kinh nghiệm trong lĩnh vực khám và điều trị Sản Phụ khoa tại các bệnh viện như bệnh viện Đa khoa tỉnh Đồng Nai và bệnh viện Đa khoa Hoàn Mỹ Sài Gòn. Với những kinh nghiệm tích lũy được trong quá trình học tập và làm việc, bác sĩ Quang Nhật đã phẫu thuật thành công ca nội soi cấp cứu vỡ thai ngoài tử cung đoạn kẽ, song thai IVF.\nTham gia ngành y với mong muốn được cống hiến cho xã hội, bác sĩ Quang Nhật luôn không ngừng học hỏi và cập nhật những phương pháp y khoa tiên tiến để hỗ trợ các thai phụ có một thai kỳ khỏe mạnh và trải nghiệm vượt cạn an toàn. Bác sĩ Quang Nhật đang là hội viên hội Nội tiết sinh sản và Vô sinh TP.HCM – HOSREM.', 
        N'Nam', 
        N'BS0031.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0032',
        N'Null', 
        N'Sau khi tốt nghiệp bác sĩ nội trú tại Đại học Y Hà Nội, với niềm đam mê và tâm huyết đối với lĩnh vực tiêu hóa, BS Đào Trần Tiến tiếp tục tham gia nhiều khóa đào tạo chuyên sâu trong và ngoài nước về các kỹ thuật can thiệp điều trị bệnh lý Tiêu hóa – Gan mật – Tụy. Trong đó có các kỹ thuật hiện đại như nội soi điều trị ung thư dạ dày sớm và cắt cơ thắt thực quản (POEM), đào tạo cầm tay Nội soi can thiệp Tiêu hoá nâng cao (ESD)…\nBác sĩ Tiến có thế mạnh trong chẩn đoán, điều trị các bệnh lý thực quản, dạ dày, đại tràng, bệnh lý về gan, đường mật, tụy; làm chủ kỹ thuật nội soi can thiệp điều trị xuất huyết tiêu hóa, cắt cơ thực quản, cắt ung thư sớm; sử dụng nội soi mật tuỵ ngược dòng trong chẩn đoán và điều trị các bệnh lý đường mật, ống tụy, và túi mật…\nĐồng thời, bác sĩ Tiến cũng tích cực tham gia nghiên cứu khoa học và là tác giả của nhiều công trình nghiên cứu có tính thực tiễn cao. Với những cống hiến không ngừng nghỉ đó, bác sĩ Đào Trần Tiến đã nhận được bằng khen của Bộ Y tế, bằng khen Chiến sĩ thi đua cấp cơ sở tại Bệnh viện Bạch Mai…', 
        N'Nam', 
        N'BS0032.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0033',
        N'Null', 
        N'Năm 2015, bác sĩ Hà Thị Loan tốt nghiệp chuyên ngành Bác sĩ Đa khoa tại trường Đại học Y dược Thái Nguyên. Với tinh thần học hỏi nâng cao chuyên môn nhằm hoàn thiện bản thân, có thể điều trị thành công nhiều ca bệnh khó, bác sĩ Loan tiếp tục học tập, hoàn thành nhiều chuyên ngành sau đại học như Hồi sức cấp cứu, siêu âm tổng quát, nội soi tiêu hóa trên, nội soi đại tràng.\nThS.BSNT Hà Thị Loan là bác sĩ trẻ nhiều tâm huyết với người bệnh, tận tụy với công việc khám chữa bệnh tại khoa Tiêu hóa – Gan Mật – Tụy, Bệnh viện Đa khoa Tâm Anh Hà Nội. Bên cạnh đó, bác sĩ luôn dành thời gian nghiên cứu chuyên sâu. Tiêu biểu là công trình nghiên cứu: Đặc điểm lâm sàng, cận lâm sàng và nồng độ Procalcitonin huyết thanh ở bệnh nhân nhiễm khuẩn huyết điều trị tại Bệnh viện đa khoa Trung Ương Thái Nguyên năm 2018.', 
        N'Nữ', 
        N'BS0033.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0034',
        N'Null', 
        N'ThS. BS Mai Mạnh Tam được đào tạo cơ bản và chuyên sâu lĩnh vực Nội – Hô Hấp tại trường Đại học Y Hà Nội từ năm 2003, có nhiều kinh nghiệm trong thăm khám và điều trị bệnh. Thời gian học tập tại National Center for Global Health and Medicine (NCGM – Nhật Bản) giúp Bác sĩ Mai Mạnh Tam ưu thế phát triển kỹ thuật nội soi phế quản.\nBác sĩ Mai Mạnh Tam đã đóng góp nhiều đề tài, công trình nghiên cứu khoa học, vinh dự nhận được giải thưởng Chiến sĩ thi đua do Sở Y tế trao tặng.', 
        N'Nam', 
        N'BS0034.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0035',
        N'Null', 
        N'BSNT Lã Quý Hương là bác sĩ  trẻ được đào tạo chuyên biệt – hệ Bác sĩ Nội trú, chuyên ngành Nội khoa tại một trong những trường đại học về Y lớn nhất cả nước – Đại học Y Hà Nội và thực tập tại Bệnh viện Đại học Ajou (Hàn Quốc). \nLà bác sĩ vững vàng về chuyên môn tại chuyên khoa Nội Hô hấp, bác sĩ Lã Quý Hương để lại ấn tượng tốt cho người bệnh trong suốt quá trình theo dõi tình trạng sức khỏe khi thăm khám, điều trị tại bệnh viện.\nNgoài ra, BSNT Lã Quý Hương thường xuyên tham gia các khóa đào tạo cơ bản cũng như nâng cao trong và ngoài nước để cập nhật các kiến thức y khoa mới. BS Hương là thành viên tích cực của Hội Hô hấp Việt Nam, Hội Hô hấp Hà Nội và Hội Y học Giấc ngủ Việt Nam.', 
        N'Nữ', 
        N'BS0035.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0036',
        N'Null', 
        N'Với nhiều năm kinh nghiệm trong lĩnh vực Nội tổng hợp và công tác tại bệnh viện tuyến đầu của cả nước, BSNT. Nguyễn Văn Ngân đã điều trị thành công hàng trăm ca bệnh hô hấp phổ biến như: Viêm phế quản, viêm phổi, COPD, hen phế quản, ung thư phổi,… cũng như các bệnh hô hấp chuyên sâu như: Lao, bệnh tích protein phế nang, viêm phổi kẽ, xơ phổi vô căn, Sarcoidosis,… \nLà thành viên tích cực của Hội hô hấp Việt Nam, Hội hô hấp Hà Nội, Hội hô hấp Thành phố Hồ Chí Minh, BS Nguyễn Văn Ngân luôn dẫn đầu trong các hoạt động, hội thảo về chuyên môn, cập nhật những kỹ thuật mới và ứng dụng linh hoạt, sáng tạo trong việc điều trị cho người bệnh một cách hiệu quả nhất. ', 
        N'Nam', 
        N'BS0036.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0037',
        N'Null', 
        N'ThS.BSNT. Đặng Thành Đô tốt nghiệp xuất sắc tại trường ĐH Y Hà Nội với nhiều thành tích đáng nể. Là một trong những bác sĩ trẻ được đánh giá cao về chuyên môn, bác sĩ Đặng Thành Đô được giữ lại giảng dạy tại Đại học Y Hà Nội, đây cũng là cơ hội để bác sĩ “truyền lửa” đam mê và nhiệt huyết cống hiến cho nhiều thế hệ sinh viên.\nTrong suốt quá trình khám chữa bệnh tại các cơ sở y tế đầu ngành của cả nước, BS Đô đã thăm khám và điều trị thành công hàng nghìn ca bệnh mắc các bệnh lý hô hấp, đặc biệt là bệnh Phổi tắc nghẽn mạn tính. \nNgoài ra, BS Đô luôn dành nhiều thời gian và tâm huyết để giải đáp thắc mắc, tư vấn giúp người bệnh nhanh chóng cải thiện các vấn đề sức khỏe.', 
        N'Nam', 
        N'BS0037.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0038',
        N'Null', 
        N'Với nhiều năm kinh nghiệm thực tiễn tích lũy tại các bệnh viện lớn, ThS.BSNT. Thân Thị Ngọc Lan được các chuyên gia đầu ngành đánh giá cao về trình độ chuyên môn cũng như nhiệt huyết với công tác khám chữa bệnh. Không chỉ dừng lại ở trong nước, ThS.BSNT Ngọc Lan còn tham gia nhiều đào tạo khoa học liên đại học Pháp – Việt về phương pháp chẩn đoán và điều trị bệnh lý hô hấp. \nVới hơn 10 năm học tập và công tác, bác sĩ Thân Thị Ngọc Lan đã giải quyết được nhiều vấn đề sức khỏe cho người bệnh trong lĩnh vực hô hấp. Luôn tận tâm, chu đáo với từng người bệnh, Ths.BSNT. Ngọc Lan trở thành lựa chọn tin cậy được nhiều người bệnh khi đến thăm khám và điều trị tại Khoa Nội Hô hấp, Bệnh viện Đa Khoa Tâm Anh Hà Nội.', 
        N'Nữ', 
        N'BS0038.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0039',
        N'Null', 
        N'Tốt nghiệp Trường Đại học Y Hà Nội (2018) – đơn vị đào tạo y khoa hàng đầu cả nước, bác sĩ Trần Duy Hưng tiếp tục tham gia chương trình đào tạo Bác sĩ Nội trú. Sau 3 năm học tập, rèn luyện, bác sĩ Trần Duy Hưng đã xuất sắc hoàn thành khóa học và công tác tại khoa Hô hấp, Bệnh viện Đa khoa Tâm Anh Hà Nội.\nLà người đầy nhiệt huyết, đam mê với công việc, không quản ngại khó khăn thử thách, bác sĩ Trần Duy Hưng đã tích cực tham gia công tác phòng chống và hỗ trợ điều trị người bệnh Covid-19 trong đợt dịch bệnh bùng phát nghiêm trọng, giúp không ít bệnh nhân khỏi bệnh trở về với gia đình.\nBác sĩ Trần Duy Hưng còn dành nhiều thời gian nghiên cứu sâu về phương pháp chẩn đoán, điều trị hiệu quả các bệnh lý đường hô hấp ở người lớn, không ngừng cập nhật các kiến thức mới để áp dụng trong thực tiễn khám chữa bệnh.', 
        N'Nam', 
        N'BS0039.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0040',
        N'Null', 
        N'Dược sĩ Cẩn Tuyết Nga tốt nghiệp xuất sắc Đại học Dược Piatigorsk (Cộng hòa Liên Bang Nga). Với mong muốn nâng cao chuyên môn, trau dồi kiến thức, dược sĩ Nga trở về Việt Nam, tiếp tục tham gia nghiên cứu và được cấp bằng tiến sĩ tại Đại học Dược Hà Nội.\nVới hơn 30 năm công tác trong ngành Y Dược, TS.DS Cẩn Tuyết Nga từng đảm nhiệm nhiều vị trí quan trọng tại Bệnh viện Bạch Mai như Phó khoa Dược (2013 – 2018), Trưởng khoa Dược (2019 – 2020). Tại đây, TS Nga đã tổ chức hoạt động dược lâm sàng, thông tin các loại thuốc, góp phần giúp người bệnh sử dụng thuốc an toàn, hợp lý, hiệu quả.\nTrong quá trình công tác, TS.DS Cẩn Tuyết Nga đã tham gia xây dựng và triển khai thành công ứng dụng phần mềm cảnh báo các vấn đề liên quan đến thuốc khi kê đơn thuốc ngoại trú tại bệnh viện Bạch Mai (là một trong những đơn vị đầu tiên đưa ra ý tưởng và phát triển được phần mềm cảnh báo khi kê đơn)', 
        N'Nữ', 
        N'BS0040.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0041',
        N'Null', 
        N'Bác sĩ Hậu được đào tạo chuyên ngành Nhi khoa tại trường Đại học Y Nhi Leningrad, Liên xô. Sau khi tốt nghiệp, bác sĩ tiếp tục thực tập sau đại học tại trường, tích lũy kinh nghiệm thăm khám và điều trị cho các bệnh nhi. Bác sĩ Hậu đã có hơn 30 năm kinh nghiệm trong chuyên ngành Nhi khoa.\nBên cạnh công tác chuyên môn, bác sĩ Trần Đức Hậu dành thời gian tham dự nhiều khóa đào tạo nâng cao chuyên môn và báo cáo tại các hội nghị khoa học trong nước và quốc tế chuyên ngành Nhi, chuyên ngành Nhi Ung thư. Đồng thời bác sĩ là giảng viên thỉnh giảng của Bộ môn Nhi, Đại học Y Hà Nội trong nhiều năm, tham gia vào công tác đào tạo sau đại học.', 
        N'Nam', 
        N'BS0041.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0042',
        N'Null', 
        N'Bằng chuyên môn vững chắc cùng bề dày kinh nghiệm 20 năm về Nhi khoa, ThS.BSNT Lê Thị Lan Anh được nhiều bố mẹ đánh giá “mát tay” trong thăm khám và điều trị các bệnh lý ở trẻ nhỏ. Sự cẩn thận, nhẹ nhàng của bác sĩ Lan Anh là điều mà các bậc phụ huynh hoàn toàn an tâm và tin tưởng.\nBác sĩ Lan Anh tốt nghiệp Đại học Y Hà Nội và tiếp tục đào tạo chuyên sâu về Thạc sĩ, Bác sĩ nội trú chuyên khoa Nhi. Trong suốt thời gian cống hiến cho ngành Y, bác sĩ Lan Anh luôn không ngừng hoàn thiện chuyên môn về kỹ năng, tham gia nghiên cứu, cập nhật các kỹ thuật, phương pháp mới.\nKhông chỉ là tác giả của nhiều đề án nghiên cứu giá trị, bác sĩ Lan Anh cũng là gương mặt quen thuộc trong nhiều chương trình về sức khỏe với vai trò chuyên gia tư vấn và là Hội viên Hội Nhi khoa Việt Nam.', 
        N'Nữ', 
        N'BS0042.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0043',
        N'Null', 
        N'Với 15 năm kinh nghiệm trong ngành Chẩn đoán hình ảnh, BSCKI Nguyễn Văn Lan – Phó khoa Chẩn đoán hình ảnh, Bệnh viện Đa khoa Tâm Anh, Hà Nội đã ứng dụng các kỹ thuật tiên tiến vào chẩn đoán, giúp phát hiện sớm các bệnh lý, hỗ trợ bác sĩ điều trị đưa ra phác đồ điều trị sớm và hiệu quả cho người bệnh.\nNgay sau khi tốt nghiệp Bác sĩ Y khoa tại Đại học Y Thái Bình, ông đã “đầu quân” cho Bệnh viện Đa khoa tỉnh Hà Tĩnh. Sau 10 năm giữ vai trò bác sĩ đa khoa, tiếp xúc với nhiều bệnh nhân, trải nghiệm khám chữa bệnh thực tế, ông nhận ra việc chẩn đoán bệnh chính xác, kịp thời giữ vai trò quan trọng, là yếu tố tiên quyết trong điều trị bất kỳ loại bệnh nào. Thấu hiểu tầm quan trọng đó, cùng khát khao muốn cứu chữa nhiều bệnh nhân, bác sĩ Nguyễn Văn Lan tiếp tục theo học Bác sĩ chuyên khoa I – Chuyên ngành Chẩn đoán hình ảnh và tốt nghiệp vào năm 2005. 2 năm sau đó, ông nhận được Chứng chỉ An toàn bức xạ trong X-quang y tế và tiếp tục đạt nhiều thành tựu trong lĩnh vực chẩn đoán hình ảnh, đóng góp cho sự phát triển của y học nước nhà.', 
        N'Nam', 
        N'BS0043.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0044',
        N'Null', 
        N'Với gần 10 năm kinh nghiệm và từng công tác tại các bệnh viện tuyến đầu của cả nước trong lĩnh vực Chẩn đoán hình ảnh và điện quang can thiệp, BSCKII. BSNT Lê Văn Khánh đã thực hiện thành công hàng nghìn ca đốt sóng cao tần RFA tuyến giáp, thực hiện nút mạch thành trong u xơ tử cung, u xơ tuyến tiền liệt và đặc biệt kỹ thuật nút tĩnh mạch thừng tinh trong trường hợp vô sinh hiếm muộn.\nMong muốn trau dồi kiến thức, kỹ năng, nâng cao chuyên môn nghề nghiệp, BSNT Lê Văn Khánh nhiệt tình tham gia nhiều khóa học chuyên sâu tại Hàn Quốc như: cắt u hút u vú chân không VABB, đốt sóng cao tầng RFA tuyến giáp… BS Khánh còn dành thời gian nghiên cứu các công trình liên quan đến Chẩn đoán hình ảnh và Điện quang can thiệp, vinh dự được đăng tải các công trình có giá trị thực tiễn trên tạp chí trong và ngoài nước. \nNhờ những cống hiến hết mình trong công tác khám chữa bệnh và nghiên cứu khoa học, BS Khánh được lãnh đạo viện và đồng nghiệp đánh giá cao về chuyên môn, nhiệt huyết với công việc, hết mình vì người bệnh.', 
        N'Nam', 
        N'BS0044.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0045',
        N'Null', 
        N'BS.CKII Lê Nguyệt Minh đã có hơn 10 năm kinh nghiệm trong lĩnh vực chẩn đoán hình ảnh và can thiệp điện quang. Tốt nghiệp Đại học Y Hà Nội – một trong những môi trường đào tạo y khoa danh tiếng nhất cả nước, Bác sĩ Minh tiếp tục tham gia thêm nhiều chương trình đào tạo chuyên sâu từ các trường đại học nổi tiếng thế giới như chứng chỉ DFMSA tại Trường đại học Clermont Auvergne (Pháp), đào tạo chẩn đoán hình ảnh tại Bệnh viện Đại học San Antonio (Mỹ), chứng chỉ sinh thiết vú có hỗ trợ hút chân không (VABB) tại Seoul (Hàn Quốc)…\nDành hết thời gian và tâm huyết của mình cho lĩnh vực chẩn đoán hình ảnh và can thiệp vú – tĩnh mạch, Bác sĩ Minh không chỉ xuất sắc trong hoạt động khám chữa bệnh, mà còn đóng góp xây dựng nên nhiều công trình nghiên cứu khoa học có giá trị lớn trong và ngoài nước. Tiêu biểu như công trình “Nghiên cứu đặc điểm hình ảnh suy tĩnh mạch chi dưới tại Bệnh viện Bạch Mai” đăng trên Tạp chí Y học thực hành năm 2017, báo cáo “Các liệu pháp giảm nhẹ trong điều trị suy giãn tĩnh mạch – kinh nghiệm của Việt Nam” tại Đại hội Can thiệp ung thư Châu Á – Thái Bình Dương lần thứ 6 (2017)…', 
        N'Nữ', 
        N'BS0045.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0046',
        N'Null', 
        N'Bác sĩ Quản Thị Bính Thìn có gần 20 năm công tác trong lĩnh vực y khoa, chuyên khoa Chẩn đoán hình ảnh. Những kinh nghiệm đúc kết được trong quá trình học tập và khám chữa bệnh đã giúp Bác sĩ Bính Thìn đưa ra những đánh giá chính xác khi thực hiện các chẩn đoán lâm sàng cho bệnh nhân. Đây chính là cơ sở giúp bác sĩ phát hiện bệnh kịp thời và đưa ra phương án điều trị hiệu quả. ', 
        N'Nữ', 
        N'BS0046.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0047',
        N'Null', 
        N'Là một trong những người đầu tiên đặt nền móng xây dựng khoa Nhi trở thành khoa mũi nhọn của Bệnh viện Đa Khoa Tâm Anh Hà Nội và là khoa vệ tinh của Bệnh viện Nhi Trung ương, BS.CKII Phạm Thanh Xuân không chỉ được các bệnh nhân yêu mến bởi sự nhẹ nhàng, ấm áp mà còn nhận được sự kính trọng của các đồng nghiệp bởi tính quyết đoán, mạnh mẽ bên trong sự nhẹ nhàng của một bác sĩ Nhi khoa.\nGần 40 năm “tuổi nghề”, bác sĩ Thanh Xuân đã đồng hành cùng hàng triệu bệnh nhi, hàng triệu trường hợp đã được điều trị thành công. Chưa bao giờ ngừng đam mê, sau thời gian công tác tại bệnh viện, bác sĩ Thanh Xuân luôn dành tâm huyết để tìm tòi, nghiên cứu và trau dồi kiến thức chuyên môn.\nKhông chỉ chú trọng công tác chuyên môn, bác sĩ Thanh Xuân còn tích cực tham gia công tác giảng dạy, tâm huyết với sự nghiệp “truyền lửa đam mê” cho các thế hệ bác sĩ trẻ. Đối với bác sĩ Thanh Xuân, giáo dục y tế là phải nhìn về cội nguồn, y tế phải gắn với tri thức và thái độ ứng xử của con người, do đó trong công tác giảng dạy cũng như khi thực hiện vai trò khám chữa bệnh, bác sĩ Thanh Xuân luôn đề cao kinh nghiệm sống, thái độ phục vụ bệnh nhân, đặc biệt là thấu hiểu và thích nghi với những điều kiện thực tế, cho dù là khó khăn và thiếu thốn nhất.\nHơn nửa đời người gắn bó với mối duyên nợ Nhi khoa, bác sĩ Thanh Xuân đã xuất sắc giành được nhiều thành tích nổi bật, trong đó có nhiều danh hiệu thi đua và bằng khen của Bộ Y tế.', 
        N'Nữ', 
        N'BS0047.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0048',
        N'Null', 
        N'“Thân thiện, chuyên nghiệp, tận tâm” là những tính từ nổi bật mà đồng nghiệp và bệnh nhân nói về ThS.BS.CKII Phan Thị Phương Thảo. Hơn 29 năm gắn bó với nghề y, niềm vui của bác sĩ Phương Thảo là nhìn thấy nụ cười hài lòng của bệnh nhân. Mỗi ngày đến bệnh viện, bác sĩ Phương Thảo đều cảm thấy hạnh phúc hơn khi bệnh nhân có tiến triển tích cực, hồi phục khỏe mạnh. \nĐối với bác sĩ Phương Thảo, điều trị cho bệnh nhân không chỉ là xây dựng phác đồ phù hợp, theo dõi sát sao quá trình chữa trị; mà còn ở sự tư vấn tận tình, cử chỉ nhẹ nhàng, quan sát từng chút và lưu tâm đến cả những điều nhỏ ở bệnh nhân. Điều này giúp bác sĩ gần gũi hơn và bệnh nhân có thể đặt trọn niềm tin ở người bác sĩ. \nHiện tại, ThS.BS.CKII Phan Thị Phương Thảo vẫn không ngừng nâng cao kiến thức để phát huy các ưu thế trong điều trị. Là bác sĩ nội tim mạch giàu kinh nghiệm, bác sĩ Phương Thảo ưu tiên lựa chọn phương án chữa trị tối ưu với chi phí phù hợp cho bệnh nhân.', 
        N'Nữ', 
        N'BS0048.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0049',
        N'Null', 
        N'Hơn 30 năm gắn bó với nghề y, ThS.BS Nguyễn Quốc Khánh luôn miệt mài nghiên cứu, học tập để nâng cao trình độ chuyên môn trong khám, chẩn đoán bệnh và đưa ra những quyết định đúng đắn để chiến thắng những ca bệnh khó, cứu sống người bệnh.\nTrở về nước sau nhiều năm tu nghiệp ở nước ngoài, ThS.BS Nguyễn Quốc Khánh vừa đảm nhận công tác tại Khoa tim mạch Bệnh viện 19-8 Bộ Công an vừa tiếp tục theo học bác sĩ chuyên khoa và cao học tại Học viện Quân Y. “Luôn bận rộn, căng thẳng và nhiều áp lực, nhưng khi đã bén duyên và yêu quý nghề là nguồn động lực để tôi vượt lên tất cả và gắn bó đến tận bây giờ và cả sau này nữa.”, bác sĩ Nguyễn Quốc Khánh chia sẻ. \nCó lẽ cũng chính vì vậy mà trong ngần ấy năm theo nghiệp Y khoa, Ths.BS Nguyễn Quốc Khánh được nhắc nhớ không chỉ về cái tâm, cái tài của người thầy thuốc mà còn về một tấm gương trau dồi chuyên môn, với những công trình nghiên cứu có giá trị cao, trong đó nhiều đề tài khoa học của bác sĩ đã được áp dụng vào thực tiễn.', 
        N'Nam', 
        N'BS0049.png');
INSERT INTO CHITIETBACSI VALUES (
        'BS0050',
        N'Null', 
        N'ThS.BSNT Dương Công Lĩnh vượt qua kỳ sát hạch khắt khe để trở thành Bác sĩ nội trú chuyên ngành Nội Tim mạch tại Trường Đại học Y Hà Nội. \nĐặt phương châm “dùng trái tim để bảo vệ trái tim” lên đầu, ThS.BSNT Dương Công Lĩnh không ngừng học hỏi và áp dụng những kỹ thuật, phương pháp trị liệu mới giúp cho bệnh nhân bảo vệ sức khỏe của mình trước những nguy hiểm của bệnh tim mạch. Không chỉ là bác sĩ giỏi chuyên môn, đam mê sáng tạo và có tinh thần trách nhiệm, bác sĩ Lĩnh còn tích cực tham gia công tác tư vấn khám chữa cho bệnh nhân. \nBằng y đức và tài năng của mình, bác sĩ Lĩnh được rất nhiều bệnh nhân và người nhà tin tưởng. Hiện tại Bác sĩ Lĩnh đang công tác tại Khoa Tim mạch, BVĐK Tâm Anh Hà Nội.', 
        N'Nam', 
        N'BS0050.png');


INSERT INTO HOCVI VALUES ('BS.CKII', N'Bác sĩ chuyên khoa II', 3);
INSERT INTO HOCVI VALUES ('BS.CKI', N'Bác sĩ chuyên khoa I', 3);
INSERT INTO HOCVI VALUES ('DS', N'Dược sĩ', 5);
INSERT INTO HOCVI VALUES ('BSNT', N'Bác sĩ nội trú', 4);
INSERT INTO HOCVI VALUES ('CN', N'Cử nhân', 6);
INSERT INTO HOCVI VALUES ('BSCC', N'Bác sĩ cao cấp', 3);
INSERT INTO HOCVI VALUES ('TS', N'Tiến sĩ', 1);
INSERT INTO HOCVI VALUES ('THS', N'Thạc sĩ', 2);
INSERT INTO HOCVI VALUES ('BS', N'Bác sĩ', 4);


INSERT INTO CHITIETHOCVI VALUES ('BS0001', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0002', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0002', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0003', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0003', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0004', 'DS');
INSERT INTO CHITIETHOCVI VALUES ('BS0005', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0005', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0007', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0008', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0008', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0009', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0010', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0010', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0011', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0011', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0012', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0012', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0013', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0013', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0014', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0014', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0015', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0016', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0017', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0006', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0018', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0018', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0019', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0020', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0020', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0021', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0022', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0023', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0024', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0025', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0025', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0026', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0026', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0027', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0027', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0028', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0028', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0029', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0029', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0030', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0031', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0032', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0032', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0033', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0033', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0034', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0034', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0035', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0036', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0036', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0037', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0037', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0038', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0038', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0039', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0039', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0040', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0040', 'DS');
INSERT INTO CHITIETHOCVI VALUES ('BS0041', 'TS');
INSERT INTO CHITIETHOCVI VALUES ('BS0041', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0042', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0042', 'BSNT');
INSERT INTO CHITIETHOCVI VALUES ('BS0043', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0044', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0045', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0046', 'BS.CKI');
INSERT INTO CHITIETHOCVI VALUES ('BS0047', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0048', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0048', 'BS.CKII');
INSERT INTO CHITIETHOCVI VALUES ('BS0049', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0049', 'BS');
INSERT INTO CHITIETHOCVI VALUES ('BS0050', 'THS');
INSERT INTO CHITIETHOCVI VALUES ('BS0050', 'BSNT');

SET DATEFORMAT DMY

INSERT INTO BENHNHAN VALUES ('BN0001', N'Trần Trương Tuấn Phát', '23/02/1997', N'Nam', '0226979476', N'46/6 Cộng Hòa, Phường 13, Quận Tân Bình, TP Hồ Chí Minh');
INSERT INTO BENHNHAN VALUES ('BN0002', N'Nguyễn Quốc Thái', '26/12/2003', N'Nam', '0258522796', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0003', N'Đỗ Huy Ngọc Trinh', '03/12/1996', N'Nữ', '0517034901', N'202 Đ. Trương Định, Tương Mai, Hai Bà Trưng, Hà Nội');
INSERT INTO BENHNHAN VALUES ('BN0004', N'Trương Văn Bích Ngọc', '20/07/1978', N'Nữ', '0012200884', N'27 Hai Bà Trưng, Bến Nghé, Quận 1, Hồ Chí Minh');
INSERT INTO BENHNHAN VALUES ('BN0005', N'Mai Quang Hà My', '22/12/1975', N'Nữ', '0278250452', N'248 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh');
INSERT INTO BENHNHAN VALUES ('BN0006', N'Triệu Đức An', '16/09/1978', N'Nam', '0127062401', N'20 Lê Thánh Tông, Cẩm Sơn, Hội An, Quảng Nam, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0007', N'Giang Phúc Quyết', '09/03/1954', N'Nam', '0269360334', N'58 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0008', N'Phùng Công Đông', '12/08/1987', N'Nam', '0675041817', N'404 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0009', N'Tống Văn Xuân', '24/10/1974', N'Nam', '0625793114', N'85 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0010', N'Phùng Thành Thùy Linh', '03/01/1990', N'Nữ', '0562583388', N'45 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0011', N'Trương Minh Hà', '20/05/1973', N'Nữ', '0084561757', N'31 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0012', N'Phù Huy Ngọc Ánh', '22/11/1975', N'Nữ', '0378969265', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0013', N'Lưu Hoàng Thị Hương', '11/06/1974', N'Nữ', '0855936553', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0014', N'Trịnh Hữu Vũ', '12/01/2004', N'Nam', '0987157069', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0015', N'Viễn Nguyễn Quang', '12/02/1994', N'Nam', '0481340734', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0016', N'Ngụy Phúc Bảo', '28/03/1990', N'Nam', '0824454073', N'281 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0017', N'Sái Hoàng Nhật', '15/02/1999', N'Nam', '0226979476', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0018', N'Vi Thị Kiên', '24/10/1997', N'Nữ', '0083703932', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0019', N'Hà Thị Loan', '21/02/1967', N'Nữ', '0168823739', N'202 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0020', N'Cung Đình Phú', '20/05/2017', N'Nam', '0002620708', N'24 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0021', N'Tô Đình Long', '25/12/1999', N'Nam', '0258522796', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0022', N'Tô Văn Khang', '27/09/2021', N'Nam', '0407658210', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0023', N'Cáp Hoàng Minh Châu', '22/01/1975', N'Nữ', '0815421991', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0024', N'Trình Quang Thái', '12/10/1961', N'Nam', '0841478808', N'237 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0025', N'Ngụy Hoàng Tuấn', '17/07/1965', N'Nam', '0552702699', N'249 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0026', N'Tô Hoàng Vy', '29/07/1984', N'Nữ', '0619899167', N'578 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0027', N'Nguyễn Ngọc Phong', '30/12/1979', N'Nam', '0766638154', N'25 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0028', N'Triệu Phúc Thái', '13/02/1976', N'Nam', '0785467500', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0029', N'Tiết Hoàng Thùy Linh', '19/08/1980', N'Nữ', '0457679418', N'36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0030', N'Phí Nguyễn Ngọc Lan', '01/12/1986', N'Nữ', '0246071750', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0031', N'Võ Hoàng Việt', '28/01/2016', N'Nam', '0345324336', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0032', N'Hàm Thị Văn', '20/11/1992', N'Nam', '0201493281', N'203 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0033', N'Địch Thị Quỳnh Nga', '17/01/1963', N'Nữ', '0544045347', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0034', N'Lưu Thành Văn', '11/08/1974', N'Nam', '0250832780', N'33 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0035', N'Giang Văn Vy', '14/10/2004', N'Nam', '0072349208', N'28 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0036', N'Đồng Thị Hà My', '22/01/1956', N'Nữ', '0332378390', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0037', N'Vi Phúc Thanh Hương', '29/07/2006', N'Nữ', '0472037078', N'59 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0038', N'Cung Hoàng Ngọc Trinh', '23/02/1997', N'Nữ', '0703461097', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0039', N'Viên Thị Thắng', '16/01/1955', N'Nam', '0704383494', N'405 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0040', N'Lý Hữu Trí', '26/06/1979', N'Nam', '0204581339', N'86 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0041', N'Đỗ Văn Ngọc Diệp', '20/11/1956', N'Nữ', '0809874862', N'46 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0042', N'Ngô Đình Hoa', '15/04/1996', N'Nữ', '0143825471', N'32 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0043', N'Mã Văn Thu', '18/05/1998', N'Nam', '0282318547', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0044', N'Đậu Anh Bảo', '11/12/1979', N'Nam', '0579532527', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0045', N'Tạ Hoàng Tuấn', '06/06/1955', N'Nam', '0895025939', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0046', N'Mai Văn Phương', '31/12/1965', N'Nam', '0342615880', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0047', N'Khúc Thành Anh', '12/09/1979', N'Nam', '0746131570', N'282 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0048', N'Phạm Huy Ngọc Ánh', '18/05/1990', N'Nữ', '0122983232', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0049', N'Ôn Thị Trung', '13/08/2008', N'Nữ', '0825794952', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0050', N'Nhâm Duy Loan', '29/05/1969', N'Nữ', '0746554697', N'203 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0051', N'Khúc Hoàng Phúc', '03/09/2018', N'Nam', '0282437723', N'25 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0052', N'Phù Văn Thanh Hương', '21/10/1950', N'Nữ', '0795438089', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0053', N'Tôn Công Hà', '13/04/2016', N'Nam', '0163671750', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0054', N'Đàm Ngọc Yến', '22/04/2015', N'Nữ', '0571144640', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0055', N'Doãn Anh Minh Tuấn', '02/09/1971', N'Nam', '0102831102', N'238 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0056', N'Tô Hoài Hoa', '10/06/1983', N'Nữ', '0167098927', N'250 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0057', N'Lâm Văn Linh', '19/06/1996', N'Nam', '0342984493', N'579 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0058', N'Hà Công Tân', '25/02/1997', N'Nam', '0097678943', N'26 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0059', N'Trịnh Thị Hoàng', '08/05/2005', N'Nữ', '0329960334', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0060', N'Mai Phúc Long', '27/09/1963', N'Nam', '0578597387', N'37 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0061', N'Tôn Văn Kim', '11/08/1986', N'Nam', '0342880951', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0062', N'Cù Hữu Nhật', '30/08/2003', N'Nam', '0812499826', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0063', N'Quản Văn Đức', '19/01/2000', N'Nam', '0245767912', N'204 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0064', N'Phù Đình Thúy', '24/05/1978', N'Nữ', '0307214330', N'105 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0065', N'Khắc Quang Ánh', '05/03/2007', N'Nam', '0877856155', N'34 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0066', N'Vi Huy Lan', '18/12/2014', N'Nữ', '0629774350', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0067', N'Khúc Thanh Phúc', '05/06/1957', N'Nam', '0153774013', N'29 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0068', N'Tô Đình Huyền Trang', '12/05/1959', N'Nữ', '0116182693', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0069', N'Ngụy Thanh Thành', '07/01/1986', N'Nữ', '0459534966', N'60 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0070', N'Sái Thị Kim', '05/10/1978', N'Nữ', '0883251224', N'406 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0071', N'Bùi Phúc Quang', '17/06/1972', N'Nam', '0614822096', N'87 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0072', N'Tôn Huy Lâm', '14/08/1975', N'Nam', '0429727318', N'47 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0073', N'Vương Văn Thắng', '22/07/1969', N'Nam', '0304378000', N'33 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0074', N'Trầm Hoài Phúc', '23/04/1998', N'Nam', '0310541533', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0075', N'Bùi Thị Phúc', '05/11/2003', N'Nữ', '0787096071', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0076', N'Lâm Hoài Thùy Linh', '15/05/2005', N'Nữ', '0706015508', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0077', N'Văn Nguyễn Yến', '04/10/1981', N'Nữ', '0313692775', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0078', N'Kiều Nguyễn Thanh Thảo', '05/11/1999', N'Nữ', '0910926390', N'283 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0079', N'Văn Huy Ngọc Mai', '16/11/1974', N'Nữ', '0193535313', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0080', N'Khúc Hoài Khánh', '16/09/2001', N'Nam', '0241786228', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0081', N'Tôn Đức Minh', '08/05/1986', N'Nam', '0174511089', N'46/1A Đỗ Nhuận, Sơn Kỳ, Tân Phú, TP.HCM');
INSERT INTO BENHNHAN VALUES ('BN0082', N'Đàm Công Ngọc Trinh', '03/08/1956', N'Nữ', '0140441630', N'16 P. Nguyễn Quang Bích. Cửa Đông. Hoàn Kiếm. Hà Nội 10000. Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0083', N'Khúc Quang Ngọc Yến', '30/09/1956', N'Nữ', '0898999040', N'88 Lê Văn Duyệt, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0084', N'Nông Phúc Hà', '10/06/1977', N'Nam', '0008201235', N'21 5 Tháng 6, Tổ dân phố số 16, Thị xã Lai Châu, Lai Châu, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0085', N'Cáp Thành Long', '07/09/1973', N'Nam', '0146292469', N'107 Minh Khai, Phố Mới, Lào Cai, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0086', N'Ôn Văn Long', '20/03/1981', N'Nam', '0476426220', N'876 Trần Cao Vân, Thanh Khê Đông, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0087', N'Nhâm Hoàng Ngọc Diệp', '08/07/2002', N'Nữ', '0120215526', N'Ng. 34 P. Hào Nam, Chợ Dừa, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0088', N'Viễn Thành Mai Phương', '31/03/1957', N'Nữ', '0410554823', N'164 Nguyễn Thông, Bình Tâm, Tân An, Long An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0089', N'Khổng Thanh Đức', '30/09/2017', N'Nam', '0208293459', N'108 Thái Bình, Trần Tế Xương, TP. Nam Định, Nam Định, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0090', N'Mã Văn Ngọc Yến', '21/11/2000', N'Nữ', '0550821125', N'573 Điện Biên Phủ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0091', N'Phú Phúc Ngọc Mai', '05/06/1971', N'Nữ', '0608019402', N'79 Đ. La Thành, Chợ Dừa, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0092', N'Châu Anh Gia Hân', '04/06/2023', N'Nữ', '0780329453', N'198 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0093', N'Khổng Hoàng Thái', '28/09/2003', N'Nam', '0506997384', N'12 Hà Liễu, Ph.Gia Cẩm, Thành phố Việt Trì, Phú Thọ, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0094', N'Duy Thị Thảo', '18/10/1975', N'Nữ', '0168753181', N'112 Đ. Đinh Tiên Hoàng, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0095', N'Bàng Minh Diệu', '09/08/2012', N'Nam', '0052062068', N'9 Đ. Phan Đăng Lưu, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0096', N'Khải Công Quốc', '01/12/2003', N'Nam', '0277797848', N'12 Nơ Trang Long, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0097', N'Thi Tuấn Hoài', '24/03/2010', N'Nam', '0918765429', N'90 Phạm Văn Đồng, Nghĩa Chánh Bắc, Quảng Ngãi, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0098', N'Ứng Hoàng Vũ', '12/02/1998', N'Nam', '0801991858', N'1 Đ. Phan Đăng Lưu, phường 03, Bình Thạnh, Thành phố Hồ Chí Minh 72300, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0099', N'Tiêu Thị Bảo', '10/07/1982', N'Nữ', '0987497170', N'105 Hai Bà Trưng, Phường 3, Quảng Trị, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0100', N'Tiêu Đức Thùy Linh', '11/10/2005', N'Nữ', '0063082928', N'10 Lê Thánh Tông, Thắng Lợi, Thành phố Buôn Ma Thuột, Đắk Lắk, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0101', N'Phạm Huy Tùng', '02/12/2003', N'Nam', '0269628526', N'122 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0102', N'Lê Tuấn Tuyết', '02/10/1981', N'Nữ', '0797282312', N'258 Cù Chính Lan, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0103', N'Biện Huy Ngọc Diệp', '27/11/1957', N'Nữ', '0407458673', N'199 P. Vương Thừa Vũ, Khương Trung, Thanh Xuân, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0104', N'Dương Tuấn Hà Thu', '17/12/1967', N'Nam', '0829992479', N'132 ĐT848, Phường An Hoà, Sa Đéc, Đồng Tháp, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0105', N'Nông Thanh Tiến', '25/12/2018', N'Nam', '0173226779', N'87P1 Đ. Lê Văn Duyệt, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0106', N'Tiết Văn Hoài', '18/08/1985', N'Nam', '0396977682', N'24 Bạch Đằng, P. Nguyễn Trãi, Hà Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0107', N'Phú Thịnh Thùy Linh', '01/10/1970', N'Nữ', '0930946142', N'164 / 44 P. Vương Thừa Vũ, Khương Trung, Thanh Xuân, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0108', N'Đồng Minh Bảo', '02/08/1960', N'Nam', '0325594507', N'5 Nguyễn Tri Phương, Quán Thánh, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0109', N'Trịnh Huy Quốc', '20/04/1986', N'Nam', '0305927970', N'745 Trần Cao Vân, Thanh Khê Đông, Hải Châu, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0110', N'Khổng Quang Ánh', '19/11/2017', N'Nam', '0971753833', N'1/2 Phó Đức Chính, Phường 1, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0111', N'Biện Văn Vy', '13/11/2001', N'Nữ', '0775722224', N'93 Bà Triệu, P. Thanh Trung, Thành phố Hải Dương, Hải Dương, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0112', N'Châu Hoài Loan', '27/05/1994', N'Nữ', '0516178668', N'8 Lê Quang Định, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0113', N'Vi Hoài Đức', '14/02/1964', N'Nam', '0102625379', N'58 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0114', N'Bùi Văn Phú', '28/11/1985', N'Nam', '0095123285', N'404 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0115', N'Tri Thanh Quyết', '10/10/2001', N'Nam', '0421335164', N'85 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0116', N'Vương Thị Tùng', '10/05/1963', N'Nữ', '0894842441', N'45 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0117', N'Chu Tuấn Ngọc Mai', '27/03/1982', N'Nữ', '0129522753', N'31 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0118', N'Đoàn Tuấn Yến', '22/06/1977', N'Nữ', '0199215687', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0119', N'Bàng Thị Phương Anh', '29/05/1964', N'Nữ', '0097803805', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0120', N'Đậu Văn Thùy Linh', '08/09/2017', N'Nữ', '0337004353', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0121', N'Thi Quang Khánh', '12/11/1990', N'Nam', '0318165951', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0122', N'Kiều Thị Vy', '03/03/1950', N'Nữ', '0214533954', N'281 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0123', N'Chu Hoài Khánh', '29/08/2002', N'Nam', '0381252162', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0124', N'Khổng Văn Ngọc Mai', '17/03/1996', N'Nữ', '0797527593', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0125', N'Kiều Ngọc Trung', '21/09/1975', N'Nữ', '0370920560', N'202 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0126', N'Thạch Ngọc Trang', '18/06/1995', N'Nữ', '0214711316', N'24 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0127', N'Hà Ngọc Minh', '13/04/1992', N'Nữ', '0552750061', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0128', N'Bùi Duy Long', '22/08/2017', N'Nam', '0728386149', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0129', N'Thạch Thành Khánh', '18/12/1995', N'Nam', '0881852173', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0130', N'Vương Thịnh Thùy Linh', '13/12/2014', N'Nữ', '0184216450', N'237 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0131', N'Khổng Ngọc Hải', '20/10/1987', N'Nữ', '0877204484', N'249 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0132', N'Nghiêm Nguyễn Tiến', '15/10/1958', N'Nam', '0366631894', N'578 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0133', N'Ngụy Đình Ngọc Diệp', '10/11/1971', N'Nữ', '0921963284', N'25 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0134', N'Dư Hoài Phú', '09/09/1989', N'Nam', '0327263296', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0135', N'Dư Đình Trường', '21/03/2017', N'Nam', '0008666947', N'36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0136', N'Tôn Minh Nhung', '23/06/1953', N'Nữ', '0490479215', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0137', N'Hà Tuấn Ngân', '09/01/2002', N'Nữ', '0556593193', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0138', N'Bàng Văn Thảo', '12/02/1977', N'Nam', '0767181270', N'203 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0139', N'Ứng Huy Bình', '13/01/1988', N'Nam', '0940025221', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0140', N'Đặng Văn Thuý', '17/06/1982', N'Nữ', '0669925124', N'33 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0141', N'Tống Quang Tùng', '15/02/1993', N'Nam', '0689185491', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0142', N'Đậu Thành Hoàng', '14/08/1995', N'Nam', '0602859364', N'28 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0143', N'Giang Phúc Gia Hân', '19/03/1992', N'Nữ', '0501315147', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0144', N'Phú Đình Nguyên', '15/02/2014', N'Nam', '0133548778', N'368 Đ. Hùng Vương. Phường 3. Tân An. Long An. Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0145', N'Tống Thịnh Trung', '05/07/1986', N'Nam', '0987988405', N'H55 Nguyễn Thị Nghĩa, Phường 2, Thành phố Đà Lạt, Lâm Đồng 66109, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0146', N'Mai Tuấn Tùng', '18/03/1995', N'Nam', '0633642440', N'92 Trương Thị Sáu, Phường 3, Tân An, Long An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0147', N'Mạc Thành Thắng', '29/04/1989', N'Nam', '0361601677', N'Đường N3, Lộc Hoà, TP. Nam Định, Nam Định, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0148', N'Viên Công Quyết', '20/06/1950', N'Nam', '0791969015', N'Số 40 Đại lộ Xô Viết Nghệ, Nghi Phú, Thành phố Vinh, Nghệ An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0149', N'Đồng Tuấn Phúc', '12/07/2000', N'Nam', '0108364118', N'89 đường Ninh Tôn, Ninh Phú, Ninh Bình, 08000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0150', N'Đối Đức Thắng', '10/05/1977', N'Nam', '0090471097', N'1E Thống Nhất, Đài Sơn, Phan Rang-Tháp Chàm, Ninh Thuận, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0151', N'Tôn Thành Hà', '02/03/2010', N'Nam', '0504886113', N'98C6+H48, Hy Cương, Thành phố Việt Trì, Phú Thọ, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0152', N'Tô Hoàng Đạt', '29/07/1986', N'Nam', '0397588978', N'154 Đ. Nguyễn Trãi, Phường 5, Tuy Hòa, Phú Yên 56100, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0153', N'Khúc Văn Nhật', '02/06/1994', N'Nam', '0573964998', N'5RX7+MGF, Mỹ Thuỷ, Lệ Thủy, Quảng Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0154', N'Tài Ngọc Hà', '16/02/1994', N'Nữ', '0056185883', N'V7F9+36 Điện Bàn, Quảng Nam, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0155', N'Phí Thịnh Ngọc Lan', '19/02/1999', N'Nữ', '0888202438', N'4VHF+MPC, Nghĩa Hà, Tư Nghĩa, Quảng Ngãi, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0156', N'Quách Quang Hạnh', '04/03/1971', N'Nam', '0461544763', N'VRXH+W4H, Unnamed Road, Liên Hoà, Yên Hưng, Quảng Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0157', N'Trần Văn Cường', '26/07/1992', N'Nam', '0648804426', N'WH88+45W, Hòa Sơn, Lương Sơn, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0158', N'Văn Công Phúc', '02/04/1953', N'Nam', '0007611148', N'Nguyễn Hữu Thọ, Phường 3, Tây Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0159', N'Văn Ngọc Thanh', '14/12/2008', N'Nữ', '0823674748', N'Phạm Quang Lịch Lý Bôn, Tiền Phong, Thái Bình, 61000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0160', N'Tri Hữu Lan', '22/08/1972', N'Nữ', '0364480461', N'HR8R+4X6, Đ. Việt Bắc, Phú Xá, Thành phố Thái Nguyên, Thái Nguyên, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0161', N'Cao Thị Ngọc Diệp', '09/11/1996', N'Nữ', '0836986289', N'50 Ngô Đức, TT. Nhồi, Đông Sơn, Thanh Hoá, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0162', N'Bàng Hữu Ngân', '17/06/2012', N'Nữ', '0263426923', N'38 An Dương Vương, An Cựu, Thành phố Huế, Thừa Thiên Huế, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0163', N'Cáp Hoài Lan', '15/09/2016', N'Nữ', '0869794224', N'9FP4+572, Đăng Hưng Phước, Chợ Gạo, Tiền Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0164', N'Hàm Nguyễn Thuý', '08/10/1983', N'Nữ', '0905128719', N'492f Võ Văn Kiệt, Phường 1, Trà Vinh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0165', N'Tống Phúc Hồng Loan', '16/07/2010', N'Nữ', '0553712241', N'48 Nguyễn Văn Cừ, P. Minh Xuân, Tuyên Quang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0166', N'Ôn Đức Văn', '15/02/1953', N'Nam', '0539684641', N'294 Nguyễn Văn Thiệt, Phường 3, Vĩnh Long, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0167', N'Phù Văn Quỳnh Nga', '03/07/1953', N'Nữ', '0217947183', N'Ngã 5 - Nguyễn Tất Thành, Trần Phú, Liên Bảo, Vĩnh Yên, Vĩnh Phúc, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0168', N'Khúc Hoài Thanh Thảo', '19/11/1958', N'Nữ', '0976644028', N'Đá Bia, Tổ 4, Thành phố Yên Bái, Yên Bái, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0169', N'Trịnh Nguyễn Phương', '12/03/1979', N'Nữ', '0228768349', N'M89M+GJ6, Phú An, Phú Tân, An Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0170', N'Địch Thành Đức', '19/07/2008', N'Nam', '0111625667', N'783W+C27, Lộ Cơ Khí, Bình Phú, Bến Tre, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0171', N'Bàng Hoàng Phúc', '20/05/1990', N'Nam', '0243020511', N'376 Nguyễn An Ninh, Dĩ An, Bình Dương, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0172', N'Đồng Thanh Quyết', '27/07/1973', N'Nam', '0835894577', N'11 Huỳnh Tấn Phát, Đống Đa, Thành phố Qui Nhơn, Bình Định 560000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0173', N'Tô Thị Hải', '13/03/1962', N'Nữ', '0046451706', N'GWM6+FVW, Phường Tân Thiện, Đồng Xoài, Bình Phước, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0174', N'Tiết Thịnh Thùy Linh', '25/04/1956', N'Nữ', '0191383193', N'Nguyễn Minh Châu, Mũi Né, Thành phố Phan Thiết, Bình Thuận, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0175', N'Hứa Huy Minh Tuấn', '19/03/2022', N'Nam', '0007319128', N'36 Điện Biên Phủ, Điện Biên, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0176', N'Đối Minh Tuấn', '21/10/1955', N'Nam', '0708439179', N'63 Đình Tân Khai, Bình Trị Đông, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0177', N'Tri Hoài Vy', '10/04/2000', N'Nữ', '0312223054', N'185 Bùi Tá Hán, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0178', N'Văn Nguyễn Huyền Trang', '07/11/1951', N'Nữ', '0205079930', N'42/4c Đ. Bình Trị Đông, Bình Trị Đông, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0179', N'Lại Anh Thùy Linh', '09/04/1996', N'Nữ', '0366925580', N'Ng. 82 P. Kim Mã, Kim Mã, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0180', N'Hồ Phúc Đức', '16/07/1999', N'Nam', '0586063012', N'487 Chiến Lược, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0181', N'Tôn Văn Quân', '17/01/1993', N'Nam', '0038287534', N'Lô 15B3, 1 Bùi Tá Hán, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0182', N'Đinh Huy Ngọc', '10/04/1994', N'Nam', '0083557469', N'65 Trung Lương 14, Hoà Xuân, Cẩm Lệ, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0183', N'Hàm Thị Tiến', '25/08/2017', N'Nam', '0912476437', N'365 Đ. Trường Chinh, Phường 14, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0184', N'Chuẩn Huy Ngọc', '26/11/1971', N'Nam', '0318831456', N'143 P. Đốc Ngữ, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0185', N'Mai Phúc Hà', '19/12/1961', N'Nam', '0636069548', N'1888 C3 Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0186', N'Viên Minh Thúy', '24/05/1988', N'Nữ', '0904033781', N'281/55, Lý Thường Kiệt, Phường 15, Quận 11, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0187', N'Lại Ngọc Đức', '25/09/2013', N'Nam', '0324760018', N'298 Lý Thường Kiệt, Phường 14, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0188', N'Hồ Duy Ngọc Mai', '10/03/1982', N'Nữ', '0422122942', N'104 Đ. Đoàn Khuê, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0189', N'Quản Văn Lan', '12/10/2020', N'Nam', '0555501220', N'36 Ngõ 68 Phố Phùng Chí Kiên, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0190', N'Lê Công Ngọc Diệp', '05/05/1973', N'Nữ', '0461071495', N'43 Lê Hữu Khánh, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0191', N'Trình Ngọc Yến', '25/01/2012', N'Nữ', '0849659371', N'495 Đ. Nhật Tảo, Phường 7, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0192', N'Tề Phúc Tân', '27/08/1982', N'Nam', '0480271279', N'30 Đ. Nguyễn Văn Huyên, Quan Hoa, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0193', N'Quản Thành Thùy Linh', '01/03/1963', N'Nữ', '0709906931', N'79 Đ. Đoàn Khuê, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0194', N'Chuẩn Nguyễn Ngọc Lan', '21/01/1964', N'Nữ', '0237757518', N'80 Đ. Châu Văn Liêm, Phường 11, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0195', N'Đoàn Duy Trang', '18/08/1992', N'Nam', '0413922535', N'38 P. Khúc Thừa Dụ, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0196', N'Trình Hữu Thắng', '18/11/2022', N'Nam', '0549765605', N'148 Ni Sư Huỳnh Liên, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0197', N'Trương Minh Hà', '04/04/2021', N'Nam', '0991529016', N'135 Đ. Nguyễn Phong Sắc, Nghĩa Tân, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0198', N'Phạm Đình Lâm', '22/12/1978', N'Nam', '0525735108', N'110/D6 Hẻm 108 Cộng Hòa, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0199', N'Khúc Đức Thị Hương', '29/03/2023', N'Nữ', '0862357649', N'217 Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0200', N'Ngụy Phúc Vy', '03/05/1977', N'Nữ', '0269602688', N'02 Trần Hữu Độ, Khuê Mỹ, Ngũ Hành Sơn, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0201', N'Địch Ngọc Thanh Hương', '27/04/1990', N'Nữ', '0218872633', N'22 Nguyễn Tất Thành, Phường 12, Quận 4, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0202', N'Cáp Quang Duy', '21/09/1959', N'Nam', '0610960483', N'289 Tây Thạnh, P. Phú Thuận, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0203', N'Hà Nguyễn Quyết', '25/05/1970', N'Nam', '0033342278', N'Ngõ 234 Hoàng Quốc Việt, Cổ Nhuế, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0204', N'Vũ Huy Hà My', '25/07/1979', N'Nữ', '0685536722', N'106 Đ. Hồ Tùng Mậu, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0205', N'Doãn Hoàng Ngọc', '21/10/1950', N'Nam', '0250788805', N'39 Đ. Mạc Đĩnh Chi, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0206', N'Cù Quang Bích Ngọc', '12/01/1979', N'Nữ', '0825393878', N'58 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0207', N'Hà Công Thanh', '06/07/1953', N'Nam', '0979396267', N'404 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0208', N'Phí Thị Tùng', '02/03/2018', N'Nữ', '0674136815', N'85 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0209', N'Chuẩn Đức Quyết', '09/04/1960', N'Nam', '0850951388', N'45 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0210', N'Lại Anh Hà Thu', '11/02/1970', N'Nữ', '0870333060', N'31 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0211', N'Đối Thị Thanh Hương', '18/03/1963', N'Nữ', '0606854476', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0212', N'Mạc Văn Trung', '14/08/1991', N'Nam', '0430785034', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0213', N'Trình Tuấn Vy', '26/01/1956', N'Nam', '0799083045', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0214', N'Từ Văn Anh', '31/05/1961', N'Nam', '0665980250', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0215', N'Từ Hoàng Minh', '21/02/1991', N'Nam', '0100803129', N'281 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0216', N'Khúc Thị Thúy', '16/08/2015', N'Nữ', '0752434582', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0217', N'Viên Phúc Tân', '22/10/2011', N'Nam', '0402712811', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0218', N'Thi Thị Ngọc Lan', '31/01/1984', N'Nữ', '0456893388', N'202 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0219', N'Đỗ Minh Kim', '26/03/1970', N'Nữ', '0089004193', N'24 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0220', N'Đặng Huy Hà My', '06/06/2011', N'Nữ', '0670243583', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0221', N'Quách Thành Ngọc Yến', '03/03/2013', N'Nữ', '0923842261', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0222', N'Biện Quang Minh Châu', '17/10/1965', N'Nữ', '0925949688', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0223', N'Biện Minh Phúc', '15/01/1970', N'Nam', '0761457918', N'237 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0224', N'Tạ Quang Phương Anh', '28/05/1973', N'Nữ', '0935160118', N'249 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0225', N'Cáp Nguyễn Bích Ngọc', '10/01/2014', N'Nữ', '0137130149', N'578 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0226', N'Bùi Văn Xuân', '10/03/2002', N'Nam', '0727302411', N'25 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0227', N'Dư Duy Cường', '19/01/1986', N'Nam', '0813657972', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0228', N'Phùng Văn Tân', '31/10/1968', N'Nam', '0200458316', N'36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0229', N'Mai Đình Huy', '03/08/1957', N'Nam', '0289046638', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0230', N'Hà Thành Đạt', '13/07/1955', N'Nam', '0363470024', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0231', N'Hồ Ngọc Bình', '12/09/1992', N'Nữ', '0550504823', N'203 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0232', N'Duy Thành Bảo', '06/05/2021', N'Nam', '0030303678', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0233', N'Mã Văn Hùng', '12/03/1980', N'Nam', '0437013594', N'33 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0234', N'Huỳnh Phúc Sơn', '21/11/1966', N'Nam', '0317996357', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0235', N'Ngụy Văn Xuân', '10/12/2023', N'Nam', '0774380697', N'28 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0236', N'Tề Đình Tiến', '21/02/1993', N'Nam', '0686169829', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0237', N'Bàng Minh Khánh', '25/02/2008', N'Nam', '0043016552', N'59 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0238', N'Dương Thị Thắng', '24/02/1970', N'Nữ', '0387923668', N'405 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0239', N'Ngụy Hoàng Thái', '08/06/1989', N'Nam', '0994918474', N'86 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0240', N'Phù Thị Vũ', '01/09/1979', N'Nữ', '0999921530', N'46 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0241', N'Hồ Thị Lan', '06/09/1986', N'Nữ', '0147644910', N'32 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0242', N'Khải Văn Bảo', '14/03/2006', N'Nam', '0892233091', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0243', N'Ngụy Thịnh Văn', '27/10/2010', N'Nam', '0168346316', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0244', N'Giang Thành Trang', '20/05/1990', N'Nữ', '0554867971', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0245', N'Mạc Hữu Minh', '13/03/1952', N'Nam', '0239521093', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0246', N'Tất Hoàng Hải', '10/11/1987', N'Nam', '0133299603', N'282 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0247', N'Tài Văn Phúc', '18/10/2022', N'Nam', '0157567079', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0248', N'La Huy Nhung', '18/06/1956', N'Nữ', '0775527523', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0249', N'Phùng Huy Nhật', '13/04/2020', N'Nam', '0236686892', N'203 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0250', N'Đồng Nguyễn Bảo', '16/02/2016', N'Nam', '0765384385', N'25 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0251', N'Dương Đức Thanh Thảo', '25/02/2021', N'Nam', '0667862431', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0252', N'Tất Tuấn Minh', '18/07/1954', N'Nam', '0438806444', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0253', N'Cáp Văn Ngọc Trinh', '07/04/1989', N'Nữ', '0889794343', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0254', N'Tạ Quang Ngọc Mai', '31/05/2021', N'Nữ', '0743852723', N'238 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0255', N'Lý Hoàng Khang', '22/09/2005', N'Nam', '0626067090', N'250 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0256', N'Tiêu Công Hồng Loan', '31/08/2013', N'Nữ', '0875987487', N'579 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0257', N'Khổng Duy Cường', '09/12/1970', N'Nam', '0829960869', N'26 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0258', N'Viễn Tuấn Minh', '16/11/2022', N'Nam', '0889765505', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0259', N'Tô Nguyễn Đức', '17/08/1967', N'Nam', '0848889974', N'37 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0260', N'Tạ Tuấn Ngọc Yến', '08/04/1965', N'Nữ', '0807718123', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0261', N'Hồng Thịnh Thu', '05/04/1960', N'Nữ', '0893181024', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0262', N'Đối Hoàng Nam', '04/12/2002', N'Nam', '0724221167', N'204 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0263', N'Vũ Thanh Gia Hân', '10/08/1962', N'Nữ', '0955851625', N'105 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0264', N'Tiêu Ngọc Quân', '27/07/1958', N'Nam', '0887747542', N'34 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0265', N'Duy Văn Ngọc Ánh', '24/07/1986', N'Nữ', '0770254273', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0266', N'Đàm Công Minh Tuấn', '07/03/1996', N'Nam', '0293091253', N'29 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0267', N'Ân Công Yến', '12/11/2019', N'Nam', '0179533367', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0268', N'Cung Đình Tuấn', '16/04/2010', N'Nam', '0673754181', N'60 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0269', N'Phước Duy Bình', '25/02/1959', N'Nam', '0727513942', N'406 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0270', N'Phí Thanh Ngọc Diệp', '16/10/1994', N'Nữ', '0169783456', N'87 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0271', N'Biện Văn Quỳnh', '04/11/2018', N'Nam', '0057250321', N'47 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0272', N'Dương Thị Nguyên', '27/03/1975', N'Nữ', '0141119140', N'33 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0273', N'Bàng Văn An', '30/07/1993', N'Nam', '0452852330', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0274', N'Hà Văn Quang', '04/03/1991', N'Nam', '0645321937', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0275', N'Châu Văn Huyền Trang', '02/11/1987', N'Nữ', '0471857479', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0276', N'Trương Huy Phú', '22/03/1951', N'Nam', '0775576565', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0277', N'Triệu Hoàng Vũ', '12/08/1999', N'Nam', '0995189131', N'283 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0278', N'Ân Hữu Ngân', '26/08/1977', N'Nam', '0609314163', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0279', N'Lưu Ngọc Phú', '12/12/1951', N'Nam', '0021788130', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0280', N'Phú Văn An', '14/09/1986', N'Nam', '0711912382', N'253 Lê Lợi, TT. An Châu, Châu Thành, An Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0281', N'Trầm Thành Linh', '07/06/2004', N'Nam', '0287439945', N'213 Nguyễn An Ninh, Phường 6, Thành phố Vũng Tầu, Bà Rịa - Vũng Tàu, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0282', N'Phạm Đình Thanh Thảo', '22/04/1969', N'Nữ', '0717973770', N'346 Cao Văn Lầu, Phường 2, Bạc Liêu, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0283', N'Lại Đình Phương Anh', '15/01/1997', N'Nữ', '0729886675', N'4RWQ+R5Q, Phùng Chí Kiên, Bắc Kạn, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0284', N'Võ Văn Hiếu', '25/01/2001', N'Nam', '0290969224', N'217 Lê Lợi, Phường Hoàng Văn Thụ, Bắc Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0285', N'Vương Thị Hà My', '23/05/2015', N'Nữ', '0990078607', N'420, Nghiêm Xá, Yên Phong, Bắc Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0286', N'Đinh Đình Anh', '18/09/1985', N'Nam', '0556036662', N'68 Đồng Văn Cống, Bình Phú, Bến Tre, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0287', N'Phó Thanh Khang', '31/03/1967', N'Nam', '0088673688', N'77 Đ. Hoàng Hoa Thám, Hiệp Thành, Thủ Dầu Một, Bình Dương, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0288', N'Ân Văn Thái', '16/03/1983', N'Nam', '0002789060', N'468 Trần Hưng Đạo, Lê Hồng Phong, Thành Phố, Bình Định, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0289', N'Lâm Ngọc Quỳnh Nga', '01/05/2004', N'Nữ', '0493898634', N'57 Lê Duẩn, Tân Phú, Đồng Xoài, Bình Phước, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0290', N'Tống Văn Hải', '09/11/2001', N'Nam', '0339256903', N'154 Trương Hán Siêu, Phú Thuỷ, Thành phố Phan Thiết, Bình Thuận, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0291', N'Huỳnh Duy Quỳnh', '18/07/1977', N'Nam', '0038662284', N'298 Đ. Trần Hưng Đạo, Phường 5, Thành phố Cà Mau, Cà Mau, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0292', N'Phù Duy Bình', '24/03/2017', N'Nam', '0624568086', N'Sn18 Tổ 1 Phố Giữa, Hòa An, Cao Bằng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0293', N'Dương Minh Bích Ngọc', '24/06/2005', N'Nữ', '0014009650', N'55 Đ. Ngô Tất Tố, Phường An Khánh, Ninh Kiều, Cần Thơ, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0294', N'Chuẩn Văn Đông', '14/07/1972', N'Nam', '0230869081', N'Nguyễn Phước Tần, Hoà Phát, Cẩm Lệ, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0295', N'Triệu Văn Hoa', '18/11/1980', N'Nam', '0803684153', N'J46M+HMC, Ea tur, Cư Kuin, Đắk Lắk, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0296', N'Tống Huy Hương', '25/02/1969', N'Nam', '0889371741', N'448 Tôn Đức Thắng, Phường Nghĩa Thành, Gia Nghĩa, Đắk Nông, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0297', N'Đàm Hoàng Huy', '07/07/2000', N'Nam', '0842047195', N'Số 565, tổ 11, Thành phố Điện Biên Phủ, Điện Biên, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0298', N'Dư Nguyễn Hùng', '15/11/1971', N'Nam', '0787332262', N'201-203 QL1A ,Ấp, Hố Nai 3, Trảng Bom, Đồng Nai, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0299', N'Ân Công Phúc', '12/03/1963', N'Nam', '0410233685', N'267 Ngô Thì Nhậm, Phường 1, TP. Cao Lãnh, Đồng Tháp, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0300', N'Tiết Văn Trang', '16/02/1984', N'Nam', '0705979365', N'67 Hoàng Văn Thụ, P.Tây Sơn, Thành phố Pleiku, Gia Lai, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0301', N'Tiêu Duy Hà', '13/05/1999', N'Nam', '0419917499', N'SỐ 522 ĐƯỜNG QUANG TRUNG, TỔ 5, THỊ TRẤN, Hà Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0302', N'Tri Duy Thanh Thảo', '24/07/2009', N'Nam', '0732524257', N'294 Nguyễn Hữu Tiến, Đồng Văn, Duy Tiên, Hà Nam, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0303', N'Lê Hoàng Kiên', '16/08/1995', N'Nam', '0677179693', N'THANH OAI, SỐ 147, Cao Dương, HÀ NỘI, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0304', N'Phạm Thịnh Ngọc Trinh', '24/01/1981', N'Nữ', '0758219838', N'6 Trần Phú, Bắc Hà, Hà Tĩnh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0305', N'Tiêu Quang Anh', '13/09/1999', N'Nam', '0469084586', N'169 Bạch Đằng, P. Trần Phú, Thành phố Hải Dương, Hải Dương, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0306', N'Nông Thành Cường', '10/06/1993', N'Nam', '0337098434', N'771 Nguyễn Bỉnh Khiêm, Đông Hải 1, Hải An, Hải Phòng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0307', N'Chuẩn Anh Trang', '20/04/1999', N'Nữ', '0358083760', N'22 Ngõ 38 Phố Trần Quý Kiên, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0308', N'Thái Tuấn Hà Thu', '22/07/1985', N'Nữ', '0104409716', N'161 đường Nguyễn Đình Chiểu, Phường 6, Quận 3, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0309', N'Tạ Đức Minh', '10/01/1997', N'Nam', '0910700689', N'38 Ba Mươi Tháng Tư, Phường 1, Vị Thanh, Hậu Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0310', N'Phạm Công Nhung', '05/12/1970', N'Nữ', '0058981281', N'65 Lê Thanh Nghị, P. Hiền Nam, Hưng Yên, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0311', N'Tài Thị Thanh Thảo', '23/03/2024', N'Nữ', '0365451084', N'254 Trường Chinh, Cam Đức, Cam Lâm, Khánh Hòa, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0312', N'Trần Văn Hạnh', '06/06/1950', N'Nam', '0936180647', N'237 Đông An, TT. Tân Hiệp, Tân Hịêp, Kiên Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0313', N'Đồng Hữu Huyền Trang', '26/05/1988', N'Nữ', '0337990131', N'191 Phan Chu Trinh, Phường Quyết Thắng, Kon Tum, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0314', N'Mạc Nguyễn Hồng Loan', '27/04/2019', N'Nữ', '0273779739', N'TỔ 12, Tp. Lai Châu, Lai Châu, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0315', N'Ngọc Hoàng Ngọc', '22/09/2003', N'Nam', '0538733912', N'224 Nguyễn Huệ, Phố Mới, Lào Cai, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0316', N'Biện Thanh Phong', '31/12/1982', N'Nam', '0070929993', N'422 Hùng Vương, Mai Pha, Thành phố Lạng Sơn, Lạng Sơn, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0317', N'Lại Ngọc Hiếu', '04/05/2001', N'Nữ', '0706689400', N'151 Nguyễn Công Trứ, Phường 8, Thành phố Đà Lạt, Lâm Đồng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0318', N'Cao Nguyễn Trang', '04/08/1987', N'Nam', '0378500231', N'Số 30 ấp Phước Toàn, Long Hiệp, Bến Lức, Long An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0319', N'Trịnh Quang Anh', '12/05/1962', N'Nam', '0698092407', N'192 Quán Chiền, Nam Dương, Nam Trực, Nam Định, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0320', N'Nông Hoàng Thắng', '01/03/1959', N'Nam', '0616479081', N'96 Lý Thường Kiệt, Lê Lợi, Thành phố Vinh, Nghệ An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0321', N'Đoàn Văn Dung', '07/10/1956', N'Nam', '0023591801', N'120 Xuân Thành, Tân Thành, Ninh Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0322', N'Trương Hoàng Hà My', '21/04/1965', N'Nữ', '0992715835', N'90A Trần Phú, Phủ Hà, Phan Rang-Tháp Chàm, Ninh Thuận, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0323', N'Sái Ngọc Lan', '13/11/2013', N'Nữ', '0149581470', N'8C4J+26W, Đ. Hùng Vương, Ph. Thanh Miếu, Thành phố Việt Trì, Phú Thọ, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0324', N'Vương Hoàng Ngọc Ánh', '07/09/2015', N'Nữ', '0939320090', N'42 Đ. Trần Bình Trọng, Phường 4, Tuy Hòa, Phú Yên, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0325', N'Phí Thành Hoa', '14/05/1987', N'Nam', '0368781306', N'145 Lý Thái Tổ, Đồng Sơn, Đồng Hới, Quảng Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0326', N'Hồ Văn Phong', '17/01/1980', N'Nam', '0686705779', N'140 Quang Trung, Khu 5, Đại Lộc, Quảng Nam, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0327', N'Vi Văn Minh Tuấn', '01/02/1967', N'Nam', '0115095119', N'336 Đ. Nguyễn Huệ, La Hà, Tư Nghĩa, Quảng Ngãi, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0328', N'Ngụy Thịnh Đức', '14/06/2006', N'Nam', '0561025071', N'8 Đ Thanh Niên, Cẩm Thành, Cẩm Phả, Quảng Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0329', N'Tôn Huy Hải', '27/02/1984', N'Nam', '0208552286', N'Kiệt 125, QL9, Phường 5, Đông Hà, Quảng Trị, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0330', N'Giang Công Thảo', '06/07/1992', N'Nam', '0973501753', N'98 Nguyễn Huệ, K1P1, Ngã Năm, Sóc Trăng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0331', N'Hà Hoàng Anh', '11/01/2003', N'Nữ', '0634112856', N'Số 61 Đường Hương Xoài, TT. Yên Châu, Yên Châu, Sơn La, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0332', N'Biện Thị Trí', '03/02/1986', N'Nữ', '0233780510', N'250 Nguyễn Chí Thanh, Phường 3, Tây Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0333', N'Tiêu Hoàng Long', '14/03/1988', N'Nam', '0062376838', N'218 Long Hưng, Hoàn Diệu, Thái Bình, 411004, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0334', N'Quách Minh An', '11/03/1981', N'Nữ', '0657350002', N'262 đường Phan Đình Phùng, Thành phố Thái Nguyên, Thái Nguyên, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0335', N'La Hoài Kiên', '02/09/2003', N'Nam', '0877122253', N'360A Đ. Trần Phú, P. Ba Đình, Thành phố Thanh Hóa, Thanh Hoá, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0336', N'Chuẩn Ngọc Quỳnh Anh', '30/08/1979', N'Nữ', '0874714085', N'193 Điện Biên Phủ, Trường An, Thành phố Huế, Thừa Thiên Huế, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0337', N'Lý Thanh Hạnh', '06/09/2005', N'Nữ', '0853197144', N'559A Lý Thường Kiệt, Phường 5, Thành phố Mỹ Tho, Tiền Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0338', N'Tài Hoài Hà Thu', '27/05/1950', N'Nữ', '0231873448', N'156 Đ. Nguyễn Đáng, Phường 7, Trà Vinh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0339', N'Phạm Thịnh Long', '22/08/2007', N'Nam', '0502443320', N'R626+X3W, Phạm Văn Đồng, Hưng Thành, Tp. Tuyên Quang, Tuyên Quang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0340', N'Đoàn Minh Quyết', '26/04/1962', N'Nam', '0503276475', N'55E Phạm Thái Bường, Phường 4, Vĩnh Long, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0341', N'Châu Minh Dung', '24/02/1979', N'Nữ', '0945349555', N'31 Ng. 376 Đ. Thụy Khuê, Bưởi, Tây Hồ, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0342', N'Hàm Văn Ngọc Ánh', '21/06/2023', N'Nữ', '0461142800', N'318 đường Kim Đồng, phường Minh Tân, Thành phố Yên Bái, Yên Bái, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0343', N'Trình Duy Thành', '12/11/2003', N'Nam', '0754955531', N'46/6 Cộng Hòa, Phường 13, Quận Tân Bình, TP Hồ Chí Minh');
INSERT INTO BENHNHAN VALUES ('BN0344', N'Cung Ngọc Lan', '29/09/2007', N'Nữ', '0892965574', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0345', N'Bùi Hữu Cường', '14/07/2016', N'Nam', '0450689989', N'202 Đ. Trương Định, Tương Mai, Hai Bà Trưng, Hà Nội');
INSERT INTO BENHNHAN VALUES ('BN0346', N'Ngọc Duy Hạnh', '15/10/1950', N'Nam', '0222197293', N'27 Hai Bà Trưng, Bến Nghé, Quận 1, Hồ Chí Minh');
INSERT INTO BENHNHAN VALUES ('BN0347', N'Quản Huy Quốc', '04/07/2008', N'Nam', '0969064462', N'248 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh');
INSERT INTO BENHNHAN VALUES ('BN0348', N'Biện Huy Khánh', '22/07/2009', N'Nam', '0795239933', N'20 Lê Thánh Tông, Cẩm Sơn, Hội An, Quảng Nam, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0349', N'Hứa Công Mai', '20/02/1995', N'Nam', '0777752118', N'58 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0350', N'Đàm Hoài Hùng', '20/04/1990', N'Nam', '0247656748', N'404 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0351', N'Chuẩn Anh Phương Anh', '11/05/2015', N'Nữ', '0059918542', N'85 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0352', N'Đặng Thịnh Kim', '22/05/2009', N'Nam', '0587632377', N'45 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0353', N'Ứng Thịnh Phú', '15/12/2014', N'Nam', '0879117426', N'31 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0354', N'Giang Hoàng Hương', '15/10/2007', N'Nữ', '0435310657', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0355', N'Khải Thịnh Phúc', '28/08/2018', N'Nam', '0291711645', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0356', N'Giang Thành Quỳnh Anh', '18/08/1992', N'Nữ', '0747362248', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0357', N'Phùng Thanh Khang', '11/02/1995', N'Nam', '0567895636', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0358', N'Triệu Hoài Anh', '13/10/2001', N'Nam', '0843296005', N'281 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0359', N'Trần Nguyễn Anh', '24/09/1956', N'Nữ', '0356991755', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0360', N'Tri Công Thuý', '21/11/1999', N'Nữ', '0852094550', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0361', N'Ngụy Văn Linh', '06/08/2022', N'Nam', '0689867830', N'202 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0362', N'Vi Hoàng Quyết', '25/10/1978', N'Nam', '0320236334', N'24 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0363', N'Khắc Thị Thái', '25/11/1956', N'Nữ', '0309565391', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0364', N'Phan Thành Ngân', '11/03/1994', N'Nam', '0716463358', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0365', N'Tề Thanh Anh', '15/07/1950', N'Nam', '0326620195', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0366', N'Khắc Trung Duy', '03/07/1990', N'Nam', '0619251301', N'237 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0367', N'Phước Hoài Ngân', '27/06/2024', N'Nữ', '0034582793', N'249 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0368', N'Lương Văn Thái', '09/08/1969', N'Nam', '0827091032', N'578 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0369', N'Đặng Đức Long', '09/02/2016', N'Nam', '0148090898', N'25 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0370', N'Sái Văn Hạnh', '19/01/1976', N'Nam', '0357038793', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0371', N'Đối Phúc Thanh Hương', '10/12/2008', N'Nữ', '0738566933', N'36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0372', N'Ứng Văn Hạnh', '30/01/2023', N'Nam', '0587898983', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0373', N'Lê Thành Ngọc', '10/12/1956', N'Nữ', '0573336459', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0374', N'Tề Thanh Huy', '09/01/2011', N'Nam', '0549547310', N'203 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0375', N'Dư Văn Ngọc', '07/04/1974', N'Nam', '0934527517', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0376', N'Kiều Hoàng Lan', '13/06/2006', N'Nam', '0098405192', N'33 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0377', N'Quản Duy Đức', '06/02/2015', N'Nam', '0489943572', N'28 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0378', N'Tô Thanh Minh Châu', '01/11/1963', N'Nữ', '0996807839', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0379', N'Châu Công Thùy Linh', '11/02/1957', N'Nữ', '0975536070', N'59 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0380', N'Thạch Văn Phong', '14/02/1990', N'Nam', '0243908803', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0381', N'Trầm Thịnh Đông', '12/10/1978', N'Nam', '0639892135', N'405 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0382', N'Kiều Công Nguyên', '15/04/1953', N'Nam', '0106440397', N'86 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0383', N'Ngọc Hoàng Hùng', '10/04/1982', N'Nam', '0733682706', N'46 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0384', N'Lê Thị Quỳnh', '08/01/1951', N'Nữ', '0088677613', N'32 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0385', N'Phù Hoàng Kiên', '26/06/1956', N'Nam', '0705015133', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0386', N'Đinh Văn Tùng', '27/09/1988', N'Nam', '0631772687', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0387', N'Kiều Đức Hải', '15/10/1963', N'Nam', '0859659723', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0388', N'Lâm Thị Hải', '04/10/2006', N'Nữ', '0462686498', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0389', N'Lê Văn Diệu', '20/12/1977', N'Nam', '0899890077', N'282 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0390', N'Nông Văn Thành', '19/11/2022', N'Nam', '0722402798', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0391', N'Lương Công Dung', '18/04/2005', N'Nữ', '0268059211', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0392', N'Mạc Thị Hương', '18/07/2018', N'Nữ', '0725259443', N'203 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0393', N'Hứa Huy Hà My', '05/01/2023', N'Nữ', '0183271461', N'25 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0394', N'Sái Hữu Vũ', '02/02/1953', N'Nam', '0038687082', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0395', N'Hồng Hoàng Khang', '15/01/2024', N'Nam', '0576215918', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0396', N'Bàng Nguyễn Phúc', '04/08/1969', N'Nam', '0040072539', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0397', N'Doãn Hoài Minh Tuấn', '30/08/2006', N'Nam', '0014539237', N'238 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0398', N'Sái Đình Phú', '18/02/2024', N'Nam', '0763124768', N'250 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0399', N'Tề Đức Quốc', '07/08/1987', N'Nam', '0208573767', N'579 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0400', N'Phạm Hoài Đạt', '29/04/1981', N'Nam', '0756288737', N'26 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0401', N'Hà Đức Yến', '15/05/1956', N'Nam', '0258510545', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0402', N'Tô Hữu Hương', '24/09/2006', N'Nữ', '0945662641', N'37 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0403', N'Viên Thành Quỳnh', '29/06/1960', N'Nam', '0993528750', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0404', N'Nhâm Hoài Huyền Trang', '19/01/1953', N'Nữ', '0172695352', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0405', N'Văn Văn Quang', '14/05/1972', N'Nam', '0135095339', N'204 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0406', N'Đồng Hoàng Ngọc', '10/10/1982', N'Nam', '0487244082', N'105 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0407', N'Thái Thành Gia Hân', '21/05/1980', N'Nữ', '0405106958', N'34 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0408', N'Duy Ngọc Nhung', '02/02/1957', N'Nữ', '0213796064', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0409', N'Châu Minh Thanh Hương', '21/09/1966', N'Nữ', '0710005783', N'29 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0410', N'Hàm Hữu Hiếu', '21/08/2008', N'Nam', '0993326241', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0411', N'Kiều Thị Lan', '14/01/2015', N'Nữ', '0047291330', N'60 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0412', N'Viên Phúc Ngọc', '11/04/1979', N'Nam', '0636725381', N'406 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0413', N'Đoàn Hoàng Diệu', '22/05/1966', N'Nam', '0557826613', N'87 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0414', N'Cáp Hoài Khang', '12/10/2018', N'Nam', '0881133204', N'47 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0415', N'Vương Ngọc Ngân', '28/09/1958', N'Nữ', '0309406199', N'33 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0416', N'Tề Hoàng Bình', '09/03/2013', N'Nam', '0524208702', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0417', N'Phùng Ngọc Khang', '23/05/2013', N'Nam', '0289171077', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0418', N'Từ Công Quỳnh', '27/03/2007', N'Nam', '0079331091', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0419', N'Trầm Phúc Gia Hân', '23/01/2001', N'Nữ', '0982010082', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0420', N'Vi Thành Bích Ngọc', '30/10/2019', N'Nữ', '0847539021', N'283 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0421', N'Địch Hoài Ánh', '18/02/1974', N'Nam', '0116168630', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0422', N'Ôn Phúc Ngọc Ánh', '11/03/1985', N'Nữ', '0151399031', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0423', N'Đỗ Tuấn Sơn', '03/11/1983', N'Nam', '0258160368', N'46/1A Đỗ Nhuận, Sơn Kỳ, Tân Phú, TP.HCM');
INSERT INTO BENHNHAN VALUES ('BN0424', N'Âu Hữu Vinh', '21/10/1993', N'Nam', '0918453871', N'16 P. Nguyễn Quang Bích. Cửa Đông. Hoàn Kiếm. Hà Nội 10000. Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0425', N'Doãn Tuấn Hiếu', '07/08/1971', N'Nam', '0793310974', N'88 Lê Văn Duyệt, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0426', N'Cù Ngọc Hương', '04/03/2012', N'Nữ', '0425714709', N'21 5 Tháng 6, Tổ dân phố số 16, Thị xã Lai Châu, Lai Châu, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0427', N'Phó Đức Linh', '17/11/2011', N'Nam', '0651422435', N'107 Minh Khai, Phố Mới, Lào Cai, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0428', N'Khổng Thanh Lâm', '21/09/1996', N'Nam', '0053093152', N'876 Trần Cao Vân, Thanh Khê Đông, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0429', N'Tài Phúc Lâm', '26/07/2022', N'Nam', '0262513424', N'Ng. 34 P. Hào Nam, Chợ Dừa, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0430', N'Lương Huy Quốc', '09/06/2017', N'Nam', '0191565928', N'164 Nguyễn Thông, Bình Tâm, Tân An, Long An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0431', N'Khổng Hoài Ngọc', '25/10/2019', N'Nữ', '0308039328', N'108 Thái Bình, Trần Tế Xương, TP. Nam Định, Nam Định, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0432', N'Lê Thành Ngọc Mai', '02/05/1987', N'Nữ', '0168844396', N'573 Điện Biên Phủ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0433', N'Giang Công Hà', '24/05/1959', N'Nam', '0910873984', N'79 Đ. La Thành, Chợ Dừa, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0434', N'Hứa Hữu Hải', '15/07/2002', N'Nam', '0012252478', N'198 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0435', N'Lâm Thị Ngọc Lan', '11/02/1956', N'Nam', '0254266717', N'12 Hà Liễu, Ph.Gia Cẩm, Thành phố Việt Trì, Phú Thọ, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0436', N'Văn Thị Quỳnh Nga', '22/08/1994', N'Nam', '0506334425', N'112 Đ. Đinh Tiên Hoàng, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0437', N'Hàm Nguyễn Ánh', '11/02/1955', N'Nam', '0490400433', N'9 Đ. Phan Đăng Lưu, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0438', N'Phan Thị Thắng', '11/08/1963', N'Nữ', '0490134762', N'12 Nơ Trang Long, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0439', N'Đồng Văn Quỳnh', '04/07/1965', N'Nam', '0844021811', N'90 Phạm Văn Đồng, Nghĩa Chánh Bắc, Quảng Ngãi, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0440', N'Bùi Đức Kim', '09/04/2012', N'Nam', '0398285078', N'1 Đ. Phan Đăng Lưu, phường 03, Bình Thạnh, Thành phố Hồ Chí Minh 72300, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0441', N'Mai Hoàng Quốc', '02/06/1961', N'Nam', '0400479378', N'105 Hai Bà Trưng, Phường 3, Quảng Trị, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0442', N'Đoàn Thịnh An', '22/11/2003', N'Nam', '0436423974', N'10 Lê Thánh Tông, Thắng Lợi, Thành phố Buôn Ma Thuột, Đắk Lắk, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0443', N'Tôn Thị Thái', '10/10/2020', N'Nữ', '0869053146', N'122 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0444', N'Dương Thịnh Phương Anh', '29/09/1963', N'Nữ', '0834678125', N'258 Cù Chính Lan, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0445', N'Trầm Thanh Mai Phương', '08/10/2005', N'Nữ', '0810695247', N'199 P. Vương Thừa Vũ, Khương Trung, Thanh Xuân, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0446', N'Đàm Đức Vy', '29/04/2024', N'Nữ', '0962634128', N'132 ĐT848, Phường An Hoà, Sa Đéc, Đồng Tháp, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0447', N'Phùng Thị Hà', '10/01/2003', N'Nữ', '0557739543', N'87P1 Đ. Lê Văn Duyệt, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0448', N'Hàm Hoàng Nam', '26/01/2010', N'Nam', '0708323929', N'24 Bạch Đằng, P. Nguyễn Trãi, Hà Giang, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0449', N'Tôn Minh Tuyết', '23/04/2011', N'Nữ', '0162780521', N'164 / 44 P. Vương Thừa Vũ, Khương Trung, Thanh Xuân, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0450', N'Phùng Hoài Thị Hương', '17/02/2012', N'Nữ', '0114178014', N'5 Nguyễn Tri Phương, Quán Thánh, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0451', N'Chuẩn Thị Khang', '12/04/1963', N'Nữ', '0743751503', N'745 Trần Cao Vân, Thanh Khê Đông, Hải Châu, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0452', N'Hàn Văn Phúc', '21/02/1953', N'Nam', '0500833182', N'1/2 Phó Đức Chính, Phường 1, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0453', N'Lưu Tuấn Trường', '04/08/1955', N'Nam', '0272815970', N'93 Bà Triệu, P. Thanh Trung, Thành phố Hải Dương, Hải Dương, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0454', N'Mạc Thanh Sơn', '07/09/1985', N'Nam', '0429244133', N'8 Lê Quang Định, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0455', N'Đinh Văn Ngọc Yến', '15/04/2003', N'Nữ', '0226953312', N'58 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0456', N'Thạch Hoàng Huy', '06/07/2005', N'Nam', '0588150362', N'404 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0457', N'Viễn Huy Nguyên', '03/04/1956', N'Nam', '0667302263', N'85 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0458', N'Viên Anh Loan', '30/08/1974', N'Nữ', '0591255052', N'45 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0459', N'Ứng Đức Hải', '29/03/1978', N'Nam', '0052592082', N'31 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0460', N'Phùng Nguyễn Duy', '21/10/2013', N'Nam', '0220812263', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0461', N'Vương Minh Hồng Loan', '28/05/1969', N'Nữ', '0800180747', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0462', N'Biện Thị Tiến', '04/03/1979', N'Nam', '0684646419', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0463', N'Đậu Thanh Thuý', '01/03/1977', N'Nữ', '0859761378', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0464', N'Dương Thành Lâm', '24/03/1995', N'Nam', '0360744030', N'281 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0465', N'Sái Thị Quyết', '09/12/1970', N'Nữ', '0865615005', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0466', N'Quản Minh Đức', '02/05/2015', N'Nam', '0438195367', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0467', N'Đồng Tuấn Huy', '13/04/1963', N'Nam', '0420457520', N'202 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0468', N'La Minh Kim', '26/05/2016', N'Nữ', '0794637733', N'24 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0469', N'Kiều Đức Trang', '21/12/1958', N'Nữ', '0342379657', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0470', N'Văn Nguyễn Đức', '19/04/1990', N'Nam', '0850349209', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0471', N'Nhâm Thị Ngân', '17/01/2023', N'Nữ', '0130744169', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0472', N'Chuẩn Hoàng Thuý', '16/01/1957', N'Nữ', '0131526355', N'237 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0473', N'Huỳnh Đức Ngọc Lan', '19/11/1985', N'Nữ', '0440377362', N'249 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0474', N'Khúc Văn An', '03/11/1983', N'Nữ', '0108086546', N'578 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0475', N'Đặng Ngọc Mai', '02/09/1992', N'Nữ', '0614363358', N'25 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0476', N'Kiều Đức Ngọc Mai', '30/07/1954', N'Nữ', '0482934186', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0477', N'Giang Hoàng Vinh', '31/01/1960', N'Nam', '0325831860', N'36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0478', N'Châu Văn Bảo', '18/02/1964', N'Nam', '0833946994', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0479', N'Quản Công Hương', '14/01/1994', N'Nữ', '0969609618', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0480', N'Quản Văn Bảo', '16/08/1961', N'Nam', '0650079835', N'203 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0481', N'Đỗ Hoài Anh', '14/09/1952', N'Nam', '0525980446', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0482', N'Trình Thành Linh', '04/11/1989', N'Nam', '0294422396', N'33 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0483', N'Tôn Thanh Hải', '09/06/1985', N'Nam', '0897216953', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0484', N'Lý Hoàng Ngọc Diệp', '28/10/1975', N'Nữ', '0490675579', N'28 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0485', N'Lâm Hoàng Hà Thu', '23/10/1969', N'Nữ', '0718737147', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0486', N'Phan Văn Sơn', '08/08/1962', N'Nam', '0195911093', N'368 Đ. Hùng Vương. Phường 3. Tân An. Long An. Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0487', N'Tất Hoàng Quỳnh', '15/08/1992', N'Nữ', '0898622220', N'H55 Nguyễn Thị Nghĩa, Phường 2, Thành phố Đà Lạt, Lâm Đồng 66109, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0488', N'Trịnh Anh Văn', '15/12/2017', N'Nam', '0208793738', N'92 Trương Thị Sáu, Phường 3, Tân An, Long An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0489', N'Tôn Thịnh Duy', '31/08/1999', N'Nam', '0216542724', N'Đường N3, Lộc Hoà, TP. Nam Định, Nam Định, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0490', N'Ngô Duy Nam', '03/03/2002', N'Nam', '0598195333', N'Số 40 Đại lộ Xô Viết Nghệ, Nghi Phú, Thành phố Vinh, Nghệ An, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0491', N'Nguyễn Duy Khang', '16/12/1975', N'Nam', '0259970633', N'89 đường Ninh Tôn, Ninh Phú, Ninh Bình, 08000, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0492', N'Thái Đình Phú', '09/09/1962', N'Nam', '0040200327', N'1E Thống Nhất, Đài Sơn, Phan Rang-Tháp Chàm, Ninh Thuận, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0493', N'Sái Thanh Yến', '16/06/1963', N'Nam', '0815240555', N'98C6+H48, Hy Cương, Thành phố Việt Trì, Phú Thọ, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0494', N'Lý Thị Nguyên', '16/08/1967', N'Nữ', '0681042838', N'154 Đ. Nguyễn Trãi, Phường 5, Tuy Hòa, Phú Yên 56100, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0495', N'Phùng Công Nam', '24/08/1989', N'Nam', '0073086700', N'5RX7+MGF, Mỹ Thuỷ, Lệ Thủy, Quảng Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0496', N'Lê Công Thúy', '22/12/1970', N'Nữ', '0350146156', N'V7F9+36 Điện Bàn, Quảng Nam, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0497', N'Từ Văn Quân', '29/06/2016', N'Nam', '0613838659', N'4VHF+MPC, Nghĩa Hà, Tư Nghĩa, Quảng Ngãi, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0498', N'Châu Thị Ngọc Trinh', '08/04/1952', N'Nữ', '0567228699', N'VRXH+W4H, Unnamed Road, Liên Hoà, Yên Hưng, Quảng Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0499', N'Nông Quang Thanh', '08/04/1953', N'Nam', '0458232406', N'WH88+45W, Hòa Sơn, Lương Sơn, Hòa Bình, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0500', N'Lâm Thịnh Linh', '11/01/2006', N'Nam', '0266268500', N'Nguyễn Hữu Thọ, Phường 3, Tây Ninh, Việt Nam');
INSERT INTO BENHNHAN VALUES ('BN0501', N'Thi Văn Kim', '06/01/1993', N'Nam', '0781703456', N'Phạm Quang Lịch Lý Bôn, Tiền Phong, Thái Bình, 61000, Việt Nam');


INSERT INTO PHIEUHEN VALUES ('PH00001', '02/01/2023', N'Sáng', 'BS0001', N'Buồn nôn, chóng mặt', N'Phạm Huy Tùng', '02/12/2003', N'Nam', '0269628526', N'122 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00002', '02/02/2023', N'Chiều', 'BS0002', N'Đau bụng nhứt đầu', N'Lê Tuấn Tuyết', '02/10/1981', N'Nữ', '0797282312', N'258 Cù Chính Lan, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00003', '03/02/2023', N'Sáng', 'BS0003', NULL, N'Đỗ Huy Ngọc Trinh', '03/12/1996', N'Nữ', '0517034901', N'202 Đ. Trương Định, Tương Mai, Hai Bà Trưng, Hà Nội');
INSERT INTO PHIEUHEN VALUES ('PH00004', '04/03/2023', N'Sáng', 'BS0004', NULL, N'Trương Văn Bích Ngọc', '20/07/1978', N'Nữ', '0012200884', N'27 Hai Bà Trưng, Bến Nghé, Quận 1, Hồ Chí Minh');
INSERT INTO PHIEUHEN VALUES ('PH00005', '05/02/2023', N'Sáng', 'BS0005', NULL, N'Mai Quang Hà My', '22/12/1975', N'Nữ', '0278250452', N'248 Võ Văn Tần, Phường 5, Quận 3, Hồ Chí Minh');
INSERT INTO PHIEUHEN VALUES ('PH00006', '06/03/2023', N'Chiều', 'BS0006', NULL, N'Triệu Đức An', '16/09/1978', N'Nam', '0127062401', N'20 Lê Thánh Tông, Cẩm Sơn, Hội An, Quảng Nam, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00007', '07/02/2023', N'Chiều', 'BS0007', NULL, N'Giang Phúc Quyết', '09/03/1954', N'Nam', '0269360334', N'58 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00008', '08/02/2023', N'Chiều', 'BS0008', NULL, N'Phùng Công Đông', '12/08/1987', N'Nam', '0675041817', N'404 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00009', '09/02/2023', N'Chiều', 'BS0009', NULL, N'Tống Văn Xuân', '24/10/1974', N'Nam', '0625793114', N'85 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00010', '10/02/2023', N'Chiều', 'BS0010', NULL, N'Phùng Thành Thùy Linh', '03/01/1990', N'Nữ', '0562583388', N'45 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00011', '11/03/2023', N'Sáng', 'BS0011', NULL, N'Trương Minh Hà', '20/05/1973', N'Nữ', '0084561757', N'31 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00012', '12/02/2023', N'Chiều', 'BS0012', NULL, N'Phù Huy Ngọc Ánh', '22/11/1975', N'Nữ', '0378969265', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00013', '13/02/2023', N'Chiều', 'BS0013', NULL, N'Lưu Hoàng Thị Hương', '11/06/1974', N'Nữ', '0855936553', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00014', '14/02/2023', N'Sáng', 'BS0014', NULL, N'Trịnh Hữu Vũ', '12/01/2004', N'Nam', '0987157069', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00015', '15/02/2023', N'Sáng', 'BS0015', NULL, N'Viễn Nguyễn Quang', '12/02/1994', N'Nam', '0481340734', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00016', '16/02/2023', N'Sáng', 'BS0016', NULL, N'Ngụy Phúc Bảo', '28/03/1990', N'Nam', '0824454073', N'281 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00017', '17/02/2023', N'Chiều', 'BS0017', NULL, N'Sái Hoàng Nhật', '15/02/1999', N'Nam', '0226979476', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00018', '18/02/2023', N'Chiều', 'BS0018', NULL, N'Vi Thị Kiên', '24/10/1997', N'Nữ', '0083703932', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00019', '19/02/2023', N'Sáng', 'BS0019', NULL, N'Hà Thị Loan', '21/02/1967', N'Nữ', '0168823739', N'202 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00020', '20/02/2023', N'Sáng', 'BS0020', NULL, N'Cung Đình Phú', '20/05/2017', N'Nam', '0002620708', N'24 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00021', '21/02/2023', N'Sáng', 'BS0021', NULL, N'Tô Đình Long', '25/12/1999', N'Nam', '0258522796', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00022', '22/02/2023', N'Chiều', 'BS0022', NULL, N'Tô Văn Khang', '27/09/2021', N'Nam', '0407658210', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00023', '23/02/2023', N'Sáng', 'BS0023', NULL, N'Cáp Hoàng Minh Châu', '22/01/1975', N'Nữ', '0815421991', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00024', '24/02/2023', N'Chiều', 'BS0024', NULL, N'Trình Quang Thái', '12/10/1961', N'Nam', '0841478808', N'237 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00025', '25/02/2023', N'Sáng', 'BS0025', NULL, N'Ngụy Hoàng Tuấn', '17/07/1965', N'Nam', '0552702699', N'249 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00026', '26/02/2023', N'Sáng', 'BS0026', NULL, N'Tô Hoàng Vy', '29/07/1984', N'Nữ', '0619899167', N'578 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00027', '27/02/2023', N'Chiều', 'BS0027', NULL, N'Nguyễn Ngọc Phong', '30/12/1979', N'Nam', '0766638154', N'25 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00028', '28/02/2023', N'Chiều', 'BS0028', NULL, N'Triệu Phúc Thái', '13/02/1976', N'Nam', '0785467500', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00029', '01/03/2023', N'Chiều', 'BS0029', NULL, N'Tiết Hoàng Thùy Linh', '19/08/1980', N'Nữ', '0457679418', N'36 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00030', '02/03/2023', N'Sáng', 'BS0030', NULL, N'Phí Nguyễn Ngọc Lan', '01/12/1986', N'Nữ', '0246071750', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00031', '03/03/2023', N'Sáng', 'BS0031', NULL, N'Võ Hoàng Việt', '28/01/2016', N'Nam', '0345324336', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00032', '04/03/2023', N'Sáng', 'BS0032', NULL, N'Hàm Thị Văn', '20/11/1992', N'Nam', '0201493281', N'203 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00033', '05/03/2023', N'Sáng', 'BS0033', NULL, N'Địch Thị Quỳnh Nga', '17/01/1963', N'Nữ', '0544045347', N'104 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00034', '06/03/2023', N'Chiều', 'BS0034', NULL, N'Lưu Thành Văn', '11/08/1974', N'Nam', '0250832780', N'33 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00035', '07/03/2023', N'Sáng', 'BS0035', NULL, N'Giang Văn Vy', '14/10/2004', N'Nam', '0072349208', N'28 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00036', '08/03/2023', N'Sáng', 'BS0044', NULL, N'Đồng Thị Hà My', '22/01/1956', N'Nữ', '0332378390', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00037', '09/03/2023', N'Chiều', 'BS0045', NULL, N'Vi Phúc Thanh Hương', '29/07/2006', N'Nữ', '0472037078', N'59 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00038', '10/03/2023', N'Chiều', 'BS0046', NULL, N'Cung Hoàng Ngọc Trinh', '23/02/1997', N'Nữ', '0703461097', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00039', '11/03/2023', N'Sáng', 'BS0047', NULL, N'Viên Thị Thắng', '16/01/1955', N'Nam', '0704383494', N'405 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00040', '12/03/2023', N'Sáng', 'BS0048', NULL, N'Lý Hữu Trí', '26/06/1979', N'Nam', '0204581339', N'86 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00041', '13/03/2023', N'Sáng', 'BS0049', NULL, N'Đỗ Văn Ngọc Diệp', '20/11/1956', N'Nữ', '0809874862', N'46 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00042', '14/03/2023', N'Sáng', 'BS0050', NULL, N'Ngô Đình Hoa', '15/04/1996', N'Nữ', '0143825471', N'32 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00043', '15/03/2023', N'Sáng', 'BS0001', NULL, N'Mã Văn Thu', '18/05/1998', N'Nam', '0282318547', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00044', '16/03/2023', N'Sáng', 'BS0002', NULL, N'Đậu Anh Bảo', '11/12/1979', N'Nam', '0579532527', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00045', '17/03/2023', N'Sáng', 'BS0003', NULL, N'Tạ Hoàng Tuấn', '06/06/1955', N'Nam', '0895025939', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00046', '18/03/2023', N'Chiều', 'BS0004', NULL, N'Mai Văn Phương', '31/12/1965', N'Nam', '0342615880', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00047', '19/03/2023', N'Chiều', 'BS0005', NULL, N'Khúc Thành Anh', '12/09/1979', N'Nam', '0746131570', N'282 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00048', '20/03/2023', N'Sáng', 'BS0006', NULL, N'Phạm Huy Ngọc Ánh', '18/05/1990', N'Nữ', '0122983232', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00049', '21/03/2023', N'Sáng', 'BS0007', NULL, N'Ôn Thị Trung', '13/08/2008', N'Nữ', '0825794952', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00050', '22/03/2023', N'Sáng', 'BS0008', NULL, N'Nhâm Duy Loan', '29/05/1969', N'Nữ', '0746554697', N'203 Đ. Tô Hiến Thành, Phường 15, Quận 11, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00051', '23/03/2023', N'Chiều', 'BS0009', NULL, N'Khúc Hoàng Phúc', '03/09/2018', N'Nam', '0282437723', N'25 Phạm Nhữ Tăng, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00052', '24/03/2023', N'Chiều', 'BS0010', NULL, N'Phù Văn Thanh Hương', '21/10/1950', N'Nữ', '0795438089', N'Ng. 1 800A, Nghĩa Đô, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00053', '25/03/2023', N'Sáng', 'BS0011', NULL, N'Tôn Công Hà', '13/04/2016', N'Nam', '0163671750', N'226, Đường Hà Huy Tập, Phường Hòa Khê, Quận Thanh Khê, Hòa Khê, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00054', '26/03/2023', N'Sáng', 'BS0012', NULL, N'Đàm Ngọc Yến', '22/04/2015', N'Nữ', '0571144640', N'16F/B1 Ba Tháng Hai Tổ 40 KP 6, Phường 14, Quận 10, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00055', '27/03/2023', N'Chiều', 'BS0013', NULL, N'Doãn Anh Minh Tuấn', '02/09/1971', N'Nam', '0102831102', N'238 Đ. Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00056', '28/03/2023', N'Sáng', 'BS0014', NULL, N'Tô Hoài Hoa', '10/06/1983', N'Nữ', '0167098927', N'250 Hà Huy Tập, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00057', '29/03/2023', N'Sáng', 'BS0015', NULL, N'Lâm Văn Linh', '19/06/1996', N'Nam', '0342984493', N'579 Đ. Nguyễn Chí Thanh, Phường 7, Quận 5, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00058', '30/03/2023', N'Chiều', 'BS0016', NULL, N'Hà Công Tân', '25/02/1997', N'Nam', '0097678943', N'26 Ngõ 329 Cầu Giấy, Dịch Vọng, Cầu Giấy, Hà Nội 100000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00059', '31/03/2023', N'Sáng', 'BS0017', NULL, N'Trịnh Thị Hoàng', '08/05/2005', N'Nữ', '0329960334', N'C4 Cư Xá Phú Thọ Hoà, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00060', '01/04/2023', N'Chiều', 'BS0018', NULL, N'Mai Phúc Long', '27/09/1963', N'Nam', '0578597387', N'37 Xuân Thủy, Dịch Vọng Hậu, Cầu Giấy, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00061', '02/04/2023', N'Sáng', 'BS0019', NULL, N'Tôn Văn Kim', '11/08/1986', N'Nam', '0342880951', N'99B Thái Bình, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00062', '03/04/2023', N'Chiều', 'BS0020', NULL, N'Cù Hữu Nhật', '30/08/2003', N'Nam', '0812499826', N'36/23 Hẻm 36 Đồng Khởi, Phường 4, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00063', '04/04/2023', N'Chiều', 'BS0021', NULL, N'Quản Văn Đức', '19/01/2000', N'Nam', '0245767912', N'204 Nguyễn Văn Linh, TT. Núi Thành, Núi Thành, Quảng Nam 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00064', '05/04/2023', N'Chiều', 'BS0022', NULL, N'Phù Đình Thúy', '24/05/1978', N'Nữ', '0307214330', N'105 Đường B2, Tây Thạnh, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00065', '06/04/2023', N'Sáng', 'BS0023', NULL, N'Khắc Quang Ánh', '05/03/2007', N'Nam', '0877856155', N'34 Đ. Hoàng Diệu, Phường 12, Quận 4, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00066', '07/04/2023', N'Sáng', 'BS0024', NULL, N'Vi Huy Lan', '18/12/2014', N'Nữ', '0629774350', N'Ngõ 30 Đường Phạm Văn Đồng, Mai Dịch, Bắc Từ Liêm, Hà Nội 10000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00067', '08/04/2023', N'Sáng', 'BS0025', NULL, N'Khúc Thanh Phúc', '05/06/1957', N'Nam', '0153774013', N'29 Hàm Nghi, Bến Nghé, Quận 1, Thành phố Hồ Chí Minh 700000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00068', '09/04/2023', N'Sáng', 'BS0026', NULL, N'Tô Đình Huyền Trang', '12/05/1959', N'Nữ', '0116182693', N'71-73-75 Hai Bà Trưng, Street, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00069', '10/04/2023', N'Sáng', 'BS0027', NULL, N'Ngụy Thanh Thành', '07/01/1986', N'Nữ', '0459534966', N'60 ngõ 79, Hữu Nghị, Hòa Bình, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00070', '11/04/2023', N'Sáng', 'BS0028', NULL, N'Sái Thị Kim', '05/10/1978', N'Nữ', '0883251224', N'406 Nguyễn Sơn, Phú Thọ Hoà, Tân Phú, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00071', '12/04/2023', N'Sáng', 'BS0029', NULL, N'Bùi Phúc Quang', '17/06/1972', N'Nam', '0614822096', N'87 Huỳnh Ngọc Huệ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00072', '13/04/2023', N'Chiều', 'BS0030', NULL, N'Tôn Huy Lâm', '14/08/1975', N'Nam', '0429727318', N'47 Nguyễn Triệu Luật, Khu Phố 4, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00073', '14/04/2023', N'Sáng', 'BS0031', NULL, N'Vương Văn Thắng', '22/07/1969', N'Nam', '0304378000', N'33 P. Yên Thế, Văn Miếu, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00074', '15/04/2023', N'Sáng', 'BS0032', NULL, N'Trầm Hoài Phúc', '23/04/1998', N'Nam', '0310541533', N'HL2, Bình Trị Đông A, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00075', '16/04/2023', N'Chiều', 'BS0033', NULL, N'Bùi Thị Phúc', '05/11/2003', N'Nữ', '0787096071', N'K 123 Cù Chính Lan, Hòa Khê, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00076', '17/04/2023', N'Sáng', 'BS0034', NULL, N'Lâm Hoài Thùy Linh', '15/05/2005', N'Nữ', '0706015508', N'28/1B Lê Đình Cẩn, P, Bình Tân, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00077', '18/04/2023', N'Chiều', 'BS0035', NULL, N'Văn Nguyễn Yến', '04/10/1981', N'Nữ', '0313692775', N'A7/54 Đường 1C, Vĩnh Lộc B, Bình Chánh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00078', '19/04/2023', N'Sáng', 'BS0044', NULL, N'Kiều Nguyễn Thanh Thảo', '05/11/1999', N'Nữ', '0910926390', N'283 P. Đội Cấn, Liễu Giai, Ba Đình, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00079', '20/04/2023', N'Sáng', 'BS0045', NULL, N'Văn Huy Ngọc Mai', '16/11/1974', N'Nữ', '0193535313', N'Lạc Long Quân, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00080', '21/04/2023', N'Chiều', 'BS0046', NULL, N'Khúc Hoài Khánh', '16/09/2001', N'Nam', '0241786228', N'7/3C Đ. Âu Cơ, Phường 10, Tân Bình, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00081', '22/04/2023', N'Chiều', 'BS0047', NULL, N'Tôn Đức Minh', '08/05/1986', N'Nam', '0174511089', N'46/1A Đỗ Nhuận, Sơn Kỳ, Tân Phú, TP.HCM');
INSERT INTO PHIEUHEN VALUES ('PH00082', '23/04/2023', N'Sáng', 'BS0048', NULL, N'Đàm Công Ngọc Trinh', '03/08/1956', N'Nữ', '0140441630', N'16 P. Nguyễn Quang Bích. Cửa Đông. Hoàn Kiếm. Hà Nội 10000. Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00083', '24/04/2023', N'Sáng', 'BS0049', NULL, N'Khúc Quang Ngọc Yến', '30/09/1956', N'Nữ', '0898999040', N'88 Lê Văn Duyệt, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00084', '25/04/2023', N'Sáng', 'BS0050', NULL, N'Nông Phúc Hà', '10/06/1977', N'Nam', '0008201235', N'21 5 Tháng 6, Tổ dân phố số 16, Thị xã Lai Châu, Lai Châu, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00085', '26/04/2023', N'Sáng', 'BS0021', NULL, N'Cáp Thành Long', '07/09/1973', N'Nam', '0146292469', N'107 Minh Khai, Phố Mới, Lào Cai, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00086', '27/04/2023', N'Chiều', 'BS0022', NULL, N'Ôn Văn Long', '20/03/1981', N'Nam', '0476426220', N'876 Trần Cao Vân, Thanh Khê Đông, Thanh Khê, Đà Nẵng, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00087', '28/04/2023', N'Chiều', 'BS0023', NULL, N'Nhâm Hoàng Ngọc Diệp', '08/07/2002', N'Nữ', '0120215526', N'Ng. 34 P. Hào Nam, Chợ Dừa, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00088', '29/04/2023', N'Sáng', 'BS0024', NULL, N'Viễn Thành Mai Phương', '31/03/1957', N'Nữ', '0410554823', N'164 Nguyễn Thông, Bình Tâm, Tân An, Long An, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00089', '30/04/2023', N'Sáng', 'BS0025', NULL, N'Khổng Thanh Đức', '30/09/2017', N'Nam', '0208293459', N'108 Thái Bình, Trần Tế Xương, TP. Nam Định, Nam Định, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00090', '01/05/2023', N'Sáng', 'BS0026', NULL, N'Mã Văn Ngọc Yến', '21/11/2000', N'Nữ', '0550821125', N'573 Điện Biên Phủ, Thanh Khê Đông, Thanh Khê, Đà Nẵng 550000, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00091', '02/05/2023', N'Chiều', 'BS0027', NULL, N'Phú Phúc Ngọc Mai', '05/06/1971', N'Nữ', '0608019402', N'79 Đ. La Thành, Chợ Dừa, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00092', '03/05/2023', N'Chiều', 'BS0028', NULL, N'Châu Anh Gia Hân', '04/06/2023', N'Nữ', '0780329453', N'198 Nguyễn Lương Bằng, Quang Trung, Đống Đa, Hà Nội, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00093', '04/05/2023', N'Chiều', 'BS0029', NULL, N'Khổng Hoàng Thái', '28/09/2003', N'Nam', '0506997384', N'12 Hà Liễu, Ph.Gia Cẩm, Thành phố Việt Trì, Phú Thọ, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00094', '05/05/2023', N'Sáng', 'BS0030', NULL, N'Duy Thị Thảo', '18/10/1975', N'Nữ', '0168753181', N'112 Đ. Đinh Tiên Hoàng, Đa Kao, Quận 1, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00095', '06/05/2023', N'Chiều', 'BS0022', NULL, N'Bàng Minh Diệu', '09/08/2012', N'Nam', '0052062068', N'9 Đ. Phan Đăng Lưu, Phường 3, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00096', '07/05/2023', N'Sáng', 'BS0023', NULL, N'Khải Công Quốc', '01/12/2003', N'Nam', '0277797848', N'12 Nơ Trang Long, Phường 14, Bình Thạnh, Thành phố Hồ Chí Minh, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00097', '08/05/2023', N'Sáng', 'BS0024', NULL, N'Thi Tuấn Hoài', '24/03/2010', N'Nam', '0918765429', N'90 Phạm Văn Đồng, Nghĩa Chánh Bắc, Quảng Ngãi, Việt Nam');
INSERT INTO PHIEUHEN VALUES ('PH00098', '09/05/2023', N'Chiều', 'BS0033', NULL, N'Ứng Hoàng Vũ', '12/02/1998', N'Nam', '0801991858', N'1 Đ. Phan Đăng Lưu, phường 03, Bình Thạnh, Thành phố Hồ Chí Minh 72300, Việt Nam');

INSERT INTO NHANVIEN VALUES ('NV001', N'Bùi Phan Bảo Ngọc ', N'Quản lý', 'TK0001');
INSERT INTO NHANVIEN VALUES ('NV002', N'Nguyễn Phan Như Quỳnh ', N'Thu ngân', 'TK0002');
INSERT INTO NHANVIEN VALUES ('NV003', N'Võ Thị Thanh Trúc', N'Thu ngân', 'TK0003');
INSERT INTO NHANVIEN VALUES ('BS0001', N'Triệu Triều Dương', N'Giám đốc', 'TK0004');
INSERT INTO NHANVIEN VALUES ('BS0002', N'Trần Văn Hinh', N'Trưởng khoa', 'TK0005');
INSERT INTO NHANVIEN VALUES ('BS0003', N'Nguyễn Văn Nghĩa', N'Bác sĩ', 'TK0006');
INSERT INTO NHANVIEN VALUES ('BS0004', N'Tống Văn Khả', N'Dược sĩ', 'Null');
INSERT INTO NHANVIEN VALUES ('BS0005', N'Đỗ Thanh Thư', N'Bác sĩ', 'TK0007');
INSERT INTO NHANVIEN VALUES ('BS0006', N'Huỳnh Thị Thanh Trang', N'Phó khoa', 'TK0008');
INSERT INTO NHANVIEN VALUES ('BS0007', N'Trần Kim Oanh', N'Bác si', 'TK0009');
INSERT INTO NHANVIEN VALUES ('BS0008', N'Trần Đức Minh', N'Bác sĩ', 'TK0010');
INSERT INTO NHANVIEN VALUES ('BS0009', N'Võ Thị Tường Duy', N'Bác sĩ', 'TK0011');
INSERT INTO NHANVIEN VALUES ('BS0010', N'Cam Ngọc Phượng', N'Giám đốc trung tâm', 'Null');
INSERT INTO NHANVIEN VALUES ('BS0011', N'Trần Ngọc Hứu', N'Bác sĩ', 'TK0012');
INSERT INTO NHANVIEN VALUES ('BS0012', N'Nguyễn Thị Liên Hương', N'Bác sĩ', 'TK0013');
INSERT INTO NHANVIEN VALUES ('BS0013', N'Trịnh Tuấn Dũng', N'Bác sĩ', 'TK0014');
INSERT INTO NHANVIEN VALUES ('BS0014', N'Nguyễn Duy Trinh', N'Phó giám đốc', 'TK0015');
INSERT INTO NHANVIEN VALUES ('BS0015', N'Trần Thị Thanh Trúc', N'Bác sĩ', 'TK0016');
INSERT INTO NHANVIEN VALUES ('BS0016', N'Huỳnh Văn Mười Một', N'Bác sĩ', 'TK0017');
INSERT INTO NHANVIEN VALUES ('BS0017', N'Nguyễn Đức Hưng', N'Phó khoa', 'TK0018');
INSERT INTO NHANVIEN VALUES ('BS0018', N'Nguyễn Tân Cương', N'Bác sĩ', 'TK0019');
INSERT INTO NHANVIEN VALUES ('BS0019', N'Nguyễn Ngọc Huỳnh', N'Trưởng lap', 'Null');
INSERT INTO NHANVIEN VALUES ('BS0020', N'Dương Quang Huy', N'Bác sĩ', 'TK0020');
INSERT INTO NHANVIEN VALUES ('BS0021', N'Lê Xuân Nguyên', N'Bác sĩ', 'TK0021');
INSERT INTO NHANVIEN VALUES ('BS0022', N'Nguyễn Phạm Thùy Linh', N'Bác sĩ', 'TK0022');
INSERT INTO NHANVIEN VALUES ('BS0023', N'Ngô Trường Sơn', N'Phó trưởng khoa', 'TK0023');
INSERT INTO NHANVIEN VALUES ('BS0024', N'Lê Thanh Hùng', N'Bác sĩ', 'TK0024');
INSERT INTO NHANVIEN VALUES ('BS0025', N'Tạ Ngọc Thạch', N'Bác sĩ', 'TK0025');
INSERT INTO NHANVIEN VALUES ('BS0026', N'Chế Đình Nghĩa', N'Bác sĩ', 'TK0026');
INSERT INTO NHANVIEN VALUES ('BS0027', N'Ngô Quý Châu', N'Phó tổng giám đốc chuyên môn', 'TK0027');
INSERT INTO NHANVIEN VALUES ('BS0028', N'Trần Quán Anh', N'Bác sĩ cao cấp', 'TK0028');
INSERT INTO NHANVIEN VALUES ('BS0029', N'Trần Anh Vũ', N'Cố vấn chuyên môn', 'TK0029');
INSERT INTO NHANVIEN VALUES ('BS0030', N'Hồ Thị Khánh Quyên', N'Bác sĩ', 'TK0030');
INSERT INTO NHANVIEN VALUES ('BS0031', N'Nguyễn Quang Nhật', N'Bác sĩ', 'TK0031');
INSERT INTO NHANVIEN VALUES ('BS0032', N'Đào Trần Tiến', N'Bác sĩ', 'TK0032');
INSERT INTO NHANVIEN VALUES ('BS0033', N'Hà Thị Loan', N'Bác sĩ', 'TK0033');
INSERT INTO NHANVIEN VALUES ('BS0034', N'Mai Mạnh Tam', N'Bác sĩ', 'TK0034');
INSERT INTO NHANVIEN VALUES ('BS0035', N'Lã Quý Hương', N'Bác sĩ', 'TK0035');
INSERT INTO NHANVIEN VALUES ('BS0036', N'Nguyễn Văn Ngân', N'Bác sĩ', 'TK0036');
INSERT INTO NHANVIEN VALUES ('BS0037', N'Đặng Thành Đô', N'Bác sĩ', 'TK0037');
INSERT INTO NHANVIEN VALUES ('BS0038', N'Thân Thị Ngọc Lan', N'Bác sĩ', 'TK0038');
INSERT INTO NHANVIEN VALUES ('BS0039', N'Trần Duy Hưng', N'Bác sĩ', 'TK0039');
INSERT INTO NHANVIEN VALUES ('BS0040', N'Cẩn Tuyết Nga', N'Bác sĩ', 'TK0040');
INSERT INTO NHANVIEN VALUES ('BS0041', N'Trần Đức Hậu', N'Bác sĩ', 'TK0041');
INSERT INTO NHANVIEN VALUES ('BS0042', N'Lê Thị Lan Anh', N'Bác sĩ', 'TK0042');
INSERT INTO NHANVIEN VALUES ('BS0043', N'Nguyễn Văn Lan', N'Bác sĩ', 'TK0043');
INSERT INTO NHANVIEN VALUES ('BS0044', N'Lê Văn Khánh', N'Bác sĩ', 'TK0044');
INSERT INTO NHANVIEN VALUES ('BS0045', N'Lê Nguyệt Minh', N'Bác sĩ', 'TK0045');
INSERT INTO NHANVIEN VALUES ('BS0046', N'Quảng Thị Bính Thìn', N'Bác sĩ', 'TK0046');
INSERT INTO NHANVIEN VALUES ('BS0047', N'Phạm Thanh Xuân', N'Bác sĩ', 'TK0047');
INSERT INTO NHANVIEN VALUES ('BS0048', N'Phan Thị Phương Thảo', N'Bác sĩ', 'TK0048');
INSERT INTO NHANVIEN VALUES ('BS0049', N'Nguyễn Quốc Khánh', N'Bác sĩ', 'TK0049');
INSERT INTO NHANVIEN VALUES ('BS0050', N'Dương Công Lĩnh', N'Bác sĩ', 'TK0050');

INSERT INTO BENH VALUES ('B0001', N'Cúm');
INSERT INTO BENH VALUES ('B0002', N'Viêm phổi');
INSERT INTO BENH VALUES ('B0003', N'Lao');
INSERT INTO BENH VALUES ('B0004', N'COVID-19');
INSERT INTO BENH VALUES ('B0005', N'Sởi');
INSERT INTO BENH VALUES ('B0006', N'Quai bị');
INSERT INTO BENH VALUES ('B0007', N'Rubella');
INSERT INTO BENH VALUES ('B0008', N'Thuỷ đậu');
INSERT INTO BENH VALUES ('B0009', N'Ho gà');
INSERT INTO BENH VALUES ('B0010', N'Viêm não Nhật Bản');
INSERT INTO BENH VALUES ('B0011', N'Tay chân miệng');
INSERT INTO BENH VALUES ('B0012', N'Bệnh dại');
INSERT INTO BENH VALUES ('B0013', N'Đau mắt hột ');
INSERT INTO BENH VALUES ('B0014', N'Tả');
INSERT INTO BENH VALUES ('B0015', N'Thương hàn');
INSERT INTO BENH VALUES ('B0016', N'Lỵ');
INSERT INTO BENH VALUES ('B0017', N'Viêm gan A');
INSERT INTO BENH VALUES ('B0018', N'Viêm gan B');
INSERT INTO BENH VALUES ('B0019', N'Viêm gan C');
INSERT INTO BENH VALUES ('B0020', N'Rotavirus');
INSERT INTO BENH VALUES ('B0021', N'HIV/AIDS');
INSERT INTO BENH VALUES ('B0022', N'Bệnh lậu');
INSERT INTO BENH VALUES ('B0023', N'Giang mai');
INSERT INTO BENH VALUES ('B0024', N'Chlamydia');
INSERT INTO BENH VALUES ('B0025', N'Mụn cóc sinh dục');
INSERT INTO BENH VALUES ('B0026', N'Sốt xuất huyết');
INSERT INTO BENH VALUES ('B0027', N'Sốt rét');
INSERT INTO BENH VALUES ('B0028', N'Zika');
INSERT INTO BENH VALUES ('B0029', N'Sốt vàng da');
INSERT INTO BENH VALUES ('B0030', N'Viêm da do virus');
INSERT INTO BENH VALUES ('B0031', N'Viêm kết mạc');
INSERT INTO BENH VALUES ('B0032', N'Nhiễm nấm da');
INSERT INTO BENH VALUES ('B0033', N'Than');
INSERT INTO BENH VALUES ('B0034', N'Viêm màng não do não mô cầu');
INSERT INTO BENH VALUES ('B0035', N'Uốn ván');
INSERT INTO BENH VALUES ('B0036', N'Phong');
INSERT INTO BENH VALUES ('B0037', N'Bệnh dịch hạch');
INSERT INTO BENH VALUES ('B0038', N'Ebola');
INSERT INTO BENH VALUES ('B0039', N'Marburg');
INSERT INTO BENH VALUES ('B0040', N'Viêm gan E');
INSERT INTO BENH VALUES ('B0041', N'Hantavirus');
INSERT INTO BENH VALUES ('B0042', N'Giun đũa');
INSERT INTO BENH VALUES ('B0043', N'Sán lá gan');
INSERT INTO BENH VALUES ('B0044', N'Sán dây');
INSERT INTO BENH VALUES ('B0045', N'Nhiễm nấm Coccidioides');
INSERT INTO BENH VALUES ('B0046', N'Nhiễm nấm Histoplasma');
INSERT INTO BENH VALUES ('B0047', N'Nhiễm nấm Cryptococcus');
INSERT INTO BENH VALUES ('B0048', N'Khác');

INSERT INTO THUOC VALUES ('T0001', N'Acetylcystein', N'Vỉ 10 viên', N'Viên', 26);
INSERT INTO THUOC VALUES ('T0002', N'Avircrem', N'Hộp 1 tuýp 5g', N'Tuýp', 131);
INSERT INTO THUOC VALUES ('T0003', N'Salonpas pain relief patch', N'hộp 1 bao x 5 miếng', N'Hộp', 147);
INSERT INTO THUOC VALUES ('T0004', N'Dung dịch Natri clorid 0,9%', N'Chai 500ml', N'Chai', 46);
INSERT INTO THUOC VALUES ('T0005', N'Farzincol', N'Lọ 100 viên', N'Lọ', 255);
INSERT INTO THUOC VALUES ('T0006', N'Phosphalugel', N'Hộp 26 gói', N'Gói', 147);
INSERT INTO THUOC VALUES ('T0007', N'Eszopiclone', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 89);
INSERT INTO THUOC VALUES ('T0008', N'5-Fluorouracil Ebewe', N'Hộp 1 lọ 5ml', N'Lọ', 96);
INSERT INTO THUOC VALUES ('T0009', N'Aecysmux', N'Chai 100 viên', N'Viên', 205);
INSERT INTO THUOC VALUES ('T0010', N'Isotretinoin', N'Hộp 3 vỉ x 10 viên', N'Viên', 194);
INSERT INTO THUOC VALUES ('T0011', N'Chymotrypsin', N'Hộp 2 vỉ x 10 viên', N'Viên', 33);
INSERT INTO THUOC VALUES ('T0012', N'Aradine', N'Hộp 1 lọ', N'Lọ', 84);
INSERT INTO THUOC VALUES ('T0013', N'Bactronil', N'Tuýp 5g', N'Tuýp', 161);
INSERT INTO THUOC VALUES ('T0014', N'Beratan', N'Chai 100 viên', N'Viên', 38);
INSERT INTO THUOC VALUES ('T0015', N'Cadipiride', N'Hộp 10 vỉ x 10 viên', N'Viên', 264);
INSERT INTO THUOC VALUES ('T0016', N'Paracetamol', N'Hộp 20 gói x 15g', N'Gói', 261);
INSERT INTO THUOC VALUES ('T0017', N'AB-Intimus', N'Hộp 1 vỉ x 7 viên', N'Hộp', 137);
INSERT INTO THUOC VALUES ('T0018', N'Pravastatin Dwp', N'Vỉ 10 viên', N'Viên', 236);
INSERT INTO THUOC VALUES ('T0019', N'Perindopril Plus Dwp', N'Hộp 1 tuýp 5g', N'Tuýp', 205);
INSERT INTO THUOC VALUES ('T0020', N'Nebivolol Plus', N'hộp 1 bao x 5 miếng', N'Hộp', 200);
INSERT INTO THUOC VALUES ('T0021', N'Irbesartan Dwp', N'Chai 500ml', N'Chai', 243);
INSERT INTO THUOC VALUES ('T0022', N'Calcivin', N'Lọ 100 viên', N'Lọ', 441);
INSERT INTO THUOC VALUES ('T0023', N'Saxagliptin', N'Hộp 26 gói', N'Gói', 383);
INSERT INTO THUOC VALUES ('T0024', N'Mebizemib', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 334);
INSERT INTO THUOC VALUES ('T0025', N'Toduet', N'Hộp 1 lọ 5ml', N'Lọ', 272);
INSERT INTO THUOC VALUES ('T0026', N'Methylprednisolon', N'Chai 100 viên', N'Viên', 21);
INSERT INTO THUOC VALUES ('T0027', N'Lazimidin', N'Hộp 3 vỉ x 10 viên', N'Viên', 19);
INSERT INTO THUOC VALUES ('T0028', N'Infloxin', N'Hộp 2 vỉ x 10 viên', N'Viên', 249);
INSERT INTO THUOC VALUES ('T0029', N'Glutathion', N'Hộp 1 lọ', N'Lọ', 3);
INSERT INTO THUOC VALUES ('T0030', N'Gliglutin', N'Tuýp 5g', N'Tuýp', 104);
INSERT INTO THUOC VALUES ('T0031', N'Colistimethate sodium', N'Chai 100 viên', N'Viên', 147);
INSERT INTO THUOC VALUES ('T0032', N'Bimesta', N'Hộp 10 vỉ x 10 viên', N'Viên', 46);
INSERT INTO THUOC VALUES ('T0033', N'Aciste', N'Hộp 20 gói x 15g', N'Gói', 255);
INSERT INTO THUOC VALUES ('T0034', N'Bfavits', N'Hộp 1 vỉ x 7 viên', N'Hộp', 147);
INSERT INTO THUOC VALUES ('T0035', N'Aciste 2 MIU', N'Hộp 1 cái', N'Que', 89);
INSERT INTO THUOC VALUES ('T0036', N'Methobam', N'Hộp 20 miếng', N'Hộp', 96);
INSERT INTO THUOC VALUES ('T0037', N'Sun Pharmaceutical Industries  ', N'Túi 25g', N'Túi', 205);
INSERT INTO THUOC VALUES ('T0038', N'Dr. Reddys Laboratories  ', N'Gói 5 cái', N'Gói', 194);
INSERT INTO THUOC VALUES ('T0039', N'Divis Laboratories  ', N'Hộp 20 ống x 10ml', N'Hộp', 33);
INSERT INTO THUOC VALUES ('T0040', N'Cipla  ', N'Hộp 2 vỉ x 15 viên', N'Hộp', 84);
INSERT INTO THUOC VALUES ('T0041', N'Biocon  ', N'Hộp 60 viên', N'Hộp', 161);
INSERT INTO THUOC VALUES ('T0042', N'Aurobindo Pharma  ', N'Hộp 60 viên', N'Viên', 38);
INSERT INTO THUOC VALUES ('T0043', N'Torrent Pharmaceuticals  ', N'Hộp 60 viên', N'Hộp', 264);
INSERT INTO THUOC VALUES ('T0044', N'Lupin  ', N'Hộp 1 máy', N'Máy', 261);
INSERT INTO THUOC VALUES ('T0045', N'Cadila Healthcare  ', N'Hộp 1 cái', N'Cái', 137);
INSERT INTO THUOC VALUES ('T0046', N'Abbott India  ', N'Hộp 100 chiếc', N'Cái', 236);
INSERT INTO THUOC VALUES ('T0047', N'Alkem Laboratories  ', N'Hộp 100 cái', N'Cái', 205);
INSERT INTO THUOC VALUES ('T0048', N'Glaxosmithkline Pharmaceuticals  ', N'Vỉ 10 viên', N'Viên', 200);
INSERT INTO THUOC VALUES ('T0049', N'Ipca Laboratories  ', N'Hộp 1 tuýp 5g', N'Tuýp', 243);
INSERT INTO THUOC VALUES ('T0050', N'Alembic Pharmaceuticals  ', N'hộp 1 bao x 5 miếng', N'Hộp', 441);
INSERT INTO THUOC VALUES ('T0051', N'Glenmark Pharmaceuticals  ', N'Chai 500ml', N'Chai', 383);
INSERT INTO THUOC VALUES ('T0052', N'JB Chemicals & Pharmaceuticals  ', N'Lọ 100 viên', N'Lọ', 334);
INSERT INTO THUOC VALUES ('T0053', N'Sun Pharmaceutical Industries  ', N'Hộp 26 gói', N'Gói', 272);
INSERT INTO THUOC VALUES ('T0054', N'Dr. Reddys Laboratories  ', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 21);
INSERT INTO THUOC VALUES ('T0055', N'Divis Laboratories  ', N'Hộp 1 lọ 5ml', N'Lọ', 19);
INSERT INTO THUOC VALUES ('T0056', N'Cipla  ', N'Chai 100 viên', N'Viên', 249);
INSERT INTO THUOC VALUES ('T0057', N'Biocon  ', N'Hộp 3 vỉ x 10 viên', N'Viên', 3);
INSERT INTO THUOC VALUES ('T0058', N'Aurobindo Pharma  ', N'Hộp 2 vỉ x 10 viên', N'Viên', 104);
INSERT INTO THUOC VALUES ('T0059', N'Torrent Pharmaceuticals  ', N'Hộp 1 lọ', N'Lọ', 147);
INSERT INTO THUOC VALUES ('T0060', N'Lupin  ', N'Tuýp 5g', N'Tuýp', 46);
INSERT INTO THUOC VALUES ('T0061', N'Cadila Healthcare  ', N'Chai 100 viên', N'Viên', 255);
INSERT INTO THUOC VALUES ('T0062', N'Abbott India  ', N'Hộp 10 vỉ x 10 viên', N'Viên', 147);
INSERT INTO THUOC VALUES ('T0063', N'Alkem Laboratories  ', N'Hộp 20 gói x 15g', N'Gói', 89);
INSERT INTO THUOC VALUES ('T0064', N'Glaxosmithkline Pharmaceuticals  ', N'Hộp 1 vỉ x 7 viên', N'Hộp', 96);
INSERT INTO THUOC VALUES ('T0065', N'Ipca Laboratories  ', N'Hộp 1 cái', N'Que', 205);
INSERT INTO THUOC VALUES ('T0066', N'Alembic Pharmaceuticals  ', N'Hộp 20 miếng', N'Hộp', 194);
INSERT INTO THUOC VALUES ('T0067', N'Glenmark Pharmaceuticals  ', N'Túi 25g', N'Túi', 33);
INSERT INTO THUOC VALUES ('T0068', N'JB Chemicals & Pharmaceuticals  ', N'Gói 5 cái', N'Gói', 84);
INSERT INTO THUOC VALUES ('T0069', N'Sun Pharmaceutical Industries  ', N'Hộp 20 ống x 10ml', N'Hộp', 161);
INSERT INTO THUOC VALUES ('T0070', N'Dr. Reddys Laboratories  ', N'Hộp 2 vỉ x 15 viên', N'Hộp', 38);
INSERT INTO THUOC VALUES ('T0071', N'Divis Laboratories  ', N'Hộp 60 viên', N'Hộp', 264);
INSERT INTO THUOC VALUES ('T0072', N'Cipla  ', N'Hộp 60 viên', N'Viên', 261);
INSERT INTO THUOC VALUES ('T0073', N'Biocon  ', N'Hộp 60 viên', N'Hộp', 137);
INSERT INTO THUOC VALUES ('T0074', N'Aurobindo Pharma  ', N'Hộp 1 máy', N'Máy', 236);
INSERT INTO THUOC VALUES ('T0075', N'Torrent Pharmaceuticals  ', N'Hộp 1 cái', N'Cái', 205);
INSERT INTO THUOC VALUES ('T0076', N'Lupin  ', N'Hộp 100 chiếc', N'Cái', 200);
INSERT INTO THUOC VALUES ('T0077', N'Cadila Healthcare  ', N'Hộp 100 cái', N'Cái', 243);
INSERT INTO THUOC VALUES ('T0078', N'Abbott India  ', N'Vỉ 10 viên', N'Viên', 441);
INSERT INTO THUOC VALUES ('T0079', N'Alkem Laboratories  ', N'Hộp 1 tuýp 5g', N'Tuýp', 383);
INSERT INTO THUOC VALUES ('T0080', N'Glaxosmithkline Pharmaceuticals  ', N'hộp 1 bao x 5 miếng', N'Hộp', 334);
INSERT INTO THUOC VALUES ('T0081', N'Ipca Laboratories  ', N'Chai 500ml', N'Chai', 272);
INSERT INTO THUOC VALUES ('T0082', N'Alembic Pharmaceuticals  ', N'Lọ 100 viên', N'Lọ', 21);
INSERT INTO THUOC VALUES ('T0083', N'Glenmark Pharmaceuticals  ', N'Hộp 26 gói', N'Gói', 19);
INSERT INTO THUOC VALUES ('T0084', N'JB Chemicals & Pharmaceuticals  ', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 249);
INSERT INTO THUOC VALUES ('T0085', N'Sun Pharmaceutical Industries  ', N'Hộp 1 lọ 5ml', N'Lọ', 3);
INSERT INTO THUOC VALUES ('T0086', N'Dr. Reddys Laboratories  ', N'Chai 100 viên', N'Viên', 104);
INSERT INTO THUOC VALUES ('T0087', N'Divis Laboratories  ', N'Hộp 3 vỉ x 10 viên', N'Viên', 147);
INSERT INTO THUOC VALUES ('T0088', N'Cipla  ', N'Hộp 2 vỉ x 10 viên', N'Viên', 46);
INSERT INTO THUOC VALUES ('T0089', N'Biocon  ', N'Hộp 1 lọ', N'Lọ', 255);
INSERT INTO THUOC VALUES ('T0090', N'Aurobindo Pharma  ', N'Tuýp 5g', N'Tuýp', 147);
INSERT INTO THUOC VALUES ('T0091', N'Torrent Pharmaceuticals  ', N'Chai 100 viên', N'Viên', 89);
INSERT INTO THUOC VALUES ('T0092', N'Lupin  ', N'Hộp 10 vỉ x 10 viên', N'Viên', 96);
INSERT INTO THUOC VALUES ('T0093', N'Cadila Healthcare  ', N'Hộp 20 gói x 15g', N'Gói', 205);
INSERT INTO THUOC VALUES ('T0094', N'Abbott India  ', N'Hộp 1 vỉ x 7 viên', N'Hộp', 194);
INSERT INTO THUOC VALUES ('T0095', N'Alkem Laboratories  ', N'Hộp 1 cái', N'Que', 33);
INSERT INTO THUOC VALUES ('T0096', N'Glaxosmithkline Pharmaceuticals  ', N'Hộp 20 miếng', N'Hộp', 84);
INSERT INTO THUOC VALUES ('T0097', N'Ipca Laboratories  ', N'Túi 25g', N'Túi', 161);
INSERT INTO THUOC VALUES ('T0098', N'Alembic Pharmaceuticals  ', N'Gói 5 cái', N'Gói', 38);
INSERT INTO THUOC VALUES ('T0099', N'Glenmark Pharmaceuticals  ', N'Hộp 20 ống x 10ml', N'Hộp', 264);
INSERT INTO THUOC VALUES ('T0100', N'JB Chemicals & Pharmaceuticals  ', N'Hộp 2 vỉ x 15 viên', N'Hộp', 261);
INSERT INTO THUOC VALUES ('T0101', N'Sun Pharmaceutical Industries  ', N'Hộp 60 viên', N'Hộp', 137);
INSERT INTO THUOC VALUES ('T0102', N'Dr. Reddys Laboratories  ', N'Hộp 60 viên', N'Viên', 236);
INSERT INTO THUOC VALUES ('T0103', N'Divis Laboratories  ', N'Hộp 60 viên', N'Hộp', 205);
INSERT INTO THUOC VALUES ('T0104', N'Cipla  ', N'Hộp 1 máy', N'Máy', 200);
INSERT INTO THUOC VALUES ('T0105', N'Biocon  ', N'Hộp 1 cái', N'Cái', 243);
INSERT INTO THUOC VALUES ('T0106', N'Aurobindo Pharma  ', N'Hộp 100 chiếc', N'Cái', 441);
INSERT INTO THUOC VALUES ('T0107', N'Torrent Pharmaceuticals  ', N'Hộp 100 cái', N'Cái', 383);
INSERT INTO THUOC VALUES ('T0108', N'Sun Pharmaceutical Industries  ', N'Vỉ 10 viên', N'Viên', 334);
INSERT INTO THUOC VALUES ('T0109', N'Dr. Reddys Laboratories  ', N'Hộp 1 tuýp 5g', N'Tuýp', 272);
INSERT INTO THUOC VALUES ('T0110', N'Divis Laboratories  ', N'hộp 1 bao x 5 miếng', N'Hộp', 21);
INSERT INTO THUOC VALUES ('T0111', N'Cipla  ', N'Chai 500ml', N'Chai', 19);
INSERT INTO THUOC VALUES ('T0112', N'Biocon  ', N'Lọ 100 viên', N'Lọ', 249);
INSERT INTO THUOC VALUES ('T0113', N'Aurobindo Pharma  ', N'Hộp 26 gói', N'Gói', 3);
INSERT INTO THUOC VALUES ('T0114', N'Torrent Pharmaceuticals  ', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 104);
INSERT INTO THUOC VALUES ('T0115', N'Lupin  ', N'Hộp 1 lọ 5ml', N'Lọ', 147);
INSERT INTO THUOC VALUES ('T0116', N'Cadila Healthcare  ', N'Chai 100 viên', N'Viên', 46);
INSERT INTO THUOC VALUES ('T0117', N'Abbott India  ', N'Hộp 3 vỉ x 10 viên', N'Viên', 255);
INSERT INTO THUOC VALUES ('T0118', N'Alkem Laboratories  ', N'Hộp 2 vỉ x 10 viên', N'Viên', 147);
INSERT INTO THUOC VALUES ('T0119', N'Glaxosmithkline Pharmaceuticals  ', N'Hộp 1 lọ', N'Lọ', 89);
INSERT INTO THUOC VALUES ('T0120', N'Ipca Laboratories  ', N'Tuýp 5g', N'Tuýp', 96);
INSERT INTO THUOC VALUES ('T0121', N'Alembic Pharmaceuticals  ', N'Chai 100 viên', N'Viên', 205);
INSERT INTO THUOC VALUES ('T0122', N'Glenmark Pharmaceuticals  ', N'Hộp 10 vỉ x 10 viên', N'Viên', 194);
INSERT INTO THUOC VALUES ('T0123', N'JB Chemicals & Pharmaceuticals  ', N'Hộp 20 gói x 15g', N'Gói', 33);
INSERT INTO THUOC VALUES ('T0124', N'Sun Pharmaceutical Industries  ', N'Hộp 1 vỉ x 7 viên', N'Hộp', 84);
INSERT INTO THUOC VALUES ('T0125', N'Dr. Reddys Laboratories  ', N'Hộp 1 cái', N'Que', 161);
INSERT INTO THUOC VALUES ('T0126', N'Divis Laboratories  ', N'Hộp 20 miếng', N'Hộp', 38);
INSERT INTO THUOC VALUES ('T0127', N'Cipla  ', N'Túi 25g', N'Túi', 264);
INSERT INTO THUOC VALUES ('T0128', N'Biocon  ', N'Gói 5 cái', N'Gói', 261);
INSERT INTO THUOC VALUES ('T0129', N'Aurobindo Pharma  ', N'Hộp 20 ống x 10ml', N'Hộp', 137);
INSERT INTO THUOC VALUES ('T0130', N'Torrent Pharmaceuticals  ', N'Hộp 2 vỉ x 15 viên', N'Hộp', 236);
INSERT INTO THUOC VALUES ('T0131', N'Lupin  ', N'Hộp 60 viên', N'Hộp', 205);
INSERT INTO THUOC VALUES ('T0132', N'Cadila Healthcare  ', N'Hộp 60 viên', N'Viên', 200);
INSERT INTO THUOC VALUES ('T0133', N'Abbott India  ', N'Hộp 60 viên', N'Hộp', 243);
INSERT INTO THUOC VALUES ('T0134', N'Alkem Laboratories  ', N'Hộp 1 máy', N'Máy', 441);
INSERT INTO THUOC VALUES ('T0135', N'Glaxosmithkline Pharmaceuticals  ', N'Hộp 1 cái', N'Cái', 383);
INSERT INTO THUOC VALUES ('T0136', N'Ipca Laboratories  ', N'Hộp 100 chiếc', N'Cái', 334);
INSERT INTO THUOC VALUES ('T0137', N'Alembic Pharmaceuticals  ', N'Hộp 100 cái', N'Cái', 272);
INSERT INTO THUOC VALUES ('T0138', N'Glenmark Pharmaceuticals  ', N'Vỉ 10 viên', N'Viên', 21);
INSERT INTO THUOC VALUES ('T0139', N'JB Chemicals & Pharmaceuticals  ', N'Hộp 1 tuýp 5g', N'Tuýp', 19);
INSERT INTO THUOC VALUES ('T0140', N'Sun Pharmaceutical Industries  ', N'hộp 1 bao x 5 miếng', N'Hộp', 249);
INSERT INTO THUOC VALUES ('T0141', N'Dr. Reddys Laboratories  ', N'Chai 500ml', N'Chai', 3);
INSERT INTO THUOC VALUES ('T0142', N'Divis Laboratories  ', N'Lọ 100 viên', N'Lọ', 104);
INSERT INTO THUOC VALUES ('T0143', N'Cipla  ', N'Hộp 26 gói', N'Gói', 147);
INSERT INTO THUOC VALUES ('T0144', N'Biocon  ', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 46);
INSERT INTO THUOC VALUES ('T0145', N'Aurobindo Pharma  ', N'Hộp 1 lọ 5ml', N'Lọ', 255);
INSERT INTO THUOC VALUES ('T0146', N'Torrent Pharmaceuticals  ', N'Chai 100 viên', N'Viên', 147);
INSERT INTO THUOC VALUES ('T0147', N'Lupin  ', N'Hộp 3 vỉ x 10 viên', N'Viên', 89);
INSERT INTO THUOC VALUES ('T0148', N'Cadila Healthcare  ', N'Hộp 2 vỉ x 10 viên', N'Viên', 96);
INSERT INTO THUOC VALUES ('T0149', N'Abbott India  ', N'Hộp 1 lọ', N'Lọ', 205);
INSERT INTO THUOC VALUES ('T0150', N'Alkem Laboratories  ', N'Tuýp 5g', N'Tuýp', 194);
INSERT INTO THUOC VALUES ('T0151', N'Glaxosmithkline Pharmaceuticals  ', N'Chai 100 viên', N'Viên', 33);
INSERT INTO THUOC VALUES ('T0152', N'Ipca Laboratories  ', N'Hộp 10 vỉ x 10 viên', N'Viên', 84);
INSERT INTO THUOC VALUES ('T0153', N'Alembic Pharmaceuticals  ', N'Hộp 20 gói x 15g', N'Gói', 161);
INSERT INTO THUOC VALUES ('T0154', N'Glenmark Pharmaceuticals  ', N'Hộp 1 vỉ x 7 viên', N'Hộp', 38);
INSERT INTO THUOC VALUES ('T0155', N'JB Chemicals & Pharmaceuticals  ', N'Hộp 1 cái', N'Que', 264);
INSERT INTO THUOC VALUES ('T0156', N'Sun Pharmaceutical Industries  ', N'Hộp 20 miếng', N'Hộp', 261);
INSERT INTO THUOC VALUES ('T0157', N'Dr. Reddys Laboratories  ', N'Túi 25g', N'Túi', 137);
INSERT INTO THUOC VALUES ('T0158', N'Divis Laboratories  ', N'Gói 5 cái', N'Gói', 236);
INSERT INTO THUOC VALUES ('T0159', N'Cipla  ', N'Hộp 20 ống x 10ml', N'Hộp', 205);
INSERT INTO THUOC VALUES ('T0160', N'Biocon  ', N'Hộp 2 vỉ x 15 viên', N'Hộp', 200);
INSERT INTO THUOC VALUES ('T0161', N'Aurobindo Pharma  ', N'Hộp 60 viên', N'Hộp', 243);
INSERT INTO THUOC VALUES ('T0162', N'Torrent Pharmaceuticals  ', N'Hộp 60 viên', N'Viên', 441);
INSERT INTO THUOC VALUES ('T0163', N'Lupin  ', N'Hộp 60 viên', N'Hộp', 383);
INSERT INTO THUOC VALUES ('T0164', N'Cadila Healthcare  ', N'Hộp 1 máy', N'Máy', 334);
INSERT INTO THUOC VALUES ('T0165', N'Abbott India  ', N'Hộp 1 cái', N'Cái', 272);
INSERT INTO THUOC VALUES ('T0166', N'Alkem Laboratories  ', N'Hộp 100 chiếc', N'Cái', 21);
INSERT INTO THUOC VALUES ('T0167', N'Glaxosmithkline Pharmaceuticals  ', N'Hộp 100 cái', N'Cái', 19);
INSERT INTO THUOC VALUES ('T0168', N'Ipca Laboratories  ', N'Vỉ 10 viên', N'Viên', 249);
INSERT INTO THUOC VALUES ('T0169', N'Alembic Pharmaceuticals  ', N'Hộp 1 tuýp 5g', N'Tuýp', 3);
INSERT INTO THUOC VALUES ('T0170', N'Glenmark Pharmaceuticals  ', N'hộp 1 bao x 5 miếng', N'Hộp', 104);
INSERT INTO THUOC VALUES ('T0171', N'JB Chemicals & Pharmaceuticals  ', N'Chai 500ml', N'Chai', 147);
INSERT INTO THUOC VALUES ('T0172', N'Sun Pharmaceutical Industries  ', N'Lọ 100 viên', N'Lọ', 46);
INSERT INTO THUOC VALUES ('T0173', N'Dr. Reddys Laboratories  ', N'Hộp 26 gói', N'Gói', 255);
INSERT INTO THUOC VALUES ('T0174', N'Divis Laboratories  ', N'Hộp 3 vỉ x 10 viên', N'Vỉ', 147);
INSERT INTO THUOC VALUES ('T0175', N'Cipla  ', N'Hộp 1 lọ 5ml', N'Lọ', 89);
INSERT INTO THUOC VALUES ('T0176', N'Biocon  ', N'Chai 100 viên', N'Viên', 96);
INSERT INTO THUOC VALUES ('T0177', N'Aurobindo Pharma  ', N'Hộp 3 vỉ x 10 viên', N'Viên', 205);
INSERT INTO THUOC VALUES ('T0178', N'Torrent Pharmaceuticals  ', N'Hộp 2 vỉ x 10 viên', N'Viên', 194);
INSERT INTO THUOC VALUES ('T0179', N'Sun Pharmaceutical Industries  ', N'Hộp 1 lọ', N'Lọ', 33);
INSERT INTO THUOC VALUES ('T0180', N'Dr. Reddys Laboratories  ', N'Tuýp 5g', N'Tuýp', 84);
INSERT INTO THUOC VALUES ('T0181', N'Divis Laboratories  ', N'Chai 100 viên', N'Viên', 161);
INSERT INTO THUOC VALUES ('T0182', N'Cipla  ', N'Hộp 10 vỉ x 10 viên', N'Viên', 38);
INSERT INTO THUOC VALUES ('T0183', N'Biocon  ', N'Hộp 20 gói x 15g', N'Gói', 264);
INSERT INTO THUOC VALUES ('T0184', N'Aurobindo Pharma  ', N'Hộp 1 vỉ x 7 viên', N'Hộp', 261);
INSERT INTO THUOC VALUES ('T0185', N'Torrent Pharmaceuticals  ', N'Hộp 1 cái', N'Que', 137);
INSERT INTO THUOC VALUES ('T0186', N'Lupin  ', N'Hộp 20 miếng', N'Hộp', 236);
INSERT INTO THUOC VALUES ('T0187', N'Cadila Healthcare  ', N'Túi 25g', N'Túi', 205);
INSERT INTO THUOC VALUES ('T0188', N'Abbott India  ', N'Gói 5 cái', N'Gói', 200);
INSERT INTO THUOC VALUES ('T0189', N'Alkem Laboratories  ', N'Hộp 20 ống x 10ml', N'Hộp', 243);
INSERT INTO THUOC VALUES ('T0190', N'Glaxosmithkline Pharmaceuticals  ', N'Hộp 2 vỉ x 15 viên', N'Hộp', 441);
INSERT INTO THUOC VALUES ('T0191', N'Ipca Laboratories  ', N'Hộp 60 viên', N'Hộp', 383);
INSERT INTO THUOC VALUES ('T0192', N'Alembic Pharmaceuticals  ', N'Hộp 60 viên', N'Viên', 334);
INSERT INTO THUOC VALUES ('T0193', N'Glenmark Pharmaceuticals  ', N'Hộp 60 viên', N'Hộp', 272);
INSERT INTO THUOC VALUES ('T0194', N'JB Chemicals & Pharmaceuticals  ', N'Hộp 1 máy', N'Máy', 21);
INSERT INTO THUOC VALUES ('T0195', N'Sun Pharmaceutical Industries  ', N'Hộp 1 cái', N'Cái', 19);
INSERT INTO THUOC VALUES ('T0196', N'Dr. Reddys Laboratories  ', N'Hộp 100 chiếc', N'Cái', 249);
INSERT INTO THUOC VALUES ('T0197', N'Divis Laboratories  ', N'Hộp 100 cái', N'Cái', 3);
INSERT INTO THUOC VALUES ('T0198', N'Cipla  ', N'Lọ 100 viên', N'Viên', 104);
INSERT INTO THUOC VALUES ('T0199', N'Biocon  ', N'Hộp 26 gói', N'Tuýp', 20);
INSERT INTO THUOC VALUES ('T0200', N'Aurobindo Pharma  ', N'Hộp 3 vỉ x 10 viên', N'Hộp', 15);

INSERT INTO PHONGKHAM VALUES ('A31', N'Phòng khám chuyên khoa ký sinh trùng', N'Tầng 3 khu A');						
INSERT INTO PHONGKHAM VALUES ('A42', N'Phòng khám hậu Covid-19', N'Tầng 4 khu A');						
INSERT INTO PHONGKHAM VALUES ('B14', N'Phòng khám Bệnh truyền nhiễm đặc biệt', N'Tầng 3 khu B');						
INSERT INTO PHONGKHAM VALUES ('F33', N'Phòng chống độc trẻ em và người lớn', N'Tầng 3 khu F');						
INSERT INTO PHONGKHAM VALUES ('A14', N'Phòng hồi sức tích cực', N'Tầng 1 khu A');						
INSERT INTO PHONGKHAM VALUES ('P24', N'Phòng tiêm chủng ngừa dịch vụ', N'Tầng 2 khu P');						
INSERT INTO PHONGKHAM VALUES ('B32', N'Phòng khám và điều trị các bệnh nhiễm vi khuẩn', N'Tầng 3 khu B');						
INSERT INTO PHONGKHAM VALUES ('A21', N'Phòng khám bệnh truyền nhiễm gan', N'Tầng 2 khu A');						
INSERT INTO PHONGKHAM VALUES ('A34', N'Phòng xét nghiệm HIV', N'Tầng 3 khu A');						
INSERT INTO PHONGKHAM VALUES ('B11', N'Phòng khám chuyên khoa nội - nhi - nhiễm', N'Tầng 1 khu B');						
INSERT INTO PHONGKHAM VALUES ('B31', N'Phòng khám bệnh truyền nhiễm ngoài da', N'Tầng 3 khu B');						
INSERT INTO PHONGKHAM VALUES ('C31', N'Phòng khám bệnh lậu - giang mai', N'Tầng 3 khu C');						
INSERT INTO PHONGKHAM VALUES ('A11', N'Phòng khám bệnh lây nhiễm đường hô hấp', N'Tầng 1 khu A');						
INSERT INTO PHONGKHAM VALUES ('B33', N'Phòng khám bệnh lây nhiễm do ký sinh trùng', N'Tầng 3 khu B');						
INSERT INTO PHONGKHAM VALUES ('A22', N'Phòng số khám bệnh cấp độ 1', N'Tầng 2 khu A');						
INSERT INTO PHONGKHAM VALUES ('P31', N'Phòng xét nghiệm tổng quát', N'Tầng 3 khu P');						
INSERT INTO PHONGKHAM VALUES ('B34', N'Phòng kiểm tra định kỳ', N'Tầng 3 khu B');						
INSERT INTO PHONGKHAM VALUES ('P31', N'Phòng khám bệnh sốt rét', N'Tầng 3 khu F');						
INSERT INTO PHONGKHAM VALUES ('A35', N'Phòng khám bệnh viêm não', N'Tầng 3 khu A');						
INSERT INTO PHONGKHAM VALUES ('A12', N'Phòng khám bệnh truyền nhiễm do vi rút', N'Tầng 1 khu A');						


INSERT INTO PHIEUKHAM VALUES ('PK0001', 'BN0003', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0002', 'BN0004', 150000, 'A42', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0003', 'BN0005', 150000, 'A42', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0004', 'BN0006', 150000, 'P31', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0005', 'BN0007', 150000, 'A12', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0006', 'BN0008', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0007', 'BN0009', 150000, 'A42', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0008', 'BN0010', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0009', 'BN0011', 150000, 'P31', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0010', 'BN0012', 150000, 'P31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0011', 'BN0013', 150000, 'A12', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0012', 'BN0014', 150000, 'B31', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0013', 'BN0015', 150000, 'A21', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0014', 'BN0016', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0015', 'BN0017', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0016', 'BN0018', 150000, 'A12', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0017', 'BN0019', 150000, 'P31', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0018', 'BN0020', 150000, 'P31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0019', 'BN0021', 150000, 'B31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0020', 'BN0022', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0021', 'BN0023', 150000, 'B33', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0022', 'BN0024', 150000, 'A12', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0023', 'BN0025', 150000, 'P24', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0024', 'BN0026', 150000, 'A42', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0025', 'BN0027', 150000, 'F33', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0026', 'BN0028', 150000, 'A12', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0027', 'BN0029', 150000, 'A34', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0028', 'BN0030', 150000, 'F33', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0029', 'BN0031', 150000, 'B32', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0030', 'BN0032', 150000, 'F33', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0031', 'BN0033', 150000, 'A14', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0032', 'BN0034', 150000, 'B11', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0033', 'BN0035', 150000, 'F33', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0034', 'BN0036', 150000, 'A31', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0035', 'BN0037', 150000, 'A31', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0036', 'BN0038', 150000, 'B31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0037', 'BN0039', 150000, 'B11', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0038', 'BN0040', 150000, 'A11', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0039', 'BN0041', 150000, 'B14', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0040', 'BN0042', 150000, 'A35', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0041', 'BN0043', 150000, 'A14', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0042', 'BN0044', 150000, 'F33', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0043', 'BN0045', 150000, 'B11', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0044', 'BN0046', 150000, 'F33', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0045', 'BN0047', 150000, 'B32', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0046', 'BN0048', 150000, 'F33', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0047', 'BN0049', 150000, 'A31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0048', 'BN0050', 150000, 'A12', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0049', 'BN0051', 150000, 'B33', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0050', 'BN0052', 150000, 'A14', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0051', 'BN0053', 150000, 'P31', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0052', 'BN0054', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0053', 'BN0055', 150000, 'B34', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0054', 'BN0056', 150000, 'A14', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0055', 'BN0057', 150000, 'A21', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0056', 'BN0058', 150000, 'P31', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0057', 'BN0059', 150000, 'B33', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0058', 'BN0060', 150000, 'A31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0059', 'BN0061', 150000, 'C31', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0060', 'BN0062', 150000, 'B32', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0061', 'BN0063', 150000, 'C31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0062', 'BN0064', 150000, 'A34', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0063', 'BN0065', 150000, 'A42', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0064', 'BN0066', 150000, 'B31', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0065', 'BN0067', 150000, 'P31', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0066', 'BN0068', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0067', 'BN0069', 150000, 'A31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0068', 'BN0070', 150000, 'B33', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0069', 'BN0071', 150000, 'A35', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0070', 'BN0072', 150000, 'F33', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0071', 'BN0073', 150000, 'B34', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0072', 'BN0074', 150000, 'A14', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0073', 'BN0075', 150000, 'P31', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0074', 'BN0076', 150000, 'A34', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0075', 'BN0077', 150000, 'B14', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0076', 'BN0078', 150000, 'A31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0077', 'BN0079', 150000, 'A35', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0078', 'BN0080', 150000, 'C31', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0079', 'BN0081', 150000, 'A42', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0080', 'BN0082', 150000, 'A35', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0081', 'BN0083', 150000, 'P31', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0082', 'BN0084', 150000, 'P24', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0083', 'BN0085', 150000, 'A34', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0084', 'BN0086', 150000, 'A11', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0085', 'BN0087', 150000, 'B14', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0086', 'BN0088', 150000, 'C31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0087', 'BN0089', 150000, 'B33', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0088', 'BN0090', 150000, 'B31', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0089', 'BN0091', 150000, 'B33', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0090', 'BN0092', 150000, 'B31', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0091', 'BN0093', 150000, 'P24', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0092', 'BN0094', 150000, 'F33', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0093', 'BN0095', 150000, 'A21', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0094', 'BN0096', 150000, 'P31', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0095', 'BN0097', 150000, 'A12', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0096', 'BN0098', 150000, 'B14', N'Không có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0097', 'BN0099', 150000, 'B32', N'Có hẹn', 'NV002');
INSERT INTO PHIEUKHAM VALUES ('PK0098', 'BN0100', 150000, 'C31', N'Không có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0099', 'BN0101', 150000, 'A14', N'Có hẹn', 'NV003');
INSERT INTO PHIEUKHAM VALUES ('PK0100', 'BN0102', 150000, 'A11', N'Không có hẹn', 'NV003');


INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0001', 'PK0001', 'BS0001', '02/01/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0002', 'PK0002', 'BS0002', '02/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0003', 'PK0003', 'BS0003', '03/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0004', 'PK0004', 'BS0014', '04/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0005', 'PK0005', 'BS0005', '05/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0006', 'PK0006', 'BS0006', '06/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0007', 'PK0007', 'BS0007', '07/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0008', 'PK0008', 'BS0008', '08/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0009', 'PK0009', 'BS0009', '09/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0010', 'PK0010', 'BS0020', '10/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0011', 'PK0011', 'BS0011', '11/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0012', 'PK0012', 'BS0012', '12/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0013', 'PK0013', 'BS0013', '13/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0014', 'PK0014', 'BS0014', '14/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0015', 'PK0015', 'BS0015', '15/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0016', 'PK0016', 'BS0016', '16/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0017', 'PK0017', 'BS0017', '17/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0018', 'PK0018', 'BS0018', '18/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0019', 'PK0019', 'BS0029', '19/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0020', 'PK0020', 'BS0020', '20/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0021', 'PK0021', 'BS0021', '21/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0022', 'PK0022', 'BS0022', '22/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0023', 'PK0023', 'BS0023', '23/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0024', 'PK0024', 'BS0024', '24/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0025', 'PK0025', 'BS0025', '25/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0026', 'PK0026', 'BS0026', '26/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0027', 'PK0027', 'BS0027', '27/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0028', 'PK0028', 'BS0028', '28/02/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0029', 'PK0029', 'BS0029', '01/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0030', 'PK0030', 'BS0030', '02/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0031', 'PK0031', 'BS0031', '03/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0032', 'PK0032', 'BS0032', '04/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0033', 'PK0033', 'BS0033', '05/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0034', 'PK0034', 'BS0034', '06/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0035', 'PK0035', 'BS0035', '07/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0036', 'PK0036', 'BS0036', '08/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0037', 'PK0037', 'BS0037', '09/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0038', 'PK0038', 'BS0038', '10/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0039', 'PK0039', 'BS0039', '11/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0040', 'PK0040', 'BS0040', '12/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0041', 'PK0041', 'BS0041', '13/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0042', 'PK0042', 'BS0042', '14/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0043', 'PK0043', 'BS0043', '15/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0044', 'PK0044', 'BS0044', '16/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0045', 'PK0045', 'BS0045', '17/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0046', 'PK0046', 'BS0046', '18/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0047', 'PK0047', 'BS0047', '19/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0048', 'PK0048', 'BS0048', '20/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0049', 'PK0049', 'BS0049', '21/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0050', 'PK0050', 'BS0050', '22/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0051', 'PK0051', 'BS0001', '23/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0052', 'PK0052', 'BS0002', '24/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0053', 'PK0053', 'BS0003', '25/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0054', 'PK0054', 'BS0011', '26/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0055', 'PK0055', 'BS0005', '27/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0056', 'PK0056', 'BS0006', '28/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0057', 'PK0057', 'BS0007', '29/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0058', 'PK0058', 'BS0008', '30/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0059', 'PK0059', 'BS0009', '31/03/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0060', 'PK0060', 'BS0050', '01/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0061', 'PK0061', 'BS0011', '02/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0062', 'PK0062', 'BS0012', '03/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0063', 'PK0063', 'BS0013', '04/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0064', 'PK0064', 'BS0014', '05/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0065', 'PK0065', 'BS0015', '06/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0066', 'PK0066', 'BS0016', '07/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0067', 'PK0067', 'BS0017', '08/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0068', 'PK0068', 'BS0018', '09/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0069', 'PK0069', 'BS0049', '10/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0070', 'PK0070', 'BS0020', '11/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0071', 'PK0071', 'BS0021', '12/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0072', 'PK0072', 'BS0022', '13/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0073', 'PK0073', 'BS0023', '14/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0074', 'PK0074', 'BS0024', '15/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0075', 'PK0075', 'BS0025', '16/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0076', 'PK0076', 'BS0026', '17/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0077', 'PK0077', 'BS0027', '18/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0078', 'PK0078', 'BS0028', '19/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0079', 'PK0079', 'BS0029', '20/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0080', 'PK0080', 'BS0030', '21/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0081', 'PK0081', 'BS0031', '22/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0082', 'PK0082', 'BS0032', '23/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0083', 'PK0083', 'BS0033', '24/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0084', 'PK0084', 'BS0034', '25/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0085', 'PK0085', 'BS0035', '26/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0086', 'PK0086', 'BS0036', '27/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0087', 'PK0087', 'BS0037', '28/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0088', 'PK0088', 'BS0038', '29/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0089', 'PK0089', 'BS0039', '30/04/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0090', 'PK0090', 'BS0040', '01/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0091', 'PK0091', 'BS0041', '02/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0092', 'PK0092', 'BS0042', '03/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0093', 'PK0093', 'BS0043', '04/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0094', 'PK0094', 'BS0044', '05/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0095', 'PK0095', 'BS0045', '06/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0096', 'PK0096', 'BS0046', '07/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0097', 'PK0097', 'BS0047', '08/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0098', 'PK0098', 'BS0048', '09/05/2023');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0099', 'PK0099', 'BS0049', '09/05/2024');
INSERT INTO TOATHUOC (MATOATHUOC, MAPHIEUKHAM, MANHANVIEN, NGAYLAP) VALUES ('TT0100', 'PK0100', 'BS0050', '09/05/2025');


INSERT INTO CHITIETCHUANDOAN VALUES ('TT0001', 'B0001');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0001', 'B0002');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0001', 'B0003');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0002', 'B0004');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0003', 'B0005');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0003', 'B0006');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0004', 'B0007');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0005', 'B0008');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0006', 'B0009');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0006', 'B0010');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0006', 'B0011');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0007', 'B0012');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0008', 'B0013');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0009', 'B0014');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0010', 'B0015');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0011', 'B0016');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0012', 'B0017');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0013', 'B0018');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0014', 'B0019');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0014', 'B0020');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0014', 'B0021');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0015', 'B0022');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0016', 'B0023');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0017', 'B0024');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0018', 'B0025');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0019', 'B0026');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0019', 'B0027');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0019', 'B0028');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0019', 'B0029');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0020', 'B0030');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0021', 'B0031');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0022', 'B0032');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0022', 'B0033');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0023', 'B0034');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0024', 'B0035');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0025', 'B0036');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0026', 'B0037');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0027', 'B0038');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0028', 'B0039');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0029', 'B0040');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0030', 'B0041');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0031', 'B0042');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0032', 'B0043');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0033', 'B0044');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0034', 'B0045');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0035', 'B0046');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0036', 'B0047');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0037', 'B0048');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0038', 'B0001');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0039', 'B0002');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0040', 'B0003');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0041', 'B0004');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0042', 'B0005');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0043', 'B0006');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0044', 'B0007');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0045', 'B0008');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0045', 'B0009');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0046', 'B0010');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0047', 'B0011');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0047', 'B0012');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0047', 'B0013');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0047', 'B0014');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0048', 'B0015');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0049', 'B0016');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0050', 'B0017');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0051', 'B0018');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0052', 'B0019');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0053', 'B0020');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0054', 'B0021');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0055', 'B0022');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0056', 'B0023');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0057', 'B0024');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0058', 'B0025');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0059', 'B0026');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0060', 'B0027');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0061', 'B0028');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0062', 'B0029');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0063', 'B0030');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0064', 'B0031');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0065', 'B0032');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0066', 'B0033');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0067', 'B0034');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0068', 'B0035');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0069', 'B0036');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0070', 'B0037');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0071', 'B0038');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0071', 'B0039');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0071', 'B0040');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0071', 'B0041');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0072', 'B0042');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0073', 'B0043');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0074', 'B0044');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0075', 'B0045');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0076', 'B0046');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0077', 'B0047');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0078', 'B0048');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0079', 'B0001');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0080', 'B0002');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0081', 'B0003');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0082', 'B0004');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0083', 'B0005');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0084', 'B0006');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0085', 'B0007');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0086', 'B0008');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0087', 'B0009');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0088', 'B0010');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0089', 'B0011');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0089', 'B0012');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0089', 'B0013');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0090', 'B0014');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0091', 'B0015');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0092', 'B0016');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0093', 'B0017');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0093', 'B0018');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0093', 'B0019');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0094', 'B0020');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0095', 'B0021');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0096', 'B0022');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0097', 'B0023');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0098', 'B0024');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0098', 'B0025');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0098', 'B0026');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0099', 'B0027');
INSERT INTO CHITIETCHUANDOAN VALUES ('TT0100', 'B0028');


INSERT INTO TAIKHOAN VALUES ('TK0001', 'quanly', N'admin', N'Quản lý', 'Q001');
INSERT INTO TAIKHOAN VALUES ('TK0002', 'nhuquynh', N'123456', N'Thu ngân', 'Q002');
INSERT INTO TAIKHOAN VALUES ('TK0003', 'thanhtruc', N'1234', N'Thu ngân', 'Q002');
INSERT INTO TAIKHOAN VALUES ('TK0004', 'ttd1', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0005', 'tvh2', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0006', 'nvn3', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0007', 'dtt5', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0008', 'httt6', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0009', 'tko7', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0010', 'tdm8', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0011', 'vttd9', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0012', 'tnh11', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0013', 'ntlh12', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0014', 'ttd13', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0015', 'ndt14', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0016', 'tttt15', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0017', 'hvmm16', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0018', 'ndh17', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0019', 'ntc18', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0020', 'dqh20', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0021', 'lxn21', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0022', 'nptl22', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0023', 'nts23', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0024', 'lth24', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0025', 'tnt25', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0026', 'cdn26', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0027', 'nqc27', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0028', 'tqa28', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0029', 'tav29', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0030', 'htkq30', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0031', 'nqn31', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0032', 'dtt32', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0033', 'htl33', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0034', 'mmt34', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0035', 'lqh35', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0036', 'nvn36', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0037', 'dtd37', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0038', 'ttnl38', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0039', 'tdh39', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0040', 'ctn40', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0041', 'tdh41', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0042', 'ltla42', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0043', 'nvl43', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0044', 'lvk44', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0045', 'lnm45', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0046', 'qtbt46', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0047', 'ptx47', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0048', 'ptpt48', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0049', 'nqk49', N'123', N'Bác sĩ', 'Q003');
INSERT INTO TAIKHOAN VALUES ('TK0050', 'dcl50', N'123', N'Bác sĩ', 'Q003');

INSERT INTO CHITIETTOATHUOC VALUES ('TT0001', 'T0096', 50000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0001', 'T0097', 7000, 12, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0001', 'T0098', 49000, 30, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0002', 'T0099', 25000, 15, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0003', 'T0100', 11000, 12, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0003', 'T0101', 56000, 6, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0004', 'T0102', 120000, 9, N'Ngày 2 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0005', 'T0103', 21800, 30, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0006', 'T0104', 30000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0006', 'T0105', 12000, 10, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0006', 'T0106', 158000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0007', 'T0107', 12000, 9, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0008', 'T0108', 1526000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0009', 'T0109', 12000, 5, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0010', 'T0110', 150000, 3, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0011', 'T0111', 599000, 1, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0012', 'T0112', 811000, 8, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0013', 'T0113', 389000, 5, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0014', 'T0114', 369000, 6, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0014', 'T0115', 189000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0014', 'T0116', 789000, 15, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0015', 'T0117', 559000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0016', 'T0118', 484000, 20, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0017', 'T0119', 639000, 24, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0018', 'T0120', 439000, 30, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0019', 'T0121', 490000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0019', 'T0122', 239000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0019', 'T0123', 369000, 30, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0019', 'T0124', 169000, 15, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0020', 'T0125', 569000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0021', 'T0126', 399000, 6, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0022', 'T0127', 169000, 9, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0022', 'T0128', 16900, 30, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0023', 'T0129', 169000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0024', 'T0130', 169000, 10, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0025', 'T0131', 769000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0026', 'T0132', 169000, 9, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0027', 'T0133', 869000, 6, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0028', 'T0134', 1569000, 5, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0029', 'T0135', 899000, 3, N'Ngày 1 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0030', 'T0136', 1629000, 1, N'Ngày 1 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0031', 'T0137', 169000, 8, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0032', 'T0138', 499000, 5, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0033', 'T0139', 279000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0034', 'T0140', 169000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0035', 'T0141', 99000, 15, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0036', 'T0142', 399000, 18, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0037', 'T0143', 830000, 20, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0038', 'T0144', 222000, 24, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0039', 'T0145', 569000, 30, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0040', 'T0146', 769000, 10, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0041', 'T0147', 869000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0042', 'T0148', 129000, 30, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0043', 'T0149', 269000, 15, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0044', 'T0150', 45000, 12, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0045', 'T0151', 669000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0045', 'T0152', 559000, 9, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0046', 'T0153', 369000, 30, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0047', 'T0154', 69000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0047', 'T0155', 1690000, 10, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0047', 'T0156', 369000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0047', 'T0157', 269000, 9, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0048', 'T0158', 69000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0049', 'T0159', 169000, 5, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0050', 'T0160', 169000, 3, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0051', 'T0161', 550000, 1, N'Ngày 1 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0052', 'T0162', 750000, 8, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0053', 'T0163', 300000, 5, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0054', 'T0164', 299000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0055', 'T0165', 140000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0056', 'T0166', 700000, 15, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0057', 'T0167', 500000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0058', 'T0168', 404000, 20, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0059', 'T0169', 600000, 24, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0060', 'T0170', 400000, 30, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0061', 'T0171', 450000, 10, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0062', 'T0172', 200000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0063', 'T0173', 360000, 30, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0064', 'T0174', 160000, 15, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0065', 'T0175', 560000, 12, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0066', 'T0176', 389000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0067', 'T0177', 160000, 9, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0068', 'T0178', 15000, 30, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0069', 'T0179', 160000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0070', 'T0180', 160000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0071', 'T0181', 760000, 12, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0071', 'T0182', 160000, 9, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0071', 'T0183', 760000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0071', 'T0184', 1460000, 5, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0072', 'T0185', 860000, 3, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0073', 'T0186', 1600000, 1, N'Ngày 1 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0074', 'T0187', 160000, 8, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0075', 'T0188', 400000, 5, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0076', 'T0189', 250000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0077', 'T0190', 160000, 10, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0078', 'T0191', 90000, 15, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0079', 'T0192', 390000, 18, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0080', 'T0193', 760000, 20, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0081', 'T0194', 160000, 24, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0082', 'T0195', 560000, 30, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0083', 'T0196', 760000, 10, N'Ngày 2 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0084', 'T0197', 860000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0085', 'T0198', 120000, 30, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0086', 'T0199', 260000, 15, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0087', 'T0065', 30000, 12, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0088', 'T0066', 650000, 6, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0089', 'T0067', 540000, 9, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0089', 'T0068', 360000, 30, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0089', 'T0069', 60000, 18, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0090', 'T0070', 1600000, 10, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0091', 'T0071', 360000, 12, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0092', 'T0072', 160000, 9, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0093', 'T0073', 60000, 6, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0093', 'T0074', 160000, 5, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0093', 'T0075', 160000, 3, N'Ngày 1 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0094', 'T0076', 499000, 1, N'Ngày 3 lần mỗi lần 2 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0095', 'T0077', 279000, 8, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0096', 'T0078', 169000, 5, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0097', 'T0079', 99000, 6, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0098', 'T0080', 399000, 10, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0098', 'T0081', 830000, 15, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0098', 'T0082', 222000, 18, N'Ngày 3 lần mỗi lần 3 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0099', 'T0083', 569000, 20, N'Ngày 3 lần mỗi lần 1 viên');
INSERT INTO CHITIETTOATHUOC VALUES ('TT0100', 'T0073', 769000, 24, N'Ngày 3 lần mỗi lần 2 viên');

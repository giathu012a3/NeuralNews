-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: neuralnews
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `summary` text,
  `image_url` varchar(500) DEFAULT NULL,
  `author_id` bigint DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `status` enum('DRAFT','PENDING','PUBLISHED','ARCHIVED','REJECTED') DEFAULT 'DRAFT',
  `views` int DEFAULT '0',
  `likes_count` int DEFAULT '0',
  `sentiment_label` varchar(50) DEFAULT NULL,
  `source_score` int DEFAULT NULL,
  `popularity_score` float DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Sự bùng nổ của Trí tuệ Nhân tạo năm 2026','<div class=\"article-html-content\">\n    <h2>1. Kỷ nguyên mới của công nghệ</h2>\n    <p>Năm 2026 đánh dấu một bước ngoặt lớn trong sự phát triển của <strong>Trí tuệ Nhân tạo (AI)</strong>. Các mô hình ngôn ngữ lớn không chỉ tạo ra văn bản tự nhiên mà còn có khả năng lập luận phức tạp hơn bao giờ hết.</p>\n    <img src=\"https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=1000\" alt=\"AI Technology\" style=\"max-width:100%; height:auto; border-radius:8px; margin:15px 0;\">\n    <h3>2. Tác động đến đời sống và công việc</h3>\n    <p>Các công cụ AI giờ đây được tích hợp sâu vào mọi nền tảng làm việc, từ việc hỗ trợ lập trình, sáng tạo nghệ thuật đến y tế giáo dục. Câu hỏi đặt ra không còn là <em>\"Trí tuệ nhân tạo có thay thế con người hay không?\"</em> mà là <em>\"Chúng ta ứng dụng chúng như thế nào cho hiệu quả?\"</em>.</p>\n    <blockquote style=\"border-left: 4px solid #007bff; padding-left: 15px; font-style: italic; color: #555; background: #f8f9fa; padding: 15px; border-radius: 4px;\">\n        \"AI sẽ không thay thế bạn. Người sử dụng AI sẽ thay thế bạn.\"\n    </blockquote>\n    <p>Theo báo cáo mới nhất, năng suất lao động trong các ngành công nghệ đã tăng 40% nhờ vào sự hỗ trợ của các trợ lý ảo.</p>\n</div>','Sự phát triển vượt bậc của AI trong năm 2026 và tác động của nó tới tương lai công việc.','https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=800',2,1,'ARCHIVED',1500,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(2,'Khám phá đột phá mới trong công nghệ y tế: Nanobot điều trị ung thư','<article class=\"health-article\">\n    <h2>Khởi đầu kỷ nguyên Nanobot trong y tế</h2>\n    <p>Các nhà nghiên cứu tại Viện Công nghệ Y sinh vừa công bố thử nghiệm thành công thế hệ <strong>Nanobot (robot nano)</strong> đầu tiên có khả năng tiêu diệt tế bào ung thư mà không gây tổn hại đến các mô lành xung quanh.</p>\n    \n    <div style=\"background-color: #e8f5e9; padding: 15px; border-left: 4px solid #4caf50; margin: 20px 0; border-radius: 0 8px 8px 0;\">\n        <strong>Thông tin nổi bật:</strong> Phương pháp mới này giảm thiểu tác dụng phụ lến đến 90% so với hóa trị truyền thống và tăng tốc độ hồi phục lên gấp 3 lần.\n    </div>\n    \n    <img src=\"https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&q=80&w=1000\" alt=\"Medical Lab\" style=\"width:100%; height:auto; border-radius:8px; margin: 15px 0;\">\n    \n    <h3>Cơ chế hoạt động</h3>\n    <p>Đội ngũ chuyên gia đã lập trình các robot siêu nhỏ này để nhận diện đặc điểm protein riêng biệt của khối u. Khi tiếp cận, chúng sẽ:</p>\n    <ul style=\"line-height: 1.8;\">\n        <li>Gắn kết với tế bào mang bệnh với độ chính xác tuyệt đối.</li>\n        <li>Bơm trực tiếp thuốc đặc trị với liều lượng siêu nhỏ vào bên trong tế bào.</li>\n        <li>Tự phân hủy an toàn qua hệ bài tiết sau khi hoàn thành nhiệm vụ.</li>\n    </ul>\n\n    <h3>Tương lai của điều trị y khoa</h3>\n    <p>Mặc dù vẫn đang trong giai đoạn thử nghiệm lâm sàng chuyên sâu, nhưng những kết quả ban đầu đầy hứa hẹn này mở ra một tương lai tươi sáng, mang lại hy vọng mới cho hàng triệu bệnh nhân trên toàn cầu trong cuộc chiến chống lại căn bệnh nan y.</p>\n</article>','Bước đột phá y học với việc ứng dụng Nanobot vào quá trình nhắm mục tiêu và tiêu diệt khối u, giảm thiểu tác dụng phụ.','https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&q=80&w=800',2,3,'ARCHIVED',3200,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(3,'Thiết kế Web 2026: Sự lên ngôi của UI Động và Glassmorphism','<div class=\"tech-article-content\">\n    <h2 style=\"color: #2c3e50;\">Xu hướng thiết kế tương lai</h2>\n    <p>Năm nay, xu hướng thiết kế web đang dịch chuyển mạnh mẽ từ Flat Design (thiết kế phẳng) truyền thống sang các giao diện đậm chất tương tác và chân thực hơn. Nổi bật nhất chính là sự kết hợp giữa <strong>Glassmorphism</strong> (hiệu ứng kính mờ) và <strong>Dynamic UI</strong> (giao diện khả biến).</p>\n    \n    <h3>Glassmorphism là gì?</h3>\n    <p>Đây là phong cách thiết kế sử dụng hiệu ứng bóng mờ đằng sau các thành phần giao diện, tạo cảm giác như bạn đang nhìn xuyên qua một tấm kính. Hiệu ứng này mang lại chiều sâu và tính hiện đại cho website, đặc biệt hiệu quả khi sử dụng trên các nền màu sắc sống động (vibrant colors).</p>\n    <img src=\"https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?auto=format&fit=crop&q=80&w=1000\" alt=\"Web Design Trend\" style=\"width:100%; border-radius:12px; margin: 20px 0; box-shadow: 0 4px 15px rgba(0,0,0,0.1);\">\n    \n    <h3>Tầm quan trọng của UI Động</h3>\n    <p>Bên cạnh yếu tố thẩm mỹ, UI hiện nay phải đáp ứng tính tương tác theo chuyển động chuột (micro-interactions) và tối ưu hóa trải nghiệm cá nhân (tự động chuyển đổi Dark/Light mode dựa theo thời gian biểu người dùng, tự điều chỉnh font size). Nếu một website chỉ hiển thị nội dung một cách tĩnh lặng thì sẽ rất khó giữ chân người dùng trong bối cảnh nội dung số đang bão hòa.</p>\n    \n    <div class=\"code-snippet-example\" style=\"background:#282c34; color:#abb2bf; padding:20px; border-radius:8px; font-family:\'Courier New\', Courier, monospace; margin-top:20px; overflow-x: auto;\">\n        <span style=\"color:#c678dd;\">.glass-card</span> {<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">background</span>: rgba(255, 255, 255, 0.05);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">backdrop-filter</span>: blur(15px);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">border-top</span>: 1px solid rgba(255, 255, 255, 0.2);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">border-left</span>: 1px solid rgba(255, 255, 255, 0.2);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">box-shadow</span>: 0 8px 32px 0 rgba(31, 38, 135, 0.37);<br>\n        }\n    </div>\n</div>','Khám phá các xu hướng thiết kế giao diện đình đám trong năm 2026, tập trung vào Glassmorphism và trải nghiệm vi mô.','https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?auto=format&fit=crop&q=80&w=800',1,1,'DRAFT',850,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(4,'Thiền định kỹ thuật số: Giải pháp giảm stress cho thế hệ Gen Z','<article class=\"health-article\">\n    <h2>Sự quá tải thông tin và nhu cầu phục hồi</h2>\n    <p>Trong thời đại mà màn hình điện thoại chiếm hơn 8 giờ mỗi ngày của một người trẻ bình thường, sự gia tăng của các vấn đề sức khỏe tinh thần như lo âu và trầm cảm là không thể tránh khỏi. Để đối phó, phong trào <strong>Thiền định kỹ thuật số (Digital Mindfulness)</strong> đang trở thành cứu cánh mới.</p>\n    <img src=\"https://images.unsplash.com/photo-1593811167562-9cef47bfc3d7?auto=format&fit=crop&q=80&w=1000\" alt=\"Meditation App\" style=\"width:100%; border-radius:12px; margin: 15px 0;\">\n    <h3>Ứng dụng công nghệ để \"cai nghiện\" công nghệ</h3>\n    <p>Thay vì từ bỏ hoàn toàn thiết bị điện tử, các ứng dụng thiền hiện nay sử dụng âm thanh không gian (Spatial Audio) và giao diện tối giản để hướng dẫn người dùng tập thở sâu và thư giãn ngay tại bàn làm việc.</p>\n    <ul>\n        <li>Theo dõi nhịp tim qua Camera hoặc Smartwatch.</li>\n        <li>Cá nhân hóa lộ trình dựa trên mức độ stress hằng ngày.</li>\n        <li>Tích hợp các bài tập dãn cơ ngắn 5 phút mỗi 2 giờ.</li>\n    </ul>\n</article>','Tìm hiểu về phong trào Thiền định kỹ thuật số giúp thế hệ trẻ vượt qua áp lực và lo âu từ quá tải thông tin.','https://images.unsplash.com/photo-1593811167562-9cef47bfc3d7?auto=format&fit=crop&q=80&w=800',1,3,'PUBLISHED',2100,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(5,'Hội nghị Thượng đỉnh G20 năm 2026: Trọng tâm về năng lượng xanh','<div class=\"politics-news-content\">\n    <h2>Cam kết toàn cầu về giảm phát thải</h2>\n    <p>Hội nghị Thượng đỉnh G20 vừa diễn ra tại Geneva đã chứng kiến một cam kết lịch sử từ các quốc gia thành viên: Giảm 60% lượng khí thải carbon vào năm 2035. Đây là bước đi tham vọng nhất từ trước tới nay nhằm đối phó với hiện tượng biến đổi khí hậu đang diễn biến phức tạp.</p>\n    <img src=\"https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&q=80&w=1000\" alt=\"G20 Summit\" style=\"width:100%; height:auto; border-radius:8px; margin: 15px 0;\">\n    <h3>Quỹ hỗ trợ chuyển đổi năng lượng</h3>\n    <p>Điểm nhấn của hội nghị là quyết định thành lập <em>Quỹ Chuyển đổi Năng lượng Toàn cầu</em> trị giá 2 nghìn tỷ USD, nhằm hỗ trợ các quốc gia đang phát triển xây dựng cơ sở hạ tầng năng lượng mặt trời và điện gió.</p>\n    <blockquote style=\"border-left: 5px solid #d9534f; padding: 15px; margin: 20px 0; background-color: #fdf2f2;\">\n        \"Đã đến lúc chúng ta ngừng thỏa hiệp với tương lai của hành tinh.\" - Tổng Thư ký LHQ phát biểu.\n    </blockquote>\n</div>','Các nhà lãnh đạo G20 thống nhất cam kết lịch sử về giảm phát thải carbon và thành lập quỹ hỗ trợ năng lượng xanh.','https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&q=80&w=800',2,2,'PUBLISHED',5400,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(6,'Tàu vũ trụ Artemis V chuẩn bị khởi hành mang theo căn cứ mặt trăng','<article class=\"space-tech-article\">\n    <h2>Bước tiến mới trong công cuộc chinh phục không gian</h2>\n    <p>Cơ quan vũ trụ NASA đã thông báo hoàn tất quá trình kiểm tra cuối cùng cho sứ mệnh <strong>Artemis V</strong>. Tham vọng của chuyến đi này không chỉ là đưa con người trở lại mặt trăng, mà còn là lắp ráp phần lõi của trạm nghiên cứu lâu dài mang tên <em>Lunar Gateway</em>.</p>\n    \n    <div style=\"background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; border-radius: 8px; margin: 20px 0;\">\n        <h3 style=\"margin-top:0;\">Trạm Lunar Gateway có gì đặc biệt?</h3>\n        <p>Đây sẽ là tiền đồn xa xôi nhất của nhân loại, sử dụng 100% năng lượng mặt trời kép và là bệ phóng cho các phi vụ thám hiểm Sao Hỏa trong thập kỷ tới.</p>\n    </div>\n    \n    <img src=\"https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?auto=format&fit=crop&q=80&w=1000\" alt=\"Spacecraft Launch\" style=\"width:100%; border-radius:8px; margin-bottom: 15px;\">\n    <p>Các phi hành gia sẽ dành 45 ngày trên quỹ đạo mặt trăng để triển khai hệ thống robot tự hành, giúp đào xới và tìm kiếm nguồn nước băng giá tiềm năng dưới bề mặt.</p>\n</article>','Sứ mệnh Artemis V mang theo hy vọng và nền tảng cốt lõi cho việc xây dựng trạm nghiên cứu lâu dài trên Mặt Trăng.','https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?auto=format&fit=crop&q=80&w=800',1,4,'REJECTED',4800,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(7,'Sự thật về chế độ ăn nhịn ăn gián đoạn (Intermittent Fasting)','<div class=\"health-nutrition-content\">\n    <h2>Phong trào hay phương pháp khoa học?</h2>\n    <p>Chế độ nhịn ăn gián đoạn (IF) như 16/8 hay 5:2 đã không còn xa lạ. Tuy nhiên, một nghiên cứu kéo dài 5 năm tại ĐH Y khoa Harvard vừa công bố đã làm rõ bức tranh về hiệu quả thực sự của phương pháp này.</p>\n    \n    <h3>Lợi ích đã được chứng minh</h3>\n    <p>Các nhà khoa học xác nhận việc duy trì biểu đồ ăn uống nghiêm ngặt giúp cơ thể kích hoạt cơ chế <strong>Autophagy</strong> - quá trình tế bào tự \"dọn dẹp\" các thành phần hư hỏng, từ đó giảm nguy cơ mắc chứng Alzheimer và trẻ hóa tế bào.</p>\n    \n    <img src=\"https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=1000\" alt=\"Healthy Food\" style=\"width:100%; border-radius:12px; margin: 20px 0;\">\n    \n    <h3>Những lầm tưởng phổ biến</h3>\n    <ul>\n        <li><em>Nhịn đói bằng mọi giá sẽ giảm cân:</em> Sự thật là tổng lượng calo nạp vào trong khung giờ được phép ăn mới quyết định kết quả.</li>\n        <li><em>Phù hợp với tất cả mọi người:</em> Phụ nữ có thai, người có tiền sử dạ dày đặc biệt được khuyến cáo không nên áp dụng IF mà cần có sự tư vấn y khoa.</li>\n    </ul>\n</div>','Phân tích khoa học khách quan từ nghiên cứu 5 năm về những lợi ích cũng như hiểu lầm xung quanh chế độ ăn IF.','https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=800',2,3,'PUBLISHED',2900,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(8,'Web3 và tương lai của danh tính số phi tập trung','<div class=\"tech-crypto-article\">\n    <h2>Cuộc cách mạng quyền riêng tư</h2>\n    <p>Người dùng Internet từ lâu đã chán ngấy việc các ông lớn công nghệ thu thập dữ liệu cá nhân của họ. Sự xuất hiện của <strong>Web3</strong> hứa hẹn giải quyết triệt để vấn đề này với mô hình <em>Danh tính phi tập trung (Decentralized Identity - DID)</em>.</p>\n    \n    <h3>DID hoạt động, như thế nào?</h3>\n    <p>Thay vì sử dụng Google hoặc Facebook để đăng nhập vào một dịch vụ mới, người dùng sẽ tự nắm giữ chìa khóa mã hóa cá nhân trên thiết bị của mình.</p>\n    <img src=\"https://images.unsplash.com/photo-1639762681485-074b7f4ec665?auto=format&fit=crop&q=80&w=1000\" alt=\"Cyber Security\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    <p>Một DID có thể sử dụng cơ chế bảo mật xác minh không tri thức (Zero-Knowledge Proofs). Ví dụ: Một trang web yêu cầu chứng minh bạn trên 18 tuổi. DID chỉ trả lời \"Có\" hoặc \"Không\", trình diễn xác thực hợp pháp, song hoàn toàn không bao giờ tiết lộ ngày sinh cụ thể của bạn.</p>\n    \n    <div style=\"padding: 15px; border: 2px dashed #6c757d; border-radius: 8px; margin-top: 20px;\">\n        <h4 style=\"margin:0 0 10px 0; color:#495057;\">Tương lai không mật khẩu</h4>\n        <p style=\"margin:0;\">Với DID, người dùng quản lý quyền truy cập dữ liệu của chính mình như cách họ quản lý tiền trong ví. Việc bị rò rỉ cơ sở dữ liệu số lượng lớn từ các dịch vụ tập trung sẽ sớm chỉ còn là quá khứ.</p>\n    </div>\n</div>','Thảo luận về cách mà Web3 cùng Danh tính phi tập trung (DID) thay đổi hoàn toàn cục diện bảo mật dữ liệu.','https://images.unsplash.com/photo-1639762681485-074b7f4ec665?auto=format&fit=crop&q=80&w=800',1,1,'PUBLISHED',1150,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(9,'Dự luật \"Làm việc 4 ngày/tuần\" được thông qua tại Liên minh Châu Âu','<article class=\"politics-article\">\n    <h2>Một cuộc biểu quyết lịch sử</h2>\n    <p>Hôm qua, Nghị viện Châu Âu đã thông qua dự luật yêu cầu các doanh nghiệp cung cấp tùy chọn chuyển đổi mô hình làm việc 4 ngày trên 1 tuần mà không bị cắt giảm lương. Dự luật sẽ chính thức có hiệu lực đồng bộ từ năm 2027.</p>\n    \n    <h3>Tác động đến nền kinh tế</h3>\n    <p>Mặc dù vấp phải một số phản ứng lo ngại từ giới chủ đầu tư về nguy cơ làm chậm tốc độ tăng trưởng, tuy nhiên các báo cáo thí điểm từ Na Uy và Tây Ban Nha lại cho thấy kết quả trái ngược:</p>\n    \n    <table border=\"1\" style=\"width:100%; border-collapse: collapse; margin: 20px 0; text-align: left;\">\n        <thead>\n            <tr style=\"background-color: #f2f2f2;\">\n                <th style=\"padding: 10px;\">Chỉ số</th>\n                <th style=\"padding: 10px;\">Thay đổi</th>\n            </tr>\n        </thead>\n        <tbody>\n            <tr>\n                <td style=\"padding: 10px;\">Năng suất nhân viên</td>\n                <td style=\"padding: 10px; color: green; font-weight: bold;\">+15%</td>\n            </tr>\n            <tr>\n                <td style=\"padding: 10px;\">Tỷ lệ nhân viên kiệt sức</td>\n                <td style=\"padding: 10px; color: red; font-weight: bold;\">-40%</td>\n            </tr>\n            <tr>\n                <td style=\"padding: 10px;\">Gắn bó với tổ chức</td>\n                <td style=\"padding: 10px; color: green; font-weight: bold;\">+25%</td>\n            </tr>\n        </tbody>\n    </table>\n    \n    <img src=\"https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&q=80&w=1000\" alt=\"Office Working\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    <p>Dự luật hiện trở thành cột mốc mang tính tiên phong, khơi nguồn cảm hứng cho nhiều quốc gia Bắc Mỹ khác đang theo dõi sát sao mô hình này.</p>\n</article>','Nghị viện Châu Âu thông qua dự luật chính thức ưu tiên mô hình làm việc 4 ngày mỗi tuần, cân bằng công việc và đời sống.','https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&q=80&w=800',2,2,'PUBLISHED',7600,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(10,'DNA cá nhân hóa: Chìa khóa vàng cho việc thiết kế bài tập thể thao','<div class=\"health-fitness-content\">\n    <h2>Xóa mờ ranh giới \"Một kích cỡ vừa cho tất cả\"</h2>\n    <p>Gần đây, lĩnh vực thể thao đón nhận xu hướng mới dựa trên hồ sơ di truyền học (DNA Profiling). Nghiên cứu cho thấy mã gen ảnh hưởng trực tiếp đến cấu trúc sợi cơ và tỷ lệ phục hồi, quyết định việc bạn hợp với bộ môn nào hơn.</p>\n    \n    <h3>Hai loại sợi cơ cơ bản</h3>\n    <ul style=\"list-style-type: square;\">\n        <li><strong>Sợi cơ loại I (Co rút chậm):</strong> Bền bỉ, dùng nhiều oxy. Những người mang bộ gen nổi trội loại cơ này rất phù hợp với chạy marathon, đạp xe leo núi.</li>\n        <li><strong>Sợi cơ loại II (Co rút nhanh):</strong> Tạo lực nổ mạnh. Những cá nhân này nên tập trung vào đẩy tạ nặng, võ thuật hoặc chạy nước rút (sprinting).</li>\n    </ul>\n    \n    <img src=\"https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&q=80&w=1000\" alt=\"Fitness Tracking\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    \n    <p>Thay vì ép buộc bản thân vào một chế độ khắc nghiệt chung chung do huấn luyện viên giao, giờ đây chỉ với một mẫu thử nước bọt đơn giản tại nhà, người dùng sẽ nhận được báo cáo về nguy cơ chấn thương kèm đề xuất lộ trình tập lý tưởng nhằm khai phá hoàn toàn tiềm năng sức mạnh sinh học.</p>\n</div>','Công nghệ lập hồ sơ DNA đang giúp xây dựng các chương trình thể chất riêng biệt đem lại hiệu quả tập luyện lớn hơn.','https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&q=80&w=800',1,3,'ARCHIVED',1550,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(11,'Rust đang tái định hình hệ điều hành thế hệ mới','<div class=\"tech-programming-content\">\n    <h2>Sự dịch chuyển lớn ra khỏi C và C++</h2>\n    <p>Sự nổi lên của ngôn ngữ lập trình <strong>Rust</strong> không còn là trào lưu nhất thời. Cả Microsoft, Linux Foundation và Google đều đang tái cấu trúc các phân hệ cốt lõi liên quan tới bảo mật bộ nhớ (memory safety) thành các module viết bằng ngôn ngữ này.</p>\n    <img src=\"https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=1000\" alt=\"Programming Code\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    \n    <h3>Bảo mật an toàn ngay từ trình biên dịch</h3>\n    <p>Hơn 70% các lỗi bảo mật nghiêm trọng trên phần mềm truyền thống như Windows hay Android xuất phát từ cách quản lý bộ nhớ yếu kém. Điểm ăn tiền của Rust nằm ở công cụ Borrow Checker, cưỡng chế quy tắc biên dịch hà khắc khiến lập trình viên phải viết mã đúng và an toàn tuyệt đối từ lúc code.</p>\n    \n    <blockquote style=\"background: #2b2b2b; color: #a9b7c6; padding: 20px; font-family: monospace; border-radius: 8px;\">\n        fn main() {<br>\n        &nbsp;&nbsp;println!(\"Chậm một phút lúc biên dịch để phần mềm an toàn mãi mãi!\");<br>\n        }\n    </blockquote>\n    <p>Hiện tại, mã nguồn của Linux Kernel đã chính thức chứa hơn 50,000 dòng mã Rust và con số này dự kiến gia tăng nhân đôi theo từng quý.</p>\n</div>','Tại sao các gã khổng lồ công nghệ lại đồng loạt đặt trọn niềm tin vào ngôn ngữ Rust để xây dựng lại nhân hệ điều hành.','https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=800',2,1,'PUBLISHED',4120,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(12,'Thành phố Thông minh: Kế hoạch biến đổi hệ thống giao thông công cộng','<div class=\"smart-city-article\">\n    <h2>Giao thông dưới sự quản lý của AI</h2>\n    <p>Nhàm chán với cảnh kẹt xe kéo dài, chính quyền các đô thị lớn tại Châu Á đang lên kế hoạch triển khai đồng loạt nền tảng <em>City-Wide AI Traffic Control</em>. Trí tuệ nhân tạo sẽ kiểm soát chu kỳ đèn giao thông theo thời gian thực (Real-time Adaptive Control).</p>\n    \n    <h3>Hoạt động như thế nào?</h3>\n    <p>Hệ thống hàng nghìn camera và cảm biến IoT được đặt dọc vỉa hè, thu thập lưu lượng phương tiện. Sau đó AI tự động dự báo dòng xe trong 15 phút tới để cân chỉnh số giây cho đèn xanh.</p>\n    \n    <img src=\"https://images.unsplash.com/photo-1449824913935-59a10b8dce00?auto=format&fit=crop&q=80&w=1000\" alt=\"Smart City Traffic\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    \n    <div style=\"background-color: #f1f8ff; border-left: 5px solid #0366d6; padding: 15px; border-radius: 5px;\">\n        <strong>Thử nghiệm thực tế:</strong> Làn sóng \"đèn xanh rải thảm\" được tạo ra bởi AI đã giúp cắt giảm trung bình 18 phút di chuyển cho một lượt đi lại giờ cao điểm, giúp tiết kiệm hàng triệu giờ lao động mỗi năm cho cư dân.\n    </div>\n</div>','Dự án Thành phố thông minh sử dụng hệ thống Trí tuệ nhân tạo tối ưu hóa lưu lượng giao thông đem lại những lợi ích thiết thực.','https://images.unsplash.com/photo-1449824913935-59a10b8dce00?auto=format&fit=crop&q=80&w=800',1,2,'PUBLISHED',1830,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(13,'Ô nhiễm vi nhựa đã xuất hiện trong mưa: Báo động môi trường toàn cầu','<article class=\"health-environment-content\">\n    <h2 style=\"color: #c0392b;\">Báo động đỏ cho nhân loại</h2>\n    <p>Nếu bạn nghĩ rằng ô nhiễm nhựa chỉ xảy ra ở dưới đáy đại dương, thì báo cáo nghiên cứu không khí mới nhất vừa dội gáo nước lạnh: <strong>Vi nhựa (Microplastics)</strong> đang rơi xuống ngay giữa những khu vực hẻo lánh nhất dưới dạng hạt mưa.</p>\n    \n    <img src=\"https://images.unsplash.com/photo-1611273426858-450d8e3c9cce?auto=format&fit=crop&q=80&w=1000\" alt=\"Plastic Pollution\" style=\"width:100%; height: 350px; object-fit: cover; border-radius:12px; margin: 20px 0;\">\n    \n    <h3>Vòng tuần hoàn khép kín độc hại</h3>\n    <p>Rác thải nhựa từ sinh hoạt bị phân rã, bốc hơi theo gió, hợp lại cùng độ ẩm trong tầng đối lưu và rửa trôi xuống lòng đất, len lỏi vô tình vào chuỗi thức ăn tự nhiên và xâm nhập vào cơ thể con người với nguy cơ tiềm tàng về viêm nhiễm hạt mịn (nano-level poisoning).</p>\n    \n    <h3>Hành động ngay lập tức</h3>\n    <p>Các chuyên gia kêu gọi việc cấm phân phối hoàn toàn bao bì nhựa xốp, chai nhựa dùng một lần. Việc quản lý tái chế nhựa giờ đây không chỉ là \"sống xanh\", mà là sự bắt buộc sinh tồn cho chính sinh mạng thế hệ tương lai.</p>\n</article>','Hiện tượng hạt Vi Nhựa rơi cùng mưa gióng lên hồi chuông về vòng tuần hoàn ô nhiễm lan rộng và đe dọa sinh học tiềm ẩn.','https://images.unsplash.com/photo-1611273426858-450d8e3c9cce?auto=format&fit=crop&q=80&w=800',2,5,'PUBLISHED',6000,0,NULL,NULL,0,'2026-03-02 16:15:28','2026-03-02 16:15:28');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Technology','Công nghệ và Khoa học máy tính'),(2,'Politics','Chính trị và Ngoại giao'),(3,'Health','Sức khỏe, Y tế và Đời sống'),(4,'Science','Khoa học Không gian và Tự nhiên'),(5,'Environment','Môi trường và Khí hậu');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `article_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `homepage_config`
--

DROP TABLE IF EXISTS `homepage_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homepage_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section_name` varchar(100) DEFAULT NULL,
  `display_order` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `layout_type` enum('GRID','LIST','CAROUSEL','HERO') DEFAULT 'GRID',
  `display_columns` int DEFAULT '3',
  `item_limit` int DEFAULT '6',
  `data_source` enum('LATEST','CATEGORY','TRENDING','FEATURED','CUSTOM_HTML') DEFAULT 'LATEST',
  `category_id` int DEFAULT NULL,
  `html_content` text,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `homepage_config_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homepage_config`
--

LOCK TABLES `homepage_config` WRITE;
/*!40000 ALTER TABLE `homepage_config` DISABLE KEYS */;
INSERT INTO `homepage_config` VALUES (1,'Hero Banner',1,1,'HERO',3,6,'FEATURED',NULL,NULL),(2,'Tech News Grid',2,1,'GRID',4,8,'CATEGORY',1,NULL),(3,'Ad Banner',3,1,'GRID',3,6,'CUSTOM_HTML',NULL,'<div style=\"background:#f0f0f0; padding:20px; text-align:center;\">Quảng Cáo Tại Đây</div>');
/*!40000 ALTER TABLE `homepage_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interactions`
--

DROP TABLE IF EXISTS `interactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interactions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `article_id` bigint NOT NULL,
  `type` enum('LIKE','BOOKMARK','VIEW') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `interactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `interactions_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interactions`
--

LOCK TABLES `interactions` WRITE;
/*!40000 ALTER TABLE `interactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `interactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `article_id` bigint NOT NULL,
  `reporter_id` bigint DEFAULT NULL,
  `reason` varchar(100) NOT NULL,
  `status` enum('PENDING','Reviewed','DISMISSED','ACTION_TAKEN') DEFAULT 'PENDING',
  `ai_analysis` text,
  `ai_trust_score` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`),
  KEY `reporter_id` (`reporter_id`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'USER','Người dùng bình thường'),(2,'JOURNALIST','Nhà báo'),(3,'ADMIN','Quản trị viên');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_history`
--

DROP TABLE IF EXISTS `search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `search_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `keyword` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `search_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_history`
--

LOCK TABLES `search_history` WRITE;
/*!40000 ALTER TABLE `search_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` int NOT NULL,
  `assigned_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role_id` int NOT NULL DEFAULT '1',
  `status` enum('ACTIVE','PENDING','BANNED','SUSPENDED') DEFAULT 'ACTIVE',
  `avatar_url` varchar(500) DEFAULT NULL,
  `bio` text,
  `experience_years` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@neuralnews.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Hệ thống Admin',3,'ACTIVE',NULL,'System administrator of NexusAI',10,'2026-03-02 16:15:17'),(2,'tech.writer@neuralnews.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Tech Writer',2,'ACTIVE',NULL,'Senior tech journalist with focus on AI.',5,'2026-03-02 16:15:17'),(3,'health.expert@neuralnews.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Health Expert',1,'ACTIVE',NULL,'Regular user learning about AI',0,'2026-03-02 16:15:17'),(4,'nguyengiathu24052004@gmail.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Nguyễn Gia Thụ',2,'ACTIVE',NULL,NULL,0,'2026-03-03 11:50:55');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-14  0:20:15

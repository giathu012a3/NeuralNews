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
  `approved_by` bigint DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `status` enum('DRAFT','PENDING','PUBLISHED','ARCHIVED','REJECTED') DEFAULT 'DRAFT',
  `views` int DEFAULT '0',
  `likes_count` int DEFAULT '0',
  `dislikes_count` int DEFAULT '0',
  `popularity_score` float DEFAULT '0',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `category_id` (`category_id`),
  KEY `fk_articles_approved_by` (`approved_by`),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `articles_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_articles_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'Sự bùng nổ của Trí tuệ Nhân tạo năm 2026','<div class=\"article-html-content\">\n    <h2>1. Kỷ nguyên mới của công nghệ</h2>\n    <p>Năm 2026 đánh dấu một bước ngoặt lớn trong sự phát triển của <strong>Trí tuệ Nhân tạo (AI)</strong>. Các mô hình ngôn ngữ lớn không chỉ tạo ra văn bản tự nhiên mà còn có khả năng lập luận phức tạp hơn bao giờ hết.</p>\n    <img src=\"https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=1000\" alt=\"AI Technology\" style=\"max-width:100%; height:auto; border-radius:8px; margin:15px 0;\">\n    <h3>2. Tác động đến đời sống và công việc</h3>\n    <p>Các công cụ AI giờ đây được tích hợp sâu vào mọi nền tảng làm việc, từ việc hỗ trợ lập trình, sáng tạo nghệ thuật đến y tế giáo dục. Câu hỏi đặt ra không còn là <em>\"Trí tuệ nhân tạo có thay thế con người hay không?\"</em> mà là <em>\"Chúng ta ứng dụng chúng như thế nào cho hiệu quả?\"</em>.</p>\n    <blockquote style=\"border-left: 4px solid #007bff; padding-left: 15px; font-style: italic; color: #555; background: #f8f9fa; padding: 15px; border-radius: 4px;\">\n        \"AI sẽ không thay thế bạn. Người sử dụng AI sẽ thay thế bạn.\"\n    </blockquote>\n    <p>Theo báo cáo mới nhất, năng suất lao động trong các ngành công nghệ đã tăng 40% nhờ vào sự hỗ trợ của các trợ lý ảo.</p>\n</div>','Sự phát triển vượt bậc của AI trong năm 2026 và tác động của nó tới tương lai công việc.','uploads/images/photo-1677442136019-21780ecad995.jpg',1,NULL,1,'PUBLISHED',1513,1,1,16,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(2,'Khám phá đột phá mới trong công nghệ y tế: Nanobot điều trị ung thư','<article class=\"health-article\">\n    <h2>Khởi đầu kỷ nguyên Nanobot trong y tế</h2>\n    <p>Các nhà nghiên cứu tại Viện Công nghệ Y sinh vừa công bố thử nghiệm thành công thế hệ <strong>Nanobot (robot nano)</strong> đầu tiên có khả năng tiêu diệt tế bào ung thư mà không gây tổn hại đến các mô lành xung quanh.</p>\n    \n    <div style=\"background-color: #e8f5e9; padding: 15px; border-left: 4px solid #4caf50; margin: 20px 0; border-radius: 0 8px 8px 0;\">\n        <strong>Thông tin nổi bật:</strong> Phương pháp mới này giảm thiểu tác dụng phụ lến đến 90% so với hóa trị truyền thống và tăng tốc độ hồi phục lên gấp 3 lần.\n    </div>\n    \n    <img src=\"https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&q=80&w=1000\" alt=\"Medical Lab\" style=\"width:100%; height:auto; border-radius:8px; margin: 15px 0;\">\n    \n    <h3>Cơ chế hoạt động</h3>\n    <p>Đội ngũ chuyên gia đã lập trình các robot siêu nhỏ này để nhận diện đặc điểm protein riêng biệt của khối u. Khi tiếp cận, chúng sẽ:</p>\n    <ul style=\"line-height: 1.8;\">\n        <li>Gắn kết với tế bào mang bệnh với độ chính xác tuyệt đối.</li>\n        <li>Bơm trực tiếp thuốc đặc trị với liều lượng siêu nhỏ vào bên trong tế bào.</li>\n        <li>Tự phân hủy an toàn qua hệ bài tiết sau khi hoàn thành nhiệm vụ.</li>\n    </ul>\n\n    <h3>Tương lai của điều trị y khoa</h3>\n    <p>Mặc dù vẫn đang trong giai đoạn thử nghiệm lâm sàng chuyên sâu, nhưng những kết quả ban đầu đầy hứa hẹn này mở ra một tương lai tươi sáng, mang lại hy vọng mới cho hàng triệu bệnh nhân trên toàn cầu trong cuộc chiến chống lại căn bệnh nan y.</p>\n</article>','Bước đột phá y học với việc ứng dụng Nanobot vào quá trình nhắm mục tiêu và tiêu diệt khối u, giảm thiểu tác dụng phụ.','uploads/images/photo-1530497610245-94d3c16cda28.jpg',2,1,3,'PUBLISHED',3213,2,0,29,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(3,'Thiết kế Web 2026: Sự lên ngôi của UI Động và Glassmorphism','<div class=\"tech-article-content\">\n    <h2 style=\"color: #2c3e50;\">Xu hướng thiết kế tương lai</h2>\n    <p>Năm nay, xu hướng thiết kế web đang dịch chuyển mạnh mẽ từ Flat Design (thiết kế phẳng) truyền thống sang các giao diện đậm chất tương tác và chân thực hơn. Nổi bật nhất chính là sự kết hợp giữa <strong>Glassmorphism</strong> (hiệu ứng kính mờ) và <strong>Dynamic UI</strong> (giao diện khả biến).</p>\n    \n    <h3>Glassmorphism là gì?</h3>\n    <p>Đây là phong cách thiết kế sử dụng hiệu ứng bóng mờ đằng sau các thành phần giao diện, tạo cảm giác như bạn đang nhìn xuyên qua một tấm kính. Hiệu ứng này mang lại chiều sâu và tính hiện đại cho website, đặc biệt hiệu quả khi sử dụng trên các nền màu sắc sống động (vibrant colors).</p>\n    <img src=\"https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?auto=format&fit=crop&q=80&w=1000\" alt=\"Web Design Trend\" style=\"width:100%; border-radius:12px; margin: 20px 0; box-shadow: 0 4px 15px rgba(0,0,0,0.1);\">\n    \n    <h3>Tầm quan trọng của UI Động</h3>\n    <p>Bên cạnh yếu tố thẩm mỹ, UI hiện nay phải đáp ứng tính tương tác theo chuyển động chuột (micro-interactions) và tối ưu hóa trải nghiệm cá nhân (tự động chuyển đổi Dark/Light mode dựa theo thời gian biểu người dùng, tự điều chỉnh font size). Nếu một website chỉ hiển thị nội dung một cách tĩnh lặng thì sẽ rất khó giữ chân người dùng trong bối cảnh nội dung số đang bão hòa.</p>\n    \n    <div class=\"code-snippet-example\" style=\"background:#282c34; color:#abb2bf; padding:20px; border-radius:8px; font-family:\'Courier New\', Courier, monospace; margin-top:20px; overflow-x: auto;\">\n        <span style=\"color:#c678dd;\">.glass-card</span> {<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">background</span>: rgba(255, 255, 255, 0.05);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">backdrop-filter</span>: blur(15px);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">border-top</span>: 1px solid rgba(255, 255, 255, 0.2);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">border-left</span>: 1px solid rgba(255, 255, 255, 0.2);<br>\n        &nbsp;&nbsp;<span style=\"color:#d19a66;\">box-shadow</span>: 0 8px 32px 0 rgba(31, 38, 135, 0.37);<br>\n        }\n    </div>\n</div>','Khám phá các xu hướng thiết kế giao diện đình đám trong năm 2026, tập trung vào Glassmorphism và trải nghiệm vi mô.','uploads/images/photo-1507721999472-8ed4421c4af2.jpg',1,NULL,1,'DRAFT',850,0,0,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(4,'Thiền định kỹ thuật số: Giải pháp giảm stress cho thế hệ Gen Z','<article class=\"health-article\">\n    <h2>Sự quá tải thông tin và nhu cầu phục hồi</h2>\n    <p>Trong thời đại mà màn hình điện thoại chiếm hơn 8 giờ mỗi ngày của một người trẻ bình thường, sự gia tăng của các vấn đề sức khỏe tinh thần như lo âu và trầm cảm là không thể tránh khỏi. Để đối phó, phong trào <strong>Thiền định kỹ thuật số (Digital Mindfulness)</strong> đang trở thành cứu cánh mới.</p>\n    <img src=\"https://images.unsplash.com/photo-1593811167562-9cef47bfc3d7?auto=format&fit=crop&q=80&w=1000\" alt=\"Meditation App\" style=\"width:100%; border-radius:12px; margin: 15px 0;\">\n    <h3>Ứng dụng công nghệ để \"cai nghiện\" công nghệ</h3>\n    <p>Thay vì từ bỏ hoàn toàn thiết bị điện tử, các ứng dụng thiền hiện nay sử dụng âm thanh không gian (Spatial Audio) và giao diện tối giản để hướng dẫn người dùng tập thở sâu và thư giãn ngay tại bàn làm việc.</p>\n    <ul>\n        <li>Theo dõi nhịp tim qua Camera hoặc Smartwatch.</li>\n        <li>Cá nhân hóa lộ trình dựa trên mức độ stress hằng ngày.</li>\n        <li>Tích hợp các bài tập dãn cơ ngắn 5 phút mỗi 2 giờ.</li>\n    </ul>\n</article>','Tìm hiểu về phong trào Thiền định kỹ thuật số giúp thế hệ trẻ vượt qua áp lực và lo âu từ quá tải thông tin.','uploads/images/photo-1571019614242-c5c5dee9f50b.jpg',1,1,3,'PUBLISHED',2100,0,0,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(5,'Hội nghị Thượng đỉnh G20 năm 2026: Trọng tâm về năng lượng xanh','<div class=\"politics-news-content\">\n    <h2>Cam kết toàn cầu về giảm phát thải</h2>\n    <p>Hội nghị Thượng đỉnh G20 vừa diễn ra tại Geneva đã chứng kiến một cam kết lịch sử từ các quốc gia thành viên: Giảm 60% lượng khí thải carbon vào năm 2035. Đây là bước đi tham vọng nhất từ trước tới nay nhằm đối phó với hiện tượng biến đổi khí hậu đang diễn biến phức tạp.</p>\n    <img src=\"https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&q=80&w=1000\" alt=\"G20 Summit\" style=\"width:100%; height:auto; border-radius:8px; margin: 15px 0;\">\n    <h3>Quỹ hỗ trợ chuyển đổi năng lượng</h3>\n    <p>Điểm nhấn của hội nghị là quyết định thành lập <em>Quỹ Chuyển đổi Năng lượng Toàn cầu</em> trị giá 2 nghìn tỷ USD, nhằm hỗ trợ các quốc gia đang phát triển xây dựng cơ sở hạ tầng năng lượng mặt trời và điện gió.</p>\n    <blockquote style=\"border-left: 5px solid #d9534f; padding: 15px; margin: 20px 0; background-color: #fdf2f2;\">\n        \"Đã đến lúc chúng ta ngừng thỏa hiệp với tương lai của hành tinh.\" - Tổng Thư ký LHQ phát biểu.\n    </blockquote>\n</div>','Các nhà lãnh đạo G20 thống nhất cam kết lịch sử về giảm phát thải carbon và thành lập quỹ hỗ trợ năng lượng xanh.','uploads/images/photo-1529107386315-e1a2ed48a620.jpg',2,1,2,'PUBLISHED',5400,1,0,5,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(6,'Tàu vũ trụ Artemis V chuẩn bị khởi hành mang theo căn cứ mặt trăng','<article class=\"space-tech-article\">\n    <h2>Bước tiến mới trong công cuộc chinh phục không gian</h2>\n    <p>Cơ quan vũ trụ NASA đã thông báo hoàn tất quá trình kiểm tra cuối cùng cho sứ mệnh <strong>Artemis V</strong>. Tham vọng của chuyến đi này không chỉ là đưa con người trở lại mặt trăng, mà còn là lắp ráp phần lõi của trạm nghiên cứu lâu dài mang tên <em>Lunar Gateway</em>.</p>\n    \n    <div style=\"background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; border-radius: 8px; margin: 20px 0;\">\n        <h3 style=\"margin-top:0;\">Trạm Lunar Gateway có gì đặc biệt?</h3>\n        <p>Đây sẽ là tiền đồn xa xôi nhất của nhân loại, sử dụng 100% năng lượng mặt trời kép và là bệ phóng cho các phi vụ thám hiểm Sao Hỏa trong thập kỷ tới.</p>\n    </div>\n    \n    <img src=\"https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?auto=format&fit=crop&q=80&w=1000\" alt=\"Spacecraft Launch\" style=\"width:100%; border-radius:8px; margin-bottom: 15px;\">\n    <p>Các phi hành gia sẽ dành 45 ngày trên quỹ đạo mặt trăng để triển khai hệ thống robot tự hành, giúp đào xới và tìm kiếm nguồn nước băng giá tiềm năng dưới bề mặt.</p>\n</article>','Sứ mệnh Artemis V mang theo hy vọng và nền tảng cốt lõi cho việc xây dựng trạm nghiên cứu lâu dài trên Mặt Trăng.','uploads/images/photo-1541185933-ef5d8ed016c2.jpg',1,1,1,'PUBLISHED',4800,36,0,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(7,'Sự thật về chế độ ăn nhịn ăn gián đoạn (Intermittent Fasting)','<div class=\"health-nutrition-content\">\n    <h2>Phong trào hay phương pháp khoa học?</h2>\n    <p>Chế độ nhịn ăn gián đoạn (IF) như 16/8 hay 5:2 đã không còn xa lạ. Tuy nhiên, một nghiên cứu kéo dài 5 năm tại ĐH Y khoa Harvard vừa công bố đã làm rõ bức tranh về hiệu quả thực sự của phương pháp này.</p>\n    \n    <h3>Lợi ích đã được chứng minh</h3>\n    <p>Các nhà khoa học xác nhận việc duy trì biểu đồ ăn uống nghiêm ngặt giúp cơ thể kích hoạt cơ chế <strong>Autophagy</strong> - quá trình tế bào tự \"dọn dẹp\" các thành phần hư hỏng, từ đó giảm nguy cơ mắc chứng Alzheimer và trẻ hóa tế bào.</p>\n    \n    <img src=\"https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=1000\" alt=\"Healthy Food\" style=\"width:100%; border-radius:12px; margin: 20px 0;\">\n    \n    <h3>Những lầm tưởng phổ biến</h3>\n    <ul>\n        <li><em>Nhịn đói bằng mọi giá sẽ giảm cân:</em> Sự thật là tổng lượng calo nạp vào trong khung giờ được phép ăn mới quyết định kết quả.</li>\n        <li><em>Phù hợp với tất cả mọi người:</em> Phụ nữ có thai, người có tiền sử dạ dày đặc biệt được khuyến cáo không nên áp dụng IF mà cần có sự tư vấn y khoa.</li>\n    </ul>\n</div>','Phân tích khoa học khách quan từ nghiên cứu 5 năm về những lợi ích cũng như hiểu lầm xung quanh chế độ ăn IF.','uploads/images/photo-1490645935967-10de6ba17061.jpg',2,1,3,'PUBLISHED',2903,3,0,18,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(8,'Web3 và tương lai của danh tính số phi tập trung','<div class=\"tech-crypto-article\">\n    <h2>Cuộc cách mạng quyền riêng tư</h2>\n    <p>Người dùng Internet từ lâu đã chán ngấy việc các ông lớn công nghệ thu thập dữ liệu cá nhân của họ. Sự xuất hiện của <strong>Web3</strong> hứa hẹn giải quyết triệt để vấn đề này với mô hình <em>Danh tính phi tập trung (Decentralized Identity - DID)</em>.</p>\n    \n    <h3>DID hoạt động, như thế nào?</h3>\n    <p>Thay vì sử dụng Google hoặc Facebook để đăng nhập vào một dịch vụ mới, người dùng sẽ tự nắm giữ chìa khóa mã hóa cá nhân trên thiết bị của mình.</p>\n    <img src=\"https://images.unsplash.com/photo-1639762681485-074b7f4ec665?auto=format&fit=crop&q=80&w=1000\" alt=\"Cyber Security\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    <p>Một DID có thể sử dụng cơ chế bảo mật xác minh không tri thức (Zero-Knowledge Proofs). Ví dụ: Một trang web yêu cầu chứng minh bạn trên 18 tuổi. DID chỉ trả lời \"Có\" hoặc \"Không\", trình diễn xác thực hợp pháp, song hoàn toàn không bao giờ tiết lộ ngày sinh cụ thể của bạn.</p>\n    \n    <div style=\"padding: 15px; border: 2px dashed #6c757d; border-radius: 8px; margin-top: 20px;\">\n        <h4 style=\"margin:0 0 10px 0; color:#495057;\">Tương lai không mật khẩu</h4>\n        <p style=\"margin:0;\">Với DID, người dùng quản lý quyền truy cập dữ liệu của chính mình như cách họ quản lý tiền trong ví. Việc bị rò rỉ cơ sở dữ liệu số lượng lớn từ các dịch vụ tập trung sẽ sớm chỉ còn là quá khứ.</p>\n    </div>\n</div>','Thảo luận về cách mà Web3 cùng Danh tính phi tập trung (DID) thay đổi hoàn toàn cục diện bảo mật dữ liệu.','uploads/images/photo-1555066931-4365d14bab8c.jpg',1,1,1,'PUBLISHED',1151,24,0,1,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(9,'Dự luật \"Làm việc 4 ngày/tuần\" được thông qua tại Liên minh Châu Âu','<article class=\"politics-article\">\n    <h2>Một cuộc biểu quyết lịch sử</h2>\n    <p>Hôm qua, Nghị viện Châu Âu đã thông qua dự luật yêu cầu các doanh nghiệp cung cấp tùy chọn chuyển đổi mô hình làm việc 4 ngày trên 1 tuần mà không bị cắt giảm lương. Dự luật sẽ chính thức có hiệu lực đồng bộ từ năm 2027.</p>\n    \n    <h3>Tác động đến nền kinh tế</h3>\n    <p>Mặc dù vấp phải một số phản ứng lo ngại từ giới chủ đầu tư về nguy cơ làm chậm tốc độ tăng trưởng, tuy nhiên các báo cáo thí điểm từ Na Uy và Tây Ban Nha lại cho thấy kết quả trái ngược:</p>\n    \n    <table border=\"1\" style=\"width:100%; border-collapse: collapse; margin: 20px 0; text-align: left;\">\n        <thead>\n            <tr style=\"background-color: #f2f2f2;\">\n                <th style=\"padding: 10px;\">Chỉ số</th>\n                <th style=\"padding: 10px;\">Thay đổi</th>\n            </tr>\n        </thead>\n        <tbody>\n            <tr>\n                <td style=\"padding: 10px;\">Năng suất nhân viên</td>\n                <td style=\"padding: 10px; color: green; font-weight: bold;\">+15%</td>\n            </tr>\n            <tr>\n                <td style=\"padding: 10px;\">Tỷ lệ nhân viên kiệt sức</td>\n                <td style=\"padding: 10px; color: red; font-weight: bold;\">-40%</td>\n            </tr>\n            <tr>\n                <td style=\"padding: 10px;\">Gắn bó với tổ chức</td>\n                <td style=\"padding: 10px; color: green; font-weight: bold;\">+25%</td>\n            </tr>\n        </tbody>\n    </table>\n    \n    <img src=\"https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&q=80&w=1000\" alt=\"Office Working\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    <p>Dự luật hiện trở thành cột mốc mang tính tiên phong, khơi nguồn cảm hứng cho nhiều quốc gia Bắc Mỹ khác đang theo dõi sát sao mô hình này.</p>\n</article>','Nghị viện Châu Âu thông qua dự luật chính thức ưu tiên mô hình làm việc 4 ngày mỗi tuần, cân bằng công việc và đời sống.','uploads/images/photo-1542744173-8e7e53415bb0.jpg',2,1,2,'PUBLISHED',7601,1,0,6,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(10,'DNA cá nhân hóa: Chìa khóa vàng cho việc thiết kế bài tập thể thao','<div class=\"health-fitness-content\">\n    <h2>Xóa mờ ranh giới \"Một kích cỡ vừa cho tất cả\"</h2>\n    <p>Gần đây, lĩnh vực thể thao đón nhận xu hướng mới dựa trên hồ sơ di truyền học (DNA Profiling). Nghiên cứu cho thấy mã gen ảnh hưởng trực tiếp đến cấu trúc sợi cơ và tỷ lệ phục hồi, quyết định việc bạn hợp với bộ môn nào hơn.</p>\n    \n    <h3>Hai loại sợi cơ cơ bản</h3>\n    <ul style=\"list-style-type: square;\">\n        <li><strong>Sợi cơ loại I (Co rút chậm):</strong> Bền bỉ, dùng nhiều oxy. Những người mang bộ gen nổi trội loại cơ này rất phù hợp với chạy marathon, đạp xe leo núi.</li>\n        <li><strong>Sợi cơ loại II (Co rút nhanh):</strong> Tạo lực nổ mạnh. Những cá nhân này nên tập trung vào đẩy tạ nặng, võ thuật hoặc chạy nước rút (sprinting).</li>\n    </ul>\n    \n    <img src=\"https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&q=80&w=1000\" alt=\"Fitness Tracking\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    \n    <p>Thay vì ép buộc bản thân vào một chế độ khắc nghiệt chung chung do huấn luyện viên giao, giờ đây chỉ với một mẫu thử nước bọt đơn giản tại nhà, người dùng sẽ nhận được báo cáo về nguy cơ chấn thương kèm đề xuất lộ trình tập lý tưởng nhằm khai phá hoàn toàn tiềm năng sức mạnh sinh học.</p>\n</div>','Công nghệ lập hồ sơ DNA đang giúp xây dựng các chương trình thể chất riêng biệt đem lại hiệu quả tập luyện lớn hơn.','uploads/images/photo-1530497610245-94d3c16cda28.jpg',1,1,3,'PUBLISHED',1550,13,0,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(11,'Rust đang tái định hình hệ điều hành thế hệ mới','<div class=\"tech-programming-content\">\n    <h2>Sự dịch chuyển lớn ra khỏi C và C++</h2>\n    <p>Sự nổi lên của ngôn ngữ lập trình <strong>Rust</strong> không còn là trào lưu nhất thời. Cả Microsoft, Linux Foundation và Google đều đang tái cấu trúc các phân hệ cốt lõi liên quan tới bảo mật bộ nhớ (memory safety) thành các module viết bằng ngôn ngữ này.</p>\n    <img src=\"https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=1000\" alt=\"Programming Code\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    \n    <h3>Bảo mật an toàn ngay từ trình biên dịch</h3>\n    <p>Hơn 70% các lỗi bảo mật nghiêm trọng trên phần mềm truyền thống như Windows hay Android xuất phát từ cách quản lý bộ nhớ yếu kém. Điểm ăn tiền của Rust nằm ở công cụ Borrow Checker, cưỡng chế quy tắc biên dịch hà khắc khiến lập trình viên phải viết mã đúng và an toàn tuyệt đối từ lúc code.</p>\n    \n    <blockquote style=\"background: #2b2b2b; color: #a9b7c6; padding: 20px; font-family: monospace; border-radius: 8px;\">\n        fn main() {<br>\n        &nbsp;&nbsp;println!(\"Chậm một phút lúc biên dịch để phần mềm an toàn mãi mãi!\");<br>\n        }\n    </blockquote>\n    <p>Hiện tại, mã nguồn của Linux Kernel đã chính thức chứa hơn 50,000 dòng mã Rust và con số này dự kiến gia tăng nhân đôi theo từng quý.</p>\n</div>','Tại sao các gã khổng lồ công nghệ lại đồng loạt đặt trọn niềm tin vào ngôn ngữ Rust để xây dựng lại nhân hệ điều hành.','uploads/images/photo-1555066931-4365d14bab8c.jpg',2,1,1,'PUBLISHED',4120,0,0,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(12,'Thành phố Thông minh: Kế hoạch biến đổi hệ thống giao thông công cộng','<div class=\"smart-city-article\">\n    <h2>Giao thông dưới sự quản lý của AI</h2>\n    <p>Nhàm chán với cảnh kẹt xe kéo dài, chính quyền các đô thị lớn tại Châu Á đang lên kế hoạch triển khai đồng loạt nền tảng <em>City-Wide AI Traffic Control</em>. Trí tuệ nhân tạo sẽ kiểm soát chu kỳ đèn giao thông theo thời gian thực (Real-time Adaptive Control).</p>\n    \n    <h3>Hoạt động như thế nào?</h3>\n    <p>Hệ thống hàng nghìn camera và cảm biến IoT được đặt dọc vỉa hè, thu thập lưu lượng phương tiện. Sau đó AI tự động dự báo dòng xe trong 15 phút tới để cân chỉnh số giây cho đèn xanh.</p>\n    \n    <img src=\"https://images.unsplash.com/photo-1449824913935-59a10b8dce00?auto=format&fit=crop&q=80&w=1000\" alt=\"Smart City Traffic\" style=\"width:100%; border-radius:8px; margin: 15px 0;\">\n    \n    <div style=\"background-color: #f1f8ff; border-left: 5px solid #0366d6; padding: 15px; border-radius: 5px;\">\n        <strong>Thử nghiệm thực tế:</strong> Làn sóng \"đèn xanh rải thảm\" được tạo ra bởi AI đã giúp cắt giảm trung bình 18 phút di chuyển cho một lượt đi lại giờ cao điểm, giúp tiết kiệm hàng triệu giờ lao động mỗi năm cho cư dân.\n    </div>\n</div>','Dự án Thành phố thông minh sử dụng hệ thống Trí tuệ nhân tạo tối ưu hóa lưu lượng giao thông đem lại những lợi ích thiết thực.','uploads/images/photo-1542744173-8e7e53415bb0.jpg',1,1,2,'PUBLISHED',1836,2,0,100016,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(13,'Ô nhiễm vi nhựa đã xuất hiện trong mưa: Báo động môi trường toàn cầu','<article class=\"health-environment-content\">\n    <h2 style=\"color: #c0392b;\">Báo động đỏ cho nhân loại</h2>\n    <p>Nếu bạn nghĩ rằng ô nhiễm nhựa chỉ xảy ra ở dưới đáy đại dương, thì báo cáo nghiên cứu không khí mới nhất vừa dội gáo nước lạnh: <strong>Vi nhựa (Microplastics)</strong> đang rơi xuống ngay giữa những khu vực hẻo lánh nhất dưới dạng hạt mưa.</p>\n    \n    <img src=\"https://images.unsplash.com/photo-1611273426858-450d8e3c9cce?auto=format&fit=crop&q=80&w=1000\" alt=\"Plastic Pollution\" style=\"width:100%; height: 350px; object-fit: cover; border-radius:12px; margin: 20px 0;\">\n    \n    <h3>Vòng tuần hoàn khép kín độc hại</h3>\n    <p>Rác thải nhựa từ sinh hoạt bị phân rã, bốc hơi theo gió, hợp lại cùng độ ẩm trong tầng đối lưu và rửa trôi xuống lòng đất, len lỏi vô tình vào chuỗi thức ăn tự nhiên và xâm nhập vào cơ thể con người với nguy cơ tiềm tàng về viêm nhiễm hạt mịn (nano-level poisoning).</p>\n    \n    <h3>Hành động ngay lập tức</h3>\n    <p>Các chuyên gia kêu gọi việc cấm phân phối hoàn toàn bao bì nhựa xốp, chai nhựa dùng một lần. Việc quản lý tái chế nhựa giờ đây không chỉ là \"sống xanh\", mà là sự bắt buộc sinh tồn cho chính sinh mạng thế hệ tương lai.</p>\n</article>','Hiện tượng hạt Vi Nhựa rơi cùng mưa gióng lên hồi chuông về vòng tuần hoàn ô nhiễm lan rộng và đe dọa sinh học tiềm ẩn.','uploads/images/photo-1530497610245-94d3c16cda28.jpg',2,1,5,'PUBLISHED',6003,1,0,0,'2026-03-02 16:15:28','2026-03-02 16:15:28'),(61,'hahah','','','',2,1,NULL,'ARCHIVED',0,0,0,0,NULL,'2026-03-20 13:03:16');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Technology','Công nghệ và Khoa học máy tính'),(2,'Politics','Chính trị và Ngoại giao'),(3,'Health','Sức khỏe, Y tế và Đời sống'),(4,'Science','Khoa học Không gian và Tự nhiên'),(5,'Environment','Môi trường và Khí hậu'),(6,'Thể thao','tin tức thể thao'),(7,'Quốc phòng An ninh',''),(8,'Khác','Các chủ để chưa được phân loại');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_likes`
--

DROP TABLE IF EXISTS `comment_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_likes` (
  `user_id` bigint NOT NULL,
  `comment_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`comment_id`),
  KEY `comment_id` (`comment_id`),
  CONSTRAINT `comment_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_likes_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_likes`
--

LOCK TABLES `comment_likes` WRITE;
/*!40000 ALTER TABLE `comment_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_likes` ENABLE KEYS */;
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
  `parent_id` bigint DEFAULT NULL,
  `status` enum('NEUTRAL','HIDDEN','DELETED') DEFAULT 'NEUTRAL',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `likes_count` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`),
  KEY `user_id` (`user_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'sai sự thật r',2,2,NULL,'NEUTRAL','2026-03-18 11:48:01',0),(2,'Bài viết này rất phiến diện và thiếu khách quan!',1,3,NULL,'NEUTRAL','2026-03-19 13:00:00',0),(3,'Nội dung này vi phạm bản quyền của tôi, yêu cầu gỡ bỏ ngay lập tức!',2,4,NULL,'HIDDEN','2026-03-19 14:00:00',7),(4,'Tác giả chả biết gì về công nghệ mà cũng viết báo.',3,6,NULL,'NEUTRAL','2026-03-19 15:00:00',0),(5,'Thật là một trò đùa, tin này cũ rích rồi.',1,9,NULL,'NEUTRAL','2026-03-19 15:30:00',0),(9,'thiệt ko đó',2,30,3,'NEUTRAL','2026-03-20 19:48:56',0);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_traffic`
--

DROP TABLE IF EXISTS `daily_traffic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_traffic` (
  `date` date NOT NULL,
  `view_count` int DEFAULT '0',
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_traffic`
--

LOCK TABLES `daily_traffic` WRITE;
/*!40000 ALTER TABLE `daily_traffic` DISABLE KEYS */;
INSERT INTO `daily_traffic` VALUES ('2026-03-10',450),('2026-03-11',620),('2026-03-12',380),('2026-03-13',890),('2026-03-14',1150),('2026-03-15',740),('2026-03-16',1500),('2026-03-17',2100),('2026-03-18',1850),('2026-03-19',2400),('2026-03-20',862),('2026-03-21',14);
/*!40000 ALTER TABLE `daily_traffic` ENABLE KEYS */;
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
  `type` enum('LIKE','DISLIKE','BOOKMARK','VIEW') NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `interactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `interactions_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interactions`
--

LOCK TABLES `interactions` WRITE;
/*!40000 ALTER TABLE `interactions` DISABLE KEYS */;
INSERT INTO `interactions` VALUES (2,30,2,'LIKE','2026-03-19 16:38:54'),(5,30,13,'LIKE','2026-03-20 04:42:34'),(8,30,1,'DISLIKE','2026-03-20 05:42:13'),(10,3,1,'VIEW','2026-03-10 07:35:37'),(11,3,2,'VIEW','2026-03-10 07:35:37'),(12,3,3,'VIEW','2026-03-11 07:35:37'),(13,3,4,'VIEW','2026-03-11 07:35:37'),(14,3,5,'VIEW','2026-03-12 07:35:37'),(15,3,1,'VIEW','2026-03-12 07:35:37'),(16,3,2,'VIEW','2026-03-13 07:35:37'),(17,3,3,'VIEW','2026-03-13 07:35:37'),(18,3,4,'VIEW','2026-03-14 07:35:37'),(19,3,5,'VIEW','2026-03-14 07:35:37'),(20,3,1,'VIEW','2026-03-15 07:35:37'),(21,3,2,'VIEW','2026-03-15 07:35:37'),(22,3,3,'VIEW','2026-03-16 07:35:37'),(23,3,4,'VIEW','2026-03-16 07:35:37'),(24,3,5,'VIEW','2026-03-17 07:35:37'),(25,3,1,'VIEW','2026-03-17 07:35:37'),(26,3,2,'VIEW','2026-03-18 07:35:37'),(27,3,3,'VIEW','2026-03-18 07:35:37'),(28,3,4,'VIEW','2026-03-19 07:35:37'),(29,3,5,'VIEW','2026-03-19 07:35:37'),(30,3,1,'VIEW','2026-03-20 07:35:37'),(31,3,1,'VIEW','2026-03-10 07:39:44'),(32,3,2,'VIEW','2026-03-10 07:39:44'),(33,3,3,'VIEW','2026-03-11 07:39:44'),(34,3,4,'VIEW','2026-03-11 07:39:44'),(35,3,5,'VIEW','2026-03-12 07:39:44'),(36,3,1,'VIEW','2026-03-12 07:39:44'),(37,3,2,'VIEW','2026-03-13 07:39:44'),(38,3,3,'VIEW','2026-03-13 07:39:44'),(39,3,4,'VIEW','2026-03-14 07:39:44'),(40,3,5,'VIEW','2026-03-14 07:39:44'),(41,3,1,'VIEW','2026-03-15 07:39:44'),(42,3,2,'VIEW','2026-03-15 07:39:44'),(43,3,3,'VIEW','2026-03-16 07:39:44'),(44,3,4,'VIEW','2026-03-16 07:39:44'),(45,3,5,'VIEW','2026-03-17 07:39:44'),(46,3,1,'VIEW','2026-03-17 07:39:44'),(47,3,2,'VIEW','2026-03-18 07:39:44'),(48,3,3,'VIEW','2026-03-18 07:39:44'),(49,3,4,'VIEW','2026-03-19 07:39:44'),(50,3,5,'VIEW','2026-03-19 07:39:44'),(51,3,1,'VIEW','2026-03-20 07:39:44'),(53,1,1,'VIEW','2026-03-19 17:00:00'),(54,1,2,'VIEW','2026-03-18 17:00:00'),(55,1,3,'VIEW','2026-03-17 17:00:00'),(56,1,4,'VIEW','2026-03-16 17:00:00'),(57,1,5,'VIEW','2026-03-15 17:00:00'),(58,1,1,'VIEW','2026-03-18 17:00:00'),(59,1,2,'VIEW','2026-03-17 17:00:00'),(60,3,2,'LIKE','2026-03-20 12:39:35'),(61,31,12,'VIEW','2026-03-20 12:48:52'),(62,31,12,'LIKE','2026-03-20 12:49:43'),(64,3,1,'LIKE','2026-03-20 13:01:52'),(65,3,7,'LIKE','2026-03-20 13:02:41'),(66,3,9,'LIKE','2026-03-20 13:09:36'),(67,30,9,'VIEW','2026-03-20 15:41:48'),(68,30,1,'VIEW','2026-03-20 15:47:17'),(71,30,1,'VIEW','2026-03-20 15:51:56'),(73,30,1,'BOOKMARK','2026-03-20 15:52:00'),(74,2,5,'LIKE','2026-03-20 16:31:18'),(75,2,7,'LIKE','2026-03-20 16:31:43'),(76,30,7,'LIKE','2026-03-20 16:32:05'),(77,2,12,'LIKE','2026-03-20 16:33:32'),(78,2,12,'VIEW','2026-03-20 16:33:35'),(89,30,2,'VIEW','2026-03-20 19:55:28');
/*!40000 ALTER TABLE `interactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,2,'Lượt Thích Mới','⭐ Health Expert vừa nhấn Thích bài viết \'Dự luật \"Làm việc 4 ngày/tuần\" được thông qua tại Liên minh Châu Âu\'.','LIKE',1,'/user/article.jsp?id=9','2026-03-20 13:09:36'),(2,2,'Bài Viết Đã Được Duyệt','✅ Xin chúc mừng! Bài viết \'Khám phá đột phá mới trong công nghệ y tế: Nanobot điều trị ung thư\' đã được phê duyệt và xuất bản lên trang chủ.','ARTICLE',1,'/user/article.jsp?id=2','2026-03-20 13:14:31'),(3,2,'Bài Viết Bị Từ Chối','❌ Rất tiếc! Bài biên tập \'Khám phá đột phá mới trong công nghệ y tế: Nanobot điều trị ung thư\' của bạn không đạt yêu cầu. Lý do: Nội dung vi phạm chính sách','ARTICLE',1,'/journalist/create-article?id=2','2026-03-20 13:16:15'),(4,2,'Lượt Thích Mới','Hồ Ngũ Đạt vừa nhấn Thích bài viết \'Sự thật về chế độ ăn nhịn ăn gián đoạn (Intermittent Fasting)\'.','LIKE',1,'/user/article?id=7','2026-03-20 16:32:05'),(5,1,'Lượt Thích Mới','Tech Writer vừa nhấn Thích bài viết \'Thành phố Thông minh: Kế hoạch biến đổi hệ thống giao thông công cộng\'.','LIKE',1,'/user/article?id=12','2026-03-20 16:33:32');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `target_type` enum('ARTICLE','COMMENT') NOT NULL,
  `target_id` bigint NOT NULL,
  `reporter_id` bigint DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `details` text,
  `status` enum('PENDING','RESOLVED','DISMISSED') DEFAULT 'PENDING',
  `problematic_snippet` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_reports_reporter` (`reporter_id`),
  CONSTRAINT `fk_reports_reporter` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,'ARTICLE',1,2,'Fake News','This article contains unverified claims.','PENDING','...unconfirmed reports from secret government insiders...','2026-03-19 03:00:00'),(2,'ARTICLE',2,4,'Plagiarism','Copied from a medical blog without citation.','PENDING','Nanobots are programmed to identify protein signatures...','2026-03-19 04:30:00'),(3,'ARTICLE',3,3,'Sensationalism','Clickbait title and exaggerated findings.','PENDING','Glassmorphism is the only way to design for 2026...','2026-03-19 05:45:00'),(4,'COMMENT',2,1,'Hate Speech','The user is being toxic and insulting.','PENDING','Bài viết này rất phiến diện và thiếu khách quan!','2026-03-19 06:10:00'),(5,'COMMENT',4,2,'Harassment','Insulting the author\'s knowledge.','PENDING','Tác giả chả biết gì về công nghệ mà cũng viết báo.','2026-03-19 08:15:00'),(6,'COMMENT',1,3,'Inaccurate','Sai thông tin thực tế.','PENDING','sai sự thật r','2026-03-19 09:00:00'),(7,'COMMENT',1,6,'Spam','Bình luận lặp lại.','PENDING','sai sự thật r','2026-03-19 09:10:00'),(8,'COMMENT',1,9,'Harassment','Kích động thù hận.','PENDING','sai sự thật r','2026-03-19 09:20:00'),(9,'COMMENT',1,10,'Irrelevant','Không liên quan đến bài viết.','PENDING','sai sự thật r','2026-03-19 09:30:00'),(10,'COMMENT',1,11,'Other','Lý do khác.','PENDING','sai sự thật r','2026-03-19 09:40:00'),(11,'COMMENT',2,12,'Offensive','Lời lẽ không phù hợp.','PENDING','Bài viết này rất phiến diện và thiếu khách quan!','2026-03-19 10:00:00'),(12,'COMMENT',2,13,'Spam','Tài khoản ảo report.','PENDING','Bài viết này rất phiến diện và thiếu khách quan!','2026-03-19 10:05:00'),(13,'COMMENT',2,15,'Inaccurate','Thông tin sai lệch.','PENDING','Bài viết này rất phiến diện và thiếu khách quan!','2026-03-19 10:10:00'),(14,'COMMENT',2,16,'Hate Speech','Ghét bỏ tác giả.','PENDING','Bài viết này rất phiến diện và thiếu khách quan!','2026-03-19 10:15:00'),(15,'COMMENT',3,17,'Copyright','Vi phạm bản quyền.','RESOLVED','Nội dung này vi phạm bản quyền của tôi...','2026-03-19 11:00:00'),(16,'COMMENT',3,18,'Irrelevant','Rác.','RESOLVED','Nội dung này vi phạm bản quyền của tôi...','2026-03-19 11:10:00'),(17,'COMMENT',3,20,'Spam','Spam gỡ bài.','RESOLVED','Nội dung này vi phạm bản quyền của tôi...','2026-03-19 11:20:00'),(18,'COMMENT',4,21,'Bullying','Bắt nạt tác giả.','PENDING','Tác giả chả biết gì về công nghệ mà cũng viết báo.','2026-03-19 12:00:00'),(19,'COMMENT',4,22,'Offensive','Xúc phạm kiến thức.','PENDING','Tác giả chả biết gì về công nghệ mà cũng viết báo.','2026-03-19 12:10:00'),(20,'COMMENT',4,23,'Misinformation','Hiểu sai nội dung.','PENDING','Tác giả chả biết gì về công nghệ mà cũng viết báo.','2026-03-19 12:20:00'),(21,'COMMENT',5,24,'Irrelevant','Chả liên quan.','PENDING','Thật là một trò đùa, tin này cũ rích rồi.','2026-03-19 13:00:00'),(22,'COMMENT',5,30,'Spam','Nội dung vô nghĩa.','PENDING','Thật là một trò đùa, tin này cũ rích rồi.','2026-03-19 13:10:00'),(23,'COMMENT',1,4,'Spam','Duplicate report.','PENDING','sai sự thật r','2026-03-19 14:00:00'),(24,'COMMENT',2,3,'Hate Speech','Toxic behavior throughout the thread.','PENDING','Bài viết này rất phiến diện và thiếu khách quan!','2026-03-19 14:10:00'),(25,'COMMENT',5,2,'Outdated','Tin cũ rồi.','PENDING','Thật là một trò đùa, tin này cũ rích rồi.','2026-03-19 14:20:00'),(26,'ARTICLE',2,30,'Nội dung sai sự thật','Không đứng nội dung','PENDING','','2026-03-20 19:53:09'),(27,'COMMENT',3,30,'Bắt nạt/Quấy rối','ngôn từ lăng mạ','RESOLVED','','2026-03-20 19:53:25');
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
-- Table structure for table `system_settings`
--

DROP TABLE IF EXISTS `system_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(255) NOT NULL,
  `setting_value` text,
  `description` varchar(255) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_settings`
--

LOCK TABLES `system_settings` WRITE;
/*!40000 ALTER TABLE `system_settings` DISABLE KEYS */;
INSERT INTO `system_settings` VALUES (1,'gemini_api_key','','Gemini AI API Key','2026-03-20 17:10:16');
/*!40000 ALTER TABLE `system_settings` ENABLE KEYS */;
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
  `status` enum('ACTIVE','PENDING','BANNED','SUSPENDED','REJECTED','DELETED') DEFAULT 'ACTIVE',
  `avatar_url` varchar(500) DEFAULT NULL,
  `bio` text,
  `experience_years` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin@neuralnews.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Hệ thống Admin',3,'ACTIVE',NULL,'System administrator of NexusAI',10,'2026-03-02 16:15:17'),(2,'tech.writer@neuralnews.com','$2a$10$l/7op9LK5LSL8IVVjeJg1Onb4IFUIyuOjEPstVtCPE6gIUwisp0Y6','Tech Writer',2,'ACTIVE',NULL,'Senior tech journalist with focus on AI.',5,'2026-03-02 16:15:17'),(3,'health.expert@neuralnews.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Health Expert',1,'ACTIVE',NULL,'Regular user learning about AI',0,'2026-03-02 16:15:17'),(4,'nguyengiathu24052004@gmail.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Nguyễn Gia Thụ',2,'ACTIVE',NULL,NULL,0,'2026-03-03 11:50:55'),(6,'testuser2@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Trần Hùng',2,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 2',0,'2026-03-14 08:59:59'),(9,'testuser5@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đỗ Bình',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 5',0,'2026-03-10 21:39:59'),(10,'testuser6@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đỗ Hạnh',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 6',0,'2026-03-09 17:53:19'),(11,'testuser7@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Nguyễn Chí',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 7',0,'2026-03-08 14:06:39'),(12,'testuser8@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Phan Chí',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 8',0,'2026-03-07 10:19:59'),(13,'testuser9@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Vũ Hùng',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 9',0,'2026-03-06 06:33:19'),(14,'testuser10@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đỗ Bình',1,'BANNED',NULL,'Tôi là người dùng thử nghiệm số 10',0,'2026-03-05 02:46:39'),(15,'testuser11@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Trần Linh',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 11',0,'2026-03-03 22:59:59'),(16,'testuser12@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đặng Linh',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 12',0,'2026-03-02 19:13:19'),(17,'testuser13@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đặng Hạnh',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 13',0,'2026-03-01 15:26:39'),(18,'testuser14@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Nguyễn Linh',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 14',0,'2026-02-28 11:39:59'),(19,'testuser15@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đặng Dũng',1,'BANNED',NULL,'Tôi là người dùng thử nghiệm số 15',0,'2026-02-27 07:53:19'),(20,'testuser16@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Bùi Kiên',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 16',0,'2026-02-26 04:06:39'),(21,'testuser17@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Đỗ Kiên',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 17',0,'2026-02-25 00:19:59'),(22,'testuser18@example.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Hoàng Linh',1,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 18',0,'2026-02-23 20:33:19'),(23,'pending.journalist@news.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Nhà Báo Đang Chờ',2,'ACTIVE',NULL,'Kinh nghiệm 5 năm, muốn xin làm nhà báo.',0,'2026-02-22 16:46:39'),(24,'active.journalist@news.com','$2a$10$BN9dzhy5pMUbKOJBMlbOk.L7U.P4ksttd4PoZRzrGvMMbxHs5zAS.','Nhà Báo Hoạt Động',2,'ACTIVE',NULL,'Tôi là người dùng thử nghiệm số 20',0,'2026-02-21 12:59:59'),(25,'lehoangphuc@gmail.com','$2a$10$PCiOWCoGIhfaSPE9/Qvs/.aSsuPSu2upl22i3v.r9qN69i2SItCHS','Lê Hoàng Phúc',1,'ACTIVE',NULL,NULL,0,'2026-03-17 15:18:24'),(28,'nguyenvana@gmail.com','$2a$10$VknA9RVyIqTmFiKe6Py0PepjALSN29SKaIej7sf6Da03FoMy5tDQi','nguyễn Văn A',1,'REJECTED',NULL,'asaas',2,'2026-03-18 06:31:14'),(29,'xyz@gmail.com','$2a$10$/OMJVG5J0P4Mftd/JurCk..ZPv5TjdYR27cHYcAkoGakkVi8.5Sb6','xyz',2,'PENDING',NULL,'sấ',3,'2026-03-18 06:55:32'),(30,'ngudat@gmail.com','$2a$10$6wQkqLi2RjlhYTBz4.LCF.ydYJgrmO8SzB2O/7ITsdop1wUpAPa1u','Hồ Ngũ Đạt',2,'ACTIVE',NULL,'Tui đã làm rất nhiều báo',1,'2026-03-18 11:53:28'),(31,'reader_final@test.com','$2a$10$9Z.15nBXBY73cYe7o41WmeXF/2BoltmR9UXcSlJSiliO//rJbYyKu','Test Reader',1,'ACTIVE',NULL,NULL,0,'2026-03-20 12:47:32');
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

-- Dump completed on 2026-03-21  3:07:01

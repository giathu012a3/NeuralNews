-- Script chèn dữ liệu mẫu cho bảng Categories và Articles
-- Phù hợp với yêu cầu lưu trữ toàn bộ bài báo dưới dạng HTML thay vì chia nhỏ thành từng phần.

-- Thêm các danh mục mới
INSERT INTO categories (id, name, description) VALUES 
(1, 'Technology', 'Công nghệ và Khoa học máy tính'), 
(2, 'Politics', 'Chính trị và Ngoại giao'), 
(3, 'Health', 'Sức khỏe, Y tế và Đời sống'),
(4, 'Science', 'Khoa học Không gian và Tự nhiên'),
(5, 'Environment', 'Môi trường và Khí hậu')
ON DUPLICATE KEY UPDATE name=VALUES(name), description=VALUES(description);

-- Thêm quyền hạn (Roles)
INSERT INTO roles (id, name, description) VALUES
(1, 'USER', 'Người dùng bình thường'),
(2, 'JOURNALIST', 'Nhà báo'),
(3, 'ADMIN', 'Quản trị viên')
ON DUPLICATE KEY UPDATE name=VALUES(name), description=VALUES(description);

-- Thêm Tác giả/Người dùng rỗng (Users) để tham chiếu tác giả bài viết
INSERT INTO users (id, email, password_hash, full_name, role_id, status) VALUES
(1, 'admin@neuralnews.com', 'hashed_pw', 'Hệ thống Admin', 3, 'ACTIVE'),
(2, 'tech.writer@neuralnews.com', 'hashed_pw', 'Tech Writer', 2, 'ACTIVE'),
(3, 'health.expert@neuralnews.com', 'hashed_pw', 'Health Expert', 2, 'ACTIVE')
ON DUPLICATE KEY UPDATE email=VALUES(email), full_name=VALUES(full_name);

INSERT INTO articles (title, content, summary, image_url, author_id, category_id, status, views, published_at) VALUES

-- Bài viết 1: Công nghệ (Technology)
('Sự bùng nổ của Trí tuệ Nhân tạo năm 2026', 
'<div class="article-html-content">
    <h2>1. Kỷ nguyên mới của công nghệ</h2>
    <p>Năm 2026 đánh dấu một bước ngoặt lớn trong sự phát triển của <strong>Trí tuệ Nhân tạo (AI)</strong>. Các mô hình ngôn ngữ lớn không chỉ tạo ra văn bản tự nhiên mà còn có khả năng lập luận phức tạp hơn bao giờ hết.</p>
    <img src="https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=1000" alt="AI Technology" style="max-width:100%; height:auto; border-radius:8px; margin:15px 0;">
    <h3>2. Tác động đến đời sống và công việc</h3>
    <p>Các công cụ AI giờ đây được tích hợp sâu vào mọi nền tảng làm việc, từ việc hỗ trợ lập trình, sáng tạo nghệ thuật đến y tế giáo dục. Câu hỏi đặt ra không còn là <em>"Trí tuệ nhân tạo có thay thế con người hay không?"</em> mà là <em>"Chúng ta ứng dụng chúng như thế nào cho hiệu quả?"</em>.</p>
    <blockquote style="border-left: 4px solid #007bff; padding-left: 15px; font-style: italic; color: #555; background: #f8f9fa; padding: 15px; border-radius: 4px;">
        "AI sẽ không thay thế bạn. Người sử dụng AI sẽ thay thế bạn."
    </blockquote>
    <p>Theo báo cáo mới nhất, năng suất lao động trong các ngành công nghệ đã tăng 40% nhờ vào sự hỗ trợ của các trợ lý ảo.</p>
</div>', 
'Sự phát triển vượt bậc của AI trong năm 2026 và tác động của nó tới tương lai công việc.', 
'https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&q=80&w=800', 
2, 1, 'PUBLISHED', 1500, CURRENT_TIMESTAMP),

-- Bài viết 2: Y tế (Health)
('Khám phá đột phá mới trong công nghệ y tế: Nanobot điều trị ung thư', 
'<article class="health-article">
    <h2>Khởi đầu kỷ nguyên Nanobot trong y tế</h2>
    <p>Các nhà nghiên cứu tại Viện Công nghệ Y sinh vừa công bố thử nghiệm thành công thế hệ <strong>Nanobot (robot nano)</strong> đầu tiên có khả năng tiêu diệt tế bào ung thư mà không gây tổn hại đến các mô lành xung quanh.</p>
    
    <div style="background-color: #e8f5e9; padding: 15px; border-left: 4px solid #4caf50; margin: 20px 0; border-radius: 0 8px 8px 0;">
        <strong>Thông tin nổi bật:</strong> Phương pháp mới này giảm thiểu tác dụng phụ lến đến 90% so với hóa trị truyền thống và tăng tốc độ hồi phục lên gấp 3 lần.
    </div>
    
    <img src="https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&q=80&w=1000" alt="Medical Lab" style="width:100%; height:auto; border-radius:8px; margin: 15px 0;">
    
    <h3>Cơ chế hoạt động</h3>
    <p>Đội ngũ chuyên gia đã lập trình các robot siêu nhỏ này để nhận diện đặc điểm protein riêng biệt của khối u. Khi tiếp cận, chúng sẽ:</p>
    <ul style="line-height: 1.8;">
        <li>Gắn kết với tế bào mang bệnh với độ chính xác tuyệt đối.</li>
        <li>Bơm trực tiếp thuốc đặc trị với liều lượng siêu nhỏ vào bên trong tế bào.</li>
        <li>Tự phân hủy an toàn qua hệ bài tiết sau khi hoàn thành nhiệm vụ.</li>
    </ul>

    <h3>Tương lai của điều trị y khoa</h3>
    <p>Mặc dù vẫn đang trong giai đoạn thử nghiệm lâm sàng chuyên sâu, nhưng những kết quả ban đầu đầy hứa hẹn này mở ra một tương lai tươi sáng, mang lại hy vọng mới cho hàng triệu bệnh nhân trên toàn cầu trong cuộc chiến chống lại căn bệnh nan y.</p>
</article>', 
'Bước đột phá y học với việc ứng dụng Nanobot vào quá trình nhắm mục tiêu và tiêu diệt khối u, giảm thiểu tác dụng phụ.', 
'https://images.unsplash.com/photo-1530497610245-94d3c16cda28?auto=format&fit=crop&q=80&w=800', 
2, 3, 'PUBLISHED', 3200, CURRENT_TIMESTAMP),

-- Bài viết 3: Công nghệ Web (Technology)
('Thiết kế Web 2026: Sự lên ngôi của UI Động và Glassmorphism', 
'<div class="tech-article-content">
    <h2 style="color: #2c3e50;">Xu hướng thiết kế tương lai</h2>
    <p>Năm nay, xu hướng thiết kế web đang dịch chuyển mạnh mẽ từ Flat Design (thiết kế phẳng) truyền thống sang các giao diện đậm chất tương tác và chân thực hơn. Nổi bật nhất chính là sự kết hợp giữa <strong>Glassmorphism</strong> (hiệu ứng kính mờ) và <strong>Dynamic UI</strong> (giao diện khả biến).</p>
    
    <h3>Glassmorphism là gì?</h3>
    <p>Đây là phong cách thiết kế sử dụng hiệu ứng bóng mờ đằng sau các thành phần giao diện, tạo cảm giác như bạn đang nhìn xuyên qua một tấm kính. Hiệu ứng này mang lại chiều sâu và tính hiện đại cho website, đặc biệt hiệu quả khi sử dụng trên các nền màu sắc sống động (vibrant colors).</p>
    <img src="https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?auto=format&fit=crop&q=80&w=1000" alt="Web Design Trend" style="width:100%; border-radius:12px; margin: 20px 0; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
    
    <h3>Tầm quan trọng của UI Động</h3>
    <p>Bên cạnh yếu tố thẩm mỹ, UI hiện nay phải đáp ứng tính tương tác theo chuyển động chuột (micro-interactions) và tối ưu hóa trải nghiệm cá nhân (tự động chuyển đổi Dark/Light mode dựa theo thời gian biểu người dùng, tự điều chỉnh font size). Nếu một website chỉ hiển thị nội dung một cách tĩnh lặng thì sẽ rất khó giữ chân người dùng trong bối cảnh nội dung số đang bão hòa.</p>
    
    <div class="code-snippet-example" style="background:#282c34; color:#abb2bf; padding:20px; border-radius:8px; font-family:''Courier New'', Courier, monospace; margin-top:20px; overflow-x: auto;">
        <span style="color:#c678dd;">.glass-card</span> {<br>
        &nbsp;&nbsp;<span style="color:#d19a66;">background</span>: rgba(255, 255, 255, 0.05);<br>
        &nbsp;&nbsp;<span style="color:#d19a66;">backdrop-filter</span>: blur(15px);<br>
        &nbsp;&nbsp;<span style="color:#d19a66;">border-top</span>: 1px solid rgba(255, 255, 255, 0.2);<br>
        &nbsp;&nbsp;<span style="color:#d19a66;">border-left</span>: 1px solid rgba(255, 255, 255, 0.2);<br>
        &nbsp;&nbsp;<span style="color:#d19a66;">box-shadow</span>: 0 8px 32px 0 rgba(31, 38, 135, 0.37);<br>
        }
    </div>
</div>', 
'Khám phá các xu hướng thiết kế giao diện đình đám trong năm 2026, tập trung vào Glassmorphism và trải nghiệm vi mô.', 
'https://images.unsplash.com/photo-1507721999472-8ed4421c4af2?auto=format&fit=crop&q=80&w=800', 
1, 1, 'PUBLISHED', 850, CURRENT_TIMESTAMP),

-- Bài viết 4: Sức khỏe tinh thần (Health)
('Thiền định kỹ thuật số: Giải pháp giảm stress cho thế hệ Gen Z', 
'<article class="health-article">
    <h2>Sự quá tải thông tin và nhu cầu phục hồi</h2>
    <p>Trong thời đại mà màn hình điện thoại chiếm hơn 8 giờ mỗi ngày của một người trẻ bình thường, sự gia tăng của các vấn đề sức khỏe tinh thần như lo âu và trầm cảm là không thể tránh khỏi. Để đối phó, phong trào <strong>Thiền định kỹ thuật số (Digital Mindfulness)</strong> đang trở thành cứu cánh mới.</p>
    <img src="https://images.unsplash.com/photo-1593811167562-9cef47bfc3d7?auto=format&fit=crop&q=80&w=1000" alt="Meditation App" style="width:100%; border-radius:12px; margin: 15px 0;">
    <h3>Ứng dụng công nghệ để "cai nghiện" công nghệ</h3>
    <p>Thay vì từ bỏ hoàn toàn thiết bị điện tử, các ứng dụng thiền hiện nay sử dụng âm thanh không gian (Spatial Audio) và giao diện tối giản để hướng dẫn người dùng tập thở sâu và thư giãn ngay tại bàn làm việc.</p>
    <ul>
        <li>Theo dõi nhịp tim qua Camera hoặc Smartwatch.</li>
        <li>Cá nhân hóa lộ trình dựa trên mức độ stress hằng ngày.</li>
        <li>Tích hợp các bài tập dãn cơ ngắn 5 phút mỗi 2 giờ.</li>
    </ul>
</article>', 
'Tìm hiểu về phong trào Thiền định kỹ thuật số giúp thế hệ trẻ vượt qua áp lực và lo âu từ quá tải thông tin.', 
'https://images.unsplash.com/photo-1593811167562-9cef47bfc3d7?auto=format&fit=crop&q=80&w=800', 
1, 3, 'PUBLISHED', 2100, CURRENT_TIMESTAMP),

-- Bài viết 5: Chính trị & Kinh tế (Politics)
('Hội nghị Thượng đỉnh G20 năm 2026: Trọng tâm về năng lượng xanh', 
'<div class="politics-news-content">
    <h2>Cam kết toàn cầu về giảm phát thải</h2>
    <p>Hội nghị Thượng đỉnh G20 vừa diễn ra tại Geneva đã chứng kiến một cam kết lịch sử từ các quốc gia thành viên: Giảm 60% lượng khí thải carbon vào năm 2035. Đây là bước đi tham vọng nhất từ trước tới nay nhằm đối phó với hiện tượng biến đổi khí hậu đang diễn biến phức tạp.</p>
    <img src="https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&q=80&w=1000" alt="G20 Summit" style="width:100%; height:auto; border-radius:8px; margin: 15px 0;">
    <h3>Quỹ hỗ trợ chuyển đổi năng lượng</h3>
    <p>Điểm nhấn của hội nghị là quyết định thành lập <em>Quỹ Chuyển đổi Năng lượng Toàn cầu</em> trị giá 2 nghìn tỷ USD, nhằm hỗ trợ các quốc gia đang phát triển xây dựng cơ sở hạ tầng năng lượng mặt trời và điện gió.</p>
    <blockquote style="border-left: 5px solid #d9534f; padding: 15px; margin: 20px 0; background-color: #fdf2f2;">
        "Đã đến lúc chúng ta ngừng thỏa hiệp với tương lai của hành tinh." - Tổng Thư ký LHQ phát biểu.
    </blockquote>
</div>', 
'Các nhà lãnh đạo G20 thống nhất cam kết lịch sử về giảm phát thải carbon và thành lập quỹ hỗ trợ năng lượng xanh.', 
'https://images.unsplash.com/photo-1529107386315-e1a2ed48a620?auto=format&fit=crop&q=80&w=800', 
2, 2, 'PUBLISHED', 5400, CURRENT_TIMESTAMP),

-- Bài viết 6: Công nghệ Không gian (Technology)
('Tàu vũ trụ Artemis V chuẩn bị khởi hành mang theo căn cứ mặt trăng', 
'<article class="space-tech-article">
    <h2>Bước tiến mới trong công cuộc chinh phục không gian</h2>
    <p>Cơ quan vũ trụ NASA đã thông báo hoàn tất quá trình kiểm tra cuối cùng cho sứ mệnh <strong>Artemis V</strong>. Tham vọng của chuyến đi này không chỉ là đưa con người trở lại mặt trăng, mà còn là lắp ráp phần lõi của trạm nghiên cứu lâu dài mang tên <em>Lunar Gateway</em>.</p>
    
    <div style="background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; border-radius: 8px; margin: 20px 0;">
        <h3 style="margin-top:0;">Trạm Lunar Gateway có gì đặc biệt?</h3>
        <p>Đây sẽ là tiền đồn xa xôi nhất của nhân loại, sử dụng 100% năng lượng mặt trời kép và là bệ phóng cho các phi vụ thám hiểm Sao Hỏa trong thập kỷ tới.</p>
    </div>
    
    <img src="https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?auto=format&fit=crop&q=80&w=1000" alt="Spacecraft Launch" style="width:100%; border-radius:8px; margin-bottom: 15px;">
    <p>Các phi hành gia sẽ dành 45 ngày trên quỹ đạo mặt trăng để triển khai hệ thống robot tự hành, giúp đào xới và tìm kiếm nguồn nước băng giá tiềm năng dưới bề mặt.</p>
</article>', 
'Sứ mệnh Artemis V mang theo hy vọng và nền tảng cốt lõi cho việc xây dựng trạm nghiên cứu lâu dài trên Mặt Trăng.', 
'https://images.unsplash.com/photo-1541185933-ef5d8ed016c2?auto=format&fit=crop&q=80&w=800', 
1, 4, 'PUBLISHED', 4800, CURRENT_TIMESTAMP),

-- Bài viết 7: Dinh dưỡng (Health)
('Sự thật về chế độ ăn nhịn ăn gián đoạn (Intermittent Fasting)', 
'<div class="health-nutrition-content">
    <h2>Phong trào hay phương pháp khoa học?</h2>
    <p>Chế độ nhịn ăn gián đoạn (IF) như 16/8 hay 5:2 đã không còn xa lạ. Tuy nhiên, một nghiên cứu kéo dài 5 năm tại ĐH Y khoa Harvard vừa công bố đã làm rõ bức tranh về hiệu quả thực sự của phương pháp này.</p>
    
    <h3>Lợi ích đã được chứng minh</h3>
    <p>Các nhà khoa học xác nhận việc duy trì biểu đồ ăn uống nghiêm ngặt giúp cơ thể kích hoạt cơ chế <strong>Autophagy</strong> - quá trình tế bào tự "dọn dẹp" các thành phần hư hỏng, từ đó giảm nguy cơ mắc chứng Alzheimer và trẻ hóa tế bào.</p>
    
    <img src="https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=1000" alt="Healthy Food" style="width:100%; border-radius:12px; margin: 20px 0;">
    
    <h3>Những lầm tưởng phổ biến</h3>
    <ul>
        <li><em>Nhịn đói bằng mọi giá sẽ giảm cân:</em> Sự thật là tổng lượng calo nạp vào trong khung giờ được phép ăn mới quyết định kết quả.</li>
        <li><em>Phù hợp với tất cả mọi người:</em> Phụ nữ có thai, người có tiền sử dạ dày đặc biệt được khuyến cáo không nên áp dụng IF mà cần có sự tư vấn y khoa.</li>
    </ul>
</div>', 
'Phân tích khoa học khách quan từ nghiên cứu 5 năm về những lợi ích cũng như hiểu lầm xung quanh chế độ ăn IF.', 
'https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&q=80&w=800', 
2, 3, 'PUBLISHED', 2900, CURRENT_TIMESTAMP),

-- Bài viết 8: Bảo mật & Quyền riêng tư (Technology)
('Web3 và tương lai của danh tính số phi tập trung', 
'<div class="tech-crypto-article">
    <h2>Cuộc cách mạng quyền riêng tư</h2>
    <p>Người dùng Internet từ lâu đã chán ngấy việc các ông lớn công nghệ thu thập dữ liệu cá nhân của họ. Sự xuất hiện của <strong>Web3</strong> hứa hẹn giải quyết triệt để vấn đề này với mô hình <em>Danh tính phi tập trung (Decentralized Identity - DID)</em>.</p>
    
    <h3>DID hoạt động, như thế nào?</h3>
    <p>Thay vì sử dụng Google hoặc Facebook để đăng nhập vào một dịch vụ mới, người dùng sẽ tự nắm giữ chìa khóa mã hóa cá nhân trên thiết bị của mình.</p>
    <img src="https://images.unsplash.com/photo-1639762681485-074b7f4ec665?auto=format&fit=crop&q=80&w=1000" alt="Cyber Security" style="width:100%; border-radius:8px; margin: 15px 0;">
    <p>Một DID có thể sử dụng cơ chế bảo mật xác minh không tri thức (Zero-Knowledge Proofs). Ví dụ: Một trang web yêu cầu chứng minh bạn trên 18 tuổi. DID chỉ trả lời "Có" hoặc "Không", trình diễn xác thực hợp pháp, song hoàn toàn không bao giờ tiết lộ ngày sinh cụ thể của bạn.</p>
    
    <div style="padding: 15px; border: 2px dashed #6c757d; border-radius: 8px; margin-top: 20px;">
        <h4 style="margin:0 0 10px 0; color:#495057;">Tương lai không mật khẩu</h4>
        <p style="margin:0;">Với DID, người dùng quản lý quyền truy cập dữ liệu của chính mình như cách họ quản lý tiền trong ví. Việc bị rò rỉ cơ sở dữ liệu số lượng lớn từ các dịch vụ tập trung sẽ sớm chỉ còn là quá khứ.</p>
    </div>
</div>', 
'Thảo luận về cách mà Web3 cùng Danh tính phi tập trung (DID) thay đổi hoàn toàn cục diện bảo mật dữ liệu.', 
'https://images.unsplash.com/photo-1639762681485-074b7f4ec665?auto=format&fit=crop&q=80&w=800', 
1, 1, 'PUBLISHED', 1150, CURRENT_TIMESTAMP),

-- Bài viết 9: Chính trị Khu vực (Politics)
('Dự luật "Làm việc 4 ngày/tuần" được thông qua tại Liên minh Châu Âu', 
'<article class="politics-article">
    <h2>Một cuộc biểu quyết lịch sử</h2>
    <p>Hôm qua, Nghị viện Châu Âu đã thông qua dự luật yêu cầu các doanh nghiệp cung cấp tùy chọn chuyển đổi mô hình làm việc 4 ngày trên 1 tuần mà không bị cắt giảm lương. Dự luật sẽ chính thức có hiệu lực đồng bộ từ năm 2027.</p>
    
    <h3>Tác động đến nền kinh tế</h3>
    <p>Mặc dù vấp phải một số phản ứng lo ngại từ giới chủ đầu tư về nguy cơ làm chậm tốc độ tăng trưởng, tuy nhiên các báo cáo thí điểm từ Na Uy và Tây Ban Nha lại cho thấy kết quả trái ngược:</p>
    
    <table border="1" style="width:100%; border-collapse: collapse; margin: 20px 0; text-align: left;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th style="padding: 10px;">Chỉ số</th>
                <th style="padding: 10px;">Thay đổi</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td style="padding: 10px;">Năng suất nhân viên</td>
                <td style="padding: 10px; color: green; font-weight: bold;">+15%</td>
            </tr>
            <tr>
                <td style="padding: 10px;">Tỷ lệ nhân viên kiệt sức</td>
                <td style="padding: 10px; color: red; font-weight: bold;">-40%</td>
            </tr>
            <tr>
                <td style="padding: 10px;">Gắn bó với tổ chức</td>
                <td style="padding: 10px; color: green; font-weight: bold;">+25%</td>
            </tr>
        </tbody>
    </table>
    
    <img src="https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&q=80&w=1000" alt="Office Working" style="width:100%; border-radius:8px; margin: 15px 0;">
    <p>Dự luật hiện trở thành cột mốc mang tính tiên phong, khơi nguồn cảm hứng cho nhiều quốc gia Bắc Mỹ khác đang theo dõi sát sao mô hình này.</p>
</article>', 
'Nghị viện Châu Âu thông qua dự luật chính thức ưu tiên mô hình làm việc 4 ngày mỗi tuần, cân bằng công việc và đời sống.', 
'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&q=80&w=800', 
2, 2, 'PUBLISHED', 7600, CURRENT_TIMESTAMP),

-- Bài viết 10: Sức khỏe & Thể chất (Health)
('DNA cá nhân hóa: Chìa khóa vàng cho việc thiết kế bài tập thể thao', 
'<div class="health-fitness-content">
    <h2>Xóa mờ ranh giới "Một kích cỡ vừa cho tất cả"</h2>
    <p>Gần đây, lĩnh vực thể thao đón nhận xu hướng mới dựa trên hồ sơ di truyền học (DNA Profiling). Nghiên cứu cho thấy mã gen ảnh hưởng trực tiếp đến cấu trúc sợi cơ và tỷ lệ phục hồi, quyết định việc bạn hợp với bộ môn nào hơn.</p>
    
    <h3>Hai loại sợi cơ cơ bản</h3>
    <ul style="list-style-type: square;">
        <li><strong>Sợi cơ loại I (Co rút chậm):</strong> Bền bỉ, dùng nhiều oxy. Những người mang bộ gen nổi trội loại cơ này rất phù hợp với chạy marathon, đạp xe leo núi.</li>
        <li><strong>Sợi cơ loại II (Co rút nhanh):</strong> Tạo lực nổ mạnh. Những cá nhân này nên tập trung vào đẩy tạ nặng, võ thuật hoặc chạy nước rút (sprinting).</li>
    </ul>
    
    <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&q=80&w=1000" alt="Fitness Tracking" style="width:100%; border-radius:8px; margin: 15px 0;">
    
    <p>Thay vì ép buộc bản thân vào một chế độ khắc nghiệt chung chung do huấn luyện viên giao, giờ đây chỉ với một mẫu thử nước bọt đơn giản tại nhà, người dùng sẽ nhận được báo cáo về nguy cơ chấn thương kèm đề xuất lộ trình tập lý tưởng nhằm khai phá hoàn toàn tiềm năng sức mạnh sinh học.</p>
</div>', 
'Công nghệ lập hồ sơ DNA đang giúp xây dựng các chương trình thể chất riêng biệt đem lại hiệu quả tập luyện lớn hơn.', 
'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?auto=format&fit=crop&q=80&w=800', 
1, 3, 'PUBLISHED', 1550, CURRENT_TIMESTAMP),

-- Bài viết 11: Phát triển phần mềm (Technology)
('Rust đang tái định hình hệ điều hành thế hệ mới', 
'<div class="tech-programming-content">
    <h2>Sự dịch chuyển lớn ra khỏi C và C++</h2>
    <p>Sự nổi lên của ngôn ngữ lập trình <strong>Rust</strong> không còn là trào lưu nhất thời. Cả Microsoft, Linux Foundation và Google đều đang tái cấu trúc các phân hệ cốt lõi liên quan tới bảo mật bộ nhớ (memory safety) thành các module viết bằng ngôn ngữ này.</p>
    <img src="https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=1000" alt="Programming Code" style="width:100%; border-radius:8px; margin: 15px 0;">
    
    <h3>Bảo mật an toàn ngay từ trình biên dịch</h3>
    <p>Hơn 70% các lỗi bảo mật nghiêm trọng trên phần mềm truyền thống như Windows hay Android xuất phát từ cách quản lý bộ nhớ yếu kém. Điểm ăn tiền của Rust nằm ở công cụ Borrow Checker, cưỡng chế quy tắc biên dịch hà khắc khiến lập trình viên phải viết mã đúng và an toàn tuyệt đối từ lúc code.</p>
    
    <blockquote style="background: #2b2b2b; color: #a9b7c6; padding: 20px; font-family: monospace; border-radius: 8px;">
        fn main() {<br>
        &nbsp;&nbsp;println!("Chậm một phút lúc biên dịch để phần mềm an toàn mãi mãi!");<br>
        }
    </blockquote>
    <p>Hiện tại, mã nguồn của Linux Kernel đã chính thức chứa hơn 50,000 dòng mã Rust và con số này dự kiến gia tăng nhân đôi theo từng quý.</p>
</div>', 
'Tại sao các gã khổng lồ công nghệ lại đồng loạt đặt trọn niềm tin vào ngôn ngữ Rust để xây dựng lại nhân hệ điều hành.', 
'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&q=80&w=800', 
2, 1, 'PUBLISHED', 4120, CURRENT_TIMESTAMP),

-- Bài viết 12: Đô thị học (Politics / Tech)
('Thành phố Thông minh: Kế hoạch biến đổi hệ thống giao thông công cộng', 
'<div class="smart-city-article">
    <h2>Giao thông dưới sự quản lý của AI</h2>
    <p>Nhàm chán với cảnh kẹt xe kéo dài, chính quyền các đô thị lớn tại Châu Á đang lên kế hoạch triển khai đồng loạt nền tảng <em>City-Wide AI Traffic Control</em>. Trí tuệ nhân tạo sẽ kiểm soát chu kỳ đèn giao thông theo thời gian thực (Real-time Adaptive Control).</p>
    
    <h3>Hoạt động như thế nào?</h3>
    <p>Hệ thống hàng nghìn camera và cảm biến IoT được đặt dọc vỉa hè, thu thập lưu lượng phương tiện. Sau đó AI tự động dự báo dòng xe trong 15 phút tới để cân chỉnh số giây cho đèn xanh.</p>
    
    <img src="https://images.unsplash.com/photo-1449824913935-59a10b8dce00?auto=format&fit=crop&q=80&w=1000" alt="Smart City Traffic" style="width:100%; border-radius:8px; margin: 15px 0;">
    
    <div style="background-color: #f1f8ff; border-left: 5px solid #0366d6; padding: 15px; border-radius: 5px;">
        <strong>Thử nghiệm thực tế:</strong> Làn sóng "đèn xanh rải thảm" được tạo ra bởi AI đã giúp cắt giảm trung bình 18 phút di chuyển cho một lượt đi lại giờ cao điểm, giúp tiết kiệm hàng triệu giờ lao động mỗi năm cho cư dân.
    </div>
</div>', 
'Dự án Thành phố thông minh sử dụng hệ thống Trí tuệ nhân tạo tối ưu hóa lưu lượng giao thông đem lại những lợi ích thiết thực.', 
'https://images.unsplash.com/photo-1449824913935-59a10b8dce00?auto=format&fit=crop&q=80&w=800', 
1, 2, 'PUBLISHED', 1830, CURRENT_TIMESTAMP),

-- Bài viết 13: Sức khỏe cộng đồng (Health)
('Ô nhiễm vi nhựa đã xuất hiện trong mưa: Báo động môi trường toàn cầu', 
'<article class="health-environment-content">
    <h2 style="color: #c0392b;">Báo động đỏ cho nhân loại</h2>
    <p>Nếu bạn nghĩ rằng ô nhiễm nhựa chỉ xảy ra ở dưới đáy đại dương, thì báo cáo nghiên cứu không khí mới nhất vừa dội gáo nước lạnh: <strong>Vi nhựa (Microplastics)</strong> đang rơi xuống ngay giữa những khu vực hẻo lánh nhất dưới dạng hạt mưa.</p>
    
    <img src="https://images.unsplash.com/photo-1611273426858-450d8e3c9cce?auto=format&fit=crop&q=80&w=1000" alt="Plastic Pollution" style="width:100%; height: 350px; object-fit: cover; border-radius:12px; margin: 20px 0;">
    
    <h3>Vòng tuần hoàn khép kín độc hại</h3>
    <p>Rác thải nhựa từ sinh hoạt bị phân rã, bốc hơi theo gió, hợp lại cùng độ ẩm trong tầng đối lưu và rửa trôi xuống lòng đất, len lỏi vô tình vào chuỗi thức ăn tự nhiên và xâm nhập vào cơ thể con người với nguy cơ tiềm tàng về viêm nhiễm hạt mịn (nano-level poisoning).</p>
    
    <h3>Hành động ngay lập tức</h3>
    <p>Các chuyên gia kêu gọi việc cấm phân phối hoàn toàn bao bì nhựa xốp, chai nhựa dùng một lần. Việc quản lý tái chế nhựa giờ đây không chỉ là "sống xanh", mà là sự bắt buộc sinh tồn cho chính sinh mạng thế hệ tương lai.</p>
</article>', 
'Hiện tượng hạt Vi Nhựa rơi cùng mưa gióng lên hồi chuông về vòng tuần hoàn ô nhiễm lan rộng và đe dọa sinh học tiềm ẩn.', 
'https://images.unsplash.com/photo-1611273426858-450d8e3c9cce?auto=format&fit=crop&q=80&w=800', 
2, 5, 'PUBLISHED', 6000, CURRENT_TIMESTAMP);

# NeuralNews

Một nền tảng tin tức hiện đại được xây dựng bằng Java Servlet, JSP, JDBC và HTML/CSS/JS thuần túy.

Dự án áp dụng kiến trúc **Role-Based Access Control (RBAC) 1-N** tối ưu, kết hợp với cơ chế phân cấp quyền hạn (Role Hierarchy) được xử lý trực tiếp trong Java giúp tối giản hóa Database mà vẫn duy trì tính bảo mật cao.

## Công nghệ sử dụng (Tech Stack)

*   **Backend:** Java 17, Jakarta Servlet API, JDBC
*   **Frontend:** HTML5, CSS3, JavaScript (Vanilla), JSP
*   **Database:** MySQL 8.x
*   **Server:** Apache Tomcat 11
*   **Bảo mật:** BCrypt (mã hóa mật khẩu)

## Yêu cầu môi trường (Prerequisites)

*   **Java Development Kit (JDK):** Phiên bản 17 trở lên.
*   **Eclipse IDE:** Dành cho Enterprise Java và Web Developers.
*   **Apache Tomcat:** Phiên bản 11.
*   **MySQL Server:** Cài đặt sẵn và đang chạy.

## Hướng dẫn cài đặt (Installation Guide)

### 1. Thiết lập Database (MySQL)

Dự án sử dụng MySQL để lưu trữ dữ liệu. Bạn cần khởi tạo database và các bảng trước khi chạy code.

1.  Mở MySQL Workbench hoặc bất kỳ công cụ quản lý MySQL nào.
2.  Tạo một database mới tên là `neural_news`:
    ```sql
    CREATE DATABASE neural_news CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    USE neural_news;
    ```
3.  Tìm file `database/schema.sql` trong thư mục code.
4.  Copy toàn bộ nội dung file `schema.sql` và chạy (Execute) trong MySQL. File này sẽ tự động tạo cấu trúc bảng (1-N RBAC) và chèn sẵn một số dữ liệu mẫu (Admin, User, Journalist).
5.  Mở file `src/main/java/com/neuralnews/util/DBConnection.java` và cấu hình lại **DB_URL**, **USER**, **PASSWORD** cho khớp với MySQL của bạn máy bạn.

### 2. Import dự án vào Eclipse

Vì kho lưu trữ này không chứa các tệp cấu hình IDE, hãy làm theo các bước sau:

1.  Mở Eclipse -> **File** -> **New** -> **Dynamic Web Project**.
2.  **Project name:** Nhập `NeuralNews`.
3.  Bỏ chọn *Use default location*, nhấn **Browse** và trỏ đến thư mục code bạn vừa tải về.
4.  **Target runtime:** Chọn Apache Tomcat v11.0 (Nếu chưa có thì nhấn *New Runtime* để trỏ tới thư mục cài đặt Tomcat 11).
5.  Nhấn **Next** -> **Next**.
6.  Tại màn hình **Web Module**:
    *   *Content directory:* Đổi tên thành `src/main/webapp`.
    *   Tích chọn *Generate web.xml deployment descriptor*.
7.  Nhấn **Finish**.

### 3. Cấu hình Java Build Path

1.  Chuột phải vào project `NeuralNews` -> **Build Path** -> **Configure Build Path**.
2.  Chuyển sang tab **Source**.
3.  Mở rộng mục `NeuralNews/src/main/java`. Nếu nó chưa có, hãy nhấn **Add Folder** và tích chọn thư mục `src/main/java`.
4.  Đảm bảo mục **Default output folder** được set thành `NeuralNews/build/classes`.
5.  Chuyển sang tab **Libraries**, đảm bảo đã có *Apache Tomcat v11.0* và *JRE System Library*.
6.  Nhấn **Apply and Close**.

### 4. Chạy Ứng dụng

1.  Chuột phải vào project -> **Run As** -> **Run on Server**.
2.  Chọn server Tomcat 11.
3.  Ứng dụng sẽ khởi chạy tại: `http://localhost:8080/NeuralNews/`

## Cấu trúc quyền hạn (RBAC)

Dự án sử dụng tài khoản mẫu mặc định sau khi chạy file SQL:
*   **Admin:** `admin@neuralnews.com` / `password123`
*   **Nhà báo:** `journalist@neuralnews.com` / `password123`
*   **Người dùng:** `user@neuralnews.com` / `password123`

*(Lưu ý: Sau khi chức năng Register được hoàn thiện với BCrypt, các tài khoản tạo mới sẽ được hash mật khẩu. Tài khoản mẫu sinh ra từ raw SQL dùng mật khẩu thô để tiện kiểm tra)*

## Khắc phục sự cố thường gặp (Troubleshooting)

1.  **Lỗi "The import jakarta cannot be resolved"**: Do dùng Tomcat/Servlet phiên bản cũ. Yêu cầu bắt buộc là **Tomcat 11** và **Jakarta EE**.
2.  **Lỗi 404 hoặc giao diện vỡ nát**: Chắc chắn bạn đã set `Content directory` thành `src/main/webapp` lúc cấu hình project. Đừng để mặc định là `WebContent` hay `src/main/webapp/WEB-INF`.
3.  **Lỗi 500 khi đăng nhập/đăng ký**: Kiểm tra log console của Eclipse. Lỗi 99% do kết nối Database thất bại (Sai pass, sai port hoặc quên chưa tạo DB `neural_news`).
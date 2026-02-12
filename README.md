# NeuralNews

Một nền tảng tin tức hiện đại được xây dựng bằng Java Servlet, JSP và Tailwind CSS.

## Yêu cầu (Prerequisites)

*   **Java Development Kit (JDK)**: Phiên bản 1.8 trở lên.
*   **Eclipse IDE**: "Eclipse IDE for Enterprise Java and Web Developers" (hỗ trợ Dynamic Web Projects).
*   **Apache Tomcat**: Phiên bản 9.0 trở lên.
*   **Git**: Có thể dùng dòng lệnh (CLI) hoặc giao diện (GUI).

## Hướng dẫn cài đặt (Eclipse & Tomcat)

Vì kho lưu trữ này không chứa các tệp cấu hình riêng của Eclipse (như `.project` hay `.classpath`), hãy làm theo các bước sau để thiết lập chính xác.

### 1. Clone (Tải về) Dự án
Mở terminal hoặc command prompt và chạy lệnh:
```bash
git clone https://github.com/giathu012a3/NeuralNews.git
```

### 2. Import vào Eclipse
1.  Mở Eclipse và chọn **File > New > Dynamic Web Project**.
2.  **Project Name (Tên dự án)**: Nhập `NeuralNews`.
3.  **Project Location (Vị trí)**:
    *   Bỏ chọn "Use default location".
    *   Nhấn **Browse...** và chọn thư mục bạn vừa clone về.
4.  **Target Runtime**: Chọn Apache Tomcat runtime của bạn (ví dụ: Apache Tomcat v9.0).
    *   *Nếu chưa cài đặt Tomcat, nhấn "New Runtime" để cấu hình.*
5.  Nhấn **Next** -> **Next**.
6.  **Web Module Configuration (Cấu hình Web)**:
    *   **Content directory**: Đổi từ `WebContent` thành `src/main/webapp`.
    *   Tích chọn **Generate web.xml deployment descriptor** (nếu chưa được chọn).
7.  Nhấn **Finish**.

### 3. Cấu hình Java Build Path
Đảm bảo Eclipse nhận diện đúng các tệp nguồn Java:
1.  Chuột phải vào dự án (`NeuralNews`) -> **Build Path > Configure Build Path**.
2.  Chuyển sang tab **Source**.
3.  Đảm bảo `src/main/java` được liệt kê là một thư mục nguồn (source folder).
    *   Nếu bạn chỉ thấy `src`, hãy xóa nó đi và chọn **Add Folder...** -> chọn đường dẫn `src` > `main` > `java`.
4.  Nhấn **Apply and Close**.

### 4. Chạy Ứng dụng
1.  Chuột phải vào dự án -> **Run As > Run on Server**.
2.  Chọn server Tomcat của bạn.
3.  Nhấn **Finish**.
4.  Ứng dụng sẽ khởi động và mở trong trình duyệt nội bộ tại địa chỉ `http://localhost:8080/NeuralNews/`.

## Khắc phục sự cố (Troubleshooting)
*   **Lỗi "The superclass 'javax.servlet.http.HttpServlet' was not found on the Java Build Path"**:
    *   Chuột phải vào dự án -> Properties -> Project Facets -> Runtimes -> Tích vào **Apache Tomcat**.
*   **CSS không tải được**:
    *   Đảm bảo `Content directory` đã được đặt chính xác là `src/main/webapp` trong quá trình cài đặt (Bước 2.6).
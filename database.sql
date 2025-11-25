-- Database cho DoAn_Web1 (SQL Server phiên bản)

-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'doan_web1')
BEGIN
    CREATE DATABASE doan_web1;
END
GO

USE doan_web1;
GO

-- Nếu bảng đã tồn tại thì xóa (để tạo lại sạch sẽ khi chạy nhiều lần)
IF OBJECT_ID('dbo.products', 'U') IS NOT NULL DROP TABLE dbo.products;
IF OBJECT_ID('dbo.promos', 'U')   IS NOT NULL DROP TABLE dbo.promos;
IF OBJECT_ID('dbo.companies', 'U') IS NOT NULL DROP TABLE dbo.companies;
IF OBJECT_ID('dbo.admins', 'U')    IS NOT NULL DROP TABLE dbo.admins;
GO

-- Bảng hãng sản xuất
CREATE TABLE dbo.companies (
    id         INT IDENTITY(1,1) PRIMARY KEY,
    name       NVARCHAR(100) NOT NULL,   -- Ví dụ: Apple, Samsung
    slug       NVARCHAR(100) NOT NULL,   -- Ví dụ: apple, samsung (dùng cho code / URL)
    created_at DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- Bảng tài khoản quản trị
CREATE TABLE dbo.admins (
    id         INT IDENTITY(1,1) PRIMARY KEY,
    username   NVARCHAR(50)  NOT NULL UNIQUE,
    password   NVARCHAR(255) NOT NULL, -- mật khẩu nên mã hóa ở ứng dụng
    email      NVARCHAR(100) NULL,
    created_at DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- Bảng loại khuyến mãi
CREATE TABLE dbo.promos (
    id         INT IDENTITY(1,1) PRIMARY KEY,
    name       NVARCHAR(100) NOT NULL,   -- Ví dụ: giamgia, tragop, giareonline
    value      NVARCHAR(50)  NULL,       -- Ví dụ: '10%', '0%', '1.000.000đ'
    created_at DATETIME      NOT NULL DEFAULT GETDATE()
);
GO

-- Bảng sản phẩm
CREATE TABLE dbo.products (
    id         INT IDENTITY(1,1) PRIMARY KEY,
    name       NVARCHAR(255) NOT NULL,   -- name
    company_id INT           NOT NULL,   -- company (liên kết sang bảng companies)
    img        NVARCHAR(500) NOT NULL,   -- img (đường dẫn hình)
    price      BIGINT        NOT NULL,   -- price (giá, lưu số)
    star       TINYINT       NOT NULL DEFAULT 0,  -- star (số sao)
    rate_count INT           NOT NULL DEFAULT 0,  -- rateCount (số lượt đánh giá)
    promo_id   INT           NULL,       -- promo (liên kết sang bảng promos)
    created_at DATETIME      NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_products_company FOREIGN KEY (company_id) REFERENCES dbo.companies(id),
    CONSTRAINT FK_products_promo   FOREIGN KEY (promo_id)   REFERENCES dbo.promos(id)
);
GO

-- Dữ liệu mẫu hãng (tùy bạn chỉnh)
INSERT INTO dbo.companies (name, slug) VALUES
 (N'Apple',    N'apple'),
 (N'Samsung',  N'samsung'),
 (N'Oppo',     N'oppo'),
 (N'Xiaomi',   N'xiaomi'),
 (N'Vivo',     N'vivo'),
 (N'Nokia',    N'nokia'),
 (N'Mobiistar',N'mobiistar'),
 (N'Huawei',   N'huawei'),
 (N'Realme',   N'realme'),
 (N'Philips',  N'philips'),
 (N'Mobell',   N'mobell'),
 (N'Itel',     N'itel'),
 (N'Coolpad',  N'coolpad'),
 (N'HTC',      N'htc'),
 (N'Motorola', N'motorola');
GO

-- Dữ liệu mẫu khuyến mãi
INSERT INTO dbo.promos (name, value) VALUES
 (N'giamgia',    N'10%'),
 (N'tragop',     N'0%'),
 (N'giareonline',NULL),
 (N'moiramat',   NULL);
GO

-- Tài khoản admin mặc định
INSERT INTO dbo.admins (username, password, email) VALUES
 (N'admin', N'123456', N'admin@example.com');
GO

-- Dữ liệu mẫu sản phẩm (một phần từ data/products.js)
-- Chú ý: company_id và promo_id phụ thuộc vào thứ tự INSERT ở trên
INSERT INTO dbo.products (name, company_id, img, price, star, rate_count, promo_id) VALUES
 (N'SamSung Galaxy J4+',        2, N'img/products/samsung-galaxy-j4-plus-pink-400x400.jpg', 3490000, 3, 26, 2),
 (N'Xiaomi Mi 8 Lite',          4, N'img/products/xiaomi-mi-8-lite-black-1-600x600.jpg',   6690000, 0,  0, 2),
 (N'Oppo F9',                   3, N'img/products/oppo-f9-red-600x600.jpg',                7690000, 5, 188, 1),
 (N'Nokia 5.1 Plus',            6, N'img/products/nokia-51-plus-black-18thangbh-400x400.jpg', 4790000, 5,  7, 1),
 (N'Samsung Galaxy A8+ (2018)', 2, N'img/products/samsung-galaxy-a8-plus-2018-gold-600x600.jpg',11990000, 0, 0, 1),
 (N'iPhone X 256GB Silver',     1, N'img/products/iphone-x-256gb-silver-400x400.jpg',      31990000, 4, 10, 3),
 (N'Oppo A3s 32GB',             3, N'img/products/oppo-a3s-32gb-600x600.jpg',              4690000, 0,  0, 2),
 (N'Samsung Galaxy J8',         2, N'img/products/samsung-galaxy-j8-600x600-600x600.jpg',  6290000, 0,  0, 1),
 (N'iPad 2018 Wifi 32GB',       1, N'img/products/ipad-wifi-32gb-2018-thumb-600x600.jpg',  8990000, 0,  0, 2),
 (N'iPhone 7 Plus 32GB',        1, N'img/products/iphone-7-plus-32gb-hh-600x600.jpg',     17000000, 0,  0, 3);
GO

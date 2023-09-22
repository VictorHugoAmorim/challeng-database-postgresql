-- Create Tables
-- Ultilizando a estrutura "SERIAL" para auto-incremento dos id's no PostgreSQL
-- Chaves primárias e estrangeiras foram aplicadas, assim como as tipagem dos dados

CREATE TABLE IF NOT EXISTS Customer (
    customer_id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender CHAR(1),
    address VARCHAR(255),
    date_of_birth DATE
);

CREATE TABLE IF NOT EXISTS Category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL,
    sub_category_name VARCHAR(255) NOT NULL,
    type_category_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Item (
    item_id SERIAL PRIMARY KEY,
    item_description VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    is_active BOOLEAN NOT NULL,
    end_date DATE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

CREATE TABLE IF NOT EXISTS sale_order (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    item_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

-- Insert Tables (dados fictícios)
INSERT INTO Customer (email, first_name, last_name, gender, address, date_of_birth) VALUES
    ('joedoe@example.com', 'Joe', 'Doe', 'M', '123 Main St', '1990-09-22'),
    ('marysmith@example.com', 'Mary', 'Smith', 'F', '456 Elm St', '1985-08-22'),
    ('johnbrown@example.com', 'John', 'Brown', 'M', '789 Oak St', '1992-02-10'),
    ('sarahjones@example.com', 'Sarah', 'Jones', 'F', '567 Pine St', '1988-11-30'),
    ('mikeroberts@example.com', 'Mike', 'Roberts', 'M', '1010 Maple St', '1995-04-03'),
    ('emilywhite@example.com', 'Emily', 'White', 'F', '222 Birch St', '1993-07-18'),
    ('davidwilson@example.com', 'David', 'Wilson', 'M', '333 Cedar St', '1987-09-25'),
    ('lindadavis@example.com', 'Linda', 'Davis', 'F', '444 Spruce St', '1991-03-25'),
    ('chrisjackson@example.com', 'Chris', 'Jackson', 'M', '777 Redwood St', '1984-09-22'),
    ('jenniferlee@example.com', 'Jennifer', 'Lee', 'F', '888 Sequoia St', '1994-06-08'),
    ('roberttaylor@example.com', 'Robert', 'Taylor', 'M', '999 Oakwood St', '1989-01-17'),
    ('amycarter@example.com', 'Amy', 'Carter', 'F', '111 Willow St', '1998-09-20'),
    ('michaeladams@example.com', 'Michael', 'Adams', 'M', '222 Aspen St', '1986-10-07'),
    ('laurasmith@example.com', 'Laura', 'Smith', 'F', '333 Sycamore St', '1997-12-28'),
    ('jasonmartin@example.com', 'Jason', 'Martin', 'M', '444 Redbud St', '1996-02-14'),
    ('susanclark@example.com', 'Susan', 'Clark', 'F', '555 Oakleaf St', '1990-04-01'),
    ('williamharris@example.com', 'William', 'Harris', 'M', '666 Magnolia St', '1985-08-09'),
    ('nataliewilson@example.com', 'Natalie', 'Wilson', 'F', '777 Dogwood St', '1992-03-12'),
    ('stevenroberts@example.com', 'Steven', 'Roberts', 'M', '888 Birchwood St', '1988-07-24'),
    ('carolynbrown@example.com', 'Carolyn', 'Brown', 'F', '999 Cedarwood St', '1991-05-06'),
    ('danielmiller@example.com', 'Daniel', 'Miller', 'M', '1010 Pinecone St', '1994-10-19'),
    ('jessicajohnson@example.com', 'Jessica', 'Johnson', 'F', '1111 Willowtree St', '1987-11-03'),
    ('thomasthompson@example.com', 'Thomas', 'Thompson', 'M', '1212 Oakhill St', '1998-01-28'),
    ('karenrodriguez@example.com', 'Karen', 'Rodriguez', 'F', '1313 Elmleaf St', '1986-06-15'),
    ('christophermoore@example.com', 'Christopher', 'Moore', 'M', '1414 Mapleleaf St', '1995-09-14'),
    ('lisawilliams@example.com', 'Lisa', 'Williams', 'F', '1515 Cedarleaf St', '1993-12-04'),
    ('josephhall@example.com', 'Joseph', 'Hall', 'M', '1616 Pineleaf St', '1989-04-29'),
    ('amandathomas@example.com', 'Amanda', 'Thomas', 'F', '1717 Oaktree St', '1990-08-13');

INSERT INTO Category (category_name, sub_category_name, type_category_name) VALUES
    ('Tecnologia','Celulares e Telefones','Celulares e Smartphones'),
    ('Tecnologia','Celulares e Telefones','Acessórios para Celulares'),
    ('Tecnologia','Câmeras e Acessórios','Acessórios para Câmeras'),
    ('Tecnologia','Câmeras e Acessórios','Câmeras'),
    ('Tecnologia','Games','Vídeo Games'),
    ('Tecnologia','Games','Fliperamas e Arcade'),
    ('Tecnologia','Informática','Componentes para PC'),
    ('Tecnologia','Informática','Impressão'),
    ('Tecnologia','Informática','Acessórios para Notebooks'),
    ('Tecnologia','Informática','Conectividade e Redes'),
    ('Tecnologia','Eletrônicos, Áudio e Vídeo','Acessórios para Áudio e Vídeo'),
    ('Tecnologia','Eletrônicos, Áudio e Vídeo','Áudio Portátil e Acessórios'),
    ('Tecnologia','Eletrônicos, Áudio e Vídeo','Componentes Eletrônicos'),
    ('Tecnologia','Eletrônicos, Áudio e Vídeo','Equipamentos para DJs');

INSERT INTO Item (item_description, price, is_active, end_date, category_id ) VALUES
    ('Samsung Galaxy A03 Core Dual SIM 32 GB Mint 2 GB RAM', 599.90, TRUE, '2023-12-01', 1),
    ('Samsung Galaxy A13 Dual SIM 128 GB preto 4 GB RAM', 1306.00, TRUE, '2023-12-01', 1),
    ('Apple iPhone 13 Pro Max (256 GB) - Prateado', 7500.90, TRUE, '2023-12-01', 1),
    ('Fone De Ouvido Bluetooth 5.0 Par Sem Fio Duplo', 68.31, TRUE, '2023-12-01', 2),
    ('Fone De Ouvido Bluetooth Original Tws In-ear Com Anatel', 49.97, FALSE, '2020-01-01', 2),
    ('Cartão Memória Sandisk Ultra 32gb 100mb/s Classe 10 Microsd', 37.92, TRUE, '2023-12-01', 2),
    ('Tripé Profissional Camera, Celular 1,70mt, Mtg 3016 Tomate', 209.90, TRUE, '2023-12-01', 3),
    ('Kit Gravação Luz Tripé Microfone Sem Fio Filmagem No Celular', 284.05, TRUE, '2023-12-01', 3),
    ('Suporte De Mesa Dobrável Flexível Andoer St-01 Em Metal', 119.95, TRUE, '2023-12-01', 3),
    ('Sony Alpha 7S III ILCE-7SM3 mirrorless cor preto', 21695.00, TRUE, '2023-12-01', 4),
    ('Câmera Fotográfica Canon Eos 250d E Lente Ef-s 18-55mm Preta', 5569.00, TRUE, '2023-12-01', 4),
    ('Câmera Trilha Bushnell Prime L20 No Glow 20mp + Pilhas + Sd', 1888.95, FALSE, '2020-01-01', 4),
    ('God Of War Ragnarok Ps4 Sony Físico Standard Edition', 167.00, TRUE,'2023-12-01', 5),
    ('The Amazing Spider Man 2 - Ps3 Físico Seminovo Homem Aranha (Recondicionado)',179, TRUE,'2023-12-01', 5),
    ('FIFA 23 Standard Edition Electronic Arts Xbox One Digital', 17.95, TRUE,'2023-12-01', 5),
    ('Software Para Computador - Pacote Ouro', 99.90, TRUE,'2023-12-01', 6),
    ('Placa Usb Conector Controle Ps4 Jds-040 Cabo Flat 12 Vias', 17.95, TRUE,'2023-12-01', 6),
    ('Disco Sólido Interno Kingston Sa400s37/240g 240gb', 107.95, TRUE,'2023-12-01', 7),
    ('Memória RAM Fury DDR3 color azul 8GB 1 HyperX HX316C10F/8', 60.00, TRUE,'2023-12-01', 7),
    ('Memória RAM ValueRAM 4GB 1 Kingston KVR1333D3N9/4G', 30.95, TRUE,'2023-12-01', 7),
    ('Multifuncional / Impressora HP Deskjet Ink Advantage 2774 (Wifi | Bivolt)', 314.95, TRUE,'2023-12-01', 8),
    ('Impressora a cor multifuncional HP LaserJet Pro M479FDW com wifi branca 110V - 127V', 3938.95, TRUE,'2023-12-01', 8),
    ('Kit Teclado E Mouse Sem Fio Mk220 Preto Logitech', 117.66, TRUE,'2023-12-01', 9),
    ('Base Suporte Ergonômico P/ Notebook,netbook, Tablet Dobravel', 23.61, TRUE,'2023-12-01', 9),
    ('Roteador, Access point TP-Link Archer C60 branco 110V/220V', 230.61, TRUE,'2023-12-01', 10),
    ('Roteador Wireless Mu-mimo Ac1300 Archer C6 Tp-link', 306.26, TRUE,'2023-12-01', 10),
    ('Receptor Midiabox B5 Century Midia Box B5 Hdtv Sat Regional', 249.91, TRUE,'2023-12-01', 11),
    ('Mini Adaptador Conversor D Hdmi P/ Video 3rca Av Cabo Hdmi', 23.13, TRUE,'2023-12-01', 11),
    ('Caixa Amplificada Connect Lights Cm-400 Preta Mondial Bivolt Cor Preto 110V/220V', 519.00, TRUE,'2023-12-01', 12),
    ('Fonte Chaveada 12v 50a 600w Bivolt P/ Câmera Cftv Fita Led', 86.29, TRUE,'2023-12-01', 13),
    ('Processador Crossover De Áudio Digital Stetsom Stx2448', 299.99, TRUE,'2023-12-01', 14);

INSERT INTO sale_order (customer_id, item_id, order_date, quantity) VALUES
    (1, 3, '2020-01-15', 45),   (1, 1, '2020-01-12', 60),   (3, 1, '2020-01-12', 3),
    (1, 3, '2020-01-31', 1499), (4, 2, '2020-01-22', 80),   (9, 2, '2020-07-23', 4),
    (10, 12, '2020-02-18', 62), (5, 2, '2020-01-25', 33),   (15, 1, '2020-07-26', 1),
    (20, 8, '2020-03-10', 29),  (22, 2, '2020-01-15', 1),   (20, 1, '2020-07-16', 2),
    (15, 3, '2020-04-22', 87),  (15, 1, '2020-01-23', 22),  (12, 3, '2020-08-24', 12),
    (8, 26, '2020-05-05', 13),  (13, 3, '2020-01-02', 24),  (11, 1, '2020-08-05', 35),
    (3, 21, '2020-06-30', 55),  (11, 2, '2020-02-15', 5),   (14, 3, '2020-08-22', 12),
    (28, 14, '2020-07-03', 72), (15, 3, '2020-02-11', 12),  (21, 1, '2020-03-21', 11),
    (18, 7, '2020-08-14', 1),   (16, 3, '2020-02-13', 5),   (11, 3, '2020-03-25', 5),
    (11, 18, '2020-09-25', 18), (1, 3, '2020-02-02', 23),   (16, 2, '2020-03-12', 7),
    (5, 30, '2020-10-11', 67),  (7, 2, '2020-02-05', 7),    (18, 3, '2020-03-11', 1),
    (22, 11, '2020-11-19', 43), (9, 1, '2020-02-25', 44),   (10, 3, '2020-05-15', 1),
    (7, 28, '2020-12-06', 92),  (2, 1, '2020-03-05', 1),    (3, 1, '2020-05-15', 2),
    (9, 2, '2020-01-02', 2076), (1, 1, '2020-03-15', 22),   (5, 1, '2020-05-16', 10),
    (25, 9, '2020-02-08', 21),  (22, 1, '2020-04-05', 1),   (19, 2, '2020-05-12', 23),
    (14, 15, '2020-03-17', 34), (28, 1, '2020-04-06', 3),   (18, 1, '2020-06-01', 29),
    (4, 19, '2020-04-29', 50),  (11, 2, '2020-05-01', 19),  (10, 1, '2020-06-09', 80),
    (11, 27, '2020-05-14', 62), (25, 2, '2020-05-22', 23),  (16, 1, '2020-06-13', 220),
    (16, 6, '2020-06-25', 19),  (1, 3, '2020-06-15', 1),    (9, 3, '2020-09-15', 10),
    (28, 16, '2020-07-11', 88), (16, 3, '2020-07-05', 50),  (11, 1, '2020-09-10', 70),
    (17, 25, '2020-08-23', 39), (1, 2, '2020-07-01', 45),   (15, 1, '2020-09-12', 29),
    (6, 1, '2020-09-10', 77),   (8, 1, '2020-08-30', 14),   (25, 1, '2020-09-22', 22),
    (13, 10, '2020-10-28', 28), (10, 3, '2020-09-22', 40),  (19, 3, '2020-10-05', 1),
    (2, 13, '2020-11-09', 53),  (13, 2, '2020-10-15', 14),  (18, 3, '2020-10-09', 3),
    (19, 17, '2020-12-17', 41), (15, 3, '2020-10-16', 25),  (25, 1, '2020-11-12', 43),
    (7, 4, '2020-01-23', 1600), (18, 3, '2020-11-18', 1),   (13, 1, '2020-11-14', 20),
    (27, 23, '2020-02-04', 14), (12, 3, '2020-11-22', 10),  (7, 3, '2020-11-19', 3),
    (21, 22, '2020-03-06', 68), (11, 2, '2020-12-03', 19),  (6, 1, '2020-12-20', 26),
    (26, 5, '2020-04-19', 37),  (17, 2, '2020-12-25', 22),  (20, 1, '2020-12-24', 40),
    (26, 7, '2020-04-19', 99),  (10, 1, '2020-12-25', 1),   (1, 1, '2020-12-24', 60),
    (28, 3, '2020-04-19', 1),   (1, 3, '2020-10-19', 1),    (7, 3, '2020-10-19', 1);

CREATE DATABASE Bokhandel;

USE Bokhandel;

-- Skapa Böcker-tabellen

CREATE TABLE Bocker (
    ISBNID VARCHAR(20) PRIMARY KEY,
    Titel VARCHAR(200) NOT NULL,
    Forfattare VARCHAR(150) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),
    Lagerstatus INT NOT NULL CHECK (Lagerstatus >= 0)
);

-- Skapa Kunder-tabellen
CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100) NOT NULL,
    Epost VARCHAR(255) UNIQUE NOT NULL,
    Telefon VARCHAR(30),
    Adress VARCHAR(255)
);

-- Skapa Beställningar-tabellen
CREATE TABLE Bestallningar (
    Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp >= 0), -- 
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) -- säkerställer att KundID alltid måste finnas i Kunder-tabellen.
);

-- Skapa Orderrader-tabellen (kopplad till ISBNID) 
CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    Ordernummer INT NOT NULL,
    ISBNID VARCHAR(20) NOT NULL,
    Antal INT NOT NULL CHECK (Antal > 0),
    Pris DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Ordernummer) REFERENCES Bestallningar(Ordernummer), -- Kopplar Ordernummer till tabellen Bestallningar.
    FOREIGN KEY (ISBNID) REFERENCES Bocker(ISBNID) -- Kopplar ISBNID till tabellen Bocker.
);
-- lägger in information 
INSERT INTO Bocker (ISBNID, Titel, Forfattare, Pris, Lagerstatus) VALUES
('1', 'River Monsters', 'Jeremy Wade', 199.00, 15),
('2', 'Somewhere down the crazy river', 'Jeremy Wade', 149.00, 30),
('3', 'How to think like a fish', 'Jeremy Wade', 129.00, 40);

-- lägger in information 
INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Max', 'Max@example.com', '070-0000001', 'Max, Kalmar'),
('John', 'John@example.com', '070-0000000', 'Coopflanaden, Oskarshamn');

-- lägger in information 
INSERT INTO Bestallningar (KundID, Totalbelopp) VALUES
(1, 348.00),
(2, 199.00),
(1, 358.00);

-- Order 1: Max köper Somewhere down the crazy river + How to think like a fish
INSERT INTO Orderrader (Ordernummer, ISBNID, Antal, Pris) VALUES
(1, '2', 1, 149.00),
(1, '3', 1, 129.00);

-- Order 2: John köper River Monster
INSERT INTO Orderrader (Ordernummer, ISBNID, Antal, Pris) VALUES
(2, '1', 1, 199.00);


SELECT * FROM Orderrader;



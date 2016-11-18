CREATE TABLE Vendor (
   Vno             CHAR(50)   PRIMARY KEY   NOT NULL,
   Vname           CHAR(50)                 NOT NULL,
   City            CHAR(50)                 NOT NULL,
   Vbalance        DECIMAL(50, 2)           NOT NULL
);

CREATE TABLE Customer (
   Account        CHAR(50)    PRIMARY KEY   NOT NULL,
   CNAME          CHAR(50)                  NOT NULL,
   Province       CHAR(50)                  NOT NULL,
   Cbalance       DECIMAL(50, 2)            NOT NULL,
   Crlimit        DECIMAL(50, 2)            NOT NULL
);

CREATE TABLE Transaction (
   Tno            CHAR(50)     PRIMARY KEY   NOT NULL,
   Vno            CHAR(50)                   references Vendor(Vno),
   Account        CHAR(50)                   references Customer(Account),
   T_Date         DATE                       NOT NULL,
   Amount         DECIMAL(50, 2)             NOT NULL
);

INSERT INTO Vendor (Vno, Vname, City, Vbalance) VALUES
    ('V1', 'Sears', 'Toronto', 200.00),
    ('V2', 'WalMart', 'Waterloo', 671.05),
    ('V3', 'Esso', 'Windsor', 0.00),
    ('V4', 'Esso', 'Waterloo', 225.00);

INSERT INTO Customer (Account, CNAME, Province, Cbalance, Crlimit) VALUES
    ('A1', 'Smith', 'ONT', 2515.00, 2000),
    ('A2', 'Jones', 'BC', 2014.00, 2500),
    ('A3', 'Doc', 'ONT', 150.00, 1000);

INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount) VALUES
    ('T1', 'V2', 'A1', '2016-07-15', 1325.00),
    ('T2', 'V2', 'A3', '2015-12-16', 1900.00),
    ('T3', 'V3', 'A1', '2016-09-01', 2500.00),
    ('T4', 'V4', 'A2', '2016-03-20', 1613.00),
    ('T5', 'V4', 'A3', '2016-07-31', 3312.00);

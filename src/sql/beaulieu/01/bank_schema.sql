-- ============================================================
-- Learning SQL — Alan Beaulieu (2020)
-- Base de datos bancaria (bank)
-- Capítulos 2–18
-- ============================================================

-- Departamentos
CREATE TABLE IF NOT EXISTS department (
    dept_id   INTEGER PRIMARY KEY,
    name      VARCHAR NOT NULL
);

INSERT INTO department VALUES
    (1, 'Operations'),
    (2, 'Loans'),
    (3, 'Administration');

-- Empleados
CREATE TABLE IF NOT EXISTS employee (
    emp_id          INTEGER PRIMARY KEY,
    fname           VARCHAR NOT NULL,
    lname           VARCHAR NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE,
    superior_emp_id INTEGER REFERENCES employee(emp_id),
    dept_id         INTEGER REFERENCES department(dept_id),
    title           VARCHAR,
    assigned_branch_id INTEGER
);

INSERT INTO employee VALUES
    (1,  'Michael', 'Smith',    '2001-06-22', NULL, NULL, 3, 'President',          1),
    (2,  'Susan',   'Barker',   '2002-09-12', NULL, 1,    3, 'Vice President',     1),
    (3,  'Robert',  'Tyler',    '2000-02-09', NULL, 1,    3, 'Treasurer',          1),
    (4,  'Susan',   'Hawthorne','2002-04-24', NULL, 3,    1, 'Operations Manager', 1),
    (5,  'John',    'Gooding',  '2003-11-14', NULL, 4,    2, 'Loan Manager',       1),
    (6,  'Helen',   'Fleming',  '2004-03-17', NULL, 4,    1, 'Head Teller',        1),
    (7,  'Chris',   'Tucker',   '2004-09-15', NULL, 6,    1, 'Teller',             1),
    (8,  'Sarah',   'Parker',   '2002-12-02', NULL, 6,    1, 'Teller',             1),
    (9,  'Jane',    'Grossman', '2002-05-03', NULL, 6,    1, 'Teller',             1),
    (10, 'Paula',   'Roberts',  '2002-07-27', NULL, 4,    1, 'Head Teller',        2),
    (11, 'Thomas',  'Ziegler',  '2000-10-23', NULL, 10,   1, 'Teller',             2),
    (12, 'Samantha','Jameson',  '2003-01-08', NULL, 10,   1, 'Teller',             2),
    (13, 'John',    'Blake',    '2000-05-11', NULL, 4,    1, 'Head Teller',        3),
    (14, 'Cindy',   'Mason',    '2002-08-09', NULL, 13,   1, 'Teller',             3),
    (15, 'Frank',   'Portman',  '2003-04-01', NULL, 13,   1, 'Teller',             3),
    (16, 'Theresa', 'Markham',  '2001-03-15', NULL, 4,    1, 'Head Teller',        4),
    (17, 'Beth',    'Fowler',   '2002-06-29', NULL, 16,   1, 'Teller',             4),
    (18, 'Rick',    'Tulman',   '2002-12-12', NULL, 16,   1, 'Teller',             4);

-- Sucursales
CREATE TABLE IF NOT EXISTS branch (
    branch_id   INTEGER PRIMARY KEY,
    name        VARCHAR NOT NULL,
    address     VARCHAR,
    city        VARCHAR,
    state       VARCHAR,
    zip         VARCHAR
);

INSERT INTO branch VALUES
    (1, 'Headquarters', '3882 Main St.',     'Waltham',    'MA', '02451'),
    (2, 'Woburn Branch','422 Maple St.',      'Woburn',     'MA', '01801'),
    (3, 'Quincy Branch','125 Presidential Way','Quincy',   'MA', '02169'),
    (4, 'So. NH Branch','378 Maynard Ln.',    'Salem',      'NH', '03079');

-- Productos (tipos de cuenta)
CREATE TABLE IF NOT EXISTS product (
    product_cd  VARCHAR PRIMARY KEY,
    name        VARCHAR NOT NULL,
    product_type_cd VARCHAR NOT NULL,
    date_offered DATE,
    date_retired DATE
);

INSERT INTO product VALUES
    ('ANG', 'Angelo Bank',        'ACCOUNT', '2004-01-01', NULL),
    ('BUS', 'Business Line of Credit','LOAN','2004-01-01', NULL),
    ('CD',  'Certificate of Deposit','ACCOUNT','2004-01-01',NULL),
    ('CHK', 'Checking Account',   'ACCOUNT', '2004-01-01', NULL),
    ('MM',  'Money Market Account','ACCOUNT','2004-01-01', NULL),
    ('MRT', 'Home Mortgage',      'LOAN',    '2004-01-01', NULL),
    ('SAV', 'Savings Account',    'ACCOUNT', '2004-01-01', NULL),
    ('SBL', 'Small Business Loan','LOAN',    '2004-01-01', NULL);

-- Clientes (tabla base)
CREATE TABLE IF NOT EXISTS customer (
    cust_id     INTEGER PRIMARY KEY,
    fed_id      VARCHAR NOT NULL,
    cust_type_cd VARCHAR NOT NULL,  -- 'I' individual, 'B' business
    address     VARCHAR,
    city        VARCHAR,
    state       VARCHAR,
    postal_code VARCHAR
);

INSERT INTO customer VALUES
    (1,  '111-11-1111', 'I', '47 Mockingbird Ln', 'Lynnfield', 'MA', '01940'),
    (2,  '222-22-2222', 'I', '372 Clearwater Blvd','Woburn',   'MA', '01801'),
    (3,  '333-33-3333', 'I', '18 Jessup Rd',       'Quincy',   'MA', '02169'),
    (4,  '444-44-4444', 'I', '12 Buchanan Ln',     'Waltham',  'MA', '02451'),
    (5,  '555-55-5555', 'I', '2341 Main St.',      'Salem',    'NH', '03079'),
    (6,  '666-66-6666', 'I', '12 Blaylock Ln',    'Waltham',  'MA', '02451'),
    (7,  '777-77-7777', 'I', '29 Admiral Ln',      'Wilmington','MA','01887'),
    (8,  '888-88-8888', 'I', '472 Freedom Rd',     'Salem',    'NH', '03079'),
    (9,  '999-99-9999', 'I', '29 Maple St.',       'Newton',   'MA', '02458'),
    (10, '04-1111111',  'B', '7 Industrial Way',   'Woburn',   'MA', '01801'),
    (11, '04-2222222',  'B', '287 Newton Rd.',     'Pittsfield','MA','01201'),
    (12, '04-3333333',  'B', '789 Main St.',       'Salem',    'NH', '03079'),
    (13, '04-4444444',  'B', '4772 Presidential Way','Quincy', 'MA', '02169');

-- Individuos
CREATE TABLE IF NOT EXISTS individual (
    cust_id  INTEGER PRIMARY KEY REFERENCES customer(cust_id),
    fname    VARCHAR NOT NULL,
    lname    VARCHAR NOT NULL,
    birth_date DATE
);

INSERT INTO individual VALUES
    (1,  'James',   'Hadley',   '1972-04-22'),
    (2,  'Susan',   'Tingley',  '1968-08-15'),
    (3,  'Frank',   'Tucker',   '1958-02-06'),
    (4,  'John',    'Hayward',  '1966-12-22'),
    (5,  'Charles', 'Frasier',  '1971-08-25'),
    (6,  'John',    'Spencer',  '1962-09-14'),
    (7,  'Margaret','Young',    '1947-03-19'),
    (8,  'Louis',   'Blake',    '1977-07-01'),
    (9,  'Richard', 'Farley',   '1968-06-16');

-- Empresas
CREATE TABLE IF NOT EXISTS business (
    cust_id      INTEGER PRIMARY KEY REFERENCES customer(cust_id),
    name         VARCHAR NOT NULL,
    state_id     VARCHAR NOT NULL,
    incorp_date  DATE
);

INSERT INTO business VALUES
    (10, 'Woburn Savings Bank',    'MA', '1986-01-01'),
    (11, 'Hyundai Motor America',  'MA', '1992-01-01'),
    (12, 'Law Offices of Mahoney', 'NH', '1995-01-01'),
    (13, 'Arnold Business Assoc.', 'MA', '1997-01-01');

-- Cuentas
CREATE TABLE IF NOT EXISTS account (
    account_id      INTEGER PRIMARY KEY,
    product_cd      VARCHAR REFERENCES product(product_cd),
    cust_id         INTEGER REFERENCES customer(cust_id),
    open_date       DATE NOT NULL,
    close_date      DATE,
    last_activity_date DATE,
    status          VARCHAR,
    open_branch_id  INTEGER REFERENCES branch(branch_id),
    open_emp_id     INTEGER REFERENCES employee(emp_id),
    avail_balance   DECIMAL(10,2),
    pending_balance DECIMAL(10,2)
);

INSERT INTO account VALUES
    (1,  'CHK', 1,  '2000-01-15', NULL, '2005-01-04', 'ACTIVE', 2, 10, 1057.75, 1057.75),
    (2,  'SAV', 1,  '2000-01-15', NULL, '2004-12-19', 'ACTIVE', 2, 10,  500.00,  500.00),
    (3,  'CHK', 1,  '2004-06-30', NULL, '2005-01-03', 'ACTIVE', 1,  1, 3000.00, 3000.00),
    (4,  'CHK', 2,  '2001-03-12', NULL, '2004-12-27', 'ACTIVE', 2, 10, 2258.02, 2258.02),
    (5,  'SAV', 2,  '2001-03-12', NULL, '2004-12-11', 'ACTIVE', 2, 10,  200.00,  200.00),
    (7,  'CHK', 3,  '2002-07-30', NULL, '2004-12-29', 'ACTIVE', 3, 13, 1057.75, 1057.75),
    (8,  'MM',  3,  '2002-07-30', NULL, '2004-12-05', 'ACTIVE', 3, 13, 2212.50, 2212.50),
    (10, 'CHK', 4,  '2002-01-23', NULL, '2005-01-03', 'ACTIVE', 1,  1,  534.12,  534.12),
    (11, 'SAV', 4,  '2000-01-15', NULL, '2004-10-01', 'ACTIVE', 1,  1,  767.77,  767.77),
    (12, 'MM',  4,  '2004-09-30', NULL, '2004-11-11', 'ACTIVE', 1,  1, 5487.09, 5487.09),
    (13, 'CHK', 5,  '2003-07-28', NULL, '2004-12-19', 'ACTIVE', 4, 16,  246.25,  246.25),
    (14, 'CHK', 6,  '2004-01-12', NULL, '2004-11-30', 'ACTIVE', 1,  1, 1342.45, 1342.45),
    (15, 'SAV', 6,  '2004-01-12', NULL, '2004-06-30', 'ACTIVE', 1,  1,  200.00,  200.00),
    (17, 'CD',  6,  '2004-01-12', NULL, '2004-06-30', 'ACTIVE', 1,  1,10000.00,10000.00),
    (18, 'CHK', 7,  '2001-05-23', NULL, '2004-12-19', 'ACTIVE', 4, 16, 3487.19, 3487.19),
    (19, 'SAV', 7,  '2001-05-23', NULL, '2004-06-30', 'ACTIVE', 4, 16,  387.99,  387.99),
    (21, 'CHK', 8,  '2000-01-15', NULL, '2005-01-03', 'ACTIVE', 4, 16,  125.67,  125.67),
    (22, 'MM',  8,  '2000-01-15', NULL, '2004-12-19', 'ACTIVE', 4, 16, 9345.55, 9345.55),
    (23, 'CHK', 9,  '2001-06-08', NULL, '2004-12-08', 'ACTIVE', 1,  1, 3487.19, 3487.19),
    (24, 'CHK', 10, '2002-09-30', NULL, '2004-12-15', 'ACTIVE', 2, 10, 5345.22, 5345.22),
    (25, 'BUS', 10, '2002-10-01', NULL, '2004-08-28', 'ACTIVE', 2, 10,  0.00,   0.00),
    (27, 'CHK', 11, '2004-03-22', NULL, '2004-11-14', 'ACTIVE', 1,  1, 9345.55, 9345.55),
    (28, 'BUS', 11, '2004-03-22', NULL, '2004-11-14', 'ACTIVE', 1,  1,  0.00,   0.00),
    (29, 'CHK', 12, '2004-07-30', NULL, '2005-01-03', 'ACTIVE', 4, 16, 1500.00, 1500.00),
    (30, 'SBL', 12, '2004-07-30', NULL, '2004-11-28', 'ACTIVE', 4, 16,50000.00,50000.00);

-- Transacciones
CREATE TABLE IF NOT EXISTS acc_transaction (
    txn_id       INTEGER PRIMARY KEY,
    txn_date     DATE NOT NULL,
    account_id   INTEGER REFERENCES account(account_id),
    txn_type_cd  VARCHAR,   -- 'DBT' debit, 'CDT' credit
    amount       DECIMAL(10,2),
    teller_emp_id INTEGER REFERENCES employee(emp_id),
    execution_branch_id INTEGER REFERENCES branch(branch_id),
    funds_avail_date DATE
);

INSERT INTO acc_transaction VALUES
    (1,  '2005-01-22', 1,  'CDT', 100.00, 7,  2, '2005-01-22'),
    (2,  '2001-09-17', 2,  'CDT', 500.00, 10, 2, '2001-09-17'),
    (3,  '2004-06-30', 3,  'CDT',3000.00,  1, 1, '2004-06-30'),
    (4,  '2004-12-27', 4,  'CDT', 100.00,  9, 1, '2004-12-27'),
    (5,  '2004-12-11', 5,  'CDT', 200.00, 10, 2, '2004-12-11'),
    (6,  '2004-12-29', 7,  'DBT', 100.00, 14, 3, '2004-12-29'),
    (7,  '2004-12-05', 8,  'CDT', 500.00, 13, 3, '2004-12-05'),
    (8,  '2005-01-03', 10, 'DBT', 100.00,  1, 1, '2005-01-03'),
    (9,  '2004-10-01', 11, 'CDT', 100.00,  1, 1, '2004-10-01'),
    (10, '2004-11-11', 12, 'CDT',5487.09,  1, 1, '2004-11-11'),
    (11, '2004-12-19', 13, 'DBT',  46.25, 16, 4, '2004-12-19'),
    (12, '2004-11-30', 14, 'CDT', 100.00,  1, 1, '2004-11-30'),
    (13, '2004-06-30', 15, 'CDT', 200.00,  1, 1, '2004-06-30'),
    (14, '2004-06-30', 17, 'CDT',10000.00, 1, 1, '2004-06-30'),
    (15, '2004-12-19', 18, 'CDT', 100.00, 17, 4, '2004-12-19'),
    (16, '2004-06-30', 19, 'CDT', 387.99, 16, 4, '2004-06-30'),
    (17, '2005-01-03', 21, 'DBT',  25.67, 18, 4, '2005-01-03'),
    (18, '2004-12-19', 22, 'CDT', 100.00, 16, 4, '2004-12-19'),
    (19, '2004-12-08', 23, 'CDT', 100.00,  1, 1, '2004-12-08'),
    (20, '2004-12-15', 24, 'DBT', 345.22, 10, 2, '2004-12-15'),
    (21, '2004-08-28', 25, 'CDT',9345.55, 10, 2, '2004-08-28'),
    (22, '2004-11-14', 27, 'CDT',9345.55,  1, 1, '2004-11-14'),
    (23, '2005-01-03', 29, 'CDT',1500.00, 18, 4, '2005-01-03'),
    (24, '2004-11-28', 30, 'CDT',50000.00,16, 4, '2004-11-28');

USE transactions;

-- Nivell 1
# Exercici 2
# Llistat dels països que estan generant vendes.
SELECT DISTINCT(company.country)
FROM transaction
JOIN company ON transaction.company_id = company.Id
WHERE transaction.declined = 0;

# Des de quants països es generen les vendes. 
SELECT COUNT(DISTINCT company.country)
FROM transaction
JOIN company ON transaction.company_id = company.iD
WHERE transaction.declined = 0;

# Identifica la companyia amb la mitjana més gran de vendes. 
SELECT company.company_name, AVG(transaction.amount) AS media
FROM transaction
JOIN company ON transaction.company_id = company.id
GROUP BY company.id
ORDER BY media
LIMIT 1;

# Exercici 3
# Mostra totes les transaccions realitzades per empreses d'Alemanya. 
SELECT *
FROM transaction
WHERE company_id IN ( SELECT ID
						FROM company
						WHERE country = "Germany");
                        
# Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions. 
SELECT *
FROM company
WHERE ID IN (	SELECT company_id
				FROM transaction
				WHERE amount > (SELECT AVG(amount)
								FROM transaction));
                                
# Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses. 
SELECT *
FROM company
WHERE id IN (	SELECT company_id
				FROM transaction);
                
# Exercici 5
UPDATE credit_card
SET iban = "TR323456312213576817699999"
WHERE id = "CcU-2938";

SELECT *
FROM credit_card
WHERE id = "CcU-2938";

# Exercici 6
INSERT INTO company (id)
VALUES ("b-9999");

INSERT INTO credit_card (id)
VALUES ("CCU-9999");

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined)
VALUES ("108B1D1D-5B23-A76C-55EF-C568E49A99DD", "CcU-9999", "B-9999", 9999, 829.999, -117.999, 111.11, 0);

# Exercici 7
ALTER TABLE credit_card
DROP COLUMN pan;

# Exercici 8
CREATE DATABASE trans_clients;

USE trans_clients;

CREATE TABLE IF NOT EXISTS american_users(
	id VARCHAR (255) PRIMARY KEY,
    name VARCHAR (255) NULL,
    surname VARCHAR (255) NULL,
    phone VARCHAR (255) NULL, # Utilizo VARCHAR porque no conozco los datos y no sé si se incluirán solo números o otros caracteres. 
    email VARCHAR (255) NULL,
    birth_date VARCHAR (255) NULL,
    country VARCHAR (255) NULL, 
    city VARCHAR (255) NULL, 
    postal_code VARCHAR (255) NULL, 
    address VARCHAR (255) NULL, 
    signup_date VARCHAR (255) NULL, 
    user_segment VARCHAR (255) NULL, 
    income_band VARCHAR (255) NULL);
    
LOAD DATA LOCAL INFILE '/Users/daniel/Library/CloudStorage/OneDrive-Personal/ITAcademy/Especialització/SQL/S2/N1-Ex.8__american_users.csv'
INTO TABLE american_users
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS companies(
	company_id VARCHAR (255) PRIMARY KEY,
    company_name VARCHAR (255) NULL,
    phone VARCHAR (255) NULL,
    email VARCHAR (255) NULL,
    country VARCHAR (255) NULL,
    website VARCHAR (255) NULL,
    merchant_category VARCHAR (255) NULL,
    merchant_price_position VARCHAR (255) NULL);
    
LOAD DATA LOCAL INFILE '/Users/daniel/Library/CloudStorage/OneDrive-Personal/ITAcademy/Especialització/SQL/S2/N1-Ex.8__companies.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS credit_cards(
	id VARCHAR (255) PRIMARY KEY,
    user_id VARCHAR (255) NULL,
    iban VARCHAR (255) NULL,
    pan VARCHAR (255) NULL,
    pin VARCHAR (255) NULL,
    cvv VARCHAR (255) NULL,
    track1 VARCHAR (255) NULL,
    track2 VARCHAR (255) NULL,
    expiring_date VARCHAR (255) NULL,
    card_type VARCHAR (255) NULL,
    card_renewal_flag VARCHAR (255) NULL);

LOAD DATA LOCAL INFILE '/Users/daniel/Library/CloudStorage/OneDrive-Personal/ITAcademy/Especialització/SQL/S2/N1-Ex.8__credit_cards.csv'
INTO TABLE credit_cards
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS european_users(
	id VARCHAR (255) PRIMARY KEY,
    name VARCHAR (255) NULL,
    surname VARCHAR (255) NULL,
    phone VARCHAR (255) NULL, 
    email VARCHAR (255) NULL,
    birth_date VARCHAR (255) NULL,
    country VARCHAR (255) NULL, 
    city VARCHAR (255) NULL, 
    postal_code VARCHAR (255) NULL, 
    address VARCHAR (255) NULL, 
    signup_date VARCHAR (255) NULL, 
    user_segment VARCHAR (255) NULL, 
    income_band VARCHAR (255) NULL);

LOAD DATA LOCAL INFILE '/Users/daniel/Library/CloudStorage/OneDrive-Personal/ITAcademy/Especialització/SQL/S2/N1-Ex.8__european_users.csv'
INTO TABLE european_users
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS products(
	id VARCHAR (255) PRIMARY KEY,
    product_name VARCHAR (255) NULL,
    price VARCHAR (255) NULL,
    colour VARCHAR (255) NULL,
    weight VARCHAR (255) NULL,
    warehouse_id VARCHAR (255) NULL,
    category VARCHAR (255) NULL,
    brand VARCHAR (255) NULL,
    cost VARCHAR (255) NULL,
    launch_date VARCHAR (255) NULL);

LOAD DATA LOCAL INFILE '/Users/daniel/Library/CloudStorage/OneDrive-Personal/ITAcademy/Especialització/SQL/S2/N1-Ex.8__products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

CREATE TABLE IF NOT EXISTS transactions(
    id VARCHAR(255) PRIMARY KEY,
    card_id VARCHAR(255),
    business_id VARCHAR(255),
    timestamp VARCHAR(255) NULL,
    amount DECIMAL(10,2) NULL,
    declined VARCHAR(255) NULL,
    product_ids VARCHAR(255) NULL,
    user_id VARCHAR(255) NULL,
    lat VARCHAR(255) NULL,
    longitude VARCHAR(255) NULL,
    discount_amount DECIMAL(10,2) NULL,
    tax_amount DECIMAL(10,2) NULL,
    shipping_amount DECIMAL(10,2) NULL,
    channel VARCHAR(255) NULL,
    campaign_id VARCHAR(255) NULL,
    device_type VARCHAR(255) NULL,
    is_international VARCHAR(255) NULL,
    decline_reason VARCHAR(255) NULL,
    distance_km VARCHAR(255) NULL,
    FOREIGN KEY (card_id) REFERENCES credit_cards(id),
    FOREIGN KEY (business_id) REFERENCES companies(company_id));

LOAD DATA LOCAL INFILE '/Users/daniel/Library/CloudStorage/OneDrive-Personal/ITAcademy/Especialització/SQL/S2/N1-Ex.8__transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

ALTER TABLE credit_cards
ADD CONSTRAINT fk_credit_cards_european
FOREIGN KEY (user_id) REFERENCES european_users(id),
ADD CONSTRAINT fk_credit_cards_american
FOREIGN KEY (user_id) REFERENCES american_users(id);

CREATE TABLE IF NOT EXISTS users(
    id VARCHAR (255) PRIMARY KEY,
    name VARCHAR (255) NULL,
    surname VARCHAR (255) NULL,
    phone VARCHAR (255) NULL,
    email VARCHAR (255) NULL,
    birth_date VARCHAR (255) NULL,
    country VARCHAR (255) NULL,
    city VARCHAR (255) NULL,
    postal_code VARCHAR (255) NULL,
    address VARCHAR (255) NULL,
    signup_date VARCHAR (255) NULL,
    user_segment VARCHAR (255) NULL,
    income_band VARCHAR (255) NULL,
    region VARCHAR (50) NULL
);

INSERT INTO users (id, name, surname, phone, email, birth_date, country, city, postal_code, address, signup_date, user_segment, income_band, region)
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address, signup_date, user_segment, income_band, 'europe' FROM european_users
UNION
SELECT id, name, surname, phone, email, birth_date, country, city, postal_code, address, signup_date, user_segment, income_band, 'america' FROM american_users;

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_users
FOREIGN KEY (user_id) REFERENCES users(id);

# Exercici 9
SELECT COUNT(DISTINCT id), user_id
FROM transactions
GROUP BY user_id
HAVING COUNT(DISTINCT id) > 80;

SELECT *
FROM users
WHERE id IN (	SELECT user_id
				FROM transactions
				GROUP BY user_id
				HAVING COUNT(DISTINCT id) > 80);

# Exercici 10
SELECT AVG(transactions.amount), iban
FROM credit_cards
JOIN transactions ON transactions.card_id = credit_cards.id
JOIN companies ON companies.company_id = transactions.business_id
WHERE companies.company_name = "Donec Ltd"
GROUP BY iban;

-- Nivell 2
# Exercici 1
SELECT DATE(timestamp), SUM(amount) AS ventas
FROM transactions
GROUP BY DATE(timestamp)
ORDER BY ventas DESC;

# Exercici 2
SELECT companies.company_name, companies.phone, companies.country, DATE(transactions.timestamp), transactions.amount
FROM transactions
JOIN companies ON transactions.business_id = companies.company_id
WHERE DATE(transactions.timestamp) IN ("2015-04-29", "2018-07-20", "2024-03-13")
AND 	transactions.amount >350 
AND		transactions.amount <400
ORDER BY transactions.amount DESC;

# Exercici 3
SELECT companies.company_name, COUNT(DISTINCT transactions.id) AS recuento, 
CASE
	WHEN COUNT(DISTINCT transactions.id) >= 400 THEN "Igual o més de 400 transaccions realitzades"
	ELSE "Menys de 400 transaccions"
END
FROM transactions
JOIN companies ON transactions.business_id = companies.company_id
GROUP BY companies.company_name
ORDER BY recuento DESC;

# Exercici 4
DELETE FROM transactions
WHERE id = "000447FE-B650-4DCF-85DE-C7ED0EE1CAAD";

# Exercici 5
CREATE VIEW VistaMarketing AS
SELECT companies.company_name, companies.phone, companies.country, AVG(transactions.amount) media_trans
FROM companies
JOIN transactions ON companies.company_id = transactions.business_id
GROUP BY companies.company_name, companies.phone, companies.country;

SELECT *
FROM VistaMarketing
ORDER BY media_trans;

-- Nivell 3
# Exercici 1
CREATE TABLE targetes_actives AS
WITH ultimes AS (
    SELECT
        transactions.card_id,
        transactions.declined,
        ROW_NUMBER() OVER (
            PARTITION BY transactions.card_id
            ORDER BY transactions.timestamp DESC
        ) AS tt_ultimes
    FROM transactions
)
SELECT
    card_id,
    CASE
        WHEN COUNT(*) = 3
             AND SUM(ultimes.declined = 1) = 3
        THEN 'inactiva'
        ELSE 'activa'
    END AS estat
FROM ultimes
WHERE tt_ultimes <= 3
GROUP BY card_id;

SELECT COUNT(*)
FROM targetes_actives;

# Exercici 2
CREATE TABLE IF NOT EXISTS product_transfer(
	id INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR (255), 
    trans_id VARCHAR (255),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (trans_id) REFERENCES transactions(id));    
    
INSERT INTO product_transfer (product_id, trans_id)
SELECT transactions_json.product_id, transactions.id
FROM transactions
JOIN JSON_TABLE(
    CONCAT(
        '["',REPLACE(transactions.product_ids, ', ', '","'),'"]'),
    '$[*]' COLUMNS (product_id VARCHAR(255) PATH '$')) AS transactions_json;

SELECT COUNT(product_transfer.product_id), products.product_name
FROM product_transfer
JOIN products ON products.id = product_transfer.product_id
GROUP BY product_transfer.product_id
ORDER BY COUNT(product_transfer.product_id) DESC;




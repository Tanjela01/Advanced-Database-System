1.
CREATE TABLE purchase (
    product_id INT PRIMARY KEY,
    amount INT,
    price DECIMAL(10, 2),
    customer_id INT REFERENCES customer(customer_id),
    product_name VARCHAR(255)
);
2.
INSERT INTO purchase VALUES
    (1, 2, 150.00, 101, 'Laptop'),
    (2, 3, 25.50, 102, 'Mouse'),
    (3, 1, 500.00, 103, 'Smartphone'),
    (4, 2, 1000.00, 104, 'Tablet'),
    (5, 1, 30.00, 101, 'Mousepad'),
    (6, 3, 800.00, 105, 'Headphones'),
    (7, 2, 4500.00, 102, 'Smart Watch');
3.
DECLARE
    v_max_price DECIMAL(10, 2);
    v_customer_id INT;
    v_customer_name VARCHAR(255);
BEGIN
    SELECT MAX(price) INTO v_max_price FROM purchase;

    FOR rec IN (SELECT customer_id, customer_name FROM customer WHERE customer_id IN (SELECT customer_id FROM purchase WHERE price = v_max_price))
    LOOP
        v_customer_id := rec.customer_id;
        v_customer_name := rec.customer_name;
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_id || ', Customer Name: ' || v_customer_name);
    END LOOP;
END;
/
4.
DECLARE
    v_product_id INT := 2; -- Change this to the desired product_id
    v_min_amount INT := 2;
    v_customer_name VARCHAR(255);
    v_customer_address VARCHAR(255);
BEGIN
    FOR rec IN (SELECT c.customer_name, c.customer_address
                FROM customer c
                JOIN purchase p ON c.customer_id = p.customer_id
                WHERE p.product_id = v_product_id AND p.amount >= v_min_amount)
    LOOP
        v_customer_name := rec.customer_name;
        v_customer_address := rec.customer_address;
        DBMS_OUTPUT.PUT_LINE('Customer Name: ' || v_customer_name || ', Customer Address: ' || v_customer_address);
    END LOOP;
END;
/
5.
DECLARE
    v_max_price DECIMAL(10, 2) := 5000;
    v_customer_id INT;
    v_customer_name VARCHAR(255);
BEGIN
    FOR rec IN (SELECT c.customer_id, c.customer_name
                FROM customer c
                JOIN purchase p ON c.customer_id = p.customer_id
                WHERE p.product_name = 'Smart Watch' AND p.price < v_max_price)
    LOOP
        v_customer_id := rec.customer_id;
        v_customer_name := rec.customer_name;
        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_id || ', Customer Name: ' || v_customer_name);
    END LOOP;
END;
/
6.
SELECT * FROM purchase ORDER BY price;

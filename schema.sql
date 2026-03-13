--This code is used to create the tables for this project
CREATE TABLE customers (
    customer_id     SERIAL PRIMARY KEY,
    company_name    VARCHAR(100),
    industry        VARCHAR(50),
    country         VARCHAR(50),
    signup_date     DATE
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    plan_name       VARCHAR(50),
    monthly_price   NUMERIC(8,2),
    start_date      DATE,
    end_date        DATE
);

CREATE TABLE payments (
    payment_id      SERIAL PRIMARY KEY,
    subscription_id INT REFERENCES subscriptions(subscription_id),
    payment_date    DATE,
    amount          NUMERIC(8,2),
    status          VARCHAR(20)
);

CREATE TABLE support_tickets (
    ticket_id       SERIAL PRIMARY KEY,
    customer_id     INT REFERENCES customers(customer_id),
    created_date    DATE,
    category        VARCHAR(50),
    resolved        BOOLEAN
);
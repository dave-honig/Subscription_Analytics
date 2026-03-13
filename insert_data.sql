--This code is used to populate the tables

INSERT INTO customers (company_name, industry, country, signup_date) VALUES
('Acme Corp',         'Healthcare',   'USA',    '2022-01-15'),
('Blue Ridge Tech',   'Finance',      'USA',    '2022-02-01'),
('Nordic Solutions',  'Retail',       'Sweden', '2022-02-14'),
('Harmon & Voss',     'Healthcare',   'USA',    '2022-03-05'),
('Citywide Media',    'Media',        'USA',    '2022-03-20'),
('Delta Pharma',      'Healthcare',   'Canada', '2022-04-10'),
('Sunrise Logistics', 'Logistics',    'USA',    '2022-05-01'),
('Greenfield Co',     'Retail',       'USA',    '2022-05-18'),
('Atlas Consulting',  'Finance',      'USA',    '2022-06-09'),
('Westport Labs',     'Healthcare',   'USA',    '2022-06-22');

INSERT INTO subscriptions (customer_id, plan_name, monthly_price, start_date, end_date) VALUES
(1,  'Pro',     299.00, '2022-01-15', NULL),
(2,  'Basic',    99.00, '2022-02-01', '2023-01-31'),
(3,  'Pro',     299.00, '2022-02-14', NULL),
(4,  'Enterprise', 799.00, '2022-03-05', NULL),
(5,  'Basic',    99.00, '2022-03-20', '2022-12-31'),
(6,  'Pro',     299.00, '2022-04-10', '2023-06-30'),
(7,  'Basic',    99.00, '2022-05-01', NULL),
(8,  'Enterprise', 799.00, '2022-05-18', NULL),
(9,  'Basic',    99.00, '2022-06-09', '2023-03-31'),
(10, 'Pro',     299.00, '2022-06-22', NULL);

INSERT INTO payments (subscription_id, payment_date, amount, status) VALUES
(1,  '2022-02-01', 299.00, 'paid'),
(1,  '2022-03-01', 299.00, 'paid'),
(1,  '2022-04-01', 299.00, 'paid'),
(2,  '2022-03-01',  99.00, 'paid'),
(2,  '2022-04-01',  99.00, 'failed'),
(3,  '2022-03-14', 299.00, 'paid'),
(3,  '2022-04-14', 299.00, 'paid'),
(4,  '2022-04-05', 799.00, 'paid'),
(5,  '2022-04-20',  99.00, 'paid'),
(5,  '2022-05-20',  99.00, 'paid'),
(6,  '2022-05-10', 299.00, 'paid'),
(6,  '2022-06-10', 299.00, 'failed'),
(7,  '2022-06-01',  99.00, 'paid'),
(8,  '2022-06-18', 799.00, 'paid'),
(9,  '2022-07-09',  99.00, 'paid'),
(10, '2022-07-22', 299.00, 'paid');

INSERT INTO support_tickets (customer_id, created_date, category, resolved) VALUES
(1,  '2022-02-10', 'Billing',        true),
(2,  '2022-03-15', 'Technical',      true),
(2,  '2022-04-02', 'Billing',        false),
(4,  '2022-04-20', 'Account Access', true),
(5,  '2022-05-01', 'Technical',      true),
(6,  '2022-06-15', 'Billing',        false),
(7,  '2022-06-05', 'Technical',      true),
(8,  '2022-07-01', 'Account Access', true),
(9,  '2022-07-15', 'Billing',        false),
(10, '2022-08-01', 'Technical',      true);
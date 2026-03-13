/*How many active subscribers do we have per plan,
and what is the monthly recurring revenue each plan generates?*/

SELECT
    plan_name,
    COUNT(*) AS active_subscribers,
    SUM(monthly_price) AS monthly_recurring_revenue
FROM subscriptions
WHERE end_date IS NULL
GROUP BY plan_name
ORDER BY monthly_recurring_revenue DESC;



/*How many customers have ended their subscriptions,
and how long did they stay before canceling?*/

SELECT
    c.company_name,
    c.industry,
    s.plan_name,
    s.start_date,
    s.end_date,
    (s.end_date - s.start_date) AS days_as_customer
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
WHERE s.end_date IS NOT NULL
ORDER BY days_as_customer ASC;



/*What is the churn rate for each subscription plan?
Churn rate = (lost customers / total customers) * 100 */

WITH plan_totals AS (
    SELECT
        plan_name,
        COUNT(*) AS total_subscribers,
        COUNT(*) FILTER (WHERE end_date IS NOT NULL) AS lost_customers
    FROM subscriptions
    GROUP BY plan_name
)
SELECT
    plan_name,
    total_subscribers,
    lost_customers,
    ROUND(lost_customers::numeric / total_subscribers * 100.0, 2) AS churn_rate_pct
FROM plan_totals
ORDER BY churn_rate_pct DESC;



/*What is total revenue collected per month, and how does it trend over time?
I do find this formula interesting as it uses a window function on a aggrgated field.*/

SELECT
    DATE_TRUNC('month', payment_date) AS month,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_revenue,
    SUM(SUM(amount)) OVER (ORDER BY DATE_TRUNC('month', payment_date))  AS running_total_revenue
FROM payments
WHERE status = 'paid'
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY month;


/*Another approach would be to use a CTE to obtain the month, total_payments, and total_revenue.
Then use a SUM window function on total_revenue over the month as seen below.*/

WITH monthly_totals AS (
    SELECT
        DATE_TRUNC('month', payment_date) AS month,
        SUM(amount) AS total_revenue,
        COUNT(*) AS total_payments
    FROM payments
    WHERE status = 'paid'
    GROUP BY DATE_TRUNC('month', payment_date)
)
SELECT
    month,
    total_payments,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY month) AS running_total_revenue
FROM monthly_totals
ORDER BY month;



/*Which customers have failed payments, and do they also have unresolved support tickets?*/

SELECT
    c.company_name,
    c.industry,
    COUNT(p.payment_id) AS failed_payments,
    COUNT(t.ticket_id) AS open_tickets
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
JOIN payments p ON s.subscription_id = p.subscription_id
LEFT JOIN support_tickets t
    ON c.customer_id = t.customer_id
    AND t.resolved = false
WHERE p.status = 'failed'
GROUP BY c.company_name, c.industry
ORDER BY failed_payments DESC;



/*What is the total revenue collected from each customer for the duration of their subscription?*/

SELECT
    c.company_name,
    c.industry,
    s.plan_name,
    s.start_date,
    s.end_date,
    SUM(p.amount) AS lifetime_revenue
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
JOIN payments p ON s.subscription_id = p.subscription_id
WHERE p.status = 'paid'
GROUP BY
    c.company_name, c.industry,
    s.plan_name, s.start_date, s.end_date
ORDER BY lifetime_revenue DESC;
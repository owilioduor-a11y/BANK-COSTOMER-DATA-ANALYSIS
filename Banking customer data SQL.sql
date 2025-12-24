SELECT * FROM banking_customer_data
LIMIT 10

--1:High-Value Customer Identification by Tier
--Determining if the loyalty_classification  accurately reflects
--the total liquidity held across checking and saving accounts.

SELECT 
    loyalty_classification, 
    ROUND(AVG(checking_accounts + saving_accounts)::numeric, 2) AS avg_liquid_assets,
    COUNT(client_id) AS total_customers
FROM banking_customer_data
GROUP BY loyalty_classification
ORDER BY avg_liquid_assets DESC;

--2. Age-Based Financial Health
--Analyze which age_group holds the highest estimated_income 
--and most properties_owned to identify prime targets 
--for wealth management.

SELECT 
    age_group, 
    ROUND(AVG(estimated_income)::numeric, 2) AS avg_income,
    ROUND(AVG(properties_owned), 2) AS avg_property_holdings,
    MAX(estimated_income) AS peak_income
FROM banking_customer_data
GROUP BY age_group
ORDER BY avg_income DESC;


--3. Occupation & Wealth Correlation
--Identify the top 5 occupations with the highest superannuation_savings 
--to understand retirement preparedness across industries.

SELECT 
    occupation, 
    ROUND(AVG(superannuation_savings)::numeric, 2) AS avg_retirement_savings
FROM banking_customer_data
GROUP BY occupation
ORDER BY avg_retirement_savings DESC
LIMIT 5;


--4:Customer Longevity vs. Segment Validation
--Verify if the customer_segment labels (e.g., "older_customers")
--align with the actual years_since_joined.

SELECT 
    customer_segment, 
    ROUND(AVG(years_since_joined)::numeric, 1) AS avg_tenure,
    COUNT(*) AS customer_count
FROM banking_customer_data
GROUP BY customer_segment
ORDER BY avg_tenure DESC;


--5:Banking Contact Portfolio Analysis
--Evaluate the total value of bank_deposits managed
--by each banking_contact to assess workload and performance.

SELECT 
    banking_contact, 
    COUNT(client_id) AS client_load,
    ROUND(SUM(bank_deposits)::numeric, 2) AS total_deposits_managed,
    ROUND(AVG(bank_deposits)::numeric, 2) AS avg_deposit_per_client
FROM banking_customer_data
GROUP BY banking_contact
ORDER BY total_deposits_managed DESC;

--6. Risk Weighting vs. Credit Exposure
--Identify customers with a high risk_weighting who 
--also carry significant credit_card_balance or bank_loans.

SELECT 
    client_id, 
    account_holder, 
    risk_weighting, 
    (credit_card_balance + bank_loans) AS total_debt_exposure
FROM banking_customer_data
WHERE risk_weighting >= 4  
ORDER BY total_debt_exposure DESC;

--7. Nationality & Foreign Currency Engagement
--Analyze which nationalities are most likely 
--to hold foreign_currency_account assets.

SELECT 
    nationality, 
    COUNT(client_id) AS total_clients,
    SUM(CASE WHEN foreign_currency_account > 0 THEN 1 ELSE 0 END) AS fca_holders,
    ROUND(AVG(foreign_currency_account)::numeric, 2) AS avg_fca_balance
FROM banking_customer_data
GROUP BY nationality
ORDER BY avg_fca_balance DESC;

--8. Debt-to-Asset Ratio Analysis
--Identify clients whose total bank debt 
--exceeds their total bank deposits.

SELECT 
    client_id, 
    account_holder, 
    (bank_loans + credit_card_balance) AS total_liabilities,
    (bank_deposits + checking_accounts + saving_accounts) AS total_assets,
    
    ROUND(
        ((bank_loans + credit_card_balance) / 
        NULLIF(bank_deposits + checking_accounts + saving_accounts, 0))::numeric, 
    2) AS debt_asset_ratio
FROM banking_customer_data
WHERE (bank_loans + credit_card_balance) > (bank_deposits + checking_accounts + saving_accounts)
ORDER BY debt_asset_ratio DESC;

--9. New Member Growth Patterns
--Compare the estimated_income of legacy members (joined > 10 years ago) vs. new members.

SELECT 
    CASE 
        WHEN years_since_joined > 10 THEN 'Legacy Member' 
        ELSE 'New Member' 
    END AS member_status,
    ROUND(AVG(estimated_income)::numeric, 2) AS avg_income,
    ROUND(SUM(business_lending)::numeric, 2) AS total_business_loans
FROM banking_customer_data
GROUP BY 1;


--10. Credit Card Utilization by Age Group
--Measure the average amount_of_credit_cards held by "Young Adults" 
--to determine market penetration for credit products

SELECT 
    age_group, 
    ROUND(AVG(amount_of_credit_cards)::numeric, 2) AS avg_cards_per_person,
    ROUND(SUM(credit_card_balance)::numeric, 2) AS group_total_debt
FROM banking_customer_data
WHERE age_group = 'Young Adult'
GROUP BY age_group;








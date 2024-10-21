create database ibm_churn;

Select * from customer_churn_table;


----#total employees 
SELECT 
    COUNT(*)
FROM
    customer_Churn_table;
    
    
#Query 1: Considering the top 5 groups with the highest average monthly charges among churned customers, how can personalized offers be tailored based on age, gender, 
#and contract type to potentially improvecustomer retention rates?    

SELECT 
    CASE 
        WHEN Age BETWEEN 19 AND 29 THEN '19-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 69 THEN '60-69'
        WHEN Age BETWEEN 70 AND 80 THEN '70-80'
        ELSE 'Unknown'
    END AS Age_Group,
    Gender,
    Contract,
    round(AVG(`Monthly Charge`),2) AS Avg_Monthly_Charges
FROM 
    customer_churn_table
WHERE 
    `Churn Label` = 'Yes'    
GROUP BY 
    Age_Group, Gender, Contract
ORDER BY 
    Avg_Monthly_Charges DESC
LIMIT 5;

#Query 2: What are the feedback or complaints from
#those churned customers

select `Customer ID`,`Churn Reason`
from customer_churn_table
where `Churn Label` = 'Yes';


#Query 3: How does the payment method influence churn behavior?

select `Payment Method`, count(*) as total_customers
from customer_churn_table
where `Churn Label` = 'Yes'
group by `Payment Method`
order by total_customers desc;

SELECT 
    `Payment Method`, 
    COUNT(*) AS Total_Customers,
    COUNT(CASE WHEN `Churn Label` = 'Yes' THEN 1 END) AS Churned_Customers,
    COUNT(CASE WHEN `Churn Label` = 'No' THEN 1 END) AS Retained_Customers,
    (COUNT(CASE WHEN `Churn Label` = 'Yes' THEN 1 END) / COUNT(*)) * 100 AS Churn_Rate
FROM 
    customer_churn_table
GROUP BY 
    `Payment Method`
ORDER BY 
    Churn_Rate DESC;











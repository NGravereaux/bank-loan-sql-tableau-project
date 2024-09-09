USE bank_loan_project;
SHOW FULL TABLES;

SELECT * FROM db1;
SELECT * FROM db2;

SELECT COUNT(*) FROM db1;
SELECT COUNT(*) FROM db2;

# KPI-1: loan_amount_per_year ---------------------------------------------------------------------------
SELECT YEAR(issue_D) AS year_of_issue_d, SUM(loan_amnt) AS total_loan_amnt
FROM db1
GROUP BY year_of_issue_d
ORDER BY year_of_issue_d;

# KPI-2:  Revolving Balance by Grade and Subgrade --------------------------------------------------------
SELECT grade, sub_grade, SUM(revol_bal) AS total_revol_bal
FROM db1 INNER JOIN db2
ON(db1.id = db2.id)
GROUP BY grade, sub_grade
ORDER BY grade, sub_grade;

#KPI-3: Total payment for Verified and Non Verified Status-----------------------------------------------------
SELECT verification_status, ROUND(SUM(total_pymnt),2) AS total_payment
FROM db1 INNER JOIN db2
ON(db1.id = db2.id)
GROUP BY verification_status;

#KPI-4: Loan Status by State and Last Credit Pull Date------------------------------------------
SELECT addr_State, last_Credit_pull_D, loan_Status
FROM db1 INNER JOIN db2
ON(db1.id = db2.id)

GROUP BY addr_State, last_Credit_pull_D, loan_Status
ORDER BY last_Credit_pull_D; 

#KPI-5: Home ownership vs last payments date status------------------------------------------
SELECT
home_ownership,
last_pymnt_d,
ROUND(SUM(last_pymnt_amnt),2) AS total_payment
FROM db1 INNER JOIN db2 ON (db1.id = db2.id)
GROUP BY home_ownership, last_pymnt_d
ORDER BY last_pymnt_d DESC, home_ownership DESC;

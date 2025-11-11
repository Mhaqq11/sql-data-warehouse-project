/*
==========================================================================
Quality Checks
==========================================================================
Script Purpose:
  This script performs quality checks to validate the integrity, consistency,
  and accuracy of the Gold layer. These checks ensure:
  - Uniqueness of surrogate keys in dimension tables.
  - Referntial integrity between fact and dimension tables.
  - Valdation of relationships in the data model for analytical purposes.

Usage Notes:
  - Run these checks after data loading Silver Layer.
  - Investigate and resilve any discrepancies found during the checks.
=========================================================================
*/

-- ======================================================================
-- Checking 'gold.dim_customers'
-- ======================================================================
-- Check for uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results
SELECT customer_key, COUNT(*) FROM gold.dim_customers
GROUP BY customer key
HAVING COUNT(*) > 1;
-- ======================================================================


-- Foreign Key Integrity(Dimensions)
SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
WHERE c.customer_key IS NULL


SELECT DISTINCT
		ci.cst_gndr,
		ca.gen,
		CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is the Master for gender Info
			 ELSE COALESCE(ca.gen, 'n/a')
		END AS new_gen
	FROM silver.crm_cust_info ci
	LEFT JOIN silver.erp_cust_az12 ca
	ON		  ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 la
	ON		  ci.cst_key = la.cid
	ORDER BY 1,2

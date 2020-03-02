SELECT 'J-HEALTH' AS receipt_type, RECEIPT_100.rid as receipt_rid, RECEIPT_100.billing_date, INSURER_000.insurer_jurisdiction_tcd,
       INSURER_000.insurer_individual_number, INSURER_000.insurer_name, PRACTITIONER_000.practitioner_number, FACILITY_000.facility_number,
	   FACILITY_010.operating_organization_code,FACILITY_000.facility_name,RECEIPT_100.total_amount,RECEIPT_100.billing_amount,RECEIPT_100.insurer_pending_class_tcd,
	   RECEIPT_100.treatment_month,CONCAT(PRACTITIONER_000.first_name,'\u3000', PRACTITIONER_000.last_name) AS practitioner_name,
	   CONCAT(RECEIPT_100.patient_first_name_kana, ' ', RECEIPT_100.patient_last_name_kana) AS patient_name,TOTAL_MONEY_310.total_reconcile_amount,
	   RECEIPT_100.billing_amount - (CASE WHEN TOTAL_MONEY_310.total_reconcile_amount IS NOT NULL THEN TOTAL_MONEY_310.total_reconcile_amount ELSE 0 END) AS remaining_billing_amount,
	   RECEIPT_100.registered_symbol_number,RECEIPT_100.insured_symbol,RECEIPT_100.public_expense_bearer_number_1,RECEIPT_100.public_expense_bearer_number_2,RECEIPT_100.benefit_rate,RECEIPT_100.partial_burden_amount,RECEIPT_100.j_head_family_class_tcd AS head_family_class_tcd,
	   RECEIPT_100.insurance_category_number AS insurance_type_tcd,RECEIPT_100.relation_insurance_category_number, CONCAT(RECEIPT_100.insured_first_name_kana, ' ', RECEIPT_100.insured_last_name_kana) AS insured_name,
	   CASE WHEN RECEIPT_100.insurance_category_number > 51 THEN RELATED_RECEIPT.insurer_number ELSE '' END AS main_insurer_number,
	   CASE WHEN RECEIPT_100.insurance_category_number > 51 THEN RELATED_RECEIPT.billing_date ELSE '' END AS main_billing_date,
	   CASE WHEN RELATED_RECEIPT.insurer_return_flag = 1 THEN '•ÛŒ¯ŽÒ•Ô–ßÏ' 
	        WHEN RELATED_RECEIPT.insurer_pending_flag = 1 THEN '•ÛŒ¯ŽÒ•Û—¯’†' 
			WHEN RELATED_RECEIPT.insurer_reduction_flag = 1 AND RELATED_RECEIPT.payment_date IS NULL THEN 'Œ¸Šz' 
			WHEN  RELATED_RECEIPT.insurer_reduction_flag = 1 AND RELATED_RECEIPT.payment_date IS NOT NULL THEN 'Œ¸Šz“ü‹àÏ'
			WHEN RELATED_RECEIPT.payment_date IS NOT NULL THEN '“ü‹àÏ' ELSE '' END AS main_system_insurance_status,
	   CASE WHEN RECEIPT_100.insurance_category_number > 51 THEN RELATED_RECEIPT.payment_date ELSE '' END AS main_payment_date,
	   CASE WHEN RECEIPT_100.insurance_category_number > 51 THEN RELATED_RECEIPT.billing_amount ELSE '' END AS main_billing_amount
FROM RECEIPT_100
INNER JOIN ORGANIZATION_000 ON ORGANIZATION_000.did = RECEIPT_100.organization_000_d_id
INNER JOIN FACILITY_000 ON RECEIPT_100.facility_000_d_id = FACILITY_000.did AND FACILITY_000.organization_000_d_id = ORGANIZATION_000.did AND FACILITY_000.delete_flag = 0
INNER JOIN PRACTITIONER_000 ON PRACTITIONER_000.did = RECEIPT_100.practitioner_000_d_id AND PRACTITIONER_000.organization_000_d_id = ORGANIZATION_000.did
INNER JOIN FACILITY_010 ON PRACTITIONER_000.did = FACILITY_010.practitioner_000_d_id AND FACILITY_000.did = FACILITY_010.facility_000_d_id
INNER JOIN INSURER_000 ON RECEIPT_100.insurer_000_d_id = INSURER_000.did
LEFT JOIN (SELECT MONEY_310.receipt_100_r_id,SUM(MONEY_310.reconcile_amount) AS total_reconcile_amount
           FROM  MONEY_310
		   WHERE MONEY_310.organization_000_d_id = %(session_company)s
		   GROUP BY MONEY_310.receipt_100_r_id) AS TOTAL_MONEY_310
		 ON RECEIPT_100.rid = TOTAL_MONEY_310.receipt_100_r_id
LEFT JOIN RECEIPT_100 AS RELATED_RECEIPT
		 ON RELATED_RECEIPT.rid = RECEIPT_100.relation_receipt_r_id AND RELATED_RECEIPT.organization_000_d_id = ORGANIZATION_000.did AND RELATED_RECEIPT.delete_flag = 0
WHERE RECEIPT_100.billing_date IS NOT NULL AND RECEIPT_100.association_return_flag = 0 AND RECEIPT_100.delete_flag = 0 
		       AND RECEIPT_100.organization_000_d_id = %(session_company)s AND RECEIPT_100.payment_date IS NULL 
			   AND RECEIPT_100.insurer_return_flag = 0 AND ((RECEIPT_100.billing_date >= %(billing_date_from)s 
			   AND RECEIPT_100.billing_date <= %(billing_date_to)s)) AND ((RECEIPT_100.insurance_category_number >= %(insurance_category_number_from)s 
			   AND RECEIPT_100.insurance_category_number <= %(insurance_category_number_to)s)) 
			   AND ((INSURER_000.insurer_jurisdiction_tcd >= %(insurer_jurisdiction_tcd_from)s 
			   AND INSURER_000.insurer_jurisdiction_tcd <= %(insurer_jurisdiction_tcd_to)s)) AND (FACILITY_000.address_pref_tcd <> %(address_pref_tcd)s)
			   AND  (((INSURER_000.general_insurer_flag = 1) AND (INSURER_000.insurer_individual_number = %(insurer_individual_number)s))  
			   OR  ((INSURER_000.general_insurer_flag = 0) AND ((INSURER_000.insurer_individual_number >= %(insurer_individual_number_from)s 
			   AND INSURER_000.insurer_individual_number <= %(insurer_individual_number_to)s)))) AND (RECEIPT_100.association_pending_flag = 1)
			   AND ((PRACTITIONER_000.practitioner_number >= %(practitioner_number_from)s AND PRACTITIONER_000.practitioner_number <= %(practitioner_number_to)s))
			   AND ((FACILITY_000.facility_number >= %(facility_number_from)s AND FACILITY_000.facility_number <= %(facility_number_to)s))
			   AND ((RECEIPT_100.registered_symbol_number >= %(registered_symbol_number_from)s 
			   AND RECEIPT_100.registered_symbol_number <= %(registered_symbol_number_to)s)) 
			   AND ((FACILITY_010.operating_organization_code >= %(operating_organization_code_from)s 
			   AND FACILITY_010.operating_organization_code <= %(operating_organization_code_to)s))
			   AND ( INSURER_000.rid IN ('658cab54-05f7-11ea-9785-0a7f6911963d') OR  INSURER_000.rid IS NULL  )  
			   AND ( FACILITY_010.rid IN ('464eadaa-f6ec-11e9-9785-0a7f6911963d', '464ead61-f6ec-11e9-9785-0a7f6911963d', '464eac06-f6ec-11e9-9785-0a7f6911963d') 
			   OR  FACILITY_010.rid IS NULL  )  AND ( PRACTITIONER_000.rid IN ('f47e3001-0f68-11ea-9785-0a7f6911963d', 'f47e2d94-0f68-11ea-9785-0a7f6911963d', 'f47e2f2a-0f68-11ea-9785-0a7f6911963d') 
			   OR  PRACTITIONER_000.rid IS NULL  )  AND ( FACILITY_000.rid IN ('37d8c751-15a8-11ea-9785-0a7f6911963d') 
			   OR  FACILITY_000.rid IS NULL  )  AND ( ORGANIZATION_000.rid IN ('d33c4b28-f3a2-11e9-9785-0a7f6911963d', 'd33c4e5e-f3a2-11e9-9785-0a7f6911963d', 'd33c4f2e-f3a2-11e9-9785-0a7f6911963d', 'd33c4f79-f3a2-11e9-9785-0a7f6911963d', 'd33c4edd-f3a2-11e9-9785-0a7f6911963d') 
			   OR  ORGANIZATION_000.rid IS NULL  )
ORDER BY FACILITY_000.facility_number,CAST(INSURER_000.insurer_individual_number AS UNSIGNED),
         PRACTITIONER_000.practitioner_number


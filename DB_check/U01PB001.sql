SELECT CONCAT(RECEIPT_100.insurance_category_number,INSURER_000.insurer_jurisdiction_tcd,
	   FACILITY_000.address_pref_tcd,PRACTITIONER_000.practitioner_number) AS block_id,
	   INSURER_000.did AS row_id,RECEIPT_100.insurance_category_number,RECEIPT_100.rid,
	   RECEIPT_100.billing_date,FACILITY_001.registered_symbol_number,CONCAT(PRACTITIONER_000.last_name, '\u3000',
	   PRACTITIONER_000.first_name) AS practitioner_full_name,FACILITY_000.facility_name,
	   CONCAT(FACILITY_000.address_pref_tcd,FACILITY_000.facility_number,PRACTITIONER_000.practitioner_number) AS membership_number,
	   INSURER_000.insurer_jurisdiction_tcd,INSURER_000.insurer_name,INSURER_000.insurer_number,
	   RECEIPT_100.j_head_family_class_tcd,RECEIPT_100.total_amount,ORGANIZATION_001.for_insurers_name,
	   FACILITY_010.operating_organization_code,INSURER_000.general_insurer_d_id

FROM RECEIPT_100 
INNER JOIN ORGANIZATION_000 ON ORGANIZATION_000.did = RECEIPT_100.organization_000_d_id 
INNER JOIN ORGANIZATION_001 ON ORGANIZATION_001.organization_000_d_id = ORGANIZATION_000.did
INNER JOIN PRACTITIONER_000 ON PRACTITIONER_000.did = RECEIPT_100.practitioner_000_d_id 
           AND PRACTITIONER_000.organization_000_d_id = ORGANIZATION_000.did
INNER JOIN FACILITY_001 ON FACILITY_001.practitioner_000_d_id = PRACTITIONER_000.did 
           AND FACILITY_001.organization_000_d_id = ORGANIZATION_000.did
INNER JOIN FACILITY_000 ON FACILITY_000.did = FACILITY_001.facility_000_d_id 
           AND FACILITY_000.did = RECEIPT_100.facility_000_d_id 
           AND FACILITY_000.organization_000_d_id = ORGANIZATION_000.did
INNER JOIN INSURER_000 ON INSURER_000.did = RECEIPT_100.insurer_000_d_id
INNER JOIN INSURER_001 ON INSURER_001.insurer_000_d_id = INSURER_000.did
INNER JOIN FACILITY_010 ON FACILITY_010.facility_001_d_id = FACILITY_001.did 
           AND FACILITY_010.insurer_jurisdiction_tcd = INSURER_000.insurer_jurisdiction_tcd
           AND FACILITY_010.organization_000_d_id = ORGANIZATION_000.did'	   
		   
WHERE ORGANIZATION_000.did = %(session_company)s AND RECEIPT_100.billing_date IS NULL
      AND ((RECEIPT_100.closing_target_date >= %(closing_target_date_from)s 
	  AND RECEIPT_100.closing_target_date <= %(closing_target_date_to)s))
	  AND (RECEIPT_100.delete_flag = 0) AND (RECEIPT_100.receipt_check_date IS NOT NULL
	  AND (RECEIPT_100.receipt_error IS NULL OR RECEIPT_100.receipt_error = ''))
	  AND (RECEIPT_100.association_return_flag = 0 
	  AND (RECEIPT_100.association_pending_class_tcd IS NULL OR RECEIPT_100.association_pending_class_tcd = ''))
	  AND (FACILITY_000.opening_class_tcd = 'J')
	  AND (FACILITY_001.practitioner_license_tcd IN ('J')
	  AND FACILITY_001.registered_practitioner_tcd = 'A') 
	  AND (ORGANIZATION_001.opening_class_tcd = 'J')
	  AND (INSURER_001.opening_class_tcd = 'J')
	  AND INSURER_001.receipt_summary_report_1_output_class_flag = 1
	  AND (RECEIPT_100.insurance_category_number IN %(insurance_category_number)s)
	  AND (INSURER_000.insurer_jurisdiction_tcd IN %(insurer_jurisdiction_tcd)s)
	  AND ((INSURER_000.insurer_jurisdiction_tcd >= %(insurer_jurisdiction_tcd_from)s 
	  AND INSURER_000.insurer_jurisdiction_tcd <= %(insurer_jurisdiction_tcd_to)s))
	  AND ((PRACTITIONER_000.practitioner_number >= %(practitioner_number_from)s
	  AND PRACTITIONER_000.practitioner_number <= %(practitioner_number_to)s))
	  AND ((FACILITY_000.facility_number >= %(facility_number_from)s 
	  AND FACILITY_000.facility_number <= %(facility_number_to)s))
	  AND (ORGANIZATION_000.rid IN ('d33c4b28-f3a2-11e9-9785-0a7f6911963d', 'd33c4e5e-f3a2-11e9-9785-0a7f6911963d', 'd33c4f2e-f3a2-11e9-9785-0a7f6911963d', 'd33c4f79-f3a2-11e9-9785-0a7f6911963d', 'd33c4edd-f3a2-11e9-9785-0a7f6911963d'))
	  AND (ORGANIZATION_001.rid IN ('d4d9fc9a-f3a2-11e9-9785-0a7f6911963d', 'd4d9fd89-f3a2-11e9-9785-0a7f6911963d', 'd4d9fd48-f3a2-11e9-9785-0a7f6911963d', 'd4d9fdc9-f3a2-11e9-9785-0a7f6911963d', 'd4d9fa5d-f3a2-11e9-9785-0a7f6911963d', 'd4d9fcfd-f3a2-11e9-9785-0a7f6911963d')) 
	  AND (FACILITY_010.rid IN ('464eadaa-f6ec-11e9-9785-0a7f6911963d', '464ead61-f6ec-11e9-9785-0a7f6911963d', '464eac06-f6ec-11e9-9785-0a7f6911963d')) 
	  AND (PRACTITIONER_000.rid IN ('f47e3001-0f68-11ea-9785-0a7f6911963d', 'f47e2d94-0f68-11ea-9785-0a7f6911963d', 'f47e2f2a-0f68-11ea-9785-0a7f6911963d')) 
	  AND (INSURER_000.rid IN ('658cab54-05f7-11ea-9785-0a7f6911963d'))"		   
	  
ORDER BY ISNULL(INSURER_000.general_insurer_d_id),RECEIPT_100.insurance_category_number,INSURER_000.insurer_jurisdiction_tcd,FACILITY_000.address_pref_tcd,PRACTITIONER_000.practitioner_number,RECEIPT_100.j_insurance_class_tcd,RECEIPT_100.facility_pref_number_tcd,RECEIPT_100.insurer_number'	  

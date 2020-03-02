name_kana) = 'tttr' AND FC01.registered_symbol_number = 'ggggg' A' at line 42")
sqlstr
SELECT PR00.rid,PR00.did,PR00.apply_start_date,PR00.apply_end_date,PR00.practitioner_number,
       PR00.last_name,PR00.first_name,PR00.last_name_kana,PR00.first_name_kana,PR00.birth_date,
	   PR00.sex_tcd,FC01.facility_000_d_id,FC01.practitioner_000_d_id,FC01.practitioner_license_tcd,
	   FC01.registered_practitioner_tcd,FC01.apply_start_date,FC01.apply_end_date,
	   FC00.address_pref_tcd,FC00.address_city,FC00.address_town,FC00.address_street,FC00.address_city_kana,
	   FC00.address_town_kana,FC00.address_street_kana,FC00.facility_name,FC00.facility_name_kana,
	   FC00.phone_number_1,PR01a.issuer_name,PR01a.license_number,PR01a.license_acquisition_date,
	   PR01b.issuer_name,PR01b.license_number,PR01b.license_acquisition_date,PR01c.issuer_name,
	   PR01c.license_number,PR01c.license_acquisition_date,PR01d.issuer_name,PR01d.license_number,
	   PR01d.license_acquisition_date,PR00.zip_code,PR00.address_pref_tcd,PR00.address_city,
	   PR00.address_town,PR00.address_street,PR00.address_city_kana,PR00.address_town_kana,
	   PR00.address_street_kana,PR00.phone_number_1,FC00.apply_start_date,FC00.apply_end_date,
	   FC00.founder_last_name,FC00.founder_first_name,FC00.founder_last_name_kana,
	   FC00.founder_first_name_kana,FC00.founder_zip_code,FC00.founder_address_pref_tcd,
	   FC00.founder_address_city,FC00.founder_address_town,FC00.founder_address_street,
	   FC00.founder_address_city_kana,FC00.founder_address_town_kana,FC00.founder_address_street_kana,
	   FC00.founder_phone_number,FC00.founder_birth_date,FC01.registered_symbol_number,
	   FC01.registered_symbol_number_get_date,FC01.mutual_aid_consent_number,
	   FC01.mutual_aid_consent_number_get_date,FC01.local_mutual_aid_consent_number,
	   FC01.local_mutual_aid_consent_number_get_date,FC01.ministry_of_defense_number,
	   FC01.ministry_of_defense_number_get_date,FC01.workersaccident_designation_number,
	   FC01.workersaccident_designation_number_get_date,MB00.member_number,MB00.last_name,
	   MB00.first_name

FROM PRACTITIONER_000 AS PR00
LEFT OUTER JOIN FACILITY_001 AS FC01 ON PR00.rid = FC01.rid AND FC01.delete_flag = '0'
LEFT OUTER JOIN FACILITY_000 AS FC00 ON PR00.rid = FC00.rid AND FC00.delete_flag = '0'
LEFT OUTER JOIN PRACTITIONER_001 AS PR01 ON PR00.rid = PR01.rid
LEFT OUTER JOIN PRACTITIONER_001 AS PR01 ON PR00.did = PR01a.did AND PR01a.practitioner_license_tcd = 'J' 
     AND PR01a.delete_flag = '0'
LEFT OUTER JOIN PRACTITIONER_001 AS PR01b ON PR00.did = PR01b.did AND PR01b.practitioner_license_tcd = 'A'
     AND PR01b.delete_flag = '0'
LEFT OUTER JOIN PRACTITIONER_001 AS PR01 ON PR00.did = PR01c.did AND PR01c.practitioner_license_tcd = 'Q' 
     AND PR01c.delete_flag = '0'
LEFT OUTER JOIN PRACTITIONER_001 AS PR01d ON PR00.did = PR01d.did AND PR01d.practitioner_license_tcd = 'M' 
     AND PR01d.delete_flag = '0' 
LEFT OUTER JOIN MEMBER_000 AS MB00 ON PR00.rid = MB00.rid AND MB00.delete_flag = '0' 

WHERE PR00.apply_start_date >= '2019/12/01' AND PR00.apply_end_date <= '2019/12/15' 
      AND PR00.practitioner_number = '2321' AND CONCAT(PR00.last_name,PR00.first_name) = '4545' 
	  AND CONCAT(PR00.last_name_kana,PR00.first_name_kana) = 'sdsad' 
	  AND FC01.facility_000_d_id = '45g55' AND FC01.practitioner_000_d_id = '343434' 
	  AND FC01.practitioner_license_tcd = 'dggg' AND FC01.registered_practitioner_tcd = '3432r?' 
	  AND FC01.apply_start_date >= '2019/12/29' AND FC01.apply_end_date <= '2019/12/31' 
	  AND PR01.issuer_name = 'rrrr' AND PR01.license_number = 'rrrrr' 
	  AND PR01.license_acquisition_date = 'rtrtrttrt' AND FC00.apply_start_date >= '2019/12/23' 
	  AND FC00.apply_end_date <= '2019/12/29' AND CONCAT(FC00.founder_last_name,FC00.founder_first_name)= 'trrgg' 
	  AND CONCAT(FC00.founder_last_name_kana FC00.founder_first_name_kana) = 'tttr' 
	  AND FC01.registered_symbol_number = 'ggggg' AND FC01.mutual_aid_consent_number = '876867' 
	  AND FC01.local_mutual_aid_consent_number = '676767' AND FC01.ministry_of_defense_number = '876876' 
	  AND FC01.workersaccident_designation_number = '87678' AND MB00.member_number = '876867' 
	  AND CONCAT(MB00.last_name,MB00.first_name) = 'ttttt' AND PR00.delete_flag = '0'


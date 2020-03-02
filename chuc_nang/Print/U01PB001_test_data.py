#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

2019/08/06 DuongTrung@Gisoft 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/08/06'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# zen
from zm.common.model import getClass

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------


class Request:
    session = {
        'session_user_rid': '86939af3-8c1b-11e9-a2e2-8cec4b535f9f',
        'session_user_did': '7bcb60cf-d132-4afa-a22e-1347d603d3d6',
        'session_user_name': 'zen tester',
        'session_user_manager': 'manager',
        'session_company': 'd4cbacc0-aa8d-42c9-83c3-535d3fc8066b',
        'session_company_name': '大信協組合',
    }


class U01PB001TestData:
    def __init__(self, *args, **kwargs):
        self.request = Request()
        self.organization_000_did = self.request.session['session_company']

    def test_data_1(self):
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': 'a8b8531a-f25a-41ef-8d13-c0b4e586247d',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '43',
            'j_head_family_class_tcd': '2',
            'total_amount': 15600,
            'insurer_number': '15265',
            'facility_pref_number_tcd': '15',
        }
        receipt_model(**params).save(self.request)

        fac_0_model = getClass('FACILITY_000')
        params = {
            'did': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'revision': 10,
            'delete_flag': 0,
            'temporary_registration_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'opening_class_tcd': 'J',
            'facility_name': '療しふ変国同',
            'address_pref_tcd': '27',
            'facility_number': '48',
        }
        fac_0_model(**params).save(self.request)

        fac_1_model = getClass('FACILITY_001')
        params = {
            'did': '7ecf0b1d-8090-40dc-9355-a6ea4a8e00f6',
            'revision': 10,
            'delete_flag': 0,
            'temporary_registration_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'practitioner_license_tcd': 'J',
            'registered_practitioner_tcd': 'A',
            'registered_symbol_number': '個270081-0-1',
        }
        fac_1_model(**params).save(self.request)

        prac_0_model = getClass('PRACTITIONER_000')
        params = {
            'did': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'revision': 10,
            'delete_flag': 0,
            'temporary_registration_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'last_name': '整数',
            'first_name': '再奈神',
            'practitioner_number': '29',
        }
        prac_0_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'a8b8531a-f25a-41ef-8d13-c0b4e586247d',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '43',
            'insurer_name': '負んあ止月ヘセ肉',
            'insurer_number': '15265',
            'general_insurer_d_id': None,
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': '887edc83-49f5-4a99-855b-4133db9bd241',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'a8b8531a-f25a-41ef-8d13-c0b4e586247d',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)

        org_1_model = getClass('ORGANIZATION_001')
        params = {
            'did': 'e75d381b-188a-4825-ae38-cc438cb79ed6',
            'revision': 10,
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'opening_class_tcd': 'J',
            'for_insurers_name': '朝覧テヌハム福',
        }
        org_1_model(**params).save(self.request)

        fac_10_model = getClass('FACILITY_010')
        params = {
            'did': '0d9177ee-aeac-4901-8b92-66edf027ca0d',
            'revision': 10,
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_001_d_id': '7ecf0b1d-8090-40dc-9355-a6ea4a8e00f6',
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_jurisdiction_tcd': '15',
            'operating_organization_code': 'ABC-03-辞出タ',
            'medical_department_class_tcd': 'J',
        }
        fac_10_model(**params).save(self.request)

    def test_data_2(self):
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': 'a8b8531a-f25a-41ef-8d13-c0b4e586247d',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '43',
            'j_head_family_class_tcd': '2',
            'total_amount': 23650,
            'insurer_number': '15265',
            'facility_pref_number_tcd': '15',
        }
        receipt_model(**params).save(self.request)

    def test_data_3(self):
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': 'bc5a6d82-2a1a-4ad2-a5b2-63270896a742',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '44',
            'j_head_family_class_tcd': '2',
            'total_amount': 5900,
            'insurer_number': '23-5689',
            'facility_pref_number_tcd': '23',
        }
        receipt_model(**params).save(self.request)

        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': 'bc5a6d82-2a1a-4ad2-a5b2-63270896a742',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '44',
            'j_head_family_class_tcd': '6',
            'total_amount': 24500,
            'insurer_number': '23-5689',
            'facility_pref_number_tcd': '23',
        }
        receipt_model(**params).save(self.request)

        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': 'bc5a6d82-2a1a-4ad2-a5b2-63270896a742',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '44',
            'j_head_family_class_tcd': '6',
            'total_amount': 34600,
            'insurer_number': '23-5689',
            'facility_pref_number_tcd': '23',
        }
        receipt_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'bc5a6d82-2a1a-4ad2-a5b2-63270896a742',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '44',
            'insurer_name': '節む改構へつきほ安',
            'insurer_number': '23-5689',
            'general_insurer_d_id': None,
            'insurer_jurisdiction_tcd': '23',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': '06ae2ad5-c960-4ff6-933d-f5e08dc6bbe4',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'bc5a6d82-2a1a-4ad2-a5b2-63270896a742',
            'receipt_summary_report_1_output_class_flag': 1,
            'opening_class_tcd': 'J',
        }
        ins_1_model(**params).save(self.request)

    def test_data_4(self):
        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'bea46ae5-0380-44fe-89e4-103eacedb1a2',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '44',
            'insurer_name': '再奈神げ撃会',
            'insurer_number': '33-11999',
            'general_insurer_d_id': None,
            'general_insurer_flag': 1,
            'insurer_jurisdiction_tcd': '23',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': '32872376-efc0-4c85-b8fc-d2d81087b0b4',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'bea46ae5-0380-44fe-89e4-103eacedb1a2',
            'receipt_summary_report_1_output_class_flag': 1,
            'opening_class_tcd': 'J',
        }
        ins_1_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': '9531e8f3-a590-4da7-92cf-578bc38a7411',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '44',
            'insurer_name': '改構へつきほ安職覧',
            'insurer_number': '23-2546',
            'general_insurer_d_id': 'bea46ae5-0380-44fe-89e4-103eacedb1a2',
            'general_insurer_flag': 0,
            'insurer_jurisdiction_tcd': '23',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': '6537c2cc-3890-4c83-9f83-2c20a3040aaf',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': '9531e8f3-a590-4da7-92cf-578bc38a7411',
            'receipt_summary_report_1_output_class_flag': 1,
            'opening_class_tcd': 'J',
        }
        ins_1_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': '4bfb34cd-8c8b-47d5-b32a-8617e6f92670',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '44',
            'insurer_name': '倉タスヌ問作井ち',
            'insurer_number': '33-35435',
            'general_insurer_d_id': 'bea46ae5-0380-44fe-89e4-103eacedb1a2',
            'general_insurer_flag': 0,
            'insurer_jurisdiction_tcd': '23',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': 'dd05250d-322e-47ac-afa9-4ad98541cfba',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': '4bfb34cd-8c8b-47d5-b32a-8617e6f92670',
            'receipt_summary_report_1_output_class_flag': 1,
            'opening_class_tcd': 'J',
        }
        ins_1_model(**params).save(self.request)


        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': 'bea46ae5-0380-44fe-89e4-103eacedb1a2',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '44',
            'j_head_family_class_tcd': '2',
            'total_amount': 4750,
            'insurer_number': '33-11999',
            'facility_pref_number_tcd': '33',
        }
        receipt_model(**params).save(self.request)

        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': '9531e8f3-a590-4da7-92cf-578bc38a7411',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '44',
            'j_head_family_class_tcd': '2',
            'total_amount': 11550,
            'insurer_number': '23-2546',
            'facility_pref_number_tcd': '23',
        }
        receipt_model(**params).save(self.request)

        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': 'bb05ae42-ad7d-4d13-a44b-3c9fcf92b984',
            'practitioner_000_d_id': '4c12c26f-9b6f-4894-aaab-1b7968803721',
            'insurer_000_d_id': '4bfb34cd-8c8b-47d5-b32a-8617e6f92670',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '44',
            'j_head_family_class_tcd': '6',
            'total_amount': 37490,
            'insurer_number': '33-35435',
            'facility_pref_number_tcd': '33',
        }
        receipt_model(**params).save(self.request)

    def test_data_5(self):
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'c1b6fd08-d0cb-4ad7-a7da-d7836e865d56',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '10',
            'j_head_family_class_tcd': '6',
            'total_amount': 16450,
            'insurer_number': '両33-4321',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'c1b6fd08-d0cb-4ad7-a7da-d7836e865d56',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '10',
            'j_head_family_class_tcd': '2',
            'total_amount': 12000,
            'insurer_number': '両33-4321',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'c1b6fd08-d0cb-4ad7-a7da-d7836e865d56',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '10',
            'j_head_family_class_tcd': '6',
            'total_amount': 1050,
            'insurer_number': '両33-4321',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        
        fac_0_model = getClass('FACILITY_000')
        params = {
            'did': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'revision': 10,
            'delete_flag': 0,
            'temporary_registration_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'opening_class_tcd': 'J',
            'facility_name': '士告ハテホ道',
            'address_pref_tcd': '22',
            'facility_number': '49',
        }
        fac_0_model(**params).save(self.request)

        fac_1_model = getClass('FACILITY_001')
        params = {
            'did': 'ddcbeca0-9f24-4c64-8f95-9083bf2a239d',
            'revision': 10,
            'delete_flag': 0,
            'temporary_registration_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'practitioner_license_tcd': 'J',
            'registered_practitioner_tcd': 'A',
            'registered_symbol_number': '特670081-0-1',
        }
        fac_1_model(**params).save(self.request)

        prac_0_model = getClass('PRACTITIONER_000')
        params = {
            'did': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'revision': 10,
            'delete_flag': 0,
            'temporary_registration_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'last_name': '湧輸',
            'first_name': '視ま施能',
            'practitioner_number': '30',
        }
        prac_0_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'c1b6fd08-d0cb-4ad7-a7da-d7836e865d56',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '10',
            'insurer_name': 'ぱク築町にンな動朝フノヌヘ小',
            'insurer_number': '95869',
            'general_insurer_d_id': None,
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': 'bb69ca86-0274-4953-ae27-f4b5a70e7a26',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'c1b6fd08-d0cb-4ad7-a7da-d7836e865d56',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)

        fac_10_model = getClass('FACILITY_010')
        params = {
            'did': 'd4fce21d-b236-4475-91e8-fb84fa275cae',
            'revision': 10,
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_001_d_id': 'ddcbeca0-9f24-4c64-8f95-9083bf2a239d',
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_jurisdiction_tcd': '15',
            'operating_organization_code': '03-けに著者',
            'medical_department_class_tcd': 'J',
        }
        fac_10_model(**params).save(self.request)
 

        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'b53c8e8a-4ebb-4188-a762-ee09f947595c',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '12',
            'j_head_family_class_tcd': '6',
            'total_amount': 9800,
            'insurer_number': '95869',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'b53c8e8a-4ebb-4188-a762-ee09f947595c',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '12',
            'j_head_family_class_tcd': '6',
            'total_amount': 32000,
            'insurer_number': '95869',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'b53c8e8a-4ebb-4188-a762-ee09f947595c',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '12',
            'insurer_name': '権領博ばぼそづ',
            'insurer_number': '21616',
            'general_insurer_d_id': None,
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': '4afef2eb-39ce-4080-a6a2-83dd96118b35',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'b53c8e8a-4ebb-4188-a762-ee09f947595c',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)

        
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'a9f62922-4de2-4d31-a79d-7ea0ed711ace',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '12',
            'j_head_family_class_tcd': '6',
            'total_amount': 16450,
            'insurer_number': '5678',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'a9f62922-4de2-4d31-a79d-7ea0ed711ace',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '12',
            'j_head_family_class_tcd': '2',
            'total_amount': 10000,
            'insurer_number': '5678',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'a9f62922-4de2-4d31-a79d-7ea0ed711ace',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '12',
            'insurer_name': '事か下治烈基るざ連帯大が係',
            'insurer_number': '5678',
            'general_insurer_d_id': 'b53c8e8a-4ebb-4188-a762-ee09f947595c',
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': 'cdb9bd4d-0920-4f0b-9c91-747157fa0e41',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'a9f62922-4de2-4d31-a79d-7ea0ed711ace',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)

        
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'c91e5c94-49a3-4b27-9991-9028d84b6593',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '12',
            'j_head_family_class_tcd': '2',
            'total_amount': 3500,
            'insurer_number': '1234',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': 'c91e5c94-49a3-4b27-9991-9028d84b6593',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '12',
            'j_head_family_class_tcd': '2',
            'total_amount': 6500,
            'insurer_number': '1234',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': 'c91e5c94-49a3-4b27-9991-9028d84b6593',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '12',
            'insurer_name': 'スのえ必4西ゆわっド士告ハ',
            'insurer_number': '1234',
            'general_insurer_d_id': 'b53c8e8a-4ebb-4188-a762-ee09f947595c',
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': '3070963b-582f-4940-aec7-25d52ee676bd',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': 'c91e5c94-49a3-4b27-9991-9028d84b6593',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)

    def test_data_6(self):
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': '3248dd09-b533-4657-8f3e-891bb29d52a4',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '14',
            'j_head_family_class_tcd': '6',
            'total_amount': 14200,
            'insurer_number': '1356',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': '3248dd09-b533-4657-8f3e-891bb29d52a4',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '14',
            'j_head_family_class_tcd': '2',
            'total_amount': 24200,
            'insurer_number': '1356',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': '3248dd09-b533-4657-8f3e-891bb29d52a4',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '14',
            'j_head_family_class_tcd': '6',
            'total_amount': 3520,
            'insurer_number': '1356',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': '3248dd09-b533-4657-8f3e-891bb29d52a4',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '14',
            'insurer_name': '石オラネコ切事か',
            'insurer_number': '1356',
            'general_insurer_d_id': None,
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': 'bf94ece5-c9c0-4830-9994-fc42bce0303a',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': '3248dd09-b533-4657-8f3e-891bb29d52a4',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)


        
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': '0928c382-ef82-467d-aabe-55dc0a9ec391',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '10',
            'j_head_family_class_tcd': '6',
            'total_amount': 2000,
            'insurer_number': '11111',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': '0928c382-ef82-467d-aabe-55dc0a9ec391',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '10',
            'j_head_family_class_tcd': '2',
            'total_amount': 24200,
            'insurer_number': '11111',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)
        receipt_model = getClass('RECEIPT_100')
        params = {
            'delete_flag': 0,
            'organization_000_d_id': self.organization_000_did,
            'facility_000_d_id': '08c1e92b-a9cf-46aa-afc2-6432a2f8150f',
            'practitioner_000_d_id': '7ab7a9be-f0f5-43a8-9584-3507039970db',
            'insurer_000_d_id': '0928c382-ef82-467d-aabe-55dc0a9ec391',
            'receipt_check_date': '2019-08-19',
            'receipt_error': '',
            'billing_date': '2019-09-01',
            'closing_target_date': '2019-09-08',
            'association_return_flag': 0,
            'association_pending_class_tcd': None,
            'insurance_category_number': '10',
            'j_head_family_class_tcd': '6',
            'total_amount': 3250,
            'insurer_number': '11111',
            'facility_pref_number_tcd': '22',
        }
        receipt_model(**params).save(self.request)

        ins_0_model = getClass('INSURER_000')
        params = {
            'did': '0928c382-ef82-467d-aabe-55dc0a9ec391',
            'revision': 10,
            'delete_flag': 0,
            'insurance_category_tcd': '10',
            'insurer_name': 'ド士告ハテホ道',
            'insurer_number': '11111',
            'general_insurer_d_id': '3248dd09-b533-4657-8f3e-891bb29d52a4',
            'insurer_jurisdiction_tcd': '15',
        }
        ins_0_model(**params).save(self.request)

        ins_1_model = getClass('INSURER_001')
        params = {
            'did': 'f2fadfca-10b5-438e-8fb7-a392d5df0db0',
            'revision': 10,
            'delete_flag': 0,
            'insurer_000_d_id': '0928c382-ef82-467d-aabe-55dc0a9ec391',
            'opening_class_tcd': 'J',
            'receipt_summary_report_1_output_class_flag': 1,
        }
        ins_1_model(**params).save(self.request)

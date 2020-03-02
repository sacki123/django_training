-- Adminer 4.7.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

INSERT INTO `MONEY_300` (`rid`, `payment_source_bank_name_kana`, `payment_source_bank_branch_name_kana`, `payment_source_account_name_kana`, `deposit_date`, `deposit_amount`, `reconcile_amount`, `refund_amount`, `move_source_amount`, `move_target_amount`, `move_target_deposit_date`, `balance_amount`, `memo`, `deposit_registration_class_tcd`, `display_name`, `delete_flag`, `create_user`, `create_date`, `update_user`, `update_date`, `organization_000_d_id`, `move_target_record_r_id`, `separate_reconcile_amount`) VALUES
('5efcb2a7-304d-11ea-951f-0242ac120004',	'レソナ',	'レソナオオサカ',	'ホアン',	'2020-01-03',	9,	2,	1,	2,	1,	'2020-01-01',	7,	'ok',	NULL,	'Hoang',	0,	'zen_test',	'2020-01-01 00:00:00',	NULL,	'2020-01-01 00:00:00',	'1b19126e-03da-42b1-bdee-4a1469016739',	'5efcb2a7-304d-11ea-951f-0242ac120004',	NULL),
('d47a5f1f-304d-11ea-951f-0242ac120004',	'ミズほ',	'ミズほオオサカ',	'ゼンジュウ',	'2020-01-01',	8,	1,	1,	1,	1,	NULL,	6,	'OK',	NULL,	'EXS',	0,	'zen_tester',	'2020-01-01 00:00:00',	NULL,	'2020-01-01 00:00:00',	'1b19126e-03da-42b1-bdee-4a1469016739',	'd47a5f1f-304d-11ea-951f-0242ac120004',	NULL);

-- 2020-01-06 09:52:29

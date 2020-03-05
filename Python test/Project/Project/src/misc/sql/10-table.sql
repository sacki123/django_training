-- Project Name : 統一業務
-- Date/Time    : 2018/07/30 9:54:43
-- Author       : t_hir
-- RDBMS Type   : MySQL
-- Application  : A5:SQL Mk-2

-- 保険者組合員別振込情報
drop table if exists `TRSF0001` cascade;

create table `TRSF0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `department_type` CHAR(40) not null comment '診療科種別:1: 柔整、2:鍼灸マ'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `application_month` DATE default '1900-1-1' not null comment '請求年月:yyyy/mm/01'
  , `seq_no` INT default 0 not null comment '履歴番号'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '請求金額'
  , `bear_amount` DECIMAL(13,2) default 0 not null comment '一部負担金額'
  , `application_count` INT default 0 not null comment '請求件数'
  , `settlement_amount` SMALLINT default 0 not null comment '請求調定金額'
  , `settlement_count` DECIMAL(13,2) default 0 not null comment '請求調定件数'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `receipt_count` INT default 0 not null comment '入金件数'
  , `last_receipt_date` DATE default 0 not null comment '最終入金日'
  , `back_amount` DECIMAL(13,2) default 0 not null comment '返戻金額'
  , `back_count` INT default 0 not null comment '返戻件数'
  , `fluctuate_amount` DECIMAL(13,2) default 0 not null comment '増減金額'
  , `fluctuate_count` INT default 0 not null comment '増減件数'
  , `reservation_amount` DECIMAL(13,2) default 0 not null comment '保留金額'
  , `reservation_count` INT default 0 not null comment '保留件数'
  , `expense_charge_amount` DECIMAL(13,2) default 0 not null comment '事務手数料'
  , `send_expense_charge_amount` DECIMAL(13,2) default 0 not null comment '送金用事務手数料'
  , `self_charge_amount` DECIMAL(13,2) default 0 not null comment '本人請求金額'
  , `self_charge_count` INT default 0 not null comment '本人請求件数'
  , `family_charge_amount` DECIMAL(13,2) default 0 not null comment '家族請求金額'
  , `family_charge_count` INT default 0 not null comment '家族請求件数'
  , `association_flag` TINYINT default 0 not null comment '連合会区分:0:請求に関する連合会加入なし、1:請求に関する連合会加入あり'
  , `operator_user_id` CHAR(40) not null comment '操作担当者ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `TRSF0001_PKC` primary key (`rid`)
) comment '保険者組合員別振込情報' ;

-- 保険者督促備考情報
drop table if exists `RMND0010` cascade;

create table `RMND0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `reminder_id` CHAR(40) not null comment '保険者督促対象ID'
  , `answer_date` DATE default '1900-1-1' not null comment '回答日'
  , `answer` TEXT default '' not null comment '回答内容'
  , `staff_name` TEXT default '' not null comment '相手担当者名'
  , `plan_class_id` CHAR(40) comment '督促予定区分'
  , `answer_plan_date` DATE default '1900-1-1' not null comment '回答予定日:保険者からの回答(予定区分)に対する予定年月日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RMND0010_PKC` primary key (`rid`)
) comment '保険者督促備考情報' ;

-- 督促予定区分マスタ
drop table if exists `CNAM0187` cascade;

create table `CNAM0187` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '督促予定区分値'
  , `name` TEXT default '' not null comment '督促予定区分名'
  , `short_name` TEXT default '' not null comment '督促予定区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0187_PKC` primary key (`rid`)
) comment '督促予定区分マスタ' ;

-- 鍼灸マ労災コメント情報
drop table if exists `RCWC0160` cascade;

create table `RCWC0160` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マ労災申請ID'
  , `entry_user_id` CHAR(40) not null comment '入力担当者ID'
  , `remark_class_id` CHAR(40) not null comment 'コメント種別区分:1:保留､2: 返戻､3:削除(取消)'
  , `process_date` DATE default '1900-1-1' not null comment '処理年月日'
  , `reason_class_id` CHAR(40) comment '理由区分'
  , `reason` TEXT not null comment '理由'
  , `process_class_id` CHAR(40) comment '処理内容区分'
  , `process_content` TEXT not null comment '処理内容'
  , `comment` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0160_PKC` primary key (`rid`)
) comment '鍼灸マ労災コメント情報' ;

-- 柔整労災コメント情報
drop table if exists `RCWC0060` cascade;

create table `RCWC0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整労災申請ID'
  , `entry_user_id` CHAR(40) not null comment '入力担当者ID'
  , `remark_class_id` CHAR(40) not null comment 'コメント種別区分:1:保留､2: 返戻､3:削除(取消)'
  , `process_date` DATE default '1900-1-1' not null comment '処理年月日'
  , `reason_class_id` CHAR(40) comment '理由区分'
  , `reason` TEXT not null comment '理由'
  , `process_class_id` CHAR(40) comment '処理内容区分'
  , `process_content` TEXT not null comment '処理内容'
  , `comment` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0060_PKC` primary key (`rid`)
) comment '柔整労災コメント情報' ;

-- 柔整レセプトコメント情報
drop table if exists `RCPT0060` cascade;

create table `RCPT0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整レセプト申請ID'
  , `entry_user_id` CHAR(40) not null comment '入力担当者ID'
  , `remark_class_id` CHAR(40) not null comment 'コメント種別区分:1:保留､2: 返戻､3:削除(取消)、4:入金'
  , `process_date` DATE default '1900-1-1' not null comment '処理年月日'
  , `reason_class_id` CHAR(40) comment '理由区分'
  , `reason` TEXT not null comment '理由'
  , `process_class_id` CHAR(40) comment '処理内容区分'
  , `process_content` TEXT not null comment '処理内容'
  , `comment` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0060_PKC` primary key (`rid`)
) comment '柔整レセプトコメント情報' ;

-- 柔整レセプト状態情報
drop table if exists `RCPT0070` cascade;

create table `RCPT0070` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整レセプト申請ID'
  , `check_flag` TINYINT default 0 not null comment 'レセプトチェック済フラグ:0…レセプトデータチェック(CSBSCH)未処理
1…レセプトデータチェック(CSBSCH)処理済み'
  , `fix_flag` TINYINT default 0 not null comment 'レセプト確定フラグ:レセプト変更不可'
  , `fix_date` DATE default '1900-1-1' not null comment 'レセプト確定日'
  , `before_charge_amount` DECIMAL(13,2) default 0 not null comment '更正前請求額:保険者より一部返戻(減額)が発生した時、当初の請求額がセット。それ以外の時、0。'
  , `back_amount` DECIMAL(13,2) not null comment '返戻金額'
  , `back_date` DATE default '1900-1-1' not null comment '返戻処理日'
  , ` judge_reduction_amount` DECIMAL(13,2) default 0 not null comment '審査料還元金額:返戻によるレセプト定率会費の還元額'
  , `back_receipt_date` DATE default '1900-1-1' not null comment '返戻レセプト返送日'
  , `back_user_id` CHAR(40) comment '協会返戻担当者ID'
  , `back_request_flag` TINYINT default 0 not null comment '会員返戻依頼フラグ'
  , `back_request_date` DATE default '1900-1-1' not null comment '会員返戻依頼日:会員返戻の場合のみ'
  , `back_insurer_date` DATE default '1900-1-1' not null comment '保険者返戻依頼日'
  , `before_receipt_id` CHAR(40) comment '前回該当返戻レセプトID:エラーチェックで設定(以前に同一のレセプトがある場合）'
  , `send_date` DATE default '1900-1-1' not null comment '発送日:保険者等へ'
  , `reconciliation_class_id` CHAR(40) default 0 not null comment '消込区分:空白…未決(入金でも返戻でもない状態)
1…個別入金処理済(CNTTKE)
2…返戻済(一部返戻含む)(CNTHEN)
7…一括入金処理済(CNBKES)
1も7も入金を意味するが、使用するPGによってサインが異なる。'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `receipt_date` DATE default '1900-1-1' not null comment '入金日'
  , `remittance_flag` TINYINT default 0 not null comment '送金済フラグ'
  , `remittance_date` DATE default '1900-1-1' not null comment '送金日'
  , `payback_date` DATE default '1900-1-1' not null comment '保険者返金日'
  , `payback_amount` DECIMAL(13,2) default 0 not null comment '保険者返金金額'
  , `temporary_back_flag` TINYINT default 0 not null comment '仮返戻フラグ'
  , `deposit_flag` TINYINT default 0 not null comment '預りフラグ:最終請求月で返戻が起こるまたは起こりそうな場合に預かり金対象となるように設定する'
  , `repay_flag` TINYINT default 0 not null comment '預り金返金済フラグ'
  , `fd_no` TEXT default '' not null comment 'FD連番'
  , `fd_date` DATE default '1900-1-1' not null comment 'FD作成日'
  , `fd_create_date` DATETIME default '1900-1-1' not null comment 'FD作成時間:請求明細書の出力区分
療養費請求明細書作成前処理(CSBSPS)にてセットされる'
  , `other_prefecture_out_flag` TINYINT default 0 not null comment '他府県会員リスト出力済みフラグ:0…他府県会員チェック(CSBFKC)未処理
1…他府県会員チェック(CSBFKC)処理済み'
  , `detail_output_flag` TINYINT default 0 not null comment '明細出力フラグ'
  , `duplicate_flag` TINYINT default 0 not null comment '重複受診者フラグ'
  , `judge_restore_amount` DECIMAL(13,2) default 0 not null comment '審査還元料'
  , `send_membership_id` CHAR(40) not null comment '送金時の組合員ID:会員が異動していなければ同じ会員ID'
  , `after_back_flag` TINYINT default 0 not null comment '返金後返戻フラグ:返戻分を返金しないと返戻レセプトが返されない場合'
  , `re_judge_flag` TINYINT default 0 not null comment '再審査請求フラグ'
  , `disapproval_state_class_id` CHAR(40) comment '不服申請区分:0:未申請、 1:審査中､2:支給決定、3:一部支給決定、4:棄却'
  , `disapproval_amount` DECIMAL(13,2) default 0 not null comment '不服申請支給決定金額'
  , `receipt_state_class_id` CHAR(40) not null comment 'レセプト状態区分:1:申請中、2:協会返戻、3:保険者返戻､4:会員返戻､5:完了､6:一部不支給、7:不支給、9:保留'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0070_PKC` primary key (`rid`)
) comment '柔整レセプト状態情報' ;

-- 柔整レセプト科目集計情報
drop table if exists `RCPT0020` cascade;

create table `RCPT0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整レセプト申請ID'
  , `receipt_subject_class_id` CHAR(40) not null comment '柔整レセプト科目区分'
  , `receipt_injury_id` CHAR(40) comment '柔整レセプト傷病ID'
  , `unit_count` INT default 0 not null comment '部位数・往療距離:変形徒手矯正術の時の部位数、往療の時の距離'
  , `price` DECIMAL(13,2) default 0 not null comment '単価'
  , `count` INT default 0 not null comment '回数'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険金額'
  , `part_amount` DECIMAL(13,2) default 0 not null comment '一部負担金'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0020_PKC` primary key (`rid`)
) comment '柔整レセプト科目集計情報' ;

-- 鍼灸マレセプト保留簿情報
drop table if exists `RCPT0180` cascade;

create table `RCPT0180` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マレセプト申請ID'
  , `entry_user_id` CHAR(40) not null comment '登録担当者ID'
  , `release_user_id` CHAR(40) comment '解除担当者ID'
  , `reservation_class_id` CHAR(40) not null comment '保留区分'
  , `reservation_date` DATE default '1900-1-1' not null comment '保留年月日'
  , `release_date` DATE default '1900-1-1' not null comment '保留解除年月日'
  , `reservation_amount` DECIMAL(13,2) default 0 not null comment '保留金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0180_PKC` primary key (`rid`)
) comment '鍼灸マレセプト保留簿情報' ;

-- 労災状態区分マスタ
drop table if exists `CNAM0186` cascade;

create table `CNAM0186` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '労災状態区分値'
  , `name` TEXT default '' not null comment '労災状態区分名'
  , `short_name` TEXT default '' not null comment '労災状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0186_PKC` primary key (`rid`)
) comment '労災状態区分マスタ' ;

-- 柔整労災状態情報
drop table if exists `RCWC0050` cascade;

create table `RCWC0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整労災申請ID'
  , `check_flag` TINYINT default 0 not null comment '労災チェック済フラグ:0…レセプトデータチェック(CSBSCH)未処理
1…レセプトデータチェック(CSBSCH)処理済み'
  , `fix_flag` TINYINT default 0 not null comment '労災確定フラグ:労災変更不可'
  , `fix_date` DATE default '1900-1-1' not null comment '労災確定日'
  , `back_amount` DECIMAL(13,2) not null comment '返戻金額'
  , `back_date` DATE default '1900-1-1' not null comment '返戻処理日'
  , `back_receipt_date` DATE default '1900-1-1' not null comment '返戻労災返送日'
  , `back_user_id` CHAR(40) comment '協会返戻担当者ID'
  , `back_request_flag` TINYINT default 0 not null comment '会員返戻依頼フラグ'
  , `back_request_date` DATE default '1900-1-1' not null comment '会員返戻依頼日:会員返戻の場合のみ'
  , `back_insurer_date` DATE default '1900-1-1' not null comment '労災返戻依頼日'
  , `before_receipt_id` CHAR(40) comment '前回該当労災申請ID'
  , `send_date` DATE default '1900-1-1' not null comment '発送日:保険者等へ'
  , `reconciliation_class_id` CHAR(40) default 0 not null comment '消込区分:空白…未決(入金でも返戻でもない状態)
1…個別入金処理済(CNTTKE)
2…返戻済(一部返戻含む)(CNTHEN)
7…一括入金処理済(CNBKES)
1も7も入金を意味するが、使用するPGによってサインが異なる。'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `receipt_date` DATE default '1900-1-1' not null comment '入金日'
  , `remittance_flag` TINYINT default 0 not null comment '送金済フラグ'
  , `remittance_date` DATE default '1900-1-1' not null comment '送金日'
  , `payback_date` DATE default '1900-1-1' not null comment '労災返金日'
  , `payback_amount` DECIMAL(13,2) default 0 not null comment '労災返金金額'
  , `temporary_back_flag` TINYINT default 0 not null comment '仮返戻フラグ'
  , `deposit_flag` TINYINT default 0 not null comment '預りフラグ:最終請求月で返戻が起こるまたは起こりそうな場合に預かり金対象となるように設定する'
  , `repay_flag` TINYINT default 0 not null comment '預り金返金済フラグ'
  , `send_membership_id` CHAR(40) comment '送金時の組合員ID:会員が異動していなければ同じ会員ID'
  , `after_back_flag` TINYINT default 0 not null comment '返金後返戻フラグ:返戻分を返金しないと返戻レセプトが返されない場合'
  , `receipt_state_class_id` CHAR(40) not null comment '労災状態区分:1:申請中、2:協会返戻、3:保険者返戻､4:会員返戻､5:完了､6:一部不支給、7:不支給、9:保留'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0050_PKC` primary key (`rid`)
) comment '柔整労災状態情報' ;

-- 鍼灸マ労災状態情報
drop table if exists `RCWC0150` cascade;

create table `RCWC0150` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マ労災申請ID'
  , `check_flag` TINYINT default 0 not null comment '労災チェック済フラグ:0…レセプトデータチェック(CSBSCH)未処理
1…レセプトデータチェック(CSBSCH)処理済み'
  , `fix_flag` TINYINT default 0 not null comment '労災確定フラグ:労災変更不可'
  , `fix_date` DATE default '1900-1-1' not null comment '労災確定日'
  , `back_amount` DECIMAL(13,2) not null comment '返戻金額'
  , `back_date` DATE default '1900-1-1' not null comment '返戻処理日'
  , `back_receipt_date` DATE default '1900-1-1' not null comment '返戻労災返送日'
  , `back_user_id` CHAR(40) comment '協会返戻担当者ID'
  , `back_request_flag` TINYINT default 0 not null comment '会員返戻依頼フラグ'
  , `back_request_date` DATE default '1900-1-1' not null comment '会員返戻依頼日:会員返戻の場合のみ'
  , `back_insurer_date` DATE default '1900-1-1' not null comment '労災返戻依頼日'
  , `before_receipt_id` CHAR(40) comment '前回該当労災申請ID'
  , `send_date` DATE default '1900-1-1' not null comment '発送日:保険者等へ'
  , `reconciliation_class_id` CHAR(40) default 0 not null comment '消込区分:空白…未決(入金でも返戻でもない状態)
1…個別入金処理済(CNTTKE)
2…返戻済(一部返戻含む)(CNTHEN)
7…一括入金処理済(CNBKES)
1も7も入金を意味するが、使用するPGによってサインが異なる。'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `receipt_date` DATE default '1900-1-1' not null comment '入金日'
  , `remittance_flag` TINYINT default 0 not null comment '送金済フラグ'
  , `remittance_date` DATE default '1900-1-1' not null comment '送金日'
  , `payback_date` DATE default '1900-1-1' not null comment '労災返金日'
  , `payback_amount` DECIMAL(13,2) default 0 not null comment '労災返金金額'
  , `temporary_back_flag` TINYINT default 0 not null comment '仮返戻フラグ'
  , `deposit_flag` TINYINT default 0 not null comment '預りフラグ:最終請求月で返戻が起こるまたは起こりそうな場合に預かり金対象となるように設定する'
  , `repay_flag` TINYINT default 0 not null comment '預り金返金済フラグ'
  , `send_membership_id` CHAR(40) comment '送金時の組合員ID:会員が異動していなければ同じ会員ID'
  , `after_back_flag` TINYINT default 0 not null comment '返金後返戻フラグ:返戻分を返金しないと返戻レセプトが返されない場合'
  , `receipt_state_class_id` CHAR(40) not null comment '労災状態区分:1:申請中、2:協会返戻、3:保険者返戻､4:会員返戻､5:完了､6:一部不支給、7:不支給、9:保留'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0150_PKC` primary key (`rid`)
) comment '鍼灸マ労災状態情報' ;

-- 鍼灸マレセプト状態情報
drop table if exists `RCPT0170` cascade;

create table `RCPT0170` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マレセプト申請ID'
  , `check_flag` TINYINT default 0 not null comment 'レセプトチェック済フラグ:0…レセプトデータチェック(CSBSCH)未処理
1…レセプトデータチェック(CSBSCH)処理済み'
  , `fix_flag` TINYINT default 0 not null comment 'レセプト確定フラグ:レセプト変更不可'
  , `fix_date` DATE default '1900-1-1' not null comment 'レセプト確定日'
  , `before_charge_amount` DECIMAL(13,2) default 0 not null comment '更正前請求額:保険者より一部返戻(減額)が発生した時、当初の請求額がセット。それ以外の時、0。'
  , `back_amount` DECIMAL(13,2) not null comment '返戻金額'
  , `back_date` DATE default '1900-1-1' not null comment '返戻処理日'
  , ` judge_reduction_amount` DECIMAL(13,2) default 0 not null comment '審査料還元金額:返戻によるレセプト定率会費の還元額'
  , `back_receipt_date` DATE default '1900-1-1' not null comment '返戻レセプト返送日'
  , `back_user_id` CHAR(40) comment '協会返戻担当者ID'
  , `back_request_flag` TINYINT default 0 not null comment '会員返戻依頼フラグ'
  , `back_request_date` DATE default '1900-1-1' not null comment '会員返戻依頼日:会員返戻の場合のみ'
  , `back_insurer_date` DATE default '1900-1-1' not null comment '保険者返戻依頼日'
  , `before_receipt_id` CHAR(40) comment '前回該当返戻レセプトID:エラーチェックで設定(以前に同一のレセプトがある場合）'
  , `send_date` DATE default '1900-1-1' not null comment '発送日:保険者等へ'
  , `reconciliation_class_id` CHAR(40) default 0 not null comment '消込区分:空白…未決(入金でも返戻でもない状態)
1…個別入金処理済(CNTTKE)
2…返戻済(一部返戻含む)(CNTHEN)
7…一括入金処理済(CNBKES)
1も7も入金を意味するが、使用するPGによってサインが異なる。'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `receipt_date` DATE default '1900-1-1' not null comment '入金日'
  , `remittance_flag` TINYINT default 0 not null comment '送金済フラグ'
  , `remittance_date` DATE default '1900-1-1' not null comment '送金日'
  , `payback_date` DATE default '1900-1-1' not null comment '保険者返金日'
  , `payback_amount` DECIMAL(13,2) default 0 not null comment '保険者返金金額'
  , `temporary_back_flag` TINYINT default 0 not null comment '仮返戻フラグ'
  , `deposit_flag` TINYINT default 0 not null comment '預りフラグ:最終請求月で返戻が起こるまたは起こりそうな場合に預かり金対象となるように設定する'
  , `repay_flag` TINYINT default 0 not null comment '預り金返金済フラグ'
  , `fd_no` TEXT default '' not null comment 'FD連番:オフコン手入力の時、連番
それ以外、カルテ番号(5桁)+「本体0，助成1」(1桁)+「保険異動前0，後1」(1桁)'
  , `fd_date` DATE default '1900-1-1' not null comment 'FD作成日:IV転送日/オフコン手入力日/レセプト修正した日'
  , `fd_create_date` DATETIME default '1900-1-1' not null comment 'FD作成時間:請求明細書の出力区分
療養費請求明細書作成前処理(CSBSPS)にてセットされる'
  , `other_prefecture_out_flag` TINYINT default 0 not null comment '他府県会員リスト出力済みフラグ:0…他府県会員チェック(CSBFKC)未処理
1…他府県会員チェック(CSBFKC)処理済み'
  , `detail_output_flag` TINYINT default 0 not null comment '明細出力フラグ'
  , `duplicate_flag` TINYINT default 0 not null comment '重複受診者フラグ'
  , `judge_restore_amount` DECIMAL(13,2) default 0 not null comment '審査還元料'
  , `send_membership_id` CHAR(40) not null comment '送金時の組合員ID:会員が異動していなければ同じ会員ID'
  , `after_back_flag` TINYINT default 0 not null comment '返金後返戻フラグ:返戻分を返金しないと返戻レセプトが返されない場合'
  , `re_judge_flag` TINYINT default 0 not null comment '再審査請求フラグ'
  , `disapproval_state_class_id` CHAR(40) comment '不服申請区分:0:未申請、 1:審査中､2:支給決定、3:一部支給決定、4:棄却'
  , `disapproval_amount` DECIMAL(13,2) default 0 not null comment '不服申請支給決定金額'
  , `receipt_state_class_id` CHAR(40) not null comment 'レセプト状態区分:1:申請中、2:協会返戻、3:保険者返戻､4:会員返戻､5:完了､6:一部不支給、7:不支給、9:保留'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0170_PKC` primary key (`rid`)
) comment '鍼灸マレセプト状態情報' ;

-- 高齢区分マスタ
drop table if exists `CNAM0185` cascade;

create table `CNAM0185` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '高齢区分値'
  , `name` TEXT default '' not null comment '高齢区分名'
  , `short_name` TEXT default '' not null comment '高齢区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0185_PKC` primary key (`rid`)
) comment '高齢区分マスタ' ;

-- 鍼灸マレセプト傷病情報
drop table if exists `RCPT0110` cascade;

create table `RCPT0110` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マレセプト申請ID'
  , `injury_site_id` CHAR(40) not null comment '患者鍼灸傷病ID:初検料、再検料等は０を設定'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険対象金額'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '保険請求金額'
  , `berar_amount` DECIMAL(13,2) default 0 not null comment '一部負担金額'
  , `furtherance_amount` DECIMAL(13,2) default 0 not null comment '医療助成請求金額'
  , `priority` INT default 0 not null comment '優先順位'
  , `injury_code` TEXT default '' not null comment '負傷コード'
  , `injury_name` TEXT default '' not null comment '負傷名'
  , `cause` TEXT default '' not null comment '負傷原因'
  , `doctor_first_date` DATE default '1900-1-1' not null comment '医師初検日'
  , `first_date` DATE default '1900-1-1' not null comment '初療日'
  , `injury_date` DATE default '1900-1-1' not null comment '負傷日'
  , `part_count` INT default 0 not null comment '局所数:施術種別があん摩・マッサージのみ'
  , `limb_count` INT default 0 not null comment '肢数:施術種別があん摩・マッサージのみ'
  , `medical_assist_exist_flag` TINYINT default 0 not null comment '医療助成有無フラグ'
  , `recession_flag` TINYINT default 0 not null comment '逓減対象フラグ'
  , `recession_start_date` DATE default '1900-1-1' not null comment '逓減開始日'
  , `recession_ratio` INT default 0 not null comment '逓減率'
  , `long_recession_ratio` INT default 0 not null comment '長期逓減率'
  , `long_recession_sign_flag` TINYINT default 0 not null comment '長期逓減サイン'
  , `start_date` DATE default '1900-1-1' not null comment '施術開始日'
  , `end_date` DATE default '1900-1-1' not null comment '施術終了日'
  , `treatment_days` INT default 0 not null comment '実日数'
  , `all_treatment_days` INT default 0 not null comment '延日数'
  , `doctor_name` TEXT default '' not null comment '同意医師名'
  , `agreement_date` DATE default '1900-1-1' not null comment '同意日'
  , `re_doctor_name` TEXT not null comment '再同意医師名'
  , `re_agreement_date` DATE default '1900-1-1' not null comment '再同意日'
  , `prev_agreement_date` DATE default '1900-1-1' not null comment '前回同意日'
  , `continue_flag` TINYINT not null comment '継続フラグ:0:新規､1:継続'
  , `outcome_class_id` CHAR(40) not null comment '転帰区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0110_PKC` primary key (`rid`)
) comment '鍼灸マレセプト傷病情報' ;

-- 柔整レセプト傷病情報
drop table if exists `RCPT0010` cascade;

create table `RCPT0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整レセプト申請ID'
  , `injury_site_id` CHAR(40) not null comment '患者柔整傷病ID:初検料、再検料等はNULLを設定'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険対象金額'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '保険請求金額'
  , `berar_amount` DECIMAL(13,2) default 0 not null comment '一部負担金額'
  , `furtherance_amount` DECIMAL(13,2) default 0 not null comment '医療助成請求金額'
  , `priority` INT default 0 not null comment '優先順位'
  , `injury_code` TEXT default '' not null comment '負傷コード'
  , `injury_name` TEXT default '' not null comment '負傷名'
  , `cause` TEXT default '' not null comment '負傷原因'
  , `doctor_first_date` DATE default '1900-1-1' not null comment '医師初検日'
  , `first_date` DATE default '1900-1-1' not null comment '初検日'
  , `injury_date` DATE default '1900-1-1' not null comment '負傷日'
  , `medical_assist_exist_flag` TINYINT default 0 not null comment '医療助成有無フラグ'
  , `reduce_clac_flag` TINYINT default 0 not null comment '整復・固定・施療料算定フラグ:施術所システムがある場合柔整レセプト科目集計から算出'
  , `recession_flag` TINYINT default 0 not null comment '逓減対象フラグ'
  , `recession_start_date` DATE default '1900-1-1' not null comment '逓減開始日'
  , `recession_ratio` INT default 0 not null comment '逓減率'
  , `long_recession_ratio` INT default 0 not null comment '長期逓減率'
  , `long_recession_sign_flag` TINYINT default 0 not null comment '長期逓減サイン'
  , `start_date` DATE default '1900-1-1' not null comment '施術開始日'
  , `end_date` DATE default '1900-1-1' not null comment '施術終了日'
  , `treatment_days` INT default 0 not null comment '実日数'
  , `all_treatment_days` INT default 0 not null comment '延日数'
  , `doctor_name` TEXT default '' not null comment '同意医師名'
  , `agreement_date` DATE default '1900-1-1' not null comment '同意日'
  , `re_doctor_name` TEXT not null comment '再同意医師名'
  , `re_agreement_date` DATE default '1900-1-1' not null comment '再同意日'
  , `prev_agreement_date` DATE default '1900-1-1' not null comment '前回同意日'
  , `continure_flag` TINYINT default 0 not null comment '継続フラグ:0:新規､1:継続'
  , `outcome_class_id` CHAR(40) not null comment '転帰区分'
  , `special_calc` INT not null comment '特殊計算:0,4…何もなし
1…初回処置のみ算定、その他の算定は全て(後療/冷罨/温罨/電療)解除
2,3…初回処置を解除、後療/温罨/電療を設定。負傷部位が捻挫/打撲/挫傷の時のみ冷罨も解除。'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0010_PKC` primary key (`rid`)
) comment '柔整レセプト傷病情報' ;

-- 柔整レセプト対象施術情報
drop table if exists `RCPT0030` cascade;

create table `RCPT0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_detail_id` CHAR(40) not null comment '柔整レセプト傷病ID'
  , `treatment_id` CHAR(40) not null comment '柔整施術ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0030_PKC` primary key (`rid`)
) comment '柔整レセプト対象施術情報' ;

-- 税理士・会計士マスタ
drop table if exists `ACUT0001` cascade;

create table `ACUT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `owner_id` CHAR(40) not null comment '事業主ID'
  , `accountant_class_id` CHAR(40) not null comment '税理士・会計士区分:1:税理士、2:会計士､9:その他'
  , `accountant_last_kana` TEXT default '' not null comment '税理士・会計士カナ苗字'
  , `accountant_first_kana` TEXT default '' not null comment '税理士・会計士カナ名前'
  , `accountant_last_name` TEXT default '' not null comment '税理士・会計士苗字'
  , `accountant_first_name` TEXT default '' not null comment '税理士・会計士名前'
  , `shop_name` TEXT default '' not null comment '屋号'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ACUT0001_PKC` primary key (`rid`)
) comment '税理士・会計士マスタ' ;

-- 記帳代行会社区分マスタ
drop table if exists `CNAM0184` cascade;

create table `CNAM0184` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '記帳代行会社区分値'
  , `name` TEXT default '' not null comment '記帳代行会社区分名'
  , `short_name` TEXT default '' not null comment '記帳代行会社区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0184_PKC` primary key (`rid`)
) comment '記帳代行会社区分マスタ' ;

-- 削除理由区分マスタ
drop table if exists `CNAM0183` cascade;

create table `CNAM0183` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '削除理由区分値'
  , `name` TEXT default '' not null comment '削除理由区分名'
  , `short_name` TEXT default '' not null comment '削除理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0183_PKC` primary key (`rid`)
) comment '削除理由区分マスタ' ;

-- 口座出入科目区分マスタ
drop table if exists `CNAM0182` cascade;

create table `CNAM0182` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '口座出入科目区分値'
  , `name` TEXT default '' not null comment '口座出入科目区分名'
  , `short_name` TEXT default '' not null comment '口座出入科目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0182_PKC` primary key (`rid`)
) comment '口座出入科目区分マスタ' ;

-- 鍼灸マ自賠責診療科目マスタ
drop table if exists `SBIS0140` cascade;

create table `SBIS0140` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_class_id` CHAR(40) not null comment '鍼灸マ科目区分'
  , `liability_subject_class_id` CHAR(40) not null comment '鍼灸マ自賠責科目区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `real_flag` TINYINT default 0 not null comment '実費フラグ:1:金額はその時の時価を入力させる場合'
  , `part_flag` TINYINT default 0 not null comment '部位単位で算定フラグ'
  , `one_day_flag` TINYINT default 0 not null comment '1日1回算定フラグ'
  , `calc_class_id` CHAR(40) not null comment '算定日区分:1: 回目、2: 日目､ 3: 週目、4: 月目、5: 年目'
  , `from_days_count` INT default 0 not null comment '算定開始日数:算定区分の単位での開始数'
  , `to_days_count` INT default 0 not null comment '算定終了日数:算定区分の単位での終了数'
  , `from_distance` INT default 0 not null comment '往療開始距離'
  , `to_distance` INT default 0 not null comment '往療終了距離'
  , `interval_distance` INT default 0 not null comment '往療間隔距離'
  , `reasion_flag` TINYINT default 0 not null comment '摘要理由有無フラグ:1: レセプトで摘要理由が必要である場合'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0140_PKC` primary key (`rid`)
) comment '鍼灸マ自賠責診療科目マスタ' ;

-- 会員区分マスタ
drop table if exists `CNAM0095` cascade;

create table `CNAM0095` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '会員区分値'
  , `name` TEXT default '' not null comment '会員区分名'
  , `short_name` TEXT default '' not null comment '会員区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0095_PKC` primary key (`rid`)
) comment '会員区分マスタ' ;

-- 施術所コード申請先区分マスタ
drop table if exists `CNAM0094` cascade;

create table `CNAM0094` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '施術所コード申請先区分値'
  , `name` TEXT default '' not null comment '施術所コード申請先区分名'
  , `short_name` TEXT default '' not null comment '施術所コード申請先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0094_PKC` primary key (`rid`)
) comment '施術所コード申請先区分マスタ' ;

-- 鍼灸マ自賠責料金パターンマスタ
drop table if exists `SBLI0020` cascade;

create table `SBLI0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_name` TEXT default '' not null comment 'パターン名'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `liability_id` CHAR(40) not null comment '自賠責保険会社ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBLI0020_PKC` primary key (`rid`)
) comment '鍼灸マ自賠責料金パターンマスタ' ;

-- 鍼灸マ労災料金パターンマスタ
drop table if exists `SBWC0020` cascade;

create table `SBWC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_name` TEXT default '' not null comment 'パターン名'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBWC0020_PKC` primary key (`rid`)
) comment '鍼灸マ労災料金パターンマスタ' ;

-- 記帳代行情報
drop table if exists `RGST0001` cascade;

create table `RGST0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `rent_id` CHAR(40) not null comment '施術所ID'
  , `register_company_class_id` CHAR(40) not null comment '記帳代行会社区分'
  , `register_amount` DECIMAL(13,2) not null comment '記帳代金'
  , `start_date` DATE default '1900-1-1' not null comment '入会日'
  , `end_date` DATE default '9999-12-31' not null comment '退会日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RGST0001_PKC` primary key (`rid`)
) comment '記帳代行情報' ;

-- 管理企業口座用途マスタ
drop table if exists `MCAC0010` cascade;

create table `MCAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '管理企業口座ID'
  , `use_class_id` TEXT default '' not null comment '管理企業口座用途区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MCAC0010_PKC` primary key (`rid`)
) comment '管理企業口座用途マスタ' ;

-- 受付施術所診療科情報
drop table if exists `RCOF0010` cascade;

create table `RCOF0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `depertment_class_id` CHAR(40) not null comment '診療科区分'
  , `notify_office_flag` TINYINT default 0 not null comment '開設の有無フラグ'
  , `notify_plan_date` DATE default '1900-1-1' not null comment '開設予定日'
  , `notify_date` DATE default '1900-1-1' not null comment '開設日:既に開設済の場合'
  , `current_receipt_flag` TINYINT default 0 not null comment '現在の保険請求フラグ'
  , `receipt_flag` TINYINT default 0 not null comment '保険請求有無フラグ:受領委任継続フラグ'
  , `receipt_self_flag` TINYINT default 0 not null comment '保険取扱者フラグ:本人、本人以外'
  , `receipt_start_date` DATE default '1900-1-1' not null comment '保険請求開始予定日'
  , `receipt_end_date` DATE default '1900-1-1' not null comment '最終保険請求日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCOF0010_PKC` primary key (`rid`)
) comment '受付施術所診療科情報' ;

-- 施術所事業主変更情報
drop table if exists `RCIF0020` cascade;

create table `RCIF0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `change_date` DATE default '1900-1-1' not null comment '変更予定日'
  , `change_reason_id` CHAR(40) not null comment '変更理由ID'
  , `change_reason` TEXT default '' not null comment '変更理由'
  , `transfer_flag` TINYINT default 0 not null comment '引き継ぎフラグ:1: 引き継ぎ'
  , `fund_class_id` CHAR(40) not null comment '出資金処理区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0020_PKC` primary key (`rid`)
) comment '施術所事業主変更情報' ;

-- 受付施術所情報
drop table if exists `RCOF0001` cascade;

create table `RCOF0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:1:追加、2:更新、3:廃止'
  , `prefecture_class_id` CHAR(40) not null comment '開業都道府県区分'
  , `office_name` TEXT default '' not null comment '施術所名'
  , `postal_code` TINYTEXT default '' not null comment '施術所郵便番号'
  , `address_pref` TEXT default '' not null comment '施術所都道府県'
  , `address_city` TEXT default '' not null comment '施術所市区町村'
  , `address_town` TEXT default '' not null comment '施術所町域'
  , `address_street` TEXT default '' not null comment '施術所番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '施術所都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '施術所市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '施術所町域カナ'
  , `address_street_kana` TEXT default '' not null comment '施術所番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '施術所電話番号'
  , `fax_no` TINYTEXT default '' not null comment '施術所ファックス番号'
  , `home_page` TINYTEXT default '' not null comment '施術所ホームページ'
  , `open_office_flag` TINYINT default 0 not null comment '開業の有無フラグ'
  , `open_plan_date` DATE default '1900-1-1' not null comment '開業予定日'
  , `open_date` DATE default '1900-1-1' not null comment '開業日'
  , `send_date` DATE default '1900-1-1' not null comment '厚生局送付日'
  , `target_office_id` CHAR(40) comment '対象施術所ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCOF0001_PKC` primary key (`rid`)
) comment '受付施術所情報' ;

-- 管理企業口座マスタ
drop table if exists `MCAC0001` cascade;

create table `MCAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MCAC0001_PKC` primary key (`rid`)
) comment '管理企業口座マスタ' ;

-- 会員リビジョン適用期間情報
drop table if exists `MBRG0001` cascade;

create table `MBRG0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `revision` INT UNSIGNED not null comment 'リビジョン'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBRG0001_PKC` primary key (`rid`)
) comment '会員リビジョン適用期間情報' ;

-- レセプトチェック条件マスタ
drop table if exists `RCHK0020` cascade;

create table `RCHK0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `cond_group_id` CHAR(40) not null comment '条件グループID'
  , `column_name` TEXT not null comment '項目名'
  , `value_type` INT default 0 not null comment '項目タイプ:0:数値､1:文字列、2:日付'
  , `operator` INT default 0 not null comment '条件式:0:=、1:>､2:<、3:≧、4:≦､5:BITWEEN、6:!=、7:正規表現=、8:正規表現!='
  , `cond_value` TEXT default '' not null comment '値'
  , `regular` TEXT default '' not null comment '正規表現:条件式が正規表現の場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCHK0020_PKC` primary key (`rid`)
) comment 'レセプトチェック条件マスタ' ;

-- レセプトチェック条件グループマスタ
drop table if exists `RCHK0010` cascade;

create table `RCHK0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `error_check_id` CHAR(40) not null comment 'エラーチェックID'
  , `group_no` INT default 0 not null comment '条件グループ番号'
  , `logical_op` INT default 0 not null comment '論理演算:前のグループとの関係'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCHK0010_PKC` primary key (`rid`)
) comment 'レセプトチェック条件グループマスタ' ;

-- レセプトチェック条件マスタ
drop table if exists `RCHK0001` cascade;

create table `RCHK0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `check_no` INT default 0 not null comment 'エラーチェック番号'
  , `error_id` CHAR(40) not null comment 'エラー内容ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCHK0001_PKC` primary key (`rid`)
) comment 'レセプトチェック条件マスタ' ;

-- 送金備考情報
drop table if exists `RMTC0020` cascade;

create table `RMTC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `remittance_id` CHAR(40) not null comment '送金ID'
  , `remittance_remark_class_id` CHAR(40) not null comment '送金備考区分'
  , `remark` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RMTC0020_PKC` primary key (`rid`)
) comment '送金備考情報' ;

-- 鍼灸マレセプト申請情報
drop table if exists `RCPT0101` cascade;

create table `RCPT0101` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `office_id` CHAR(40) not null comment '施術所ID:会員番号から取得'
  , `office_revision` INT UNSIGNED not null comment '施術所リビジョン'
  , `membership_no` TEXT not null comment '会員番号'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `membership_revision` INT UNSIGNED not null comment '会員リビジョン'
  , `seq_no` INT default 0 not null comment '会員別連番:明細のソート順'
  , `patient_id` CHAR(40) not null comment '患者ID:施術所システムより'
  , `patient_hist_id` CHAR(40) not null comment '患者履歴ID:施術所システムより'
  , `karte_no` TEXT default '' not null comment 'カルテ番号'
  , `reception_date` DATE default '1900-1-1' not null comment '受付年月日'
  , `application_month` DATE default '1900-1-1' not null comment '請求年月:yyyy/mm/01'
  , `treatment_month` DATE default '1900-1-1' not null comment '施術年月:yyyy/mm/01'
  , `receipt_type` INT default 0 not null comment 'レセプト種別:0:保険、1:医療助成、2:生活保護'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `start_date` DATE default '1900-1-1' not null comment '対象施術開始日'
  , `end_date` DATE default '9999-12-31' not null comment '対象施術終了日'
  , `report_date` DATETIME default '1900-1-1' not null comment '申請書作成日'
  , `insurance_card_id` CHAR(40) comment '保険証ID:施術所システムより'
  , `insurance_card_hist_id` CHAR(40) comment '保険証履歴ID:施術所システムより'
  , `patient_medical_assist_id` CHAR(40) comment '患者医療助成ID'
  , `life_protection_id` CHAR(40) comment '会員生活保護ID'
  , `osaka_life_protection_id` TEXT default '' not null comment '生活保護大阪市コード:大阪市保険者(項目"大阪市内"=0)のみ管理
区コード(2桁)＋地区コード(2桁)＋ケース(7桁)＋世帯員(2桁)'
  , `receipt_direct_flag` TINYINT default 0 not null comment '生保会員直接入金フラグ:0:保険者大阪市内(全柔協入金)、1:保険者大阪市外(会員直接入金)'
  , `insurer_type` TEXT not null comment '保険者種別'
  , `law_no` TEXT default '' not null comment '法制番号:保険者法制コード(全柔協独自設定)※4'
  , `insurer_no` text default '' not null comment '保険者番号:保険者番号/公費負担者番号(全柔協独自設定)'
  , `insurer_age` TEXT default '' not null comment '保険者番号枝番:保険者番号枝番(全柔協独自設定)
以下の保険者のみ管理
・全国歯科医師国保組合(42-90-093013)の時、Ａ～T
・全国土木建築国民保険組合(42-90-133033)の時、1～9'
  , `insurer_id` CHAR(40) comment '保険者ID'
  , `medical_assist_id` CHAR(40) comment '医療助成ID'
  , `before_insurer_type` TEXT not null comment '修正前保険者種別:修正前の種別(未修正の時、空白)'
  , `before_law_no` TEXT not null comment '修正前法制番号:修正前の法制(未修正の時、空白)'
  , `before_insurer_no` TEXT not null comment '修正前保険者番号:修正前の保険者番号(未修正の時、空白)'
  , `before_insurer_age` TEXT not null comment '修正前保険者番号枝番:修正前の保険者番号枝番(未修正の時、空白)'
  , `before_insurer_id` CHAR(40) comment '修正前保険者ID'
  , `before_patient_medical_assist_id` CHAR(40) comment '修正前医療助成ID'
  , `mark` TEXT default '' not null comment '被保険者記号'
  , `number` TEXT default '' not null comment '被保険者番号'
  , `recipient_no` TEXT default '' not null comment '公費受給者番号'
  , `licence_no` TEXT not null comment '登録記号番号:会員の契約者番号'
  , `office_code` TEXT default '' not null comment '施術機関コード'
  , `office_code_id` CHAR(40) comment '施術機関コードID:施術機関コードより取得'
  , `patient_last_kana` TEXT default '' not null comment '患者カナ苗字:半角（旧システムの場合は氏名は全て含む）'
  , `patient_first_kana` TEXT default '' not null comment '患者カナ名前:半角'
  , `patient_last_name` TEXT default '' not null comment '患者苗字:全角（旧システムの場合は氏名は全て含む）'
  , `patient_first_name` TEXT default '' not null comment '患者名前:全角'
  , `patient_sex_class_id` CHAR(40) not null comment '患者性別区分:1:男、2:女'
  , `patient_postal_code` TINYTEXT default '' not null comment '患者郵便番号'
  , `patient_address_pref` TEXT default '' not null comment '患者都道府県'
  , `patient_address_city` TEXT default '' not null comment '患者市区町村'
  , `patient_address_town` TEXT default '' not null comment '患者町域'
  , `patient_address_street` TEXT default '' not null comment '患者団地・マンション'
  , `patient_birthday` DATE default '1800-1-1' not null comment '患者生年月日'
  , `insured_last_kana` TEXT default '' not null comment '被保険者カナ苗字:半角（旧システムの場合は氏名は全て含む）'
  , `insured_first_kana` TEXT default '' not null comment '被保険者カナ名前:半角'
  , `insured_last_name` TEXT default '' not null comment '被保険者苗字:全角（旧システムの場合は氏名は全て含む）'
  , `insured_first_name` TEXT default '' not null comment '被保険者名前:全角'
  , `insured_sex_class_id` CHAR(40) comment '被保険者性別区分:1:男、2:女'
  , `relation_class_id` CHAR(40) comment '健康保険証続柄区分'
  , `insured_postal_code` TINYTEXT default '' not null comment '被保険者郵便番号:FD(USB)転送のみ管理
被保険者の郵便番号'
  , `insured_address_pref` TEXT default '' not null comment '被保険者都道府県:（旧システムの場合は住所は全て含む）
FD(USB)転送のみ管理
被保険者の郵便番号'
  , `insured_address_city` TEXT default '' not null comment '被保険者市区町村'
  , `insured_address_town` TEXT default '' not null comment '被保険者町域'
  , `insured_address_street` TEXT default '' not null comment '被保険者団地・マンション'
  , `insured_birthday` DATE default '1800-1-1' not null comment '被保険者生年月日'
  , `attend_days` CHAR(31) default '' not null comment '通院日:1カラムが１日を表す 0;なし､1:通院'
  , `house_visit_days` CHAR(31) default '' not null comment '往診日:1カラムが１日を表す 0;なし､1:往療'
  , `ratio` SMALLINT default 0 not null comment '負担割合'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '保険請求金額'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険対象金額:合計'
  , `bear_amount` DECIMAL(13,2) default 0 not null comment '一部負担金額:患者の窓口負担額'
  , `main_total_amount` DECIMAL(13,2) default 0 not null comment '助成時本体合計額:助成レコードの時、本体の合計額'
  , `main_recipient_amount` DECIMAL(13,2) default 0 not null comment '助成時本体一部負担額:助成レコードの時、本体の合計額'
  , `main_charge_amount` DECIMAL(13,2) default 0 not null comment '助成時本体請求額:助成レコードの時、本体の一部負担額'
  , `main_ratio` SMALLINT default 0 not null comment '助成時本体負担割合:助成レコードの時、本体の負担割合'
  , `exempt_class_id` CHAR(40) not null comment '一部負担金免除区分:?'
  , `social_insurance_raio` SMALLINT default 0 comment '社保負担割合:生活保護のみ使用'
  , `social_insurance_amount` DECIMAL(13,2) default 0 not null comment '社保請求金額:生活保護のみ使用'
  , `sign_date` DATE default '1900-1-1' not null comment 'サイン受領日'
  , `other_print_flag` TINYINT default '0' not null comment '付属情報印字フラグ'
  , `medical_assist_class_id` CHAR(40) comment '単併区分:1:単独、2:2併､3:3併'
  , `head_family_class_id` CHAR(40) comment '本人家族区分:1:本人、2:六歳、3:家族､4:高一、5:高七'
  , `charge_class_id` CHAR(40) comment '請求区分:1:新規、2:継続､3:新規＆継続'
  , `factor_class_id` CHAR(40) comment '負傷要因区分'
  , `summary_front` TEXT default '' not null comment '摘要(表）'
  , `summary_back` TEXT default '' not null comment '摘要(裏）'
  , `elderly_class_id` CHAR(40) comment '高齢区分'
  , `no_work_class_id` CHAR(40) comment '未就区分'
  , `trader_class_id` CHAR(40) comment '業者区分:レセコンメーカー
空白…手入力
21…マキシー
22…マキシー
90…全柔協
(21,22の違いについては不明)'
  , `insurer_move_flag` TINYINT default 0 not null comment '保険異動後フラグ'
  , `ijp_no` TEXT default '' not null comment 'IJP連番(レセプト画像番号):処理年月(西暦下2桁＋月2桁)＋号機(2桁)＋"1"(固定)＋連番(6桁)
例)1712061001358
処理年月=1712,号機=06号機,"1",連番=001358'
  , `qr_process_class_id` CHAR(40) comment 'QR処理区分'
  , `update_sign` INT default 0 not null comment '更新ｻｲﾝ:0:QR/FD(USB)取り込み、1:手入力'
  , `receipt_version` TEXT default '' not null comment 'レセプトバージョン'
  , `modify_user_id` CHAR(40) comment '修正担当者ID:レセプト修正した操作員ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0101_PKC` primary key (`rid`)
) comment '鍼灸マレセプト申請情報' ;

-- 鍼灸マレセプトコメント情報
drop table if exists `RCPT0160` cascade;

create table `RCPT0160` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マレセプト申請ID'
  , `entry_user_id` CHAR(40) not null comment '入力担当者ID'
  , `remark_class_id` CHAR(40) not null comment 'コメント種別区分:1:保留､2: 返戻､3:削除(取消)、4:入金'
  , `process_date` DATE default '1900-1-1' not null comment '処理年月日'
  , `reason_class_id` CHAR(40) comment '理由区分'
  , `reason` TEXT not null comment '理由'
  , `process_class_id` CHAR(40) comment '処理内容区分'
  , `process_content` TEXT not null comment '処理内容'
  , `comment` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0160_PKC` primary key (`rid`)
) comment '鍼灸マレセプトコメント情報' ;

-- 柔整レセプト保留簿情報
drop table if exists `RCPT0080` cascade;

create table `RCPT0080` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整レセプト申請ID'
  , `entry_user_id` CHAR(40) not null comment '登録担当者ID'
  , `release_user_id` CHAR(40) comment '解除担当者ID'
  , `reservation_class_id` CHAR(40) not null comment '保留区分'
  , `reservation_date` DATE default '1900-1-1' not null comment '保留年月日'
  , `release_date` DATE default '1900-1-1' not null comment '保留解除年月日'
  , `reservation_amount` DECIMAL(13,2) default 0 not null comment '保留金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0080_PKC` primary key (`rid`)
) comment '柔整レセプト保留簿情報' ;

-- 返戻理由区分マスタ
drop table if exists `CNAM0164` cascade;

create table `CNAM0164` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '返戻理由区分値'
  , `name` TEXT default '' not null comment '返戻理由区分名'
  , `short_name` TEXT default '' not null comment '返戻理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0164_PKC` primary key (`rid`)
) comment '返戻理由区分マスタ' ;

-- 保険者督促対象情報
drop table if exists `RMND0001` cascade;

create table `RMND0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `process_date` DATE default '1900-1-1' not null comment '請求年月'
  , `office_id` CHAR(40) not null comment '保険者ID'
  , `department_type` INT default 0 not null comment '診療科種別:1: 柔整、2:鍼灸マ'
  , `receipt_id` CHAR(40) not null comment 'レセコンID'
  , `exclude_flag` TINYINT default 0 not null comment '除外フラグ'
  , `plan_class_id` CHAR(40) not null comment '督促結果区分:1:入金、2:返戻、3:保留、9:その他'
  , `plan_date` DATE default '1900-1-1' not null comment '督促結果予定日:保険者からの回答(予定区分)に対する予定年月日'
  , `complete_date` DATE default '1900-1-1' not null comment '督促完了日:回答結果区分により入金日または返戻日'
  , `complete_flag` TINYINT default 0 not null comment '完了フラグ:1: 完了'
  , `operator_id` CHAR(40) not null comment '処理ユーザーID'
  , `remark` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RMND0001_PKC` primary key (`rid`)
) comment '保険者督促対象情報' ;

-- 保険者異動マスタ
drop table if exists `INSR0010` cascade;

create table `INSR0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '異動先保険者ID'
  , `source_insurer_id` CHAR(40) not null comment '異動元保険者ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0010_PKC` primary key (`rid`)
) comment '保険者異動マスタ' ;

-- 出資金マスタ
drop table if exists `MGCP0030` cascade;

create table `MGCP0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `investment_class_id` CHAR(40) not null comment '出資金区分:1: 通常会員、2:旧会員'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `investment_amount` DECIMAL(13,2) default 0 not null comment '出資金額:一口の金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0030_PKC` primary key (`rid`)
) comment '出資金マスタ' ;

-- 管理企業口座用途対象マスタ
drop table if exists `MCAC0020` cascade;

create table `MCAC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_use_id` CHAR(40) not null comment '管理企業口座用途ID'
  , `use_class_id` CHAR(40) comment '保険者種別区分'
  , `prefecture_class_id` CHAR(40) comment '都道府県区分'
  , `municipality_id` CHAR(40) comment '自治体ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MCAC0020_PKC` primary key (`rid`)
) comment '管理企業口座用途対象マスタ' ;

-- お知らせ区分マスタ
drop table if exists `CNAM0181` cascade;

create table `CNAM0181` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'お知らせ区分値'
  , `name` TEXT default '' not null comment 'お知らせ区分名'
  , `short_name` TEXT default '' not null comment 'お知らせ区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0181_PKC` primary key (`rid`)
) comment 'お知らせ区分マスタ' ;

-- お知らせ情報
drop table if exists `NOTC0001` cascade;

create table `NOTC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `notice_class_id` CHAR(40) default '' not null comment 'お知らせ区分'
  , `sort_class_id` CHAR(40) not null comment 'SORT区分:1:保留､2:重複、3:注意情報'
  , `process_date` DATE default '1900-1-1' not null comment '処理年月'
  , `prefecture_class_id` CHAR(40) not null comment '会員都道府県区分'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `insurer_id` CHAR(40) comment '保険者ID'
  , `receipt_id` CHAR(40) comment 'レセプトID:対象会員から見た場合'
  , `chage_amount` DECIMAL(13,2) not null comment '合計金額:対象会員から見た場合'
  , `application_date` DATE default '1900-1-1' not null comment '請求年月'
  , `treatment_date` DATE default '1900-1-1' not null comment '施術年月'
  , `self_duplicate_start_date` DATE default '1900-1-1' not null comment '重複本人施術開始日(重複受診者レコード)'
  , `self_duplicate_end_date` DATE default '1900-1-1' not null comment '重複本人施術終了日(重複受診者レコード)'
  , `opposite_duplicate_start_date` DATE default '1900-1-1' not null comment '重複相手施術開始日(重複受診者レコード)'
  , `opposite_duplicate_end_date` DATE default '1900-1-1' not null comment '重複相手施術終了日(重複受診者レコード)'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `NOTC0001_PKC` primary key (`rid`)
) comment 'お知らせ情報' ;

-- 賠償保険会社マスタ
drop table if exists `RPIS0001` cascade;

create table `RPIS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `company_kana` TEXT default '' not null comment '賠償保険会社カナ名'
  , `company_name` TEXT default '' not null comment '賠償保険会社名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RPIS0001_PKC` primary key (`rid`)
) comment '賠償保険会社マスタ' ;

-- 速報情報（不要）
drop table if exists `INFO0010` cascade;

create table `INFO0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `change_class_id` CHAR(40) default '' not null comment '変更区分'
  , `membership_id` CHAR(40) not null comment '対象会員ID'
  , `member_class_id` CHAR(40) not null comment '会員種別区分'
  , `parent_membership_id` CHAR(40) not null comment '親(正)会員ID:対象会員から見た場合'
  , `child_membership_id` CHAR(40) not null comment '子(準)会員ID:対象会員から見た場合'
  , `from_content` TEXT default '' not null comment '変更前'
  , `to_content` TEXT default '' not null comment '変更後'
  , `notify_start_date` DATE default '1900-1-1' not null comment '開設日'
  , `withdraw_date` DATE default '1900-1-1' not null comment '退会(休会)日'
  , `approval_date_1` DATE default '1900-1-1' not null comment '登録記号番号登録年月日'
  , `approval_date_2` DATE default '1900-1-1' not null comment '共済連盟承認年月日'
  , `approval_date_3` DATE default '1900-1-1' not null comment '地方共済承認年月日'
  , `approval_date_4` DATE default '1900-1-1' not null comment '防衛省承認年月日'
  , `approval_date_5` DATE default '1900-1-1' not null comment '労災認定年月日'
  , `remark` TEXT default '' not null comment '備考'
  , `print_date` DATETIME default '1900-1-1' not null comment 'リスト出力日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INFO0010_PKC` primary key (`rid`)
) comment '速報情報（不要）' ;

-- 死亡情報
drop table if exists `RCIF0070` cascade;

create table `RCIF0070` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `death_date` DATE default '1900-1-1' not null comment '死亡日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0070_PKC` primary key (`rid`)
) comment '死亡情報' ;

-- 返済状態区分マスタ
drop table if exists `CNAM0180` cascade;

create table `CNAM0180` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '返済状態区分値'
  , `name` TEXT default '' not null comment '返済状態区分名'
  , `short_name` TEXT default '' not null comment '返済状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0180_PKC` primary key (`rid`)
) comment '返済状態区分マスタ' ;

-- 会員貸付移行情報
drop table if exists `LOAN0010` cascade;

create table `LOAN0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `loan_id` CHAR(40) not null comment '貸付ID'
  , `process_date` DATE default '1900-1-1' not null comment '移行処理日'
  , `move_month` DATE default '1900-1-1' not null comment '移行開始年月'
  , `prev_membership_id` CHAR(40) not null comment '移行元会員ID'
  , `next_membership_id` CHAR(40) not null comment '移行先会員ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LOAN0010_PKC` primary key (`rid`)
) comment '会員貸付移行情報' ;

-- 貸付状態区分マスタ
drop table if exists `CNAM0179` cascade;

create table `CNAM0179` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '貸付状態区分値'
  , `name` TEXT default '' not null comment '貸付状態区分名'
  , `short_name` TEXT default '' not null comment '貸付状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0179_PKC` primary key (`rid`)
) comment '貸付状態区分マスタ' ;

-- 送付用途区分マスタ
drop table if exists `CNAM0178` cascade;

create table `CNAM0178` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '送付用途区分値'
  , `name` TEXT default '' not null comment '送付用途区分名'
  , `short_name` TEXT default '' not null comment '送付用途区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0178_PKC` primary key (`rid`)
) comment '送付用途区分マスタ' ;

-- 初回利息返済方法区分マスタ
drop table if exists `CNAM0177` cascade;

create table `CNAM0177` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '初回利息返済方法区分値'
  , `name` TEXT default '' not null comment '初回利息返済方法区分名'
  , `short_name` TEXT default '' not null comment '初回利息返済方法区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0177_PKC` primary key (`rid`)
) comment '初回利息返済方法区分マスタ' ;

-- 返済方法区分マスタ
drop table if exists `CNAM0176` cascade;

create table `CNAM0176` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '返済方法区分値'
  , `name` TEXT default '' not null comment '返済方法区分名'
  , `short_name` TEXT default '' not null comment '返済方法区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0176_PKC` primary key (`rid`)
) comment '返済方法区分マスタ' ;

-- 回収不能理由区分マスタ
drop table if exists `CNAM0175` cascade;

create table `CNAM0175` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '回収不能理由区分値'
  , `name` TEXT default '' not null comment '回収不能理由区分名'
  , `short_name` TEXT default '' not null comment '回収不能理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0175_PKC` primary key (`rid`)
) comment '回収不能理由区分マスタ' ;

-- 利息返済状況区分マスタ
drop table if exists `CNAM0174` cascade;

create table `CNAM0174` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '利息返済状況区分値'
  , `name` TEXT default '' not null comment '利息返済状況区分名'
  , `short_name` TEXT default '' not null comment '利息返済状況区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0174_PKC` primary key (`rid`)
) comment '利息返済状況区分マスタ' ;

-- 元金返済状況区分マスタ
drop table if exists `CNAM0173` cascade;

create table `CNAM0173` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '元金返済状況区分値'
  , `name` TEXT default '' not null comment '元金返済状況区分名'
  , `short_name` TEXT default '' not null comment '元金返済状況区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0173_PKC` primary key (`rid`)
) comment '元金返済状況区分マスタ' ;

-- 元金送金反映区分マスタ
drop table if exists `CNAM0171` cascade;

create table `CNAM0171` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '元金送金反映区分値'
  , `name` TEXT default '' not null comment '元金送金反映区分名'
  , `short_name` TEXT default '' not null comment '元金送金反映区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0171_PKC` primary key (`rid`)
) comment '元金送金反映区分マスタ' ;

-- 利息送金反映区分マスタ
drop table if exists `CNAM0172` cascade;

create table `CNAM0172` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '利息送金反映区分値'
  , `name` TEXT default '' not null comment '利息送金反映区分名'
  , `short_name` TEXT default '' not null comment '利息送金反映区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0172_PKC` primary key (`rid`)
) comment '利息送金反映区分マスタ' ;

-- レセプト画像情報
drop table if exists `RCIM0001` cascade;

create table `RCIM0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `application_month` DATE default '1900-1-1' not null comment '請求年月'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `membership_no` INT default 0 not null comment '会員番号'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `trader_class_id` CHAR(40) not null comment '業者区分'
  , `ratio` SMALLINT default 0 not null comment '負担割合'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '請求金額'
  , `ijp_no` TEXT default '' not null comment 'IJP番号'
  , `process_class_id` CHAR(40) not null comment '処理区分'
  , `law_no` TEXT default '' not null comment '法制番号'
  , `insurer_no` TEXT default '' not null comment '保険者番号'
  , `insurer_prefecture_class_id` CHAR(40) not null comment '保険者都道府県区分'
  , `insurer_id` CHAR(40) comment '保険者ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIM0001_PKC` primary key (`rid`)
) comment 'レセプト画像情報' ;

-- 会員返済情報
drop table if exists `LOAN0020` cascade;

create table `LOAN0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `loan_id` CHAR(40) not null comment '貸付ID'
  , `loan_month` DATE default '1900-1-1' not null comment '返済年月'
  , `loan_plan_date` DATE default '1900-1-1' not null comment '返済予定日'
  , `loan_date` DATE default '1900-1-1' not null comment '返済日'
  , `load_amount` DECIMAL(13,2) default 0 not null comment '元金返済金額'
  , `interest_amount` DECIMAL(13,2) default 0 not null comment '利息返済金額'
  , `balance_amount` DECIMAL(13,2) default 0 not null comment '貸付残高'
  , `funds_remittance_class_id` CHAR(40) not null comment '元金送金反映区分'
  , `interest_remittance_class_id` CHAR(40) not null comment '利息送金反映区分'
  , `funds_payback_class_id` CHAR(40) not null comment '元金返済状況区分'
  , `interest_payback_class_id` CHAR(40) not null comment '利息返済状況区分'
  , `loan_state_class_id` CHAR(40) not null comment '返済状態区分:0:未回収、1:回収、2:翌月回し'
  , `remark` TEXT comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LOAN0020_PKC` primary key (`rid`)
) comment '会員返済情報' ;

-- 貸付種別区分マスタ
drop table if exists `CNAM0170` cascade;

create table `CNAM0170` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '貸付種別区分値'
  , `name` TEXT default '' not null comment '貸付種別区分名'
  , `short_name` TEXT default '' not null comment '貸付種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0170_PKC` primary key (`rid`)
) comment '貸付種別区分マスタ' ;

-- 会員貸付情報
drop table if exists `LOAN0001` cascade;

create table `LOAN0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `loan_date` DATE default '1900-1-1' not null comment '貸付日'
  , `loan_class_id` CHAR(40) not null comment '貸付種別区分'
  , `payback_start_date` DATE default '1900-1-1' not null comment '返済開始年月'
  , `payback_count` INT default 0 not null comment '返済回数'
  , `funds_amount` DECIMAL(13,2) default 0 not null comment '貸付金額'
  , `interest_amount` DECIMAL(13,2) default 0 not null comment '利息金額'
  , `interest_ratio` SMALLINT default 0 not null comment '年利率'
  , `payback_method_class_id` CHAR(40) not null comment '返済方法区分:0:元金均等、1:元利金均等'
  , `first_interest_method_class_id` CHAR(40) not null comment '初回利息返済方法区分:0:両端、1:片落'
  , `loan_state_class_id` CHAR(40) not null comment '貸付状態区分:0: 貸付中、1: 返済完了、9:回収不能'
  , `uncollected_reason_class_id` CHAR(40) comment '回収不能理由区分'
  , `uncollected_reason` TEXT default '' not null comment '回収不能理由'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LOAN0001_PKC` primary key (`rid`)
) comment '会員貸付情報' ;

-- 保留区分マスタ
drop table if exists `CNAM0162` cascade;

create table `CNAM0162` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '保留区分値'
  , `name` TEXT default '' not null comment '保留区分名'
  , `short_name` TEXT default '' not null comment '保留区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0162_PKC` primary key (`rid`)
) comment '保留区分マスタ' ;

-- レセコンメーカー区分マスタ
drop table if exists `CNAM0163` cascade;

create table `CNAM0163` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセコンメーカー区分値'
  , `name` TEXT default '' not null comment 'レセコンメーカー区分名'
  , `short_name` TEXT default '' not null comment 'レセコンメーカー区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0163_PKC` primary key (`rid`)
) comment 'レセコンメーカー区分マスタ' ;

-- 消込区分マスタ
drop table if exists `CNAM0165` cascade;

create table `CNAM0165` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '消込区分値'
  , `name` TEXT default '' not null comment '消込区分名'
  , `short_name` TEXT default '' not null comment '消込区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0165_PKC` primary key (`rid`)
) comment '消込区分マスタ' ;

-- 電療区分マスタ
drop table if exists `CNAM0166` cascade;

create table `CNAM0166` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '電療区分値'
  , `name` TEXT default '' not null comment '電療区分名'
  , `short_name` TEXT default '' not null comment '電療区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0166_PKC` primary key (`rid`)
) comment '電療区分マスタ' ;

-- 明細書出力区分マスタ
drop table if exists `CNAM0155` cascade;

create table `CNAM0155` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '明細書出力区分値'
  , `name` TEXT default '' not null comment '明細書出力区分名'
  , `short_name` TEXT default '' not null comment '明細書出力区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0155_PKC` primary key (`rid`)
) comment '明細書出力区分マスタ' ;

-- QR処理区分マスタ
drop table if exists `CNAM0167` cascade;

create table `CNAM0167` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'QR処理区分値'
  , `name` TEXT default '' not null comment 'QR処理区分名'
  , `short_name` TEXT default '' not null comment 'QR処理区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0167_PKC` primary key (`rid`)
) comment 'QR処理区分マスタ' ;

-- レセプト取消理由区分マスタ
drop table if exists `CNAM0168` cascade;

create table `CNAM0168` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト取消理由区分値'
  , `name` TEXT default '' not null comment 'レセプト取消理由区分名'
  , `short_name` TEXT default '' not null comment 'レセプト取消理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0168_PKC` primary key (`rid`)
) comment 'レセプト取消理由区分マスタ' ;

-- 支払決定通知区分マスタ
drop table if exists `CNAM0169` cascade;

create table `CNAM0169` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '支払決定通知区分値'
  , `name` TEXT default '' not null comment '支払決定通知区分名'
  , `short_name` TEXT default '' not null comment '支払決定通知区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0169_PKC` primary key (`rid`)
) comment '支払決定通知区分マスタ' ;

-- 警告区分マスタ
drop table if exists `CNAM0125` cascade;

create table `CNAM0125` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '警告区分値'
  , `name` TEXT default '' not null comment '警告区分名'
  , `short_name` TEXT default '' not null comment '警告区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0125_PKC` primary key (`rid`)
) comment '警告区分マスタ' ;

-- 保健所備考情報
drop table if exists `HLTH0020` cascade;

create table `HLTH0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '保健所ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `HLTH0020_PKC` primary key (`rid`)
) comment '保健所備考情報' ;

-- 保健所部署マスタ
drop table if exists `HLTH0010` cascade;

create table `HLTH0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '保健所ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `HLTH0010_PKC` primary key (`rid`)
) comment '保健所部署マスタ' ;

-- 労働基準監督署局部署マスタ
drop table if exists `LSIO0010` cascade;

create table `LSIO0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '労働基準監督署局ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LSIO0010_PKC` primary key (`rid`)
) comment '労働基準監督署局部署マスタ' ;

-- 審査会等備考情報
drop table if exists `FDRT0020` cascade;

create table `FDRT0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '審査会等ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDRT0020_PKC` primary key (`rid`)
) comment '審査会等備考情報' ;

-- 審査会等振込口座マスタ
drop table if exists `FDAC0001` cascade;

create table `FDAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '審査会等ID'
  , `check_company_id` CHAR(40) comment '点検業者ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `holder_address_street` TEXT not null comment '名義人団地・マンション'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDAC0001_PKC` primary key (`rid`)
) comment '審査会等振込口座マスタ' ;

-- 審査会等部署マスタ
drop table if exists `FDRT0010` cascade;

create table `FDRT0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '審査会等ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDRT0010_PKC` primary key (`rid`)
) comment '審査会等部署マスタ' ;

-- 福祉事務所協定マスタ
drop table if exists `WFOF0040` cascade;

create table `WFOF0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `welfare_office_id` CHAR(40) not null comment '福祉事務所ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0040_PKC` primary key (`rid`)
) comment '福祉事務所協定マスタ' ;

-- 医療助成審査先マスタ
drop table if exists `MDAO0050` cascade;

create table `MDAO0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_office_id` CHAR(40) not null comment '医療助成機関ID'
  , `send_flag` TINYINT default 0 not null comment '送付先審査会フラグ:送付先審査会フラグが１の場合のみ'
  , `organization_id` CHAR(40) comment '審査会等ID:送付先審査会フラグが１の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAO0050_PKC` primary key (`rid`)
) comment '医療助成審査先マスタ' ;

-- 労務局部署マスタ
drop table if exists `IDAC00010` cascade;

create table `IDAC00010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '労務局ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `licence_info_class_id` CHAR(40) comment '許可番号通知区分'
  , `inquiry_flag` TINYINT default 0 not null comment '問い合わせ可フラグ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IDAC00010_PKC` primary key (`rid`)
) comment '労務局部署マスタ' ;

-- 労働局マスタ
drop table if exists `IDAC00001` cascade;

create table `IDAC00001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `department_kana` TEXT default '' not null comment '労働局カナ名'
  , `department_name` TEXT default '' not null comment '労働局名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IDAC00001_PKC` primary key (`rid`)
) comment '労働局マスタ' ;

-- 防衛省部署マスタ
drop table if exists `MSDF0010` cascade;

create table `MSDF0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '防衛省ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `licence_info_class_id` CHAR(40) comment '許可番号通知区分'
  , `inquiry_flag` TINYINT default 0 not null comment '問い合わせ可フラグ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MSDF0010_PKC` primary key (`rid`)
) comment '防衛省部署マスタ' ;

-- 防衛省マスタ
drop table if exists `MSDF0001` cascade;

create table `MSDF0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_kana` TEXT default '' not null comment '防衛省カナ名'
  , `department_name` TEXT default '' not null comment '防衛省名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MSDF0001_PKC` primary key (`rid`)
) comment '防衛省マスタ' ;

-- 地方共済組合部署マスタ
drop table if exists `LMAA0010` cascade;

create table `LMAA0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '地方共済組合ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `licence_info_class_id` CHAR(40) comment '許可番号通知区分'
  , `inquiry_flag` TINYINT default 0 not null comment '問い合わせ可フラグ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LMAA0010_PKC` primary key (`rid`)
) comment '地方共済組合部署マスタ' ;

-- 地方共済組合マスタ
drop table if exists `LMAA0001` cascade;

create table `LMAA0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_kana` TEXT default '' not null comment '地方共済組合カナ名'
  , `department_name` TEXT default '' not null comment '地方共済組合名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LMAA0001_PKC` primary key (`rid`)
) comment '地方共済組合マスタ' ;

-- 共済組合部署マスタ
drop table if exists `MAAS0010` cascade;

create table `MAAS0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '共済組合ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `licence_info_class_id` CHAR(40) comment '許可番号通知区分'
  , `inquiry_flag` TINYINT default 0 not null comment '問い合わせ可フラグ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MAAS0010_PKC` primary key (`rid`)
) comment '共済組合部署マスタ' ;

-- 共済組合マスタ
drop table if exists `MAAS0001` cascade;

create table `MAAS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_kana` TEXT default '' not null comment '共済組合カナ名'
  , `department_name` TEXT default '' not null comment '共済組合名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MAAS0001_PKC` primary key (`rid`)
) comment '共済組合マスタ' ;

-- 厚生局部署マスタ
drop table if exists `MHLW0010` cascade;

create table `MHLW0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `organization_id` CHAR(40) not null comment '厚生局ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `licence_info_class_id` CHAR(40) comment '許可番号通知区分'
  , `inquiry_flag` TINYINT default 0 not null comment '問い合わせ可フラグ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MHLW0010_PKC` primary key (`rid`)
) comment '厚生局部署マスタ' ;

-- 医療助成機関マスタ
drop table if exists `MDAO0001` cascade;

create table `MDAO0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `municipality_id` CHAR(40) comment '自治体ID:県レベルの場合は指定なし'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `department_kana` TEXT default '' not null comment '医療助成機関カナ名'
  , `department_name` TEXT default '' not null comment '医療助成機関名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAO0001_PKC` primary key (`rid`)
) comment '医療助成機関マスタ' ;

-- 医療助成機関部署マスタ
drop table if exists `MDAO0010` cascade;

create table `MDAO0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `medical_assist_office_id` CHAR(40) not null comment '医療助成機関ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAO0010_PKC` primary key (`rid`)
) comment '医療助成機関部署マスタ' ;

-- 福祉事務所部署マスタ
drop table if exists `WFOF0010` cascade;

create table `WFOF0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `welfare_office_id` CHAR(40) not null comment '福祉事務所ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科医区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT not null comment '部署名'
  , `address_flag` TINYINT default 0 not null comment '住所フラグ:1: 自身の住所を使用'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0010_PKC` primary key (`rid`)
) comment '福祉事務所部署マスタ' ;

-- 福祉事務所口座マスタ
drop table if exists `WFAC0001` cascade;

create table `WFAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `welfare_office_id` CHAR(40) not null comment '福祉事務所ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `holder_address_street` TEXT not null comment '名義人団地・マンション'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFAC0001_PKC` primary key (`rid`)
) comment '福祉事務所口座マスタ' ;

-- 会員備考添付ファイル情報
drop table if exists `MBSP0045` cascade;

create table `MBSP0045` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0045_PKC` primary key (`rid`)
) comment '会員備考添付ファイル情報' ;

-- 会員紹介者情報
drop table if exists `MBSP0090` cascade;

create table `MBSP0090` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `introduce_class_id` CHAR(40) not null comment '紹介者区分:1:学校、2: 企業、3: 個人、4:本人(特定学校卒業）'
  , `introducer_membership_id` CHAR(40) comment '紹介者会員ID'
  , `introducer_id` CHAR(40) comment '紹介学校・企業ID'
  , `last_kana` TEXT default '' not null comment '紹介者カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '紹介者カナ名前:半角'
  , `last_name` TEXT default '' not null comment '紹介者苗字:全角'
  , `first_name` TEXT default '' not null comment '紹介者名前:全角'
  , `sex_class_id` CHAR(40) default '' not null comment '性別区分:1: 男、2: 女'
  , `organization` TEXT default '' not null comment '所属団体名'
  , `organization_kana` TEXT default '' not null comment '所属団体カナ名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `introduction_amount` DECIMAL(13,2) not null comment '紹介礼金額'
  , `payment_date` DATE not null comment '礼金支払日'
  , `payment_flag` TINYINT not null comment '礼金支払済フラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0090_PKC` primary key (`rid`)
) comment '会員紹介者情報' ;

-- 施術管理者マスタ
drop table if exists `OFFC0010` cascade;

create table `OFFC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分:柔整、鍼、灸、あん摩・マッサージ'
  , `staff_id` CHAR(40) not null comment '担当者ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFFC0010_PKC` primary key (`rid`)
) comment '施術管理者マスタ' ;

-- 施術所送付先用途マスタ
drop table if exists `OFFC0035` cascade;

create table `OFFC0035` (
  `rid` CHAR(40) not null comment 'RID'
  , `send_address_id` CHAR(40) not null comment '施術所送付先ID'
  , `use_class_id` TEXT default '' not null comment '送付用途区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFFC0035_PKC` primary key (`rid`)
) comment '施術所送付先用途マスタ' ;

-- 施術所送付先マスタ
drop table if exists `OFFC0030` cascade;

create table `OFFC0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment '施術所ID'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `membership_id` CHAR(40) comment '会員ID'
  , `delivery_class_id` CHAR(40) not null comment '送付区分:ヤマト、西濃'
  , `parent_office_id` CHAR(40) comment '本院施術所ID:送付先が本院の場合'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFFC0030_PKC` primary key (`rid`)
) comment '施術所送付先マスタ' ;

-- 会員特殊対象者情報
drop table if exists `MBSP0070` cascade;

create table `MBSP0070` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `special_flag` TINYINT not null comment '特殊対象者フラグ'
  , `process_date` DATE default '1900-1-1' not null comment '処理年月'
  , `start_date` DATE default '1900-1-1' not null comment '請求対象開始年月'
  , `end_date` DATE default '1900-1-1' not null comment '請求対象終了年月'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0070_PKC` primary key (`rid`)
) comment '会員特殊対象者情報' ;

-- 福祉事務所入金先マスタ
drop table if exists `WFOF0060` cascade;

create table `WFOF0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `welfare_office_id` CHAR(40) not null comment '福祉事務所ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `send_flag` TINYINT default 0 not null comment '審査会フラグ:1: 審査会で審査'
  , `organization_id` CHAR(40) comment '審査会等ID:審査会フラグが１の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0060_PKC` primary key (`rid`)
) comment '福祉事務所入金先マスタ' ;

-- 医療助成本体関係マスタ
drop table if exists `MDAS0030` cascade;

create table `MDAS0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_id` CHAR(40) not null comment '医療助成ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `main_fix_flag` TINYINT default 0 not null comment '本体決定通知要フラグ:医療助成が本体通知後のみの場合'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAS0030_PKC` primary key (`rid`)
) comment '医療助成本体関係マスタ' ;

-- 福祉事務所審査先マスタ
drop table if exists `WFOF0050` cascade;

create table `WFOF0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `welfare_office_id` CHAR(40) not null comment '福祉事務所ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `send_flag` TINYINT default 0 not null comment '送付先審査会フラグ:送付先審査会フラグが１の場合のみ'
  , `organization_id` CHAR(40) comment '審査会等ID:送付先審査会フラグが１の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0050_PKC` primary key (`rid`)
) comment '福祉事務所審査先マスタ' ;

-- 福祉事務所備考添付ファイル情報
drop table if exists `WFOF0030` cascade;

create table `WFOF0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0030_PKC` primary key (`rid`)
) comment '福祉事務所備考添付ファイル情報' ;

-- 福祉事務所備考情報
drop table if exists `WFOF0020` cascade;

create table `WFOF0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `welfare_office_id` CHAR(40) not null comment '福祉事務所ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0020_PKC` primary key (`rid`)
) comment '福祉事務所備考情報' ;

-- 自治体マスタ
drop table if exists `MNCP0001` cascade;

create table `MNCP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `municipality_no` TEXT not null comment '自治体番号'
  , `municipality_kana` TEXT default '' not null comment '自治体カナ名'
  , `municipality_name` TEXT default '' not null comment '自治体名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNCP0001_PKC` primary key (`rid`)
) comment '自治体マスタ' ;

-- 福祉事務所口座用途マスタ
drop table if exists `WFAC0010` cascade;

create table `WFAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '福祉事務所口座ID'
  , `municipality_class_id` CHAR(40) not null comment '部署区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `use_class_id` CHAR(40) not null comment '入送金区分:1: 入金、2:送金、3:両方'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFAC0010_PKC` primary key (`rid`)
) comment '福祉事務所口座用途マスタ' ;

-- 福祉事務所マスタ
drop table if exists `WFOF0001` cascade;

create table `WFOF0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `municipality_id` CHAR(40) not null comment '自治体ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `welfare_office_kana` TEXT default '' not null comment '福祉事務所カナ名'
  , `welfare_office_name` TEXT default '' not null comment '福祉事務所名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `WFOF0001_PKC` primary key (`rid`)
) comment '福祉事務所マスタ' ;

-- 医療助成口座マスタ
drop table if exists `MDAC0001` cascade;

create table `MDAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_office_id` CHAR(40) not null comment '医療助成機関ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `holder_address_street` TEXT not null comment '名義人団地・マンション'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAC0001_PKC` primary key (`rid`)
) comment '医療助成口座マスタ' ;

-- 医療助成備考添付ファイル情報
drop table if exists `MDAO0030` cascade;

create table `MDAO0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAO0030_PKC` primary key (`rid`)
) comment '医療助成備考添付ファイル情報' ;

-- 医療助成備考情報
drop table if exists `MDAO0020` cascade;

create table `MDAO0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_office_id` CHAR(40) not null comment '医療助成機関ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAO0020_PKC` primary key (`rid`)
) comment '医療助成備考情報' ;

-- 医療助成口座用途マスタ
drop table if exists `MDAC0010` cascade;

create table `MDAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '医療助成口座ID'
  , `municipality_class_id` CHAR(40) not null comment '部署区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `use_class_id` CHAR(40) not null comment '入送金区分:1: 入金、2:送金、3:両方'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAC0010_PKC` primary key (`rid`)
) comment '医療助成口座用途マスタ' ;

-- 医療助成入金先マスタ
drop table if exists `MDAO0060` cascade;

create table `MDAO0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_office_id` CHAR(40) not null comment '医療助成機関ID'
  , `municipality_class_id` CHAR(40) not null comment '部署区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `send_flag` TINYINT default 0 not null comment '審査会フラグ:1: 審査会で審査'
  , `organization_id` CHAR(40) comment '審査会等ID:審査会フラグが１の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAO0060_PKC` primary key (`rid`)
) comment '医療助成入金先マスタ' ;

-- 開設者マスタ
drop table if exists `OPNR0001` cascade;

create table `OPNR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `opener_class_id` TEXT default '' not null comment '開設者区分:1: 会員本人、9:その他'
  , `membership_id` CHAR(40) not null comment '会員ID:開設者主区分が1の場合のみ'
  , `last_kana` TEXT default '' not null comment '開設者カナ苗字'
  , `first_kana` TEXT default '' not null comment '開設者カナ名前'
  , `last_name` TEXT default '' not null comment '開設者苗字'
  , `first_name` TEXT default '' not null comment '開設者名前'
  , `sex_class_id` CHAR(40) not null comment '性別区分'
  , `die_date` DATE default '1900-1-1' not null comment '死亡年月日'
  , `company_kana` TEXT default '' not null comment '企業カナ名'
  , `company_name` TEXT default '' not null comment '企業名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OPNR0001_PKC` primary key (`rid`)
) comment '開設者マスタ' ;

-- レセプト提出予定情報
drop table if exists `RCPD0001` cascade;

create table `RCPD0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `application_month` DATE default '1900-1-1' not null comment '請求年月'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `plan_date` DATE default '1900-1-1' not null comment 'レセプト提出予定日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPD0001_PKC` primary key (`rid`)
) comment 'レセプト提出予定情報' ;

-- 会員備考マスタ
drop table if exists `MBSP0040` cascade;

create table `MBSP0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `remark_class_id` CHAR(40) not null comment '会員備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0040_PKC` primary key (`rid`)
) comment '会員備考マスタ' ;

-- レセプト消込情報
drop table if exists `ACIO0010` cascade;

create table `ACIO0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `account_id` CHAR(40) not null comment '保険者口座出入帳ID'
  , `receipt_type` INT default 0 not null comment 'レセプト種別:1:柔整、2:鍼灸､3:あん摩・マッサージ'
  , `receipt_id` CHAR(40) not null comment 'レセプトID'
  , `subject_class_id` DATE default '1900-1-1' not null comment '科目区分'
  , `self_flag` CHAR(40) not null comment '本人フラグ'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `receipted_amount` DECIMAL(13,2) default 0 not null comment '入金済金額'
  , `reconciliation_flag` TINYINT default 0 not null comment '消込フラグ'
  , `repay_flag` TINYINT default 0 not null comment '返金フラグ'
  , `operator_id` CHAR(40) not null comment '処理ユーザーID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ACIO0010_PKC` primary key (`rid`)
) comment 'レセプト消込情報' ;

-- 柔整レセプト申請エラー情報
drop table if exists `RCPT0050` cascade;

create table `RCPT0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整レセプト申請ID'
  , `receipt_injury_id` CHAR(40) not null comment '柔整レセプト傷病ID'
  , `error_class_id` CHAR(40) not null comment 'エラー区分'
  , `error_id` CHAR(40) not null comment 'エラーID'
  , `content` TEXT default '' not null comment 'エラー内容'
  , `relation_receipt_type` INT default 0 comment '関連レセプト種別:1:柔整、2:鍼灸、3:あん摩・マッサージ'
  , `relation_receipt_id` CHAR(40) comment '関連レセプトID:重複請求などの相手方のレセプト'
  , `confirm_flag` TINYINT default 0 not null comment '確認完了フラグ:1: 確認完了'
  , `comment` TEXT default '' not null comment 'コメント'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0050_PKC` primary key (`rid`)
) comment '柔整レセプト申請エラー情報' ;

-- レセプト受付情報
drop table if exists `RCRC0001` cascade;

create table `RCRC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `application_month` DATE default '1900-1-1' not null comment '請求年月'
  , `treatment_month` DATE default '1900-1-1' not null comment '施術年月'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `reception_date` DATE default '1900-1-1' not null comment '受付日'
  , `transfer_date` DATE default '1900-1-1' not null comment '転送日'
  , `ocr_check_flag` TINYINT default 0 not null comment 'OCRチェックフラグ'
  , `prefecture_check_flag` TINYINT default 0 not null comment '府県チェックフラグ'
  , `sign_check_flag` TINYINT default 0 not null comment 'レセプトサインチェックフラグ'
  , `pc_check_flag` TINYINT default 0 not null comment 'PCチェックフラグ'
  , `state_flag` TINYINT default 0 not null comment '状況フラグ'
  , `next_month_flag` TINYINT default 0 not null comment '翌月フラグ'
  , `hq_flag` TINYINT default 0 not null comment '鍼灸フラグ'
  , `manual_flag` TINYINT default 0 not null comment '手入力フラグ'
  , `headquarters_flag` TINYINT default 0 not null comment '本部入力フラグ'
  , `division_flag` TINYINT default 0 not null comment '事業部フラグ'
  , `reception_flag` TINYINT default 0 not null comment '受入フラグ'
  , `operator_id` CHAR(40) default 0 comment 'オペレーターID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCRC0001_PKC` primary key (`rid`)
) comment 'レセプト受付情報' ;

-- 保険者口座出入帳情報
drop table if exists `ACIO0001` cascade;

create table `ACIO0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `office_id` CHAR(40) not null comment '管理企業口座ID'
  , `process_date` DATE default '1900-1-1' not null comment '出入日:入金年月日'
  , `seq_no_1` INT default 0 not null comment '連番１:出入日に対する連番(元々は住友銀行の明細頁に連動)'
  , `seq_no_2` INT default 0 not null comment '連番２:出入日の連番1に対する連番。最大値15。(元々は住友銀行の明細行に連動)'
  , `subject_class_id` CHAR(40) not null comment '口座出入科目区分'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `account_kana_name` TEXT default '' not null comment '入金時口座名義カナ名'
  , `receipt_amount` DECIMAL(13,2) default 0 not null comment '入金金額'
  , `process_amount` DECIMAL(13,2) default 0 not null comment '入金処理済額'
  , `repay_flag` TINYINT default 0 not null comment '返金フラグ'
  , `operator_id` CHAR(40) not null comment '処理ユーザーID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ACIO0001_PKC` primary key (`rid`)
) comment '保険者口座出入帳情報' ;

-- 会員レセプト統計情報
drop table if exists `STCS0010` cascade;

create table `STCS0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `application_month` DATE not null comment '請求年月:[yyyy-mm-01]'
  , `treatment_month` DATE not null comment '施術年月:[yyyy-mm-01]'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `insurer_type_class_id` CHAR(40) not null comment '保険者種別区分'
  , `total_count` INT default 0 not null comment '件数'
  , `total_count_rank` INT default 0 not null comment '件数別全体順位'
  , `total_charge_amount` INT default 0 not null comment '総請求金額'
  , `total_charge_amount_rank` INT default 0 not null comment '総請求金額別全体順位'
  , `max_charge_amount` INT default 0 not null comment '最大請求金額'
  , `max_charge_amount_rank` INT default 0 not null comment '最大請求金額別全体順位'
  , `total_days` INT default 0 not null comment '総日数'
  , `total_days_rank` INT default 0 not null comment '総部位数'
  , `four_parts_count` INT default 0 not null comment '4部位以上件数'
  , `new_count` INT default 0 not null comment '新規件数'
  , `new_count_rank` INT default 0 not null comment '新規別全体順位'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `STCS0010_PKC` primary key (`rid`)
) comment '会員レセプト統計情報' ;

-- 会員統計情報
drop table if exists `STCS0001` cascade;

create table `STCS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `treatment_month` DATE not null comment '施術年月:[yyyy-mm-01]'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `self_first_examine_count` INT default 0 not null comment '本人･初検算定件数'
  , `self_4_days` INT default 0 not null comment '本人･実日数4日以下'
  , `self_9_days` INT default 0 not null comment '本人･実日数9日以下'
  , `self_14_days` INT default 0 not null comment '本人･実日数14日以下'
  , `self_31_days` INT default 0 not null comment '本人･実日数31日以下'
  , `family_first_examine_count` INT default 0 not null comment '家族・初検算定件数'
  , `family_4_days` INT default 0 not null comment '家族・実日数4日以下'
  , `family_9_days` INT default 0 not null comment '家族・実日数9日以下'
  , `family_14_days` INT default 0 not null comment '家族・実日数14日以下'
  , `family_31_days` INT default 0 not null comment '家族・実日数31日以下'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `STCS0001_PKC` primary key (`rid`)
) comment '会員統計情報' ;

-- 保険者返戻金情報
drop table if exists `ISBK0001` cascade;

create table `ISBK0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `process_month` DATE not null comment '処理年月'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `application_month` DATE not null comment '申請年月'
  , `treatment_month` DATE not null comment '施術年月'
  , `back_amount` DECIMAL(13,2) not null comment '返戻金額'
  , `judge_restore_amount` DECIMAL(13,2) not null comment '審査還元料'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ISBK0001_PKC` primary key (`rid`)
) comment '保険者返戻金情報' ;

-- 事務手数料情報
drop table if exists `CMSN0001` cascade;

create table `CMSN0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `remittance_month` DATE not null comment '送金年月'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `application_month` DATE not null comment '申請年月'
  , `treatment_month` DATE not null comment '施術年月'
  , `subject_class_id` CHAR(40) not null comment '科目区分'
  , `amount` DECIMAL(13,2) not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CMSN0001_PKC` primary key (`rid`)
) comment '事務手数料情報' ;

-- 送金明細情報
drop table if exists `RMTC0010` cascade;

create table `RMTC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `remittance_id` CHAR(40) not null comment '送金ID'
  , `subject_class_id` CHAR(40) not null comment '科目区分'
  , `remittance_amount` DECIMAL(13,2) default 0 not null comment '金額'
  , `tax_amount` DECIMAL(13,2) default 0 not null comment '消費税'
  , `start_date` DATE default '1900-1-1' not null comment '送金対象開始日'
  , `end_date` DATE default '1900-1-1' not null comment '送金対象終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RMTC0010_PKC` primary key (`rid`)
) comment '送金明細情報' ;

-- 送金情報
drop table if exists `RMTC0001` cascade;

create table `RMTC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `remittance_month` DATE not null comment '送金年月:[yyyy-mm-01]'
  , `office_id` CHAR(40) default 0 not null comment '施術所ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `remittance_amount` DECIMAL(13,2) default 0 not null comment '合計送金金額'
  , `tax_amount` DECIMAL(13,2) default 0 not null comment '合計消費税'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RMTC0001_PKC` primary key (`rid`)
) comment '送金情報' ;

-- 鍼灸マレセプト申請エラー情報
drop table if exists `RCPT0150` cascade;

create table `RCPT0150` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マレセプト申請ID'
  , `receipt_injury_id` CHAR(40) not null comment '鍼灸マレセプト傷病ID'
  , `error_class_id` CHAR(40) not null comment 'エラー区分'
  , `error_id` CHAR(40) not null comment 'エラーID'
  , `content` TEXT default '' not null comment 'エラー内容'
  , `relation_receipt_type` INT default 0 comment '関連レセプト種別:1:柔整、2:鍼灸、3:あん摩・マッサージ'
  , `relation_receipt_id` CHAR(40) comment '関連レセプトID:重複請求などの相手方のレセプト'
  , `confirm_flag` TINYINT not null comment '確認完了フラグ:1: 確認完了'
  , `comment` TEXT default '' not null comment 'コメント'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0150_PKC` primary key (`rid`)
) comment '鍼灸マレセプト申請エラー情報' ;

-- 医療助成事務手数料マスタ
drop table if exists `MDAS0020` cascade;

create table `MDAS0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_id` CHAR(40) not null comment '医療助成ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `expense_charge_class_id` CHAR(40) not null comment '事務手数料区分:1:なし、2:助成と合算入金、3: 助成分と分けて入金'
  , `expense_charge_amount` DECIMAL(13,2) not null comment '事務手数料金額'
  , `expense_charge_min_amount` DECIMAL(13,2) default 0 not null comment '事務手数料対象金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAS0020_PKC` primary key (`rid`)
) comment '医療助成事務手数料マスタ' ;

-- 医療助成給付割合マスタ
drop table if exists `MDAS0010` cascade;

create table `MDAS0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `medical_assist_id` INT default 0 not null comment '医療助成ID'
  , `condition_no` INT default 0 not null comment '医療助成条件番号'
  , `benefit_ratio` SMALLINT default 0 not null comment '助成給付割合:0:無制限'
  , `limit_amount` DECIMAL(13,2) default 0 not null comment '1診療の自己負担限度額:0:無制限'
  , `limit_count` INT default 0 not null comment '1月の限度回数:0:無制限'
  , `limit_month_amount` DECIMAL(13,2) default 0 not null comment '1月の自己負担限度額:0:無制限'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAS0010_PKC` primary key (`rid`)
) comment '医療助成給付割合マスタ' ;

-- 医療助成マスタ
drop table if exists `MDAS0001` cascade;

create table `MDAS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `medical_assist_office_id` CHAR(40) not null comment '医療助成機関ID'
  , `medical_assist_no` INT default 0 not null comment '医療助成識別番号'
  , `defrayer_no` TEXT default '' not null comment '公費負担者番号'
  , `medical_assist_class_id` CHAR(10) default '' not null comment '医療助成種別区分'
  , `medical_assist_name` TEXT default '' not null comment '医療助成名'
  , `add_up_flag` TINYINT default 0 not null comment '医療助成本体合算フラグ:1:医療助成レセプトは出さず本体レセプトに含めて提出する'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MDAS0001_PKC` primary key (`rid`)
) comment '医療助成マスタ' ;

-- 保険者口座マスタ
drop table if exists `ISAC0001` cascade;

create table `ISAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `check_company_id` CHAR(40) comment '点検業者ID:点検業者の口座の場合'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `holder_address_street` TEXT not null comment '名義人団地・マンション'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ISAC0001_PKC` primary key (`rid`)
) comment '保険者口座マスタ' ;

-- 保険者受領委任・償還払いマスタ
drop table if exists `INSR0090` cascade;

create table `INSR0090` (
  `rid` CHAR(40) not null comment 'RID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `insurer_dept_id` CHAR(40) not null comment '保険者部署ID'
  , `billing_method_class_id` CHAR(40) not null comment '受領委任・償還払い区分:なし、受領委任､償還払い'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0090_PKC` primary key (`rid`)
) comment '保険者受領委任・償還払いマスタ' ;

-- 施術所口座マスタ
drop table if exists `OFAC0001` cascade;

create table `OFAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `account_owner_class_id` CHAR(40) not null comment '口座所有者区分:1:オーナー、2: 開設者、3:施術所、4: 会員、9: その他'
  , `membership_id` CHAR(40) comment '会員ID'
  , `owner_id` CHAR(40) comment '事業主ID'
  , `opener_id` CHAR(40) comment '開設者ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `holder_address_city_kana` TEXT default '' not null comment '名義人市区町村カナ'
  , `holder_address_town_kana` TEXT default '' not null comment '名義人町域カナ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFAC0001_PKC` primary key (`rid`)
) comment '施術所口座マスタ' ;

-- 免許種別区分マスタ
drop table if exists `CNAM0033` cascade;

create table `CNAM0033` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '免許種別区分値'
  , `name` TEXT default '' not null comment '免許種別区分名'
  , `short_name` TEXT default '' not null comment '免許種別区分略称'
  , `department_short_name` TEXT default '' not null comment '診療科区分略称'
  , `j_flag` TINYINT default 0 not null comment '柔整フラグ'
  , `h_flag` TINYINT default 0 not null comment '鍼フラグ'
  , `q_flag` TINYINT default 0 not null comment '灸フラグ'
  , `m_flag` TINYINT default 0 not null comment 'あん摩・マッサージフラグ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0033_PKC` primary key (`rid`)
) comment '免許種別区分マスタ' ;

-- 書類マスタ
drop table if exists `DCMT0001` cascade;

create table `DCMT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `document_name` TEXT default '' not null comment '書類名'
  , `document_class_id` CHAR(40) default '' not null comment '書類区分'
  , `print_flag` TINYINT default 0 not null comment '印字フラグ'
  , `file_name` TEXT not null comment 'ファイル名'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `DCMT0001_PKC` primary key (`rid`)
) comment '書類マスタ' ;

-- 担当者マスタ
drop table if exists `STAF0001` cascade;

create table `STAF0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `owner_id` CHAR(40) not null comment '事業主ID'
  , `staff_no` INT default 0 not null comment '担当者番号'
  , `last_kana` TEXT default '' not null comment '担当者カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '担当者カナ名前:半角'
  , `last_name` TEXT default '' not null comment '担当者苗字:全角'
  , `first_name` TEXT default '' not null comment '担当者名前:全角'
  , `birthday` DATE default '1800-1-1' not null comment '生年月日'
  , `sex_id` CHAR(40) not null comment '性別区分:性別区分'
  , `staff_class_id` CHAR(40) not null comment '担当区分:担当区分'
  , `osteopathic_license_no` TEXT default '' not null comment '柔整師免許番号'
  , `acupuncturists_license_no` TEXT default '' not null comment '鍼師免許番号'
  , `moxibustion_license_no` TEXT default '' not null comment '灸師免許番号'
  , `massage_license_no` TEXT default '' not null comment 'あん摩マツサージ指圧免許番号'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `consent_flag` TINYINT default 0 not null comment '受領委任同意書フラグ'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `STAF0001_PKC` primary key (`rid`)
) comment '担当者マスタ' ;

-- 診療科保険請求マスタ
drop table if exists `OFDP0010` cascade;

create table `OFDP0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `department_class_id` CHAR(40) default 0 not null comment '診療科区分:柔整、鍼、灸、あん摩・マッサージ'
  , `old_insurance_class_id` CHAR(40) not null comment '老健区分:1:率、2:額'
  , `welfare_flag` TINYINT default 0 not null comment '生活保護申請済フラグ:1: 申請済'
  , `welfare_date` DATE default '1900-1-1' not null comment '生活保護申請日'
  , `detail_process_flag` TINYINT default 0 not null comment '明細処理フラグ:明細処理（仕分け）の有無'
  , `start_date` DATE default '1900-1-1' not null comment '保険請求開始日'
  , `end_date` DATE default '9999-12-31' not null comment '保険請求終了日'
  , `state_class_id` CHAR(40) not null comment '保険請求状態区分:1: 有効、2: 保留、取消'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFDP0010_PKC` primary key (`rid`)
) comment '診療科保険請求マスタ' ;

-- 施術所出資金情報
drop table if exists `OFFC0020` cascade;

create table `OFFC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) default '' not null comment '施術所ID'
  , `ownership_class_id` CHAR(40) default '' not null comment '出資金所有者区分:1:オーナー、2:会員'
  , `owner_id` CHAR(40) not null comment '事業主ID:所有者区分が1の場合のみ'
  , `membership_id` CHAR(40) not null comment '会員ID:所有者区分が2の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `investment_id` CHAR(40) not null comment '出資金ID:1: 通常会員、2:旧会員'
  , `investment_count` INT default 0 not null comment '出資口数'
  , `investment_amount` DECIMAL(13,2) default 0 not null comment '出資金額'
  , `return_flag` TINYINT default 0 not null comment '出資金返還済フラグ'
  , `transer_id` CHAR(40) default 0 not null comment '譲渡出資金情報ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFFC0020_PKC` primary key (`rid`)
) comment '施術所出資金情報' ;

-- 施術機関コード番号構成マスタ
drop table if exists `OFCC0010` cascade;

create table `OFCC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `control_id` CHAR(40) not null comment '施術機関コード制御ID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `department_class` CHAR(40) comment '診療科区分:共通の場合はブランク'
  , `number_struct` TEXT not null comment '番号構成:'''
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFCC0010_PKC` primary key (`rid`)
) comment '施術機関コード番号構成マスタ' ;

-- 保健所管理区域情報マスタ
drop table if exists `HLTH0040` cascade;

create table `HLTH0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '保健所ID'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `city_name` TEXT default '' not null comment '市郡名'
  , `town_name` TEXT default '' not null comment '区町村名'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `HLTH0040_PKC` primary key (`rid`)
) comment '保健所管理区域情報マスタ' ;

-- グループ権限管理企業マスタ
drop table if exists `USER0003` cascade;

create table `USER0003` (
  `rid` CHAR(40) not null comment 'RID'
  , `group_function_id` CHAR(40) not null comment 'グループ権限機能ID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `USER0003_PKC` primary key (`rid`)
) comment 'グループ権限管理企業マスタ' ;

-- 保険者督促先マスタ
drop table if exists `INSR0080` cascade;

create table `INSR0080` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `kana_name` TEXT default '' not null comment '督促先カナ名'
  , `name` TEXT default '' not null comment '督促先名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `department_name` TEXT default '' not null comment '担当部署名'
  , `delegate_name` TEXT default '' not null comment '担当者名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0080_PKC` primary key (`rid`)
) comment '保険者督促先マスタ' ;

-- 事業主マスタ
drop table if exists `OWNR0001` cascade;

create table `OWNR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `revision` INT UNSIGNED not null comment 'リビジョン'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `owner_no` INT default 0 not null comment '事業主番号:全柔協でユニーク'
  , `owner_class` TEXT default '' not null comment 'オーナー区分:1: 会員本人、2:開設者､9:その他'
  , `membership_id` CHAR(40) not null comment '会員ID:事業主区分が1の場合のみ'
  , `opener_id` CHAR(40) not null comment '開設者ID:事業主区分が2の場合のみ'
  , `last_kana` TEXT default '' not null comment '事業主カナ苗字'
  , `first_kana` TEXT default '' not null comment '事業主カナ名前'
  , `last_name` TEXT default '' not null comment '事業主苗字'
  , `first_name` TEXT default '' not null comment '事業主名前'
  , `sex_class_id` CHAR(40) not null comment '性別区分'
  , `die_date` DATE default '1900-1-1' not null comment '死亡年月日'
  , `company_kana` TEXT default '' not null comment '企業カナ名'
  , `company_name` TEXT default '' not null comment '企業名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OWNR0001_PKC` primary key (`rid`)
) comment '事業主マスタ' ;

-- 地方共済組合備考情報
drop table if exists `LMAA0020` cascade;

create table `LMAA0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '地方共済組合ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LMAA0020_PKC` primary key (`rid`)
) comment '地方共済組合備考情報' ;

-- 地方共済組合届出都道府県情報
drop table if exists `LMAA0040` cascade;

create table `LMAA0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `start_date` DATE default '1900-01-01' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LMAA0040_PKC` primary key (`rid`)
) comment '地方共済組合届出都道府県情報' ;

-- 開催会場区分マスタ
drop table if exists `MNAM0002` cascade;

create table `MNAM0002` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `clazz` TEXT default '' not null comment '開催会場区分値'
  , `name` TEXT default '' not null comment '開催会場区分名'
  , `short_name` TEXT default '' not null comment '開催会場区分略称'
  , `area_class_id` CHAR(40) not null comment '開催会場地域区分'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0002_PKC` primary key (`rid`)
) comment '開催会場区分マスタ' ;

-- 入会講習情報
drop table if exists `RCQL0010` cascade;

create table `RCQL0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `qualification_id` CHAR(40) not null comment '受付会員資格ID'
  , `course_class_id` CHAR(40) not null comment '入会講習区分'
  , `request_course_date` TEXT default '' not null comment '入会講習希望日'
  , `partner_count` INT default 0 not null comment '入会講習同伴者数'
  , `cource_id` CHAR(40) comment '入会講習会ID'
  , `cource_take_flag` TINYINT default 0 not null comment '入会講習受講完了フラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCQL0010_PKC` primary key (`rid`)
) comment '入会講習情報' ;

-- 施術機関コード申請書類明細マスタ
drop table if exists `OFCC0050` cascade;

create table `OFCC0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `action_id` CHAR(40) not null comment '受付処理ID'
  , `document_id` CHAR(40) not null comment '書類ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFCC0050_PKC` primary key (`rid`)
) comment '施術機関コード申請書類明細マスタ' ;

-- 施術機関コード申請書類マスタ
drop table if exists `OFCC0040` cascade;

create table `OFCC0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `control_id` CHAR(40) not null comment '施術機関コード制御ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `action_id` CHAR(40) not null comment '受付処理ID'
  , `start_date` DATE default '1900-01-01' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFCC0040_PKC` primary key (`rid`)
) comment '施術機関コード申請書類マスタ' ;

-- 施術機関コード対象機関マスタ
drop table if exists `OFCC0020` cascade;

create table `OFCC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `control_id` CHAR(40) not null comment '施術機関コード制御ID'
  , `insurance_type_class_id` CHAR(40) not null comment '医療保険制度区分:1: 国保連合会､2:後期高齢、3:医療助成、4: 生活保護、5:労災'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFCC0020_PKC` primary key (`rid`)
) comment '施術機関コード対象機関マスタ' ;

-- 施術機関コード制御マスタ
drop table if exists `OFCC0001` cascade;

create table `OFCC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `municipality_id` CHAR(40) comment '自治体ID'
  , `number_get_flag` TINYINT default 0 not null comment '番号取得フラグ:1: 取得要'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `application_destination_class_id` CHAR(40) not null comment '施術所コード申請先区分:1: 国保連合会､3:後期高齢者連合会、5:都道府県、2:自治体､4: 労務局'
  , `health_center_flag` TINYINT default 0 not null comment '保健所届有無フラグ:1: 届出要'
  , `figure_flag` TINYINT default 0 not null comment '周辺図・平面図フラグ:1:要'
  , `licence_flag` TINYINT default 0 not null comment '免許証要フラグ:1:要'
  , `number_class_id` CHAR(40) not null comment '番号種別区分:1:施術所番号、2: 団体番号'
  , `numbering_class_id` CHAR(40) not null comment '番号採番区分:1: 相手先、2: 自社'
  , `return_flag` TINYINT default 0 not null comment '番号通知書類返送フラグ:1: 返送'
  , `notification_print_flag` TINYINT default 0 not null comment '決定通知書に記載フラグ:1:記載あり'
  , `back_print_flag` TINYINT default 0 not null comment '返戻時に記載フラグ:1:記載あり'
  , `inquiry_flag` TINYINT default 0 not null comment '問い合わせ可フラグ'
  , `receipt_print_class_id` CHAR(40) not null comment 'レセプト印字区分'
  , `receipt_check_class_id` CHAR(40) not null comment 'レセプト印字チェック区分'
  , `list_flag` TINYINT default 0 not null comment '毎月名簿フラグ'
  , `entry_class_id` CHAR(40) not null comment '施術所コード登録区分:1:保険請求前に登録､2:保険請求時に登録､3:保険請求後に自動的付加'
  , `remark` TEXT not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFCC0001_PKC` primary key (`rid`)
) comment '施術機関コード制御マスタ' ;

-- 労務局備考情報
drop table if exists `IDAC00020` cascade;

create table `IDAC00020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '労務局ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IDAC00020_PKC` primary key (`rid`)
) comment '労務局備考情報' ;

-- 労務局備考添付ファイル情報
drop table if exists `IDAC00030` cascade;

create table `IDAC00030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IDAC00030_PKC` primary key (`rid`)
) comment '労務局備考添付ファイル情報' ;

-- 厚生局備考情報
drop table if exists `MHLW0020` cascade;

create table `MHLW0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '厚生局ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MHLW0020_PKC` primary key (`rid`)
) comment '厚生局備考情報' ;

-- 共済組合備考情報
drop table if exists `MAAS0020` cascade;

create table `MAAS0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '共済組合ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MAAS0020_PKC` primary key (`rid`)
) comment '共済組合備考情報' ;

-- 厚生局備考添付ファイル情報
drop table if exists `MHLW0030` cascade;

create table `MHLW0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MHLW0030_PKC` primary key (`rid`)
) comment '厚生局備考添付ファイル情報' ;

-- 共済組合備考添付ファイル情報
drop table if exists `MAAS0030` cascade;

create table `MAAS0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MAAS0030_PKC` primary key (`rid`)
) comment '共済組合備考添付ファイル情報' ;

-- 厚生局マスタ
drop table if exists `MHLW0001` cascade;

create table `MHLW0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `department_kana` TEXT default '' not null comment '厚生局カナ名'
  , `department_name` TEXT default '' not null comment '厚生局名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MHLW0001_PKC` primary key (`rid`)
) comment '厚生局マスタ' ;

-- 地方共済組合備考添付ファイル情報
drop table if exists `LMAA0030` cascade;

create table `LMAA0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LMAA0030_PKC` primary key (`rid`)
) comment '地方共済組合備考添付ファイル情報' ;

-- 労働基準監督署マスタ
drop table if exists `LSIO0001` cascade;

create table `LSIO0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_kana` TEXT default '' not null comment '労働基準監督署カナ名'
  , `department_name` TEXT default '' not null comment '労働基準監督署名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LSIO0001_PKC` primary key (`rid`)
) comment '労働基準監督署マスタ' ;

-- 申請先別申請書類明細マスタ
drop table if exists `APDC0010` cascade;

create table `APDC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `apply_document_id` CHAR(40) not null comment '申請書類ID'
  , `document_id` CHAR(40) not null comment '書類ID'
  , `client_send_flag_1` TINYINT default 0 not null comment '依頼者申込書送付フラグ'
  , `client_receive_flag_1` TINYINT default 0 not null comment '依頼者申込書返送フラグ'
  , `client_send_flag_2` TINYINT default 0 not null comment '依頼者申請書送付フラグ'
  , `client_receive_flag_2` TINYINT default 0 not null comment '依頼者申請書返送フラグ'
  , `destination_send_flag` TINYINT default 0 not null comment '申請先送付フラグ'
  , `destination_receive_flag` TINYINT default 0 not null comment '申請先返送フラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `APDC0010_PKC` primary key (`rid`)
) comment '申請先別申請書類明細マスタ' ;

-- 申請書類マスタ
drop table if exists `APDC0001` cascade;

create table `APDC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `action_id` CHAR(40) not null comment '受付処理ID'
  , `task_class_id` CHAR(40) not null comment 'タスク区分'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `municipality_id` CHAR(40) not null comment '自治体ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `organization_class_id` CHAR(40) not null comment '許可番号発行先区分'
  , `start_date` DATE default '1900-01-01' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `APDC0001_PKC` primary key (`rid`)
) comment '申請書類マスタ' ;

-- 情報区分マスタ
drop table if exists `CNAM0161` cascade;

create table `CNAM0161` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '情報区分値'
  , `name` TEXT default '' not null comment '情報区分名'
  , `short_name` TEXT default '' not null comment '情報区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0161_PKC` primary key (`rid`)
) comment '情報区分マスタ' ;

-- 会員資格状態情報
drop table if exists `MBSP0020` cascade;

create table `MBSP0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `qualification_id` CHAR(40) not null comment '会員資格ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `state_class_id` CHAR(40) not null comment '会員状態区分:1:継続、2:継続2、3:休会、4:休会2、5: 退会'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0020_PKC` primary key (`rid`)
) comment '会員資格状態情報' ;

-- 科目区分マスタ
drop table if exists `MNAM0010` cascade;

create table `MNAM0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '科目区分値'
  , `name` TEXT default '' not null comment '科目区分名'
  , `short_name` TEXT default '' not null comment '科目区分略称'
  , `credit_side_flag` TINYINT default 0 not null comment '貸方・借方フラグ:0: 貸方、1: 借方'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0010_PKC` primary key (`rid`)
) comment '科目区分マスタ' ;

-- 保健所マスタ
drop table if exists `HLTH0001` cascade;

create table `HLTH0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_kana` TEXT default '' not null comment '保健所カナ名'
  , `department_name` TEXT not null comment '保健所名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `HLTH0001_PKC` primary key (`rid`)
) comment '保健所マスタ' ;

-- 許可番号発行先区分マスタ
drop table if exists `CNAM0006` cascade;

create table `CNAM0006` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '許可番号発行先区分値'
  , `name` TEXT default '' not null comment '許可番号発行先区分名'
  , `short_name` TEXT default '' not null comment '許可番号発行先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0006_PKC` primary key (`rid`)
) comment '許可番号発行先区分マスタ' ;

-- 質問種別区分マスタ
drop table if exists `CNAM0050` cascade;

create table `CNAM0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '質問種別区分値'
  , `name` TEXT default '' not null comment '質問種別区分名'
  , `short_name` TEXT default '' not null comment '質問種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0050_PKC` primary key (`rid`)
) comment '質問種別区分マスタ' ;

-- 事務局だよりマスタ
drop table if exists `INFO0001` cascade;

create table `INFO0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `info_class_id` CHAR(40) default '' not null comment '情報区分'
  , `memo` TEXT default '' not null comment '内容'
  , `entry_user_id` CHAR(40) default '' not null comment '登録者ID'
  , `entry_date` DATE default '1900-1-1' not null comment '登録日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INFO0001_PKC` primary key (`rid`)
) comment '事務局だよりマスタ' ;

-- 書類区分マスタ
drop table if exists `CNAM0160` cascade;

create table `CNAM0160` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '書類区分値'
  , `name` TEXT default '' not null comment '書類区分名'
  , `short_name` TEXT default '' not null comment '書類区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0160_PKC` primary key (`rid`)
) comment '書類区分マスタ' ;

-- 受付書類状態区分マスタ
drop table if exists `CNAM0159` cascade;

create table `CNAM0159` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '受付書類状態区分値'
  , `name` TEXT default '' not null comment '受付書類状態区分名'
  , `short_name` TEXT default '' not null comment '受付書類状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0159_PKC` primary key (`rid`)
) comment '受付書類状態区分マスタ' ;

-- タスク区分マスタ
drop table if exists `CNAM0158` cascade;

create table `CNAM0158` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'タスク区分値'
  , `name` TEXT default '' not null comment 'タスク区分名'
  , `short_name` TEXT default '' not null comment 'タスク区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0158_PKC` primary key (`rid`)
) comment 'タスク区分マスタ' ;

-- 受付書類情報
drop table if exists `RCPR0050` cascade;

create table `RCPR0050` (
  `まいｎ` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `task_class_id` CHAR(40) not null comment 'タスク区分:1:受付書類作成、2:申請書類作成、3:申請書類提出'
  , `document_id` CHAR(40) not null comment '書類ID'
  , `plan_send_date` DATE default '1900-1-1' not null comment '依頼送付予定日'
  , `send_date` DATE default '1900-1-1' not null comment '依頼送付日'
  , `send_check_flag` TINYINT default 0 not null comment '送付前チェックフラグ'
  , `plan_receive_date` DATE default '1900-1-1' not null comment '返送予定日'
  , `receive_date` DATE default '1900-1-1' not null comment '返送日'
  , `receive_check_flag` TINYINT default 0 not null comment '返送後チェックフラグ'
  , `plan_apply_date` DATE default '1900-1-1' not null comment '申請送付予定日'
  , `apply_date` DATE default '1900-1-1' not null comment '申請送付日'
  , `apply_check_flag` TINYINT default 0 not null comment '申請前チェックフラグ'
  , `chief_check_date` DATE default '1900-1-1' not null comment '主任確認日'
  , `chief_check_flag` TINYINT default 0 not null comment '主任チェックフラグ'
  , `manager_check_date` DATE default '1900-1-1' not null comment '係長確認日'
  , `manager_check_flag` TINYINT default 0 not null comment '係長チェックフラグ'
  , `main_user_id` CHAR(40) not null comment '担当職員ID'
  , `check_user_id` CHAR(40) not null comment '送付確認担当者ID'
  , `chief_user_id` CHAR(40) not null comment '主任担当者ID'
  , `manager_user_id` CHAR(40) not null comment '係長担当者ID'
  , `state_class_id` CHAR(40) not null comment '受付書類状態区分:1:未完、2:完了、3:不備、4:取消'
  , `delay_reason_class_id` CHAR(40) not null comment '遅延理由区分'
  , `delay_reason` TEXT default '' not null comment '遅延理由'
  , `send_flag` TINYINT default 0 not null comment '送付有無フラグ:1: 有り'
  , `receive_flag` TINYINT default 0 not null comment '返送有無フラグ:1: 有り'
  , `apply_flag` TINYINT default 0 not null comment '申請有無フラグ:1: 有り'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPR0050_PKC` primary key (`まいｎ`)
) comment '受付書類情報' ;

-- 防衛省備考情報
drop table if exists `MSDF0020` cascade;

create table `MSDF0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '防衛省ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MSDF0020_PKC` primary key (`rid`)
) comment '防衛省備考情報' ;

-- 防衛省備考添付ファイル情報
drop table if exists `MSDF0030` cascade;

create table `MSDF0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MSDF0030_PKC` primary key (`rid`)
) comment '防衛省備考添付ファイル情報' ;

-- 審査会等口座用途マスタ
drop table if exists `FDAC0010` cascade;

create table `FDAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '審査会等口座ID'
  , `department_class_id` CHAR(40) default '' not null comment '診療科区分'
  , `use_class_id` CHAR(40) not null comment '入送金区分:1: 入金、2:送金、3:両方'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDAC0010_PKC` primary key (`rid`)
) comment '審査会等口座用途マスタ' ;

-- 審査会等備考添付ファイル情報
drop table if exists `FDRT0030` cascade;

create table `FDRT0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDRT0030_PKC` primary key (`rid`)
) comment '審査会等備考添付ファイル情報' ;

-- 労働基準監督署備考情報
drop table if exists `LSIO0020` cascade;

create table `LSIO0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '労働基準監督署ID'
  , `department_id` CHAR(40) comment '部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LSIO0020_PKC` primary key (`rid`)
) comment '労働基準監督署備考情報' ;

-- 審査会等点検業者関係マスタ
drop table if exists `FDRT0001_CHKC0001` cascade;

create table `FDRT0001_CHKC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '審査会等ID'
  , `check_company_id` CHAR(40) not null comment '点検業者ID'
  , `department_class_id` CHAR(40) comment '診療科区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `transfer_flag` TINYINT default 0 not null comment '点検業者振込フラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDRT0001_CHKC0001_PKC` primary key (`rid`)
) comment '審査会等点検業者関係マスタ' ;

-- 施術所本院マスタ
drop table if exists `OFFC0040` cascade;

create table `OFFC0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `parent_office_id` CHAR(40) not null comment '本院施術所ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFFC0040_PKC` primary key (`rid`)
) comment '施術所本院マスタ' ;

-- 宅配区分マスタ
drop table if exists `CNAM0157` cascade;

create table `CNAM0157` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '宅配区分値'
  , `name` TEXT default '' not null comment '宅配区分名'
  , `short_name` TEXT default '' not null comment '宅配区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0157_PKC` primary key (`rid`)
) comment '宅配区分マスタ' ;

-- 総括表出力区分マスタ
drop table if exists `CNAM0156` cascade;

create table `CNAM0156` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '総括表出力区分値'
  , `name` TEXT default '' not null comment '総括表出力区分名'
  , `short_name` TEXT default '' not null comment '総括表出力区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0156_PKC` primary key (`rid`)
) comment '総括表出力区分マスタ' ;

-- 労働基準監督署管理区域情報マスタ
drop table if exists `LSIO0040` cascade;

create table `LSIO0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `organization_id` CHAR(40) not null comment '労働基準監督署ID'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `city_name` TEXT default '' not null comment '市郡名'
  , `town_name` TEXT default '' not null comment '区町村名'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LSIO0040_PKC` primary key (`rid`)
) comment '労働基準監督署管理区域情報マスタ' ;

-- サポート企業マスタ
drop table if exists `SPRT0001` cascade;

create table `SPRT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `company_kana` TEXT default '' not null comment '企業カナ名'
  , `company_name` TEXT default '' not null comment '企業名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SPRT0001_PKC` primary key (`rid`)
) comment 'サポート企業マスタ' ;

-- 受付事業主情報
drop table if exists `RCOW0001` cascade;

create table `RCOW0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:1:追加、2:更新'
  , `owner_class_id` CHAR(40) default '' not null comment 'オーナー区分:1: 会員(入会者)本人、2:開設者､9:その他'
  , `membership_id` CHAR(40) comment '会員ID:同時に会員が新規登録される場合は、新規で登録される会員'
  , `opener_id` CHAR(40) comment '開設者ID:同時に開設者が新規登録される場合は、新規で登録される開設者'
  , `last_kana` TEXT default '' not null comment '事業主カナ苗字'
  , `first_kana` TEXT default '' not null comment '事業主カナ名前'
  , `last_name` TEXT default '' not null comment '事業主苗字'
  , `first_name` TEXT default '' not null comment '事業主名前'
  , `sex_class_id` CHAR(40) not null comment '性別区分'
  , `company_kana` TEXT default '' not null comment '企業カナ名'
  , `company_name` TEXT default '' not null comment '企業名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `target_owner_id` CHAR(40) comment '対象事業主ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCOW0001_PKC` primary key (`rid`)
) comment '受付事業主情報' ;

-- 入送金区分マスタ
drop table if exists `CNAM0154` cascade;

create table `CNAM0154` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '入送金区分値'
  , `name` TEXT default '' not null comment '入送金区分名'
  , `short_name` TEXT default '' not null comment '入送金区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0154_PKC` primary key (`rid`)
) comment '入送金区分マスタ' ;

-- 会員慶弔情報
drop table if exists `MBOC0001` cascade;

create table `MBOC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `membership_state_class_id` CHAR(40) not null comment '会員状態区分'
  , `event_class_id` CHAR(40) not null comment '慶弔イベント区分:死亡、入院見舞、結婚、出産、長寿、死亡、災害見舞'
  , `family_class_id` CHAR(40) not null comment '対象続柄区分:本人、配偶者、親、子供'
  , `application_date` DATE default '1900-1-1' not null comment '申請日'
  , `pay_date` DATE default '1900-1-1' not null comment '支払日'
  , `amoiunt` DECIMAL(13,2) default 0 not null comment '慶弔金額'
  , `state_class_id` CHAR(40) not null comment '慶弔状態区分:申請中､認可、支払済、却下、取下げ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBOC0001_PKC` primary key (`rid`)
) comment '会員慶弔情報' ;

-- DM種別区分マスタ
drop table if exists `CNAM0153` cascade;

create table `CNAM0153` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'DM種別区分値'
  , `name` TEXT default '' not null comment 'DM種別区分名'
  , `short_name` TEXT default '' not null comment 'DM種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0153_PKC` primary key (`rid`)
) comment 'DM種別区分マスタ' ;

-- 会員DMマスタ
drop table if exists `MBDM0001` cascade;

create table `MBDM0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `remark_class_id` CHAR(40) not null comment 'DM種別区分'
  , `send_flag` TINYINT default 0 not null comment '送付フラグ:1: 送付可'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBDM0001_PKC` primary key (`rid`)
) comment '会員DMマスタ' ;

-- 金融機関マスタ
drop table if exists `BANK0001` cascade;

create table `BANK0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `bank_code` VARCHAR(255) default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` VARCHAR(255) default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `BANK0001_PKC` primary key (`rid`)
) comment '金融機関マスタ' ;

-- 事業主施術所マスタ
drop table if exists `OWNR0001_OWNER0001` cascade;

create table `OWNR0001_OWNER0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `owner_id` CHAR(40) not null comment '事業主ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `transfer_flag` TINYINT default 0 not null comment '譲渡フラグ'
  , `transfer_owner_id` CHAR(40) comment '譲渡元事業者ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OWNR0001_OWNER0001_PKC` primary key (`rid`)
) comment '事業主施術所マスタ' ;

-- 初期手数料情報
drop table if exists `OFRT0020` cascade;

create table `OFRT0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `rent_id` CHAR(40) not null comment '貸出ID'
  , `charge_option_id` CHAR(40) not null comment '手数料ID'
  , `process_date` DATE default '9999-12-31' not null comment '処理日'
  , `amount` DECIMAL(13,2) not null comment '料金'
  , `support_company_id` CHAR(40) not null comment 'サポート会社ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFRT0020_PKC` primary key (`rid`)
) comment '初期手数料情報' ;

-- セット品マスタ
drop table if exists `RTST0010` cascade;

create table `RTST0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `company_id` CHAR(40) not null comment '管理企業ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `set_product_name` TEXT default '' not null comment 'セット品名'
  , `set_type` TEXT default '' not null comment 'セット品種別'
  , `cost` DECIMAL(13,2) default 0 not null comment '仕入れ額'
  , `sales_amount` DECIMAL(13,2) default 0 not null comment '販売金額'
  , `rental_amount` DECIMAL(13,2) default 0 not null comment 'レンタル料'
  , `rent_flag` TINYINT default 0 not null comment 'レンタルフラグ:1:レンタル品'
  , `option_flag` TINYINT default 0 not null comment 'オプションフラグ:1: オプション製品'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RTST0010_PKC` primary key (`rid`)
) comment 'セット品マスタ' ;

-- 手数料マスタ
drop table if exists `RTIT0010` cascade;

create table `RTIT0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `company_id` CHAR(40) not null comment '管理企業ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `charge_name` TEXT default '' not null comment '手数料名'
  , `amount` DECIMAL(13,2) not null comment '料金'
  , `support_company_id` CHAR(40) not null comment 'サポート会社ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RTIT0010_PKC` primary key (`rid`)
) comment '手数料マスタ' ;

-- 貸出ハード備品明細情報
drop table if exists `OFRT0010` cascade;

create table `OFRT0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `rent_id` CHAR(40) not null comment '貸出ID'
  , `product_id` CHAR(40) not null comment '製品ID'
  , `production_no` TEXT not null comment '製造番号'
  , `rent_date` DATE default '1900-1-1' not null comment '貸出日'
  , `return_date` DATE default '1900-1-1' not null comment '返却日'
  , `rent_count` INT default 0 not null comment '貸出数'
  , `reason_class` TEXT default '' not null comment '貸出返却理由区分:異例の場合の理由'
  , `retrun_check_date` DATE default '1900-1-1' not null comment '返却チェック日'
  , `retrun_report_check_date` DATE default '1900-1-1' not null comment '返却書類チェック日'
  , `rent_amount` DECIMAL(13,2) default 0 not null comment '使用料'
  , `state_class_id` CHAR(40) not null comment '貸出状態区分:1:貸出中、2:返却済'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFRT0010_PKC` primary key (`rid`)
) comment '貸出ハード備品明細情報' ;

-- 施術所許可番号情報
drop table if exists `RCOF0020` cascade;

create table `RCOF0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `license_class_id` CHAR(40) not null comment '許可番号区分'
  , `license_no` TEXT default '' not null comment '許可番号:30桁'
  , `grant_date` DATE default '1900-1-1' not null comment '取得年月日'
  , `disuse_date` DATE default '9999-12-31' not null comment '廃止年月日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCOF0020_PKC` primary key (`rid`)
) comment '施術所許可番号情報' ;

-- 依頼理由区分マスタ
drop table if exists `CNAM0152` cascade;

create table `CNAM0152` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '依頼理由区分値'
  , `name` TEXT default '' not null comment '依頼理由区分名'
  , `short_name` TEXT default '' not null comment '依頼理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0152_PKC` primary key (`rid`)
) comment '依頼理由区分マスタ' ;

-- 依頼理由マスタ
drop table if exists `RQRS0001` cascade;

create table `RQRS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_comapny_id` CHAR(40) not null comment '管理会社ID'
  , `reason_class_id` CHAR(40) default '' not null comment '依頼動機区分'
  , `reason` TEXT default '' not null comment '理由'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RQRS0001_PKC` primary key (`rid`)
) comment '依頼理由マスタ' ;

-- 施術所開設者変更情報
drop table if exists `RCIF0030` cascade;

create table `RCIF0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `change_date` DATE default '1900-1-1' not null comment '変更予定日'
  , `change_reason_id` CHAR(40) not null comment '変更理由ID'
  , `change_reason` TEXT default '' not null comment '変更理由'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0030_PKC` primary key (`rid`)
) comment '施術所開設者変更情報' ;

-- 賠償保険変更情報
drop table if exists `RCIF0100` cascade;

create table `RCIF0100` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:1:追加、2;変更､3:削除'
  , `insurance_id` CHAR(40) not null comment '会員賠償保険ID'
  , `reception_insurance_id` CHAR(40) not null comment '受付賠償保険ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0100_PKC` primary key (`rid`)
) comment '賠償保険変更情報' ;

-- 出資金処理区分マスタ
drop table if exists `CNAM0151` cascade;

create table `CNAM0151` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '出資金処理区分値'
  , `name` TEXT default '' not null comment '出資金処理区分名'
  , `short_name` TEXT default '' not null comment '出資金処理区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0151_PKC` primary key (`rid`)
) comment '出資金処理区分マスタ' ;

-- 受付会員情報
drop table if exists `RCMB0001` cascade;

create table `RCMB0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:1:新規、2:更新'
  , `last_kana` TEXT default '' not null comment '受付会員カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '受付会員カナ名前:半角'
  , `last_name` TEXT default '' not null comment '受付会員苗字:全角'
  , `first_name` TEXT default '' not null comment '受付会員名前:全角'
  , `birthday` DATE default '1800-1-1' not null comment '生年月日'
  , `sex_class_id` CHAR(40) not null comment '性別区分:1: 男、2: 女'
  , `school_name` TEXT default '' not null comment '出身校'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `introduction_flag` TINYINT default 0 not null comment '紹介者フラグ'
  , `introduction_membership_id` CHAR(40) not null comment '紹介者会員ID'
  , `introduction_organization_id` CHAR(40) not null comment '紹介団体ID'
  , `introduction_name` TEXT default '' not null comment '紹介者名'
  , `web_member_flag` CHAR(40) default 0 not null comment 'Web会員フラグ'
  , `web_member_no` TEXT default '' not null comment 'Web会員番号'
  , `experience_flag_1` TINYINT default 0 not null comment '柔整実務経験フラグ'
  , `experience_years_1` INT default 0 not null comment '柔整実務経験年数'
  , `manage_experience_years_1` INT default 0 not null comment '柔整管理者経験年数'
  , `experience_flag_2` TINYINT default 0 not null comment '鍼実務経験フラグ'
  , `experience_years_2` INT default 0 not null comment '鍼実務経験年数'
  , `manage_experience_years_2` INT default 0 not null comment '鍼管理者経験年数'
  , `experience_flag_3` TINYINT default 0 not null comment '灸実務経験フラグ'
  , `experience_years_3` INT default 0 not null comment '灸実務経験年数'
  , `manage_experience_years_3` INT default 0 not null comment '灸管理者経験年数'
  , `experience_flag_4` TINYINT default 0 not null comment 'あん摩・マッサージ実務経験フラグ'
  , `experience_years_4` INT default 0 not null comment 'あん摩・マッサージ灸実務経験年数'
  , `manage_experience_years_4` INT default 0 not null comment 'あん摩・マッサージ灸管理者経験年数'
  , `work_office_name` TEXT default '' not null comment '前勤務先施術所名'
  , `other_join_name` TEXT default '' not null comment '加入中の他団体名'
  , `other_liability_flag` TINYINT default 0 not null comment '他団体賠償責任保険の有無フラグ'
  , `other_liability_term_date` DATE default '1900-1-1' not null comment '他団体賠償責任保険期限日'
  , `target_membership_id` CHAR(40) comment '対象会員ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCMB0001_PKC` primary key (`rid`)
) comment '受付会員情報' ;

-- 連絡先区分マスタ
drop table if exists `CNAM0150` cascade;

create table `CNAM0150` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '連絡先区分値'
  , `name` TEXT default '' not null comment '連絡先区分名'
  , `short_name` TEXT default '' not null comment '連絡先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0150_PKC` primary key (`rid`)
) comment '連絡先区分マスタ' ;

-- 送付先区分マスタ
drop table if exists `CNAM0149` cascade;

create table `CNAM0149` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '送付先区分値'
  , `name` TEXT default '' not null comment '送付先区分名'
  , `short_name` TEXT default '' not null comment '送付先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0149_PKC` primary key (`rid`)
) comment '送付先区分マスタ' ;

-- 会員関係区分マスタ
drop table if exists `MNAM0005` cascade;

create table `MNAM0005` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '会員関係区分値'
  , `name` TEXT default '' not null comment '会員関係区分名'
  , `short_name` TEXT default '' not null comment '会員関係区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0005_PKC` primary key (`rid`)
) comment '会員関係区分マスタ' ;

-- 講習会名区分マスタ
drop table if exists `MNAM0003` cascade;

create table `MNAM0003` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `clazz` TEXT default '' not null comment '講習会名区分値'
  , `name` TEXT default '' not null comment '講習会名区分名'
  , `short_name` TEXT default '' not null comment '講習会名区分略称'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0003_PKC` primary key (`rid`)
) comment '講習会名区分マスタ' ;

-- 講習会地域区分マスタ
drop table if exists `MNAM0011` cascade;

create table `MNAM0011` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '講習会地域区分値'
  , `name` TEXT default '' not null comment '講習会地域区分名'
  , `short_name` TEXT default '' not null comment '講習会地域区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0011_PKC` primary key (`rid`)
) comment '講習会地域区分マスタ' ;

-- 受付処理区分マスタ
drop table if exists `MNAM0009` cascade;

create table `MNAM0009` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '受付処理区分値'
  , `name` TEXT default '' not null comment '受付処理区分名'
  , `short_name` TEXT default '' not null comment '受付処理区分略称'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0009_PKC` primary key (`rid`)
) comment '受付処理区分マスタ' ;

-- 出資金区分マスタ
drop table if exists `MNAM0008` cascade;

create table `MNAM0008` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '会員役員区分値'
  , `name` TEXT default '' not null comment '会員役員区分名'
  , `short_name` TEXT default '' not null comment '会員役員区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0008_PKC` primary key (`rid`)
) comment '出資金区分マスタ' ;

-- 施術所廃止情報
drop table if exists `RCIF0040` cascade;

create table `RCIF0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `close_date` DATE default '1900-1-1' not null comment '廃止予定日'
  , `close_reason_id` CHAR(40) not null comment '廃止理由ID'
  , `close_reason` TEXT default '' not null comment '廃止理由'
  , `fund_class_id` CHAR(40) not null comment '出資金処理区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0040_PKC` primary key (`rid`)
) comment '施術所廃止情報' ;

-- 受付開設者情報
drop table if exists `RCOP0001` cascade;

create table `RCOP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:追加、更新、削除'
  , `opener_class_id` TEXT default '' not null comment '開設者区分:1: 会員(入会者)本人、9:その他'
  , `membership_id` CHAR(40) comment '会員ID:同時に会員が新規登録される場合は、新規で登録される会員'
  , `last_kana` TEXT default '' not null comment '開設者カナ苗字'
  , `first_kana` TEXT default '' not null comment '開設者カナ名前'
  , `last_name` TEXT default '' not null comment '開設者苗字'
  , `first_name` TEXT default '' not null comment '開設者名前'
  , `sex_class_id` CHAR(40) not null comment '性別区分'
  , `company_kana` TEXT default '' not null comment '企業カナ名'
  , `company_name` TEXT default '' not null comment '企業名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口部署名'
  , `target_opener_id` CHAR(40) comment '対象開設者ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCOP0001_PKC` primary key (`rid`)
) comment '受付開設者情報' ;

-- 施術管理者交代情報
drop table if exists `RCIF0010` cascade;

create table `RCIF0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `incoming_flag` TINYINT default 0 not null comment '後任の有無フラグ'
  , `qualification_flag` TINYINT default 0 not null comment '後任会員資格変更フラグ:子会員から親会員へ'
  , `change_date` DATE default '1900-1-1' not null comment '交代予定日'
  , `change_reason_class_id` CHAR(40) not null comment '交代理由区分'
  , `change_reason` TEXT default '' not null comment '交代理由'
  , `fund_class_id` CHAR(40) not null comment '出資金処理区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0010_PKC` primary key (`rid`)
) comment '施術管理者交代情報' ;

-- 受付会員資格情報
drop table if exists `RCQL0001` cascade;

create table `RCQL0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT default 0 not null comment '依頼処理区分:1: 新規、2:変更､3:削除、4:会員種別異動、5:親会員異動'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `member_class_id` CHAR(40) not null comment '会員種別区分:1: 全柔協柔整会員、2: 全柔協鍼灸会員、3: 大鍼協通常会員､4:大鍼協準会員'
  , `qualification_id` CHAR(40) comment '会員資格ID:既存の場合のみ'
  , `new_office_flag` TINYINT default 0 not null comment '新規施術所フラグ'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `new_office_id` CHAR(40) not null comment '受付施術所ID'
  , `parent_membership_id` CHAR(40) not null comment '親会員ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCQL0001_PKC` primary key (`rid`)
) comment '受付会員資格情報' ;

-- 入会講習地域情報
drop table if exists `RCQL0020` cascade;

create table `RCQL0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `course_id` CHAR(40) not null comment '入会講習ID'
  , `area_class_id` CHAR(40) not null comment '講習会地域区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCQL0020_PKC` primary key (`rid`)
) comment '入会講習地域情報' ;

-- 入会講習同伴者情報
drop table if exists `RCQL0030` cascade;

create table `RCQL0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `course_id` CHAR(40) not null comment '入会講習ID'
  , `last_kana` TEXT default '' not null comment '講習同伴者カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '講習同伴者カナ名前:半角'
  , `last_name` TEXT default '' not null comment '講習同伴者苗字:全角'
  , `first_name` TEXT default '' not null comment '講習同伴者名前:全角'
  , `birthday` DATE default '1800-1-1' not null comment '生年月日'
  , `sex_class_id` CHAR(40) not null comment '性別区分:1: 男、2: 女'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCQL0030_PKC` primary key (`rid`)
) comment '入会講習同伴者情報' ;

-- 退会情報
drop table if exists `RCIF0050` cascade;

create table `RCIF0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `withdraw_date` DATE default '1900-1-1' not null comment '退会予定日'
  , `withdraw_reason_id` CHAR(40) not null comment '退会理由ID'
  , `withdraw_reason` TEXT not null comment '退会理由'
  , `other_company_name` TEXT default '' not null comment '退会後の移籍団体名'
  , `memo` TEXT default '' not null comment '退会後について'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0050_PKC` primary key (`rid`)
) comment '退会情報' ;

-- 退職情報
drop table if exists `RCIF0060` cascade;

create table `RCIF0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `retire_date` DATE default '1900-1-1' not null comment '退職予定日'
  , `retire_reason_id` CHAR(40) not null comment '退職理由ID'
  , `retire_reason` TEXT not null comment '退職理由'
  , `memo` TEXT default '' not null comment '退職後について'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0060_PKC` primary key (`rid`)
) comment '退職情報' ;

-- 休会情報
drop table if exists `RCIF0080` cascade;

create table `RCIF0080` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `adjourn_start_date` DATE default '1900-1-1' not null comment '休会開始日'
  , `comeback_plan_date` DATE default '1900-1-1' not null comment '復帰予定日'
  , `adjourn_reason_id` CHAR(40) not null comment '休会理由ID'
  , `adjourn_reason` TEXT default '' not null comment '休会理由'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCIF0080_PKC` primary key (`rid`)
) comment '休会情報' ;

-- 受付依頼連絡先情報
drop table if exists `RCPR0030` cascade;

create table `RCPR0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `reception_id` CHAR(40) not null comment '受付ID'
  , `contact_class_id` CHAR(40) not null comment '連絡先区分'
  , `contact_call_name` TEXT not null comment '連絡先氏名'
  , `contact_call_kana` TEXT not null comment '連絡先カナ名'
  , `contact_postal_code` TINYTEXT default '' not null comment '連絡先郵便番号'
  , `contact_address_pref` TEXT default '' not null comment '連絡先都道府県'
  , `contact_address_city` TEXT default '' not null comment '連絡先市区町村'
  , `contact_address_town` TEXT default '' not null comment '連絡先町域'
  , `contact_address_street` TEXT default '' not null comment '連絡先番地・マンション'
  , `contact_address_pref_kana` TEXT default '' not null comment '連絡先都道府県カナ'
  , `contact_address_city_kana` TEXT default '' not null comment '連絡先市区町村カナ'
  , `contact_address_town_kana` TEXT default '' not null comment '連絡先町域カナ'
  , `contact_address_street_kana` TEXT default '' not null comment '連絡先番地・マンションカナ'
  , `contact_phone_no` TINYTEXT default '' not null comment '連絡先電話番号'
  , `contact_fax_no` TINYTEXT default '' not null comment '連絡先ファックス番号'
  , `contact_mail_address` VARCHAR(255) default '' not null comment '連絡先メールアドレス'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPR0030_PKC` primary key (`rid`)
) comment '受付依頼連絡先情報' ;

-- 受付依頼送付先情報
drop table if exists `RCPR0020` cascade;

create table `RCPR0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `reception_id` CHAR(40) not null comment '受付ID'
  , `send_class_id` CHAR(40) not null comment '送付先区分'
  , `send_call_name` TEXT not null comment '送付先氏名'
  , `send_call_kana` TEXT not null comment '送付先カナ名'
  , `send_postal_code` TINYTEXT default '' not null comment '送付先郵便番号'
  , `send_address_pref` TEXT default '' not null comment '送付先都道府県'
  , `send_address_city` TEXT default '' not null comment '送付先市区町村'
  , `send_address_town` TEXT default '' not null comment '送付先町域'
  , `send_address_street` TEXT default '' not null comment '送付先番地・マンション'
  , `send_address_pref_kana` TEXT default '' not null comment '送付先都道府県カナ'
  , `send_address_city_kana` TEXT default '' not null comment '送付先市区町村カナ'
  , `send_address_town_kana` TEXT default '' not null comment '送付先町域カナ'
  , `send_address_street_kana` TEXT default '' not null comment '送付先番地・マンションカナ'
  , `send_phone_no` TINYTEXT default '' not null comment '送付先電話番号'
  , `send_fax_no` TINYTEXT default '' not null comment '送付先ファックス番号'
  , `send_mail_address` VARCHAR(255) default '' not null comment '送付先メールアドレス'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPR0020_PKC` primary key (`rid`)
) comment '受付依頼送付先情報' ;

-- 受付情報
drop table if exists `RCPR0001` cascade;

create table `RCPR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `reception_no` TEXT not null comment '受付番号:'''
  , `reception_date` DATE default '1900-1-1' not null comment '受付日'
  , `receptionist_id` CHAR(40) not null comment '受付担当者ID'
  , `amount` DECIMAL(13,2) default 0 not null comment '合計手続金額'
  , `state_class` CHAR(40) not null comment '受付状態区分:'':処理中、1: 完了、2:保留､3:顧客取消、4:強制取消'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPR0001_PKC` primary key (`rid`)
) comment '受付情報' ;

-- 依頼内容情報
drop table if exists `RCPR0010` cascade;

create table `RCPR0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `reception_id` CHAR(40) not null comment '受付ID'
  , `reception_detail_no` INT not null comment '受付明細番号:'''
  , `main_staff_id` CHAR(40) not null comment '処理主担当者ID'
  , `new_owner_flag` TINYINT not null comment '新規事業主フラグ:0'
  , `owner_id` CHAR(40) comment '事業主ID'
  , `new_office_flag` TINYINT not null comment '新規施術所フラグ:0'
  , `office_id` CHAR(40) comment '施術所ID'
  , `new_opener_flag` TINYINT not null comment '新規開設者フラグ:0'
  , `opener_id` CHAR(40) comment '開業者ID'
  , `new_membership_flag` TINYINT not null comment '新規会員フラグ:0'
  , `membership_id` CHAR(40) comment '会員ID'
  , `pay_method_class_id` CHAR(40) not null comment '支払方法区分:1: 振込、2:現金(講習会時)、3:現金(窓口)、4: 引落、5:分割払い(6回)'
  , `payer_class_id` CHAR(40) not null comment '支払者区分:1: 事業主､2:会員'
  , `amount` DECIMAL(13,2) default 0 not null comment '手続金額'
  , `effective_date` DATE default '1900-1-1' not null comment '適用日'
  , `send_date` DATE default '1900-1-1' not null comment '発送日'
  , `recieve_plan_date` DATE not null comment '返送予定日'
  , `recieve_date` DATE not null comment '返送日'
  , `send_id` CHAR(40) not null comment '送付先ID'
  , `contact_id` CHAR(40) not null comment '連絡先ID'
  , `state_class` CHAR(40) not null comment '受付状態区分:'':処理中、1: 完了、2:保留､3:顧客取消、4:強制取消'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPR0010_PKC` primary key (`rid`)
) comment '依頼内容情報' ;

-- 施術担当者就業時間情報
drop table if exists `RCST0020` cascade;

create table `RCST0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `staff_dept_id` CHAR(40) not null comment '施術担当者診療科ID'
  , `am_mon_start_time` TIME default '00:00:00' not null comment '月曜日午前の勤務開始時間'
  , `am_mon_end_time` TIME default '00:00:00' not null comment '月曜日午前の勤務終了時間'
  , `am_tue_start_time` TIME default '00:00:00' not null comment '火曜日午前の勤務開始時間'
  , `am_tue_end_time` TIME default '00:00:00' not null comment '火曜日午前の勤務終了時間'
  , `am_wed_start_time` TIME default '00:00:00' not null comment '水曜日午前の勤務開始時間'
  , `am_wed_end_time` TIME default '00:00:00' not null comment '水曜日午前の勤務終了時間'
  , `am_thu_start_time` TIME default '00:00:00' not null comment '木曜日午前の勤務開始時間'
  , `am_thu_end_time` TIME default '00:00:00' not null comment '木曜日午前の勤務終了時間'
  , `am_fri_start_time` TIME default '00:00:00' not null comment '金曜日午前の勤務開始時間'
  , `am_fri_end_time` TIME default '00:00:00' not null comment '金曜日午前の勤務終了時間'
  , `am_sat_start_time` TIME default '00:00:00' not null comment '土曜日午前の勤務開始時間'
  , `am_sat_end_time` TIME default '00:00:00' not null comment '土曜日午前の勤務終了時間'
  , `am_sun_start_time` TIME default '00:00:00' not null comment '日曜日午前の勤務開始時間'
  , `am_sun_end_time` TIME default '00:00:00' not null comment '日曜日午前の勤務終了時間'
  , `am_hol_start_time` TIME default '00:00:00' not null comment '祝日午前の勤務開始時間'
  , `am_hol_end_time` TIME default '00:00:00' not null comment '祝日午前の勤務終了時間'
  , `pm_mon_start_time` TIME default '00:00:00' not null comment '月曜日午後の勤務開始時間'
  , `pm_mon_end_time` TIME default '00:00:00' not null comment '月曜日午後の勤務終了時間'
  , `pm_tue_start_time` TIME default '00:00:00' not null comment '火曜日午後の勤務開始時間'
  , `pm_tue_end_time` TIME default '00:00:00' not null comment '火曜日午後の勤務終了時間'
  , `pm_wed_start_time` TIME default '00:00:00' not null comment '水曜日午後の勤務開始時間'
  , `pm_wed_end_time` TIME default '00:00:00' not null comment '水曜日午後の勤務終了時間'
  , `pm_thu_start_time` TIME default '00:00:00' not null comment '木曜日午後の勤務開始時間'
  , `pm_thu_end_time` TIME default '00:00:00' not null comment '木曜日午後の勤務終了時間'
  , `pm_fri_start_time` TIME default '00:00:00' not null comment '金曜日午後の勤務開始時間'
  , `pm_fri_end_time` TIME default '00:00:00' not null comment '金曜日午後の勤務終了時間'
  , `pm_sat_start_time` TIME default '00:00:00' not null comment '土曜日午後の勤務開始時間'
  , `pm_sat_end_time` TIME default '00:00:00' not null comment '土曜日午後の勤務終了時間'
  , `pm_sun_start_time` TIME default '00:00:00' not null comment '日曜日午後の勤務開始時間'
  , `pm_sun_end_time` TIME default '00:00:00' not null comment '日曜日午後の勤務終了時間'
  , `pm_hol_start_time` TIME default '00:00:00' not null comment '祝日午後の勤務開始時間'
  , `pm_hol_end_time` TIME default '00:00:00' not null comment '祝日午後の勤務終了時間'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCST0020_PKC` primary key (`rid`)
) comment '施術担当者就業時間情報' ;

-- 紹介団体マスタ
drop table if exists `ITRD0001` cascade;

create table `ITRD0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `introduce_class_id` CHAR(40) not null comment '紹介者区分:1:学校、2: 企業、3: 個人'
  , `group_flag` TINYINT default 0 not null comment 'グループフラグ:1: グループ'
  , `last_kana` TEXT default '' not null comment '紹介者カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '紹介者カナ名前:半角'
  , `last_name` TEXT default '' not null comment '紹介者苗字:全角'
  , `first_name` TEXT default '' not null comment '紹介者名前:全角'
  , `sex_class_id` CHAR(40) default '' not null comment '性別区分:1: 男、2: 女'
  , `organization` TEXT default '' not null comment '所属団体名'
  , `organization_kana` TEXT default '' not null comment '所属団体カナ名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ITRD0001_PKC` primary key (`rid`)
) comment '紹介団体マスタ' ;

-- 会員関係情報
drop table if exists `MBSP030` cascade;

create table `MBSP030` (
  `rid` CHAR(40) not null comment 'RID'
  , `parent_qualification_id` CHAR(40) not null comment '親会員資格ID'
  , `child_qualification_id` CHAR(40) not null comment '子会員資格ID'
  , `relation_class_id` CHAR(40) not null comment '会員関係区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP030_PKC` primary key (`rid`)
) comment '会員関係情報' ;

-- 会員総代情報
drop table if exists `MBSP0050` cascade;

create table `MBSP0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0050_PKC` primary key (`rid`)
) comment '会員総代情報' ;

-- 保険者入金先マスタ
drop table if exists `INSR0070` cascade;

create table `INSR0070` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `insurance_type_class_id` CHAR(40) not null comment '医療保険制度区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `send_flag` TINYINT default 0 not null comment '審査会フラグ:1: 審査会で審査'
  , `organization_id` CHAR(40) comment '審査会等ID:審査会フラグが１の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0070_PKC` primary key (`rid`)
) comment '保険者入金先マスタ' ;

-- 自治体部署区分マスタ
drop table if exists `CNAM0148` cascade;

create table `CNAM0148` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '自治体部署区分値'
  , `name` TEXT default '' not null comment '自治体部署区分名'
  , `short_name` TEXT default '' not null comment '自治体部署区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0148_PKC` primary key (`rid`)
) comment '自治体部署区分マスタ' ;

-- 入金口座用途区分マスタ
drop table if exists `CNAM0147` cascade;

create table `CNAM0147` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '入金口座用途区分値'
  , `name` TEXT default '' not null comment '入金口座用途区分名'
  , `short_name` TEXT default '' not null comment '入金口座用途区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0147_PKC` primary key (`rid`)
) comment '入金口座用途区分マスタ' ;

-- 保険者審査依頼先マスタ
drop table if exists `INSR0060` cascade;

create table `INSR0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `insurance_type_class_id` CHAR(40) not null comment '医療保険制度区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `send_flag` CHAR(40) default 0 not null comment '審査会フラグ:1: 審査会で審査'
  , `organization_id` CHAR(40) comment '審査会等ID:審査会フラグが１の場合のみ'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0060_PKC` primary key (`rid`)
) comment '保険者審査依頼先マスタ' ;

-- 点検業者口座用途マスタ
drop table if exists `CHAC0010` cascade;

create table `CHAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '点検業者口座ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `use_class_id` CHAR(40) not null comment '入送金区分:1: 入金、2:送金、3:両方'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHAC0010_PKC` primary key (`rid`)
) comment '点検業者口座用途マスタ' ;

-- 保険者口座用途マスタ
drop table if exists `ISAC0010` cascade;

create table `ISAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '保険者口座ID'
  , `department_class_id` CHAR(40) default '' not null comment '診療科区分'
  , `use_class_id` CHAR(40) not null comment '入送金区分:1: 入金、2:送金、3:両方'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ISAC0010_PKC` primary key (`rid`)
) comment '保険者口座用途マスタ' ;

-- 会員賠償保険情報
drop table if exists `MBIS0001` cascade;

create table `MBIS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) default 0 not null comment '会員ID:会員でない人も入れるように変更する必要がある'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `insurance_id` CHAR(40) default 0 not null comment '賠償保険ID'
  , `rent_start_date` DATE default '1900-1-1' not null comment '加入開始日'
  , `rent_end_date` DATE default '9999-12-31' not null comment '加入終了日'
  , `total_amount` DECIMAL(13,2) default 0 not null comment '合計金額'
  , `state_class_id` CHAR(40) not null comment '加入保険状態区分'
  , `auto_continue_flag` TINYINT default 0 not null comment '自動継続フラグ'
  , `confirmed_flag` TINYINT default 0 not null comment '確認済フラグ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBIS0001_PKC` primary key (`rid`)
) comment '会員賠償保険情報' ;

-- レセプト入金先区分マスタ
drop table if exists `CNAM0146` cascade;

create table `CNAM0146` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト入金先区分値'
  , `name` TEXT default '' not null comment 'レセプト入金先区分名'
  , `short_name` TEXT default '' not null comment 'レセプ入金先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0146_PKC` primary key (`rid`)
) comment 'レセプト入金先区分マスタ' ;

-- レセプト送付先区分マスタ
drop table if exists `CNAM0145` cascade;

create table `CNAM0145` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト送付先区分値'
  , `name` TEXT default '' not null comment 'レセプト送付先区分名'
  , `short_name` TEXT default '' not null comment 'レセプト送付先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0145_PKC` primary key (`rid`)
) comment 'レセプト送付先区分マスタ' ;

-- 施術所状態区分マスタ
drop table if exists `CNAM0034` cascade;

create table `CNAM0034` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '施術所状態区分値'
  , `name` TEXT default '' not null comment '施術所状態区分名'
  , `short_name` TEXT default '' not null comment '施術所状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0034_PKC` primary key (`rid`)
) comment '施術所状態区分マスタ' ;

-- 画像種別区分マスタ
drop table if exists `CNAM0144` cascade;

create table `CNAM0144` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '画像種別区分値'
  , `name` TEXT default '' not null comment '画像種別区分名'
  , `short_name` TEXT default '' not null comment '画像種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0144_PKC` primary key (`rid`)
) comment '画像種別区分マスタ' ;

-- 番号採番区分マスタ
drop table if exists `CNAM0133` cascade;

create table `CNAM0133` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '番号採番区分値'
  , `name` TEXT default '' not null comment '番号採番区分名'
  , `short_name` TEXT default '' not null comment '番号採番区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0133_PKC` primary key (`rid`)
) comment '番号採番区分マスタ' ;

-- 会員口座マスタ
drop table if exists `MBAC0001` cascade;

create table `MBAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBAC0001_PKC` primary key (`rid`)
) comment '会員口座マスタ' ;

-- 点検業者部署マスタ
drop table if exists `CHKC0020` cascade;

create table `CHKC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `check_company_id` CHAR(40) not null comment '点検業者ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT default '' not null comment '部署名'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHKC0020_PKC` primary key (`rid`)
) comment '点検業者部署マスタ' ;

-- 点検業者社備考添付ファイル情報
drop table if exists `CHKC0050` cascade;

create table `CHKC0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHKC0050_PKC` primary key (`rid`)
) comment '点検業者社備考添付ファイル情報' ;

-- 管理企業別採番マスタ
drop table if exists `MGCP0020` cascade;

create table `MGCP0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `number_type` INT default 0 not null comment '採番種別'
  , `current_no` bigint default 0 not null comment '現行番号'
  , `min_no` bigint default 0 not null comment '最少値'
  , `max_no` bigint default 0 not null comment '最大値'
  , `interval` bigint default 1 not null comment '間隔'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0020_PKC` primary key (`rid`)
) comment '管理企業別採番マスタ' ;

-- 共通設定情報マスタ
drop table if exists `CCNF0001` cascade;

create table `CCNF0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `set_type` INT default 0 not null comment '設定種別'
  , `category_code` VARCHAR(255) default '' not null comment 'カテゴリコード'
  , `key_code` VARCHAR(255) default '' not null comment 'キーコード'
  , `value` TEXT default '' not null comment '設定値'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `control_6` TEXT default '' not null comment '制御情報６'
  , `control_7` TEXT default '' not null comment '制御情報７'
  , `control_8` TEXT default '' not null comment '制御情報８'
  , `control_9` TEXT default '' not null comment '制御情報９'
  , `control_10` TEXT default '' not null comment '制御情報１０'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CCNF0001_PKC` primary key (`rid`)
) comment '共通設定情報マスタ' ;

-- 管理企業別設定情報マスタ
drop table if exists `MGCP0010` cascade;

create table `MGCP0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `set_type` INT default 0 not null comment '設定種別'
  , `category_code` VARCHAR(255) default '' not null comment 'カテゴリコード'
  , `key_code` VARCHAR(255) default '' not null comment 'キーコード'
  , `value` TEXT default '' not null comment '設定値'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `control_6` TEXT default '' not null comment '制御情報６'
  , `control_7` TEXT default '' not null comment '制御情報７'
  , `control_8` TEXT default '' not null comment '制御情報８'
  , `control_9` TEXT default '' not null comment '制御情報９'
  , `control_10` TEXT default '' not null comment '制御情報１０'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0010_PKC` primary key (`rid`)
) comment '管理企業別設定情報マスタ' ;

-- 申請担当社員マスタ
drop table if exists `APLS0001` cascade;

create table `APLS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `user_code` TEXT default '' not null comment 'ユーザーID'
  , `prefectue_class_id` CHAR(40) not null comment '都道府県区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `action_id` CHAR(40) not null comment '受付処理ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `APLS0001_PKC` primary key (`rid`)
) comment '申請担当社員マスタ' ;

-- 企業役職区分マスタ
drop table if exists `MNAM0007` cascade;

create table `MNAM0007` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '会員役員区分値'
  , `name` TEXT default '' not null comment '会員役員区分名'
  , `short_name` TEXT default '' not null comment '会員役員区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0007_PKC` primary key (`rid`)
) comment '企業役職区分マスタ' ;

-- 部署所属社員マスタ
drop table if exists `MCDP0010` cascade;

create table `MCDP0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業部署ID'
  , `user_id` CHAR(40) not null comment 'ユーザーID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `manager_class_id` CHAR(40) not null comment '企業役職区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MCDP0010_PKC` primary key (`rid`)
) comment '部署所属社員マスタ' ;

-- 管理企業部署マスタ
drop table if exists `MCDP0001` cascade;

create table `MCDP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `department_name` TEXT not null comment '部署名'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `finance_flag` TINYINT default 0 not null comment '経理入力フラグ:1:経理処理が必要な場合'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MCDP0001_PKC` primary key (`rid`)
) comment '管理企業部署マスタ' ;

-- システムマスタ
drop table if exists `SYTM0001` cascade;

create table `SYTM0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `system_name` TEXT default '' not null comment 'システム名'
  , `base_url` TINYTEXT default '' not null comment 'ベースURL'
  , `remark` TEXT default '' not null comment '説明'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SYTM0001_PKC` primary key (`rid`)
) comment 'システムマスタ' ;

-- 画面マスタ
drop table if exists `SCRN0001` cascade;

create table `SCRN0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `system_id` CHAR(40) not null comment 'システムID'
  , `screen_name` TEXT default '' not null comment '画面名'
  , `screen_url` TINYTEXT default '' not null comment 'URL'
  , `remark` TEXT default '' not null comment '説明'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SCRN0001_PKC` primary key (`rid`)
) comment '画面マスタ' ;

-- 施術担当者診療科情報
drop table if exists `RCST0010` cascade;

create table `RCST0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `reception_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:1:追加、2:更新、3:削除、4:勤務時間変更'
  , `depertment_class_id` CHAR(40) not null comment '診療科区分'
  , `staff_id` CHAR(40) comment '担当者ID'
  , `new_staff_id` CHAR(40) comment '勤務担当者ID'
  , `effective_date` DATE default '1900-1-1' not null comment '適用日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCST0010_PKC` primary key (`rid`)
) comment '施術担当者診療科情報' ;

-- 受付施術担当者情報
drop table if exists `RCST0001` cascade;

create table `RCST0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_id` CHAR(40) not null comment '依頼内容ID'
  , `process_class` INT not null comment '依頼処理区分:1:追加、2:更新、3:削除'
  , `effective_date` DATE default '1900-1-1' not null comment '適用日'
  , `staff_id` CHAR(40) comment '担当者ID:既存担当者の場合'
  , `last_kana` TEXT default '' not null comment '担当者カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '担当者カナ名前:半角'
  , `last_name` TEXT default '' not null comment '担当者苗字:全角'
  , `first_name` TEXT default '' not null comment '担当者名前:全角'
  , `birthday` DATE default '1800-1-1' not null comment '生年月日'
  , `sex_class_id` CHAR(40) not null comment '性別区分:1: 男、2: 女'
  , `school_name` TEXT default '' not null comment '出身校'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `experience_flag` TINYINT default 0 not null comment '実務経験フラグ'
  , `experience_years` INT default 0 not null comment '実務経験年数'
  , `manage_experience_years` INT default 0 not null comment '管理者経験年数'
  , `target_staff_id` CHAR(40) comment '対象担当者ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCST0001_PKC` primary key (`rid`)
) comment '受付施術担当者情報' ;

-- 会員審査員情報
drop table if exists `MBJG0001` cascade;

create table `MBJG0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `organization_id` CHAR(40) not null comment '審査会等ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBJG0001_PKC` primary key (`rid`)
) comment '会員審査員情報' ;

-- 講習会情報
drop table if exists `SMSC0001` cascade;

create table `SMSC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `course_class_id` CHAR(40) not null comment '講習種別区分:1: 入会講習、2: セミナー'
  , `place_class_id` CHAR(40) not null comment '開催会場区分'
  , `course_name_class_id` CHAR(40) comment '講習会名区分'
  , `course_name` TEXT default '' not null comment '講習会名'
  , `course_date` DATE default '1900-1-1' not null comment '開催日'
  , `start_time` TIME default '00:00:00' not null comment '開始時間'
  , `end_time` TIME default '00:00:00' not null comment '終了時間'
  , `max_count` INT default 0 not null comment '最大受講数'
  , `remark` TEXT not null comment '備考'
  , `state_class` TEXT default '' not null comment '状態区分:'':未開催、1: 完了、2:中止'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SMSC0001_PKC` primary key (`rid`)
) comment '講習会情報' ;

-- 施術所税理士・会計士マスタ
drop table if exists `ACUT0001_OFFC0001` cascade;

create table `ACUT0001_OFFC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `accountant_id` CHAR(40) not null comment '税理士・会計士ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ACUT0001_OFFC0001_PKC` primary key (`rid`)
) comment '施術所税理士・会計士マスタ' ;

-- 施術機関コードマスタ
drop table if exists `LCNC00010` cascade;

create table `LCNC00010` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_id` CHAR(40) not null comment '施術所ID'
  , `office_code_id` CHAR(40) not null comment '施術機関コード番号構成ID'
  , `office_code` TEXT default '' not null comment '施術機関コード:30桁'
  , `membership_id` CHAR(40) comment '会員ID'
  , `grant_date` DATE default '1900-1-1' not null comment '取得年月日'
  , `disuse_date` DATE default '9999-12-31' not null comment '廃止年月日'
  , `state_class_id` CHAR(40) not null comment '状態区分:通知待ち、通知書返送待ち、完了'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LCNC00010_PKC` primary key (`rid`)
) comment '施術機関コードマスタ' ;

-- 他団体加入中の有無区分マスタ
drop table if exists `CNAM0004` cascade;

create table `CNAM0004` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '他団体加入中の有無区分値'
  , `name` TEXT default '' not null comment '他団体加入中の有無区分名'
  , `short_name` TEXT default '' not null comment '他団体加入中の有無区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0004_PKC` primary key (`rid`)
) comment '他団体加入中の有無区分マスタ' ;

-- 慶弔イベント区分マスタ
drop table if exists `CNAM0134` cascade;

create table `CNAM0134` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '慶弔イベント区分値'
  , `name` TEXT default '' not null comment '慶弔イベント区分名'
  , `short_name` TEXT default '' not null comment '慶弔イベント区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0134_PKC` primary key (`rid`)
) comment '慶弔イベント区分マスタ' ;

-- レセプト印字区分マスタ
drop table if exists `CNAM0143` cascade;

create table `CNAM0143` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト印字区分値'
  , `name` TEXT default '' not null comment 'レセプト印字区分名'
  , `short_name` TEXT default '' not null comment 'レセプト印字区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0143_PKC` primary key (`rid`)
) comment 'レセプト印字区分マスタ' ;

-- レセプト印字チェック区分マスタ
drop table if exists `CNAM0142` cascade;

create table `CNAM0142` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト印字チェック区分値'
  , `name` TEXT default '' not null comment 'レセプト印字チェック区分名'
  , `short_name` TEXT default '' not null comment 'レセプト印字チェック区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0142_PKC` primary key (`rid`)
) comment 'レセプト印字チェック区分マスタ' ;

-- 番号種別区分マスタ
drop table if exists `CNAM0132` cascade;

create table `CNAM0132` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '番号種別区分値'
  , `name` TEXT default '' not null comment '番号種別区分名'
  , `short_name` TEXT default '' not null comment '番号種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0132_PKC` primary key (`rid`)
) comment '番号種別区分マスタ' ;

-- レセプト送付先区分マスタ
drop table if exists `CNAM0141` cascade;

create table `CNAM0141` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト送付先区分値'
  , `name` TEXT default '' not null comment 'レセプト送付先区分名'
  , `short_name` TEXT default '' not null comment 'レセプト送付先区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0141_PKC` primary key (`rid`)
) comment 'レセプト送付先区分マスタ' ;

-- 施術所コード登録区分マスタ
drop table if exists `CNAM0131` cascade;

create table `CNAM0131` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '施術所コード登録区分値'
  , `name` TEXT default '' not null comment '施術所コード登録区分名'
  , `short_name` TEXT default '' not null comment '施術所コード登録区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0131_PKC` primary key (`rid`)
) comment '施術所コード登録区分マスタ' ;

-- 労働基準監督署備考添付ファイル情報
drop table if exists `LSIO0030` cascade;

create table `LSIO0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LSIO0030_PKC` primary key (`rid`)
) comment '労働基準監督署備考添付ファイル情報' ;

-- 講習種別区分マスタ
drop table if exists `CNAM0035` cascade;

create table `CNAM0035` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '講習種別区分値'
  , `name` TEXT default '' not null comment '講習種別区分名'
  , `short_name` TEXT default '' not null comment '講習種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0035_PKC` primary key (`rid`)
) comment '講習種別区分マスタ' ;

-- 返戻依頼方法区分マスタ
drop table if exists `CNAM0128` cascade;

create table `CNAM0128` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '返戻依頼方法区分値'
  , `name` TEXT default '' not null comment '返戻依頼方法区分名'
  , `short_name` TEXT default '' not null comment '返戻依頼方法区分略称'
  , `seal_flag` TINYINT default 0 not null comment '返戻依頼印の有無フラグ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0128_PKC` primary key (`rid`)
) comment '返戻依頼方法区分マスタ' ;

-- 点検業者口座マスタ
drop table if exists `CHAC0001` cascade;

create table `CHAC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '点検業者ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `holder_address_street` TEXT default '' not null comment '名義人団地・マンション'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHAC0001_PKC` primary key (`rid`)
) comment '点検業者口座マスタ' ;

-- 保険者点検業者関係マスタ
drop table if exists `INSR0001_CHKC0001` cascade;

create table `INSR0001_CHKC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `department_id` CHAR(40) not null comment '保険者部署ID'
  , `check_company_id` CHAR(40) not null comment '点検業者ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `transfer_flag` TINYINT default 0 not null comment '点検業者振込フラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0001_CHKC0001_PKC` primary key (`rid`)
) comment '保険者点検業者関係マスタ' ;

-- 自賠責保険会社備考添付ファイル情報
drop table if exists `MVLI0030` cascade;

create table `MVLI0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MVLI0030_PKC` primary key (`rid`)
) comment '自賠責保険会社備考添付ファイル情報' ;

-- 保険者備考添付ファイル情報
drop table if exists `INSR0050` cascade;

create table `INSR0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0050_PKC` primary key (`rid`)
) comment '保険者備考添付ファイル情報' ;

-- 保健所備考添付ファイル情報
drop table if exists `HLTH0030` cascade;

create table `HLTH0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `remark_id` CHAR(40) not null comment '備考ID'
  , `document_name` TEXT default '' not null comment 'ドキュメント名'
  , `file_name` TEXT default '' not null comment 'ファイル名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `HLTH0030_PKC` primary key (`rid`)
) comment '保健所備考添付ファイル情報' ;

-- 支払者区分マスタ
drop table if exists `CNAM0017` cascade;

create table `CNAM0017` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '支払者区分値'
  , `name` TEXT default '' not null comment '支払者区分名'
  , `short_name` TEXT not null comment '支払者区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0017_PKC` primary key (`rid`)
) comment '支払者区分マスタ' ;

-- 審査会等マスタ
drop table if exists `FDRT0001` cascade;

create table `FDRT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `department_kana` TEXT default '' not null comment '審査会等カナ名'
  , `department_name` TEXT not null comment '審査会等名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `FDRT0001_PKC` primary key (`rid`)
) comment '審査会等マスタ' ;

-- 管理企業口座用途区分マスタ
drop table if exists `CNAM0011` cascade;

create table `CNAM0011` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '管理企業口座用途区分値'
  , `name` TEXT default '' not null comment '管理企業口座用途区分名'
  , `short_name` TEXT default '' not null comment '管理企業口座用途区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0011_PKC` primary key (`rid`)
) comment '管理企業口座用途区分マスタ' ;

-- 資料請求者マスタ
drop table if exists `DCRQ0001` cascade;

create table `DCRQ0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `management_no` INT default 0 not null comment '管理番号'
  , `revision` INT UNSIGNED default 0 not null comment 'リビジョン:改訂履歴'
  , `office_kana` TEXT default '' not null comment '施術所カナ名'
  , `office_name` TEXT default '' not null comment '施術所名'
  , `last_kana` TEXT default '' not null comment '請求者カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '請求者カナ名前:半角'
  , `last_name` TEXT default '' not null comment '請求者苗字:全角'
  , `first_name` TEXT default '' not null comment '請求者名前:全角'
  , `birthday` DATE default '1800-1-1' not null comment '生年月日'
  , `sex_class_id` CHAR(40) default '' not null comment '性別:1: 男、2: 女'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_city` TEXT default '' not null comment '住所1'
  , `address_town` TEXT default '' not null comment '住所2'
  , `address_city_kana` TEXT default '' not null comment '住所カナ1'
  , `address_town_kana` TEXT default '' not null comment '住所カナ2'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールドレス'
  , `introduce_id` CHAR(40) default 0 not null comment '紹介者会員ID:予め判る場合のみ'
  , `introduce_name` TEXT default '' not null comment '紹介者会員名'
  , `introduce_office_name` TEXT default '' not null comment '紹介者施術所名'
  , `state_class` TEXT default '' not null comment '状態区分:1:仮会員、9:退会'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `DCRQ0001_PKC` primary key (`rid`)
) comment '資料請求者マスタ' ;

-- 発送物対象会員情報
drop table if exists `SEND0001` cascade;

create table `SEND0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `send_id` CHAR(40) not null comment '発送物ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SEND0001_PKC` primary key (`rid`)
) comment '発送物対象会員情報' ;

-- 会員役員区分マスタ
drop table if exists `MNAM0006` cascade;

create table `MNAM0006` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理会社ID'
  , `clazz` TEXT default '' not null comment '会員役員区分値'
  , `name` TEXT default '' not null comment '会員役員区分名'
  , `short_name` TEXT default '' not null comment '会員役員区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0006_PKC` primary key (`rid`)
) comment '会員役員区分マスタ' ;

-- 科目種別区分マスタ
drop table if exists `CNAM0045` cascade;

create table `CNAM0045` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '科目種別区分値'
  , `name` TEXT default '' not null comment '科目種別区分名'
  , `short_name` TEXT default '' not null comment '科目種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0045_PKC` primary key (`rid`)
) comment '科目種別区分マスタ' ;

-- 会員種別区分マスタ
drop table if exists `MNAM0004` cascade;

create table `MNAM0004` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `clazz` TEXT default '' not null comment '会員種別区分値'
  , `name` TEXT default '' not null comment '会員種別区分名'
  , `short_name` TEXT default '' not null comment '会員種別区分略称'
  , `receipt_flag` TINYINT default 0 not null comment 'レセプト可能フラグ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0004_PKC` primary key (`rid`)
) comment '会員種別区分マスタ' ;

-- 現在の保険請求区分マスタ
drop table if exists `CNAM0123` cascade;

create table `CNAM0123` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '現在の保険請求区分値'
  , `name` TEXT default '' not null comment '現在の保険請求区分名'
  , `short_name` TEXT default '' not null comment '現在の保険請求区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0123_PKC` primary key (`rid`)
) comment '現在の保険請求区分マスタ' ;

-- 加入保険状態区分マスタ
drop table if exists `CNAM0140` cascade;

create table `CNAM0140` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '加入保険状態区分値'
  , `name` TEXT default '' not null comment '加入保険状態区分名'
  , `short_name` TEXT default '' not null comment '加入保険状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0140_PKC` primary key (`rid`)
) comment '加入保険状態区分マスタ' ;

-- 貸出返却理由区分マスタ
drop table if exists `CNAM0139` cascade;

create table `CNAM0139` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '貸出返却理由区分値'
  , `name` TEXT default '' not null comment '貸出返却理由区分名'
  , `short_name` TEXT default '' not null comment '貸出返却理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0139_PKC` primary key (`rid`)
) comment '貸出返却理由区分マスタ' ;

-- 会員状態区分マスタ
drop table if exists `CNAM0138` cascade;

create table `CNAM0138` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '会員状態区分値'
  , `name` TEXT default '' not null comment '会員状態区分名'
  , `short_name` TEXT default '' not null comment '会員状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0138_PKC` primary key (`rid`)
) comment '会員状態区分マスタ' ;

-- 会員備考区分マスタ
drop table if exists `CNAM0137` cascade;

create table `CNAM0137` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '会員備考区分値'
  , `name` TEXT default '' not null comment '会員備考区分名'
  , `short_name` TEXT default '' not null comment '会員備考区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0137_PKC` primary key (`rid`)
) comment '会員備考区分マスタ' ;

-- 慶弔状態区分マスタ
drop table if exists `CNAM0136` cascade;

create table `CNAM0136` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '慶弔状態区分値'
  , `name` TEXT default '' not null comment '慶弔状態区分名'
  , `short_name` TEXT default '' not null comment '慶弔状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0136_PKC` primary key (`rid`)
) comment '慶弔状態区分マスタ' ;

-- 続柄区分マスタ
drop table if exists `CNAM0135` cascade;

create table `CNAM0135` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '続柄区分値'
  , `name` TEXT default '' not null comment '続柄区分名'
  , `short_name` TEXT default '' not null comment '続柄区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0135_PKC` primary key (`rid`)
) comment '続柄区分マスタ' ;

-- 貸出状態区分マスタ
drop table if exists `CNAM0130` cascade;

create table `CNAM0130` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '貸出状態区分値'
  , `name` TEXT default '' not null comment '貸出状態区分名'
  , `short_name` TEXT default '' not null comment '貸出状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0130_PKC` primary key (`rid`)
) comment '貸出状態区分マスタ' ;

-- 申請機関区分マスタ
drop table if exists `CNAM0129` cascade;

create table `CNAM0129` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '申請機関区分値'
  , `name` TEXT default '' not null comment '申請機関区分名'
  , `short_name` TEXT default '' not null comment '申請機関区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0129_PKC` primary key (`rid`)
) comment '申請機関区分マスタ' ;

-- 保険請求状態区分マスタ
drop table if exists `CNAM0127` cascade;

create table `CNAM0127` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '保険請求状態区分値'
  , `name` TEXT default '' not null comment '保険請求状態区分名'
  , `short_name` TEXT default '' not null comment '保険請求状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0127_PKC` primary key (`rid`)
) comment '保険請求状態区分マスタ' ;

-- 出資金所有者区分マスタ
drop table if exists `CNAM0064` cascade;

create table `CNAM0064` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '出資金所有者区分値'
  , `name` TEXT default '' not null comment '出資金所有者区分名'
  , `short_name` TEXT default '' not null comment '出資金所有者区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0064_PKC` primary key (`rid`)
) comment '出資金所有者区分マスタ' ;

-- 管理企業開設者マスタ
drop table if exists `MGCP0001_OPNR0001` cascade;

create table `MGCP0001_OPNR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `original_opener_id` CHAR(40) not null comment '基本開設者ID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `opener_id` CHAR(40) not null comment '開設者ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0001_OPNR0001_PKC` primary key (`rid`)
) comment '管理企業開設者マスタ' ;

-- 管理企業施術所マスタ
drop table if exists `MGCP0001_OFFC0001` cascade;

create table `MGCP0001_OFFC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `original_office_id` CHAR(40) not null comment '基本施術所ID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0001_OFFC0001_PKC` primary key (`rid`)
) comment '管理企業施術所マスタ' ;

-- 管理企業事業主マスタ
drop table if exists `MGCP0001_OWNR0001` cascade;

create table `MGCP0001_OWNR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `original_owner_id` CHAR(40) not null comment '基本事業主ID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `owner_id` CHAR(40) not null comment '事業主ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0001_OWNR0001_PKC` primary key (`rid`)
) comment '管理企業事業主マスタ' ;

-- 施術所許可番号マスタ
drop table if exists `LCNC0001` cascade;

create table `LCNC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `membership_id` CHAR(40) comment '会員ID'
  , `license_class_id` CHAR(40) not null comment '許可番号区分'
  , `license_no` TEXT default '' not null comment '許可番号:30桁'
  , `grant_date` DATE default '1900-1-1' not null comment '取得年月日'
  , `disuse_date` DATE default '9999-12-31' not null comment '廃止年月日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `LCNC0001_PKC` primary key (`rid`)
) comment '施術所許可番号マスタ' ;

-- 労災保険種別区分マスタ
drop table if exists `CNAM0112` cascade;

create table `CNAM0112` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '労災保険種別区分値'
  , `name` TEXT default '' not null comment '労災保険種別区分名'
  , `short_name` TEXT default '' not null comment '労災保険種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0112_PKC` primary key (`rid`)
) comment '労災保険種別区分マスタ' ;

-- 返戻区分マスタ
drop table if exists `CNAM0111` cascade;

create table `CNAM0111` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '返戻区分値'
  , `name` TEXT default '' not null comment '返戻区分名'
  , `short_name` TEXT default '' not null comment '返戻区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0111_PKC` primary key (`rid`)
) comment '返戻区分マスタ' ;

-- 紹介者振込口座マスタ
drop table if exists `ITRD0010` cascade;

create table `ITRD0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `introducer_id` CHAR(40) not null comment '紹介者ID'
  , `bank_code` TEXT default '' not null comment '銀行コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `bank_kana` TEXT default '' not null comment '銀行カナ名'
  , `bank_name` TEXT default '' not null comment '銀行名'
  , `bank_branch_code` TEXT default '' not null comment '銀行支店コード'
  , `bank_branch_kana` TEXT default '' not null comment '銀行支店カナ名'
  , `bank_branch_name` TEXT default '' not null comment '銀行支店名'
  , `account_class_id` CHAR(40) not null comment '口座種別区分:1: 普通、2: 当座'
  , `account_no` TEXT default '' not null comment '口座番号'
  , `holder_kana` TEXT default '' not null comment '名義人カナ名'
  , `holder_name` TEXT default '' not null comment '名義人名'
  , `holder_phone_no` TINYTEXT default '' not null comment '名義人電話番号'
  , `holder_postal_code` TINYTEXT default '' not null comment '名義人郵便番号'
  , `holder_address_city` TEXT default '' not null comment '名義人市区町村'
  , `holder_address_town` TEXT default '' not null comment '名義人町域'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `ITRD0010_PKC` primary key (`rid`)
) comment '紹介者振込口座マスタ' ;

-- 自賠責保険会社備考情報
drop table if exists `MVLI0020` cascade;

create table `MVLI0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `liability_id` CHAR(40) not null comment '自賠責保険会社ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MVLI0020_PKC` primary key (`rid`)
) comment '自賠責保険会社備考情報' ;

-- 点検業者異動マスタ
drop table if exists `CHKC0010` cascade;

create table `CHKC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `check_company_id` CHAR(40) not null comment '異動先点検業者ID'
  , `source_check_company_id` CHAR(40) not null comment '異動元点検業者ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHKC0010_PKC` primary key (`rid`)
) comment '点検業者異動マスタ' ;

-- 保険者部署マスタ
drop table if exists `INSR0020` cascade;

create table `INSR0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `department_kana` TEXT default '' not null comment '部署カナ名'
  , `department_name` TEXT default '' not null comment '部署名'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `back_request_class_id` CHAR(40) not null comment '返戻依頼方法区分:1:電話､2:用紙'
  , `back_request_seal_flag` TINYINT default 0 not null comment '返戻依頼印の有無フラグ:1: 返戻依頼方法が用紙の場合に印が必要'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0020_PKC` primary key (`rid`)
) comment '保険者部署マスタ' ;

-- 会員賠償保険賠償ランクマスタ
drop table if exists `MBIS0010` cascade;

create table `MBIS0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `member_insurance_id` CHAR(40) not null comment '会員賠償保険ID'
  , `reparation_rank_id` CHAR(40) not null comment '賠償保険ランクID'
  , `amount` DECIMAL(13,2) default 0 not null comment '金額'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBIS0010_PKC` primary key (`rid`)
) comment '会員賠償保険賠償ランクマスタ' ;

-- 賠償保険賠償ランクマスタ
drop table if exists `RPIS0020` cascade;

create table `RPIS0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `reparation_id` CHAR(40) not null comment '賠償保険ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rank_name` TEXT default '' not null comment '賠償保険ランク名'
  , `amount` DECIMAL(13,2) default 0 not null comment '金額'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RPIS0020_PKC` primary key (`rid`)
) comment '賠償保険賠償ランクマスタ' ;

-- 会員賠償保険オプション情報
drop table if exists `MBIS0020` cascade;

create table `MBIS0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `member_insurance_id` CHAR(40) not null comment '会員賠償保険ID'
  , `reparation_option_id` CHAR(40) not null comment '賠償保険オプションID'
  , `amount` DECIMAL(13,2) default 0 not null comment '金額'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBIS0020_PKC` primary key (`rid`)
) comment '会員賠償保険オプション情報' ;

-- 賠償保険オプションマスタ
drop table if exists `RPIS0030` cascade;

create table `RPIS0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `reparation_id` CHAR(40) not null comment '賠償保険ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `option_name` TEXT default '' not null comment 'オプション名'
  , `amount` DECIMAL(13,2) default 0 not null comment '金額'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RPIS0030_PKC` primary key (`rid`)
) comment '賠償保険オプションマスタ' ;

-- ハード備品マスタ
drop table if exists `RTIT0001` cascade;

create table `RTIT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `company_id` CHAR(40) not null comment '管理企業ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `product_code` TEXT default '' not null comment '型番'
  , `product_name` TEXT default '' not null comment '型名'
  , `maker_name` TEXT default '' not null comment 'メーカー名'
  , `product_type` TEXT default '' not null comment '製品種別'
  , `cost` DECIMAL(13,2) default 0 not null comment '仕入れ額'
  , `sales_amount` DECIMAL(13,2) default 0 not null comment '販売金額'
  , `rental_amount` DECIMAL(13,2) default 0 not null comment 'レンタル料'
  , `rent_flag` TINYINT default 0 not null comment 'レンタルフラグ:1:レンタル品'
  , `option_flag` TINYINT default 0 not null comment 'オプションフラグ:1: オプション製品'
  , `support_company_id` CHAR(40) not null comment 'サポート会社ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RTIT0001_PKC` primary key (`rid`)
) comment 'ハード備品マスタ' ;

-- セット品構成マスタ
drop table if exists `RTST0001` cascade;

create table `RTST0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `set_product_id` CHAR(40) default 0 not null comment 'セット品ID'
  , `product_id` CHAR(40) default 0 not null comment '製品ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RTST0001_PKC` primary key (`rid`)
) comment 'セット品構成マスタ' ;

-- 管理企業会員マスタ
drop table if exists `MGCP0001_MBSP0001` cascade;

create table `MGCP0001_MBSP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `original_membership_id` CHAR(40) not null comment '基本会員ID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0001_MBSP0001_PKC` primary key (`rid`)
) comment '管理企業会員マスタ' ;

-- 賠償保険マスタ
drop table if exists `RPIS0010` cascade;

create table `RPIS0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurance_company_id` CHAR(40) not null comment '賠償保険会社ID'
  , `insurance_name` CHAR(40) default 0 not null comment '賠償保険名'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RPIS0010_PKC` primary key (`rid`)
) comment '賠償保険マスタ' ;

-- 受付処理マスタ
drop table if exists `MGCP0040` cascade;

create table `MGCP0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `company_id` CHAR(40) not null comment '管理企業ID'
  , `action_class_id` CHAR(40) default '' not null comment '受付処理区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0040_PKC` primary key (`rid`)
) comment '受付処理マスタ' ;

-- 管理企業マスタ
drop table if exists `MGCP0001` cascade;

create table `MGCP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `company_code` VARCHAR(255) not null comment '企業コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `company_kana` TEXT default '' not null comment '企業カナ名'
  , `company_name` TEXT default '' not null comment '企業名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MGCP0001_PKC` primary key (`rid`)
) comment '管理企業マスタ' ;

-- 点検業者備考情報
drop table if exists `CHKC0040` cascade;

create table `CHKC0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `check_company_id` CHAR(40) not null comment '点検業者ID'
  , `check_department_id` CHAR(40) comment '点検業者部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHKC0040_PKC` primary key (`rid`)
) comment '点検業者備考情報' ;

-- 点検業者マスタ
drop table if exists `CHKC0001` cascade;

create table `CHKC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `check_company_kana` TEXT default '' not null comment '点検業者カナ名'
  , `check_company_name` TEXT default '' not null comment '点検業者名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `delegate_name` TEXT default '' not null comment '窓口担当者'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CHKC0001_PKC` primary key (`rid`)
) comment '点検業者マスタ' ;

-- 貸出ハード備品情報
drop table if exists `OFRT0001` cascade;

create table `OFRT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `staff_id` CHAR(40) not null comment '業務促進担当ID'
  , `rent_start_date` DATE default '1900-1-1' not null comment '貸出開始日'
  , `rent_end_date` DATE default '9999-12-31' not null comment '貸出終了日'
  , `rent_state_class_id` CHAR(40) not null comment '貸出状態区分:1:貸出中、2:返却完了'
  , `contract_no` TEXT not null comment '契約書番号'
  , `contract_date` DATE default '1900-1-1' not null comment '契約年月日'
  , `contract_flag` TINYINT default 0 not null comment '契約書有無フラグ'
  , `payment_class_id` CHAR(40) not null comment '支払方法区分'
  , `divid_count` INT default 0 not null comment '分割回数'
  , `amount` DECIMAL(13,2) default 0 not null comment '合計金額'
  , `maintenance_contract_flag` TINYINT default 0 not null comment '保守契約フラグ'
  , `convert_company_class_id` CHAR(40) not null comment 'コンバート処理業者区分'
  , `data_move_flag` TINYINT default 0 not null comment 'データ移行フラグ'
  , `plan_establish_date` DATE default '1900-1-1' not null comment '予定設置日'
  , `establish_date` DATE default '1900-1-1' not null comment '設置日'
  , `plan_arrive_date` DATE default '1900-1-1' not null comment '予定着日'
  , `arrive_date` DATE default '1900-1-1' not null comment '着日'
  , `explanation_flag` TINYINT default 0 not null comment '設置説明済フラグ'
  , `establish_user_id` CHAR(40) comment '設置担当者ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFRT0001_PKC` primary key (`rid`)
) comment '貸出ハード備品情報' ;

-- 診療科施術担当者マスタ
drop table if exists `OFST0001` cascade;

create table `OFST0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分:柔整、鍼、灸、あん摩・マッサージ'
  , `staff_id` CHAR(40) not null comment '担当者ID:担当者マスタより'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `state_class_id` CHAR(40) not null comment '担当者状態区分:1: 休業、9: 廃業'
  , `am_mon_start_time` TIME default '00:00:00' not null comment '月曜日午前の勤務開始時間'
  , `am_mon_end_time` TIME default '00:00:00' not null comment '月曜日午前の勤務終了時間'
  , `am_tue_start_time` TIME default '00:00:00' not null comment '火曜日午前の勤務開始時間'
  , `am_tue_end_time` TIME default '00:00:00' not null comment '火曜日午前の勤務終了時間'
  , `am_wed_start_time` TIME default '00:00:00' not null comment '水曜日午前の勤務開始時間'
  , `am_wed_end_time` TIME default '00:00:00' not null comment '水曜日午前の勤務終了時間'
  , `am_thu_start_time` TIME default '00:00:00' not null comment '木曜日午前の勤務開始時間'
  , `am_thu_end_time` TIME default '00:00:00' not null comment '木曜日午前の勤務終了時間'
  , `am_fri_start_time` TIME default '00:00:00' not null comment '金曜日午前の勤務開始時間'
  , `am_fri_end_time` TIME default '00:00:00' not null comment '金曜日午前の勤務終了時間'
  , `am_sat_start_time` TIME default '00:00:00' not null comment '土曜日午前の勤務開始時間'
  , `am_sat_end_time` TIME default '00:00:00' not null comment '土曜日午前の勤務終了時間'
  , `am_sun_start_time` TIME default '00:00:00' not null comment '日曜日午前の勤務開始時間'
  , `am_sun_end_time` TIME default '00:00:00' not null comment '日曜日午前の勤務終了時間'
  , `am_hol_start_time` TIME default '00:00:00' not null comment '祝日午前の勤務開始時間'
  , `am_hol_end_time` TIME default '00:00:00' not null comment '祝日午前の勤務終了時間'
  , `pm_mon_start_time` TIME default '00:00:00' not null comment '月曜日午後の勤務開始時間'
  , `pm_mon_end_time` TIME default '00:00:00' not null comment '月曜日午後の勤務終了時間'
  , `pm_tue_start_time` TIME default '00:00:00' not null comment '火曜日午後の勤務開始時間'
  , `pm_tue_end_time` TIME default '00:00:00' not null comment '火曜日午後の勤務終了時間'
  , `pm_wed_start_time` TIME default '00:00:00' not null comment '水曜日午後の勤務開始時間'
  , `pm_wed_end_time` TIME default '00:00:00' not null comment '水曜日午後の勤務終了時間'
  , `pm_thu_start_time` TIME default '00:00:00' not null comment '木曜日午後の勤務開始時間'
  , `pm_thu_end_time` TIME default '00:00:00' not null comment '木曜日午後の勤務終了時間'
  , `pm_fri_start_time` TIME default '00:00:00' not null comment '金曜日午後の勤務開始時間'
  , `pm_fri_end_time` TIME default '00:00:00' not null comment '金曜日午後の勤務終了時間'
  , `pm_sat_start_time` TIME default '00:00:00' not null comment '土曜日午後の勤務開始時間'
  , `pm_sat_end_time` TIME default '00:00:00' not null comment '土曜日午後の勤務終了時間'
  , `pm_sun_start_time` TIME default '00:00:00' not null comment '日曜日午後の勤務開始時間'
  , `pm_sun_end_time` TIME default '00:00:00' not null comment '日曜日午後の勤務終了時間'
  , `pm_hol_start_time` TIME default '00:00:00' not null comment '祝日午後の勤務開始時間'
  , `pm_hol_end_time` TIME default '00:00:00' not null comment '祝日午後の勤務終了時間'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFST0001_PKC` primary key (`rid`)
) comment '診療科施術担当者マスタ' ;

-- 施術所マスタ
drop table if exists `OFFC0001` cascade;

create table `OFFC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `revision` INT UNSIGNED default 0 not null comment 'リビジョン'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `office_no` INT default 0 not null comment '施術所番号'
  , `open_date` DATE default '1900-1-1' not null comment '開業日'
  , `close_date` DATE default '9999-12-31' not null comment '廃業日'
  , `assist_elderly_disp_flag` TINYINT default 0 not null comment '助成老福表示フラグ'
  , `assist_mother_disp_flag` TINYINT default 0 not null comment '助成母親表示フラグ'
  , `state_class_id` TEXT default '' not null comment '施術所状態区分:'': 継続、1: 休業、9: 廃業'
  , `office_kana` TEXT default '' not null comment '施術所カナ名'
  , `office_name` TEXT default '' not null comment '施術所名'
  , `health_center_entry_class_id` CHAR(40) not null comment '保健所登録区分:1:施術所所在地、2:出張専門施術者住所地'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `ocr_process_flag` TINYINT default 0 not null comment 'OCR処理フラグ:1:OCR処理可能'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFFC0001_PKC` primary key (`rid`)
) comment '施術所マスタ' ;

-- 施術所開設者マスタ
drop table if exists `OPNR0001_OFFC0001` cascade;

create table `OPNR0001_OFFC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `opener_id` CHAR(40) not null comment '開設者ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OPNR0001_OFFC0001_PKC` primary key (`rid`)
) comment '施術所開設者マスタ' ;

-- 保険者備考情報
drop table if exists `INSR0040` cascade;

create table `INSR0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `insurer_dept_id` CHAR(40) comment '保険者部署ID'
  , `remark_class_id` CHAR(40) not null comment '備考区分'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0040_PKC` primary key (`rid`)
) comment '保険者備考情報' ;

-- 保険者の特別な負担割合情報
drop table if exists `INSR0030` cascade;

create table `INSR0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `insurer_id` CHAR(40) not null comment '保険者ID'
  , `familly_flag` TINYINT default 0 not null comment '家族フラグ:0: 本人、1:家族'
  , `ratio` INT default 0 not null comment '特別な負担割合'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0030_PKC` primary key (`rid`)
) comment '保険者の特別な負担割合情報' ;

-- 自賠責保険会社異動マスタ
drop table if exists `MVLI0010` cascade;

create table `MVLI0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `liability_id` CHAR(40) not null comment '異動先自賠責保険会社ID'
  , `source_liability_id` CHAR(40) not null comment '異動元自賠責保険会社ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MVLI0010_PKC` primary key (`rid`)
) comment '自賠責保険会社異動マスタ' ;

-- 自賠責保険会社マスタ
drop table if exists `MVLI0001` cascade;

create table `MVLI0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `liability_no` INT default 0 not null comment '自賠責保険識別番号:全柔協内でユニーク'
  , `liability_kana` TEXT default '' not null comment '保険会社カナ名'
  , `liability_name` TEXT default '' not null comment '保険会社名'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `local_no` TEXT default '' not null comment '内線番号'
  , `delegate_name` TEXT default '' not null comment '窓口担当氏名'
  , `delegate_department` TEXT default '' not null comment '窓口担当部署'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MVLI0001_PKC` primary key (`rid`)
) comment '自賠責保険会社マスタ' ;

-- 保険者マスタ
drop table if exists `INSR0001` cascade;

create table `INSR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `type_class_id` CHAR(40) not null comment '保険者種別区分'
  , `law_class_id` CHAR(40) not null comment '法別区分'
  , `insurer_no` CHAR(8) default '' not null comment '保険者番号'
  , `age` TEXT default '' not null comment '枝番'
  , `insurer_no_part_1` CHAR(2) default '' not null comment '法別番号:保険証保険者番号の1桁目、2桁目'
  , `insurer_no_part_2` CHAR(2) default '' not null comment '都道府県番号:保険証保険者番号の3桁目、4桁目'
  , `insurer_no_part_3` CHAR(3) default '' not null comment '保険者別番号:保険証保険者番号の5桁目、6桁目、7桁目'
  , `insurer_no_part_4` CHAR(1) default '' not null comment '検証番号:保険証保険者番号の8桁目'
  , `insurer_code` CHAR(14) default '' not null comment '保険者コード:種別区分+法別+保険者番号'
  , `municipality_id` CHAR(40) not null comment '自治体ID'
  , `insurer_kana_1` TEXT default '' not null comment '保険者カナ名１'
  , `insurer_kana_2` TEXT default '' not null comment '保険者カナ名２'
  , `insurer_name_1` TEXT default '' not null comment '保険者名１'
  , `insurer_name_2` TEXT default '' not null comment '保険者名２'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `warning_class_id` CHAR(40) not null comment '要注意区分'
  , `detail_output_class_id` CHAR(40) not null comment '明細書出力区分'
  , `cover_letter_print_flag` TINYINT default 0 not null comment '請求明細書送付時の送状出力フラグ'
  , `summary_output_class_id` CHAR(40) not null comment '総括表出力区分'
  , `payment_dicision_info_class_id` CHAR(40) not null comment '支払決定通知区分'
  , `delivery_class_id` CHAR(40) not null comment '宅配区分'
  , `together_flag` TINYINT default 0 not null comment 'あきは合算フラグ'
  , `ahq_repay_flag` TINYINT default 0 not null comment '鍼灸償還払区分:0：鍼灸償還払い対象外、1:鍼灸償還払い対象'
  , `ahq_repay_start_date` DATE default '1900-1-1' not null comment '鍼灸償還払開始年月日'
  , `federation_flag` TINYINT default 0 not null comment '後期高齢者広域連合会フラグ:後期高齢者医療広域連合会（都道府県レベル）の場合'
  , `move_flag` TINYINT default 0 not null comment '移管フラグ'
  , `move_insurer_id` CHAR(40) comment '移管先保険者ID'
  , `move_start_date` DATE default '1900-1-1' not null comment '移管適用開始日'
  , `move_end_date` DATE default '1900-1-1' not null comment '移管適用終了日'
  , `mark_no` TEXT default '' not null comment '記号番号:決まった記号番号がある場合'
  , `receipt_cycle` INT default 0 not null comment '入金サイクル:日単位'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `INSR0001_PKC` primary key (`rid`)
) comment '保険者マスタ' ;

-- 会員口座用途マスタ
drop table if exists `MBAC0010` cascade;

create table `MBAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '会員口座ID'
  , `use_class_id` TEXT default '' not null comment '口座用途区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `change_date` DATE default '1900-1-1' not null comment '状態異動日'
  , `reason_class_id` TEXT default '' not null comment '口座異動理由区分:1: 口座変更、2: 口座廃止、9: その他'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBAC0010_PKC` primary key (`rid`)
) comment '会員口座用途マスタ' ;

-- 会員役員情報
drop table if exists `MBSP0060` cascade;

create table `MBSP0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `representative_id` CHAR(40) not null comment '会員総代ID'
  , `officer_class_id` CHAR(40) not null comment '役員区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0060_PKC` primary key (`rid`)
) comment '会員役員情報' ;

-- 会員資格情報
drop table if exists `MBSP0010` cascade;

create table `MBSP0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `member_class_id` CHAR(40) not null comment '会員種別区分:1: 全柔協柔整会員、2: 全柔協鍼灸会員、3: 大鍼協通常会員､4:大鍼協準会員'
  , `prefecture_no` VARCHAR(255) default '' not null comment '都道府県番号'
  , `memmber_class_no` VARCHAR(255) default '' not null comment '会員種別番号'
  , `membership_no` VARCHAR(255) default 0 not null comment '会員番号'
  , `enter_course_date` DATE default '1900-1-1' not null comment '入会講習日'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0010_PKC` primary key (`rid`)
) comment '会員資格情報' ;

-- 会員マスタ
drop table if exists `MBSP0001` cascade;

create table `MBSP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `id` CHAR(40) not null comment 'ID'
  , `revision` INT UNSIGNED not null comment 'リビジョン'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `last_kana` TEXT default '' not null comment '会員カナ苗字:半角'
  , `first_kana` TEXT default '' not null comment '会員カナ名前:半角'
  , `last_name` TEXT default '' not null comment '会員苗字:全角'
  , `first_name` TEXT default '' not null comment '会員名前:全角'
  , `birthday` DATE default '1800-1-1' not null comment '生年月日'
  , `sex_class_id` CHAR(40) not null comment '性別区分:1: 男、2: 女'
  , `school_name` TEXT default '' not null comment '出身校'
  , `die_date` DATE default '1900-1-1' not null comment '死亡年月日'
  , `osteopathic_license_no` TEXT default '' not null comment '柔整師免許番号'
  , `acupuncturists_license_no` TEXT default '' not null comment '鍼師免許番号'
  , `moxibustion_license_no` TEXT default '' not null comment '灸師免許番号'
  , `massage_license_no` TEXT default '' not null comment 'あん摩マツサージ指圧免許番号'
  , `postal_code` TINYTEXT default '' not null comment '郵便番号'
  , `address_pref` TEXT default '' not null comment '都道府県'
  , `address_city` TEXT default '' not null comment '市区町村'
  , `address_town` TEXT default '' not null comment '町域'
  , `address_street` TEXT default '' not null comment '番地・マンション'
  , `address_pref_kana` TEXT default '' not null comment '都道府県カナ'
  , `address_city_kana` TEXT default '' not null comment '市区町村カナ'
  , `address_town_kana` TEXT default '' not null comment '町域カナ'
  , `address_street_kana` TEXT default '' not null comment '番地・マンションカナ'
  , `phone_no` TINYTEXT default '' not null comment '電話番号'
  , `search_phone_no` TEXT default '' not null comment '検索用電話番号:ハイフンなし'
  , `phone_no_2` TINYTEXT default '' not null comment '第２電話番号'
  , `search_phone_no_2` TEXT default '' not null comment '検索用第２電話番号:ハイフンなし'
  , `mobile_phone_no` TINYTEXT default '' not null comment '携帯番号'
  , `search_mobile_phone_no` TEXT default '' not null comment '検索用携帯番号:ハイフンなし'
  , `fax_no` TINYTEXT default '' not null comment 'ファックス番号'
  , `home_page` TINYTEXT default '' not null comment 'ホームページ'
  , `mail_address` VARCHAR(255) default '' not null comment 'メールアドレス'
  , `fix_flag` TINYINT default 0 not null comment '確定フラグ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MBSP0001_PKC` primary key (`rid`)
) comment '会員マスタ' ;

-- レセプトエラー区分マスタ
drop table if exists `CNAM0126` cascade;

create table `CNAM0126` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプトエラー区分値'
  , `name` TEXT default '' not null comment 'レセプトエラー区分名'
  , `short_name` TEXT default '' not null comment 'レセプトエラー区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0126_PKC` primary key (`rid`)
) comment 'レセプトエラー区分マスタ' ;

-- 保険者種別区分マスタ
drop table if exists `CNAM0016` cascade;

create table `CNAM0016` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '保険者種別区分値'
  , `name` TEXT default '' not null comment '保険者種別区分名'
  , `short_name` TEXT default '' not null comment '保険者種別区分略称'
  , `short_name2` TEXT not null comment '保険者種別区分略称2'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0016_PKC` primary key (`rid`)
) comment '保険者種別区分マスタ' ;

-- 医療保険制度区分マスタ
drop table if exists `CNAM0093` cascade;

create table `CNAM0093` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '医療保険制度区分値'
  , `name` TEXT default '' not null comment '医療保険制度区分名'
  , `short_name` TEXT default '' not null comment '医療保険制度区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0093_PKC` primary key (`rid`)
) comment '医療保険制度区分マスタ' ;

-- 本人家族区分マスタ
drop table if exists `CNAM0092` cascade;

create table `CNAM0092` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '本人家族区分値'
  , `name` TEXT default '' not null comment '本人家族区分名'
  , `short_name` TEXT default '' not null comment '本人家族区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0092_PKC` primary key (`rid`)
) comment '本人家族区分マスタ' ;

-- 精算状態区分マスタ
drop table if exists `CNAM0074` cascade;

create table `CNAM0074` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '精算状態区分値'
  , `name` TEXT default '' not null comment '精算状態区分名'
  , `short_name` TEXT default '' not null comment '精算状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0074_PKC` primary key (`rid`)
) comment '精算状態区分マスタ' ;

-- 傷病発生状態区分マスタ
drop table if exists `CNAM0070` cascade;

create table `CNAM0070` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '傷病発生状態区分値'
  , `name` TEXT default '' not null comment '傷病発生状態区分名'
  , `short_name` TEXT default '' not null comment '傷病発生状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0070_PKC` primary key (`rid`)
) comment '傷病発生状態区分マスタ' ;

-- 往診加算区分マスタ
drop table if exists `CNAM0072` cascade;

create table `CNAM0072` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '往診加算区分値'
  , `name` TEXT default '' not null comment '往診加算区分名'
  , `short_name` TEXT default '' not null comment '往診加算区分略称'
  , `start_time` TIME not null comment '適用開始時間'
  , `end_time` TIME not null comment '適用終了時間'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0072_PKC` primary key (`rid`)
) comment '往診加算区分マスタ' ;

-- 柔整労災料金パターンマスタ
drop table if exists `SBWC0001` cascade;

create table `SBWC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_name` TEXT default '' not null comment 'パターン名'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBWC0001_PKC` primary key (`rid`)
) comment '柔整労災料金パターンマスタ' ;

-- 柔整労災申請情報
drop table if exists `RCWC0001` cascade;

create table `RCWC0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `office_revision` INT UNSIGNED not null comment '施術所リビジョン'
  , `membership_no` TEXT default '' not null comment '会員番号'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `membership_revision` INT UNSIGNED not null comment '会員リビジョン'
  , `seq_no` INT default 0 not null comment '会員別連番'
  , `patient_id` CHAR(40) not null comment '患者ID'
  , `patient_hist_id` CHAR(40) not null comment '患者履歴ID'
  , `karte_no` TEXT not null comment 'カルテ番号'
  , `occur_id` CHAR(40) not null comment '傷病発生ID'
  , `work_insurance_class_id` CHAR(40) not null comment '労災保険種別区分'
  , `subject_pattern_id` CHAR(40) not null comment '柔整労災料金パターンID'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `application_month` DATE default 0 not null comment '請求年月:yyyy/mm/01'
  , `treatment_month` DATE not null comment '施術年月:yyyy/mm/01'
  , `create_no` INT default 0 not null comment '作成番号'
  , `start_date` DATE default '1900-1-1' not null comment '対象開始日'
  , `end_date` DATE default '9999-12-31' not null comment '対象終了日'
  , `report_date` DATETIME default '1900-1-1' not null comment '申請書作成日'
  , `application_date` DATE default '1900-1-1' not null comment '申請日'
  , `work_insurance_no` TEXT default '' not null comment '労働保険番号'
  , `office_code` TEXT default '' not null comment '施術機関コード'
  , `office_code_id` CHAR(40) not null comment '施術機関コードID'
  , `labor_authority_no` TEXT not null comment '労働局番号'
  , `labor_authority_id` CHAR(40) comment '労働局ID'
  , `patient_last_kana` TEXT default '' not null comment '患者カナ苗字:半角'
  , `patient_first_kana` TEXT default '' not null comment '患者カナ名前:半角'
  , `patient_last_name` TEXT default '' not null comment '患者苗字:全角'
  , `patient_first_name` TEXT default '' not null comment '患者名前:全角'
  , `patient_sex_class_id` CHAR(40) not null comment '患者性別区分:1:男、2:女'
  , `patient_postal_code` TINYTEXT default '' not null comment '患者郵便番号'
  , `patient_address_pref` TEXT default '' not null comment '患者都道府県'
  , `patient_address_city` TEXT default '' not null comment '患者市区町村'
  , `patient_address_town` TEXT default '' not null comment '患者町域'
  , `patient_address_street` TEXT default '' not null comment '患者団地・マンション'
  , `patient_birthday` DATE default '1800-1-1' not null comment '患者生年月日'
  , `occupation` TEXT default '' not null comment '患者の職種'
  , `attend_days` CHAR(31) default '' not null comment '通院日:1カラムが１日を表す 1:通院'
  , `house_visit_days` CHAR(31) default ’’ not null comment '往診日:1カラムが１日を表す 1:往療'
  , `all_treatment_days` INT default 0 not null comment '延日数'
  , `treatment_days` INT default 0 not null comment '実日数'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '請求金額'
  , `sign_date` DATE default '1900-1-1' not null comment 'サイン受領日'
  , `charge_class_id` CHAR(40) not null comment '請求区分:1:新規、2:継続'
  , `factor_class_id` CHAR(40) not null comment '負傷要因区分'
  , `symptom` TEXT default '' not null comment '傷病の経過の概要'
  , `complete_flag` TINYINT default 0 not null comment '完了フラグ:0:施術中,1:施術完了(1患者の最新の労災レセプトの転帰≠0:継続の時、過去すべてのレコードに1:施術完了がセットされる。)'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0001_PKC` primary key (`rid`)
) comment '柔整労災申請情報' ;

-- 鍼灸労災申請エラー情報
drop table if exists `RCWC0140` cascade;

create table `RCWC0140` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マ労災申請ID'
  , `receipt_injury_id` CHAR(40) not null comment '鍼灸マ労災傷病ID'
  , `error_class_id` CHAR(40) not null comment 'エラー区分'
  , `error_id` CHAR(40) not null comment 'エラーID'
  , `content` TEXT default '' not null comment 'エラー内容'
  , `comment` TEXT default '' not null comment 'コメント'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0140_PKC` primary key (`rid`)
) comment '鍼灸労災申請エラー情報' ;

-- 柔整労災傷病情報
drop table if exists `RCWC0010` cascade;

create table `RCWC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整労災申請ID'
  , `injury_site_id` CHAR(40) not null comment '患者柔整傷病ID:初検料、再検料等は０を設定'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '請求金額'
  , `injury_code` TEXT default '' not null comment '負傷コード'
  , `injury_name` TEXT default '' not null comment '負傷名'
  , `cause` TEXT default '' not null comment '負傷原因'
  , `first_date` DATE default '1900-1-1' not null comment '初検日'
  , `first_time` INT default 0 not null comment '初検時間'
  , `injury_date` DATE default '1900-1-1' not null comment '負傷日'
  , `start_date` DATE default '1900-1-1' not null comment '施術開始日'
  , `end_date` DATE default '1900-1-1' not null comment '施術終了日'
  , `treatment_days` INT default 0 not null comment '実日数'
  , `all_treatment_days` INT default 0 not null comment '延日数'
  , `outcome_class_id` CHAR(40) not null comment '転帰区分'
  , `treatment_content` TEXT default '' not null comment '療養内容'
  , `progress` TEXT default '' not null comment '傷病の経過の概要'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0010_PKC` primary key (`rid`)
) comment '柔整労災傷病情報' ;

-- 鍼灸労災対象施術情報
drop table if exists `RCWC0130` cascade;

create table `RCWC0130` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_detail_id` CHAR(40) not null comment '鍼灸マ労災傷病ID'
  , `treatment_id` CHAR(40) not null comment '鍼灸マ施術ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0130_PKC` primary key (`rid`)
) comment '鍼灸労災対象施術情報' ;

-- 柔整労災対象施術情報
drop table if exists `RCWC0030` cascade;

create table `RCWC0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_detail_id` CHAR(40) not null comment '柔整労災傷病ID'
  , `treatment_id` CHAR(40) not null comment '柔整施術ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0030_PKC` primary key (`rid`)
) comment '柔整労災対象施術情報' ;

-- 鍼灸労災科目集計情報
drop table if exists `RCWC0120` cascade;

create table `RCWC0120` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マ労災申請ID'
  , `receipt_subject_class_id` CHAR(40) not null comment '鍼灸マ労災科目区分'
  , `receipt_injury_id` CHAR(40) comment '鍼灸マ労災傷病ID'
  , `unit_count` INT default 0 not null comment '部位数・往療距離:変形徒手矯正術の時の部位数、往療の時の距離'
  , `price` DECIMAL(13,2) default 0 not null comment '単価'
  , `count` INT default 0 not null comment '回数'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険金額'
  , `part_amount` DECIMAL(13,2) default 0 not null comment '一部負担金'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0120_PKC` primary key (`rid`)
) comment '鍼灸労災科目集計情報' ;

-- 鍼灸労災傷病情報
drop table if exists `RCWC0110` cascade;

create table `RCWC0110` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マ労災申請ID'
  , `injury_site_id` CHAR(40) not null comment '患者鍼灸マ傷病ID:初検料、再検料等は０を設定'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '請求金額'
  , `injury_code` TEXT default '' not null comment '負傷コード'
  , `injury_name` TEXT default '' not null comment '負傷名'
  , `cause` TEXT default '' not null comment '負傷原因'
  , `first_date` DATE default '1900-1-1' not null comment '初検日'
  , `first_time` INT default 0 not null comment '初検時間'
  , `injury_date` DATE default '1900-1-1' not null comment '負傷日'
  , `start_date` DATE default '1900-1-1' not null comment '施術開始日'
  , `end_date` DATE default '1900-1-1' not null comment '施術終了日'
  , `treatment_days` INT default 0 not null comment '実日数'
  , `all_treatment_days` INT default 0 not null comment '延日数'
  , `outcome_class_id` CHAR(40) not null comment '転帰区分'
  , `treatment_content` TEXT default '' not null comment '療養内容'
  , `progress` TEXT default '' not null comment '傷病の経過の概要'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0110_PKC` primary key (`rid`)
) comment '鍼灸労災傷病情報' ;

-- 柔整労災申請エラー情報
drop table if exists `RCWC0040` cascade;

create table `RCWC0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整労災申請ID'
  , `receipt_injury_id` CHAR(40) not null comment '柔整労災傷病ID'
  , `error_class_id` CHAR(40) not null comment 'エラー区分'
  , `error_id` CHAR(40) not null comment 'エラーID'
  , `content` TEXT default '' not null comment 'エラー内容'
  , `comment` TEXT default '' not null comment 'コメント'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0040_PKC` primary key (`rid`)
) comment '柔整労災申請エラー情報' ;

-- 柔整労災科目集計情報
drop table if exists `RCWC0020` cascade;

create table `RCWC0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '柔整労災申請ID'
  , `receipt_subject_class_id` CHAR(40) not null comment '柔整労災科目区分'
  , `receipt_injury_id` CHAR(40) comment '柔整労災傷病ID'
  , `unit_count` INT default 0 not null comment '部位数・往療距離:変形徒手矯正術の時の部位数、往療の時の距離'
  , `price` DECIMAL(13,2) default 0 not null comment '単価'
  , `count` INT default 0 not null comment '回数'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険金額'
  , `part_amount` DECIMAL(13,2) default 0 not null comment '一部負担金'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0020_PKC` primary key (`rid`)
) comment '柔整労災科目集計情報' ;

-- 鍼灸マ労災申請情報
drop table if exists `RCWC0101` cascade;

create table `RCWC0101` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `office_revision` INT UNSIGNED not null comment '施術所リビジョン'
  , `membership_no` TEXT default '' not null comment '会員番号'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `membership_revision` INT UNSIGNED not null comment '会員リビジョン'
  , `seq_no` INT default 0 not null comment '会員別連番'
  , `patient_id` CHAR(40) not null comment '患者ID'
  , `patient_hist_id` CHAR(40) not null comment '患者履歴ID'
  , `karte_no` TEXT not null comment 'カルテ番号'
  , `occur_id` CHAR(40) not null comment '傷病発生ID'
  , `work_insurance_class_id` CHAR(40) not null comment '労災保険種別区分'
  , `subject_pattern_id` CHAR(40) not null comment '鍼灸マ労災料金パターンID'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `application_month` DATE default 0 not null comment '請求年月:yyyy/mm/01'
  , `treatment_month` DATE not null comment '施術年月:yyyy/mm/01'
  , `create_no` INT default 0 not null comment '作成番号'
  , `start_date` DATE default '1900-1-1' not null comment '対象開始日'
  , `end_date` DATE default '9999-12-31' not null comment '対象終了日'
  , `report_date` DATETIME default '1900-1-1' not null comment '申請書作成日'
  , `application_date` DATE default '1900-1-1' not null comment '申請日'
  , `work_insurance_no` TEXT default '' not null comment '労働保険番号'
  , `office_code` TEXT default '' not null comment '施術機関コード'
  , `office_code_id` CHAR(40) not null comment '施術機関コードID'
  , `labor_authority_no` TEXT not null comment '労働局番号'
  , `labor_authority_id` CHAR(40) comment '労働局ID'
  , `patient_last_kana` TEXT default '' not null comment '患者カナ苗字:半角'
  , `patient_first_kana` TEXT default '' not null comment '患者カナ名前:半角'
  , `patient_last_name` TEXT default '' not null comment '患者苗字:全角'
  , `patient_first_name` TEXT default '' not null comment '患者名前:全角'
  , `patient_sex_class_id` CHAR(40) not null comment '患者性別区分:1:男、2:女'
  , `patient_postal_code` TINYTEXT default '' not null comment '患者郵便番号'
  , `patient_address_pref` TEXT default '' not null comment '患者都道府県'
  , `patient_address_city` TEXT default '' not null comment '患者市区町村'
  , `patient_address_town` TEXT default '' not null comment '患者町域'
  , `patient_address_street` TEXT default '' not null comment '患者団地・マンション'
  , `patient_birthday` DATE default '1800-1-1' not null comment '患者生年月日'
  , `occupation` TEXT default '' not null comment '患者の職種'
  , `attend_days` CHAR(31) default '' not null comment '通院日:1カラムが１日を表す 1:通院'
  , `house_visit_days` CHAR(31) default ’’ not null comment '往診日:1カラムが１日を表す 1:往療'
  , `all_treatment_days` INT default 0 not null comment '延日数'
  , `treatment_days` INT default 0 not null comment '実日数'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '請求金額'
  , `sign_date` DATE default '1900-1-1' not null comment 'サイン受領日'
  , `charge_class_id` CHAR(40) not null comment '請求区分:1:新規、2:継続'
  , `factor_class_id` CHAR(40) not null comment '負傷要因区分'
  , `symptom` TEXT default '' not null comment '傷病の経過の概要'
  , `complete_flag` TINYINT default 0 not null comment '完了フラグ:0:施術中,1:施術完了(1患者の最新の労災レセプトの転帰≠0:継続の時、過去すべてのレコードに1:施術完了がセットされる。)'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCWC0101_PKC` primary key (`rid`)
) comment '鍼灸マ労災申請情報' ;

-- 備考区分マスタ
drop table if exists `CNAM0124` cascade;

create table `CNAM0124` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '備考区分値'
  , `name` TEXT default '' not null comment '備考区分名'
  , `short_name` TEXT default '' not null comment '備考区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0124_PKC` primary key (`rid`)
) comment '備考区分マスタ' ;

-- 治療見込期間単位区分マスタ
drop table if exists `CNAM0085` cascade;

create table `CNAM0085` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '治療見込期間単位区分値'
  , `name` TEXT default '' not null comment '治療見込期間単位区分名'
  , `short_name` TEXT default '' not null comment '治療見込期間単位区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0085_PKC` primary key (`rid`)
) comment '治療見込期間単位区分マスタ' ;

-- あん摩マッサージ評価項目区分マスタ
drop table if exists `CNAM0083` cascade;

create table `CNAM0083` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'あん摩マッサージ評価項目区分値'
  , `name` TEXT default '' not null comment 'あん摩マッサージ評価項目区分名'
  , `short_name` TEXT default '' not null comment 'あん摩マッサージ評価項目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0083_PKC` primary key (`rid`)
) comment 'あん摩マッサージ評価項目区分マスタ' ;

-- あん摩マッサージ評価値区分マスタ
drop table if exists `CNAM0084` cascade;

create table `CNAM0084` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'あん摩マッサージ評価値区分値'
  , `name` TEXT default '' not null comment 'あん摩マッサージ評価値区分名'
  , `short_name` TEXT default '' not null comment 'あん摩マッサージ評価値区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0084_PKC` primary key (`rid`)
) comment 'あん摩マッサージ評価値区分マスタ' ;

-- 初検加算区分マスタ
drop table if exists `CNAM0047` cascade;

create table `CNAM0047` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '初検加算区分値'
  , `name` TEXT default '' not null comment '初検加算区分名'
  , `short_name` TEXT default '' not null comment '初検加算区分略称'
  , `start_time` TIME not null comment '適用開始時間'
  , `end_time` TIME not null comment '適用終了時間'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0047_PKC` primary key (`rid`)
) comment '初検加算区分マスタ' ;

-- 柔整評価項目区分マスタ
drop table if exists `CNAM0046` cascade;

create table `CNAM0046` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整評価項目区分値'
  , `name` TEXT default '' not null comment '柔整評価項目区分名'
  , `short_name` TEXT default '' not null comment '柔整評価項目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0046_PKC` primary key (`rid`)
) comment '柔整評価項目区分マスタ' ;

-- 許可番号区分マスタ
drop table if exists `CNAM0049` cascade;

create table `CNAM0049` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '許可番号区分値'
  , `name` TEXT default '' not null comment '許可番号区分名'
  , `short_name` TEXT default '' not null comment '許可番号区分略称'
  , `organ_class_id` CHAR(40) not null comment '発行先区分:1: 厚生局､2:共済､3:地方共済、4:防衛省、5:労災､6:国保連等(機関番号)'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0049_PKC` primary key (`rid`)
) comment '許可番号区分マスタ' ;

-- 鍼灸マ自賠責科目区分マスタ
drop table if exists `CNAM0121` cascade;

create table `CNAM0121` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸マ自賠責科目区分値'
  , `name` TEXT default '' not null comment '鍼灸マ自賠責科目区分名'
  , `short_name` TEXT default '' not null comment '鍼灸マ自賠責科目区分略称'
  , `department_type` INT default 0 not null comment '診療科種別:0: 共通、1:鍼灸のみ、2:あん摩・マッサージのみ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0121_PKC` primary key (`rid`)
) comment '鍼灸マ自賠責科目区分マスタ' ;

-- 柔整自賠責科目区分マスタ
drop table if exists `CNAM0120` cascade;

create table `CNAM0120` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整自賠責科目区分値'
  , `name` TEXT default '' not null comment '柔整自賠責科目区分名'
  , `short_name` TEXT default '' not null comment '柔整自賠責科目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0120_PKC` primary key (`rid`)
) comment '柔整自賠責科目区分マスタ' ;

-- 鍼灸マ労災科目区分マスタ
drop table if exists `CNAM0118` cascade;

create table `CNAM0118` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸マ労災科目区分値'
  , `name` TEXT default '' not null comment '鍼灸マ労災科目区分名'
  , `short_name` TEXT default '' not null comment '鍼灸マ労災科目区分略称'
  , `department_type` INT default 0 not null comment '診療科種別:0: 共通、1:鍼灸のみ、2:あん摩・マッサージのみ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0118_PKC` primary key (`rid`)
) comment '鍼灸マ労災科目区分マスタ' ;

-- 柔整労災科目区分マスタ
drop table if exists `CNAM0117` cascade;

create table `CNAM0117` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整労災科目区分値'
  , `name` TEXT default '' not null comment '柔整労災科目区分名'
  , `short_name` TEXT default '' not null comment '柔整労災科目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0117_PKC` primary key (`rid`)
) comment '柔整労災科目区分マスタ' ;

-- 障害者種別区分マスタ
drop table if exists `CNAM0060` cascade;

create table `CNAM0060` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '障害者種別区分値'
  , `name` TEXT default '' not null comment '障害者種別区分名'
  , `short_name` TEXT default '' not null comment '障害者種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0060_PKC` primary key (`rid`)
) comment '障害者種別区分マスタ' ;

-- 鍼灸マ科目区分マスタ
drop table if exists `CNAM0103` cascade;

create table `CNAM0103` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸マ科目区分値'
  , `name` TEXT default '' not null comment '鍼灸マ科目区分名'
  , `short_name` TEXT default '' not null comment '鍼灸マ科目区分略称'
  , `department_type` INT default 0 not null comment '診療科種別:0: 共通、1:鍼灸のみ、2:あん摩・マッサージのみ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0103_PKC` primary key (`rid`)
) comment '鍼灸マ科目区分マスタ' ;

-- 外出区分マスタ
drop table if exists `CNAM0105` cascade;

create table `CNAM0105` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '外出区分値'
  , `name` TEXT default '' not null comment '外出区分名'
  , `short_name` TEXT default '' not null comment '外出区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0105_PKC` primary key (`rid`)
) comment '外出区分マスタ' ;

-- 鍼灸マレセプト科目区分マスタ
drop table if exists `CNAM0107` cascade;

create table `CNAM0107` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸マレセプト科目区分値'
  , `name` TEXT default '' not null comment '鍼灸マレセプト科目区分名'
  , `short_name` TEXT default '' not null comment '鍼灸マレセプト科目区分略称'
  , `department_type` INT default 0 not null comment '診療科種別:0: 共通、1:鍼灸のみ、2:あん摩・マッサージのみ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0107_PKC` primary key (`rid`)
) comment '鍼灸マレセプト科目区分マスタ' ;

-- 鍼灸施術内容区分マスタ
drop table if exists `CNAM0087` cascade;

create table `CNAM0087` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸施術内容区分値'
  , `name` TEXT default '' not null comment '鍼灸施術内容区分名'
  , `short_name` TEXT default '' not null comment '鍼灸施術内容区分略称'
  , `other_input_flag` TINYINT default 0 not null comment 'その他入力フラグ'
  , `group_class` INT default 0 not null comment 'グループ区分:1:鍼のみ、2:灸のみ、3:鍼灸、9:その他'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0087_PKC` primary key (`rid`)
) comment '鍼灸施術内容区分マスタ' ;

-- あん摩マッサージ施術内容区分マスタ
drop table if exists `CNAM0088` cascade;

create table `CNAM0088` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'あん摩マッサージ施術内容区分値'
  , `name` TEXT default '' not null comment 'あん摩マッサージ施術内容区分名'
  , `short_name` TEXT default '' not null comment 'あん摩マッサージ施術内容区分略称'
  , `other_input_flag` TINYINT default 0 not null comment 'その他入力フラグ'
  , `group_class` INT default 0 not null comment 'グループ区分:1:マッサージ、2:変形徒手矯正術、9:その他'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0088_PKC` primary key (`rid`)
) comment 'あん摩マッサージ施術内容区分マスタ' ;

-- 鍼灸傷病区分マスタ
drop table if exists `CNAM0020` cascade;

create table `CNAM0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸傷病区分値'
  , `name` TEXT default '' not null comment '鍼灸傷病区分名'
  , `short_name` TEXT default '' not null comment '鍼灸傷病区分略称'
  , `input_flag` TINYINT default 0 not null comment '入力フラグ:1: 入力フラグ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0020_PKC` primary key (`rid`)
) comment '鍼灸傷病区分マスタ' ;

-- 長期理由種別区分マスタ
drop table if exists `CNAM0080` cascade;

create table `CNAM0080` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '長期理由種別区分値'
  , `name` TEXT default '' not null comment '長期理由種別区分名'
  , `short_name` TEXT default '' not null comment '長期理由種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0080_PKC` primary key (`rid`)
) comment '長期理由種別区分マスタ' ;

-- マッサージ施術種別区分マスタ
drop table if exists `CNAM0078` cascade;

create table `CNAM0078` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'マッサージ施術種別区分値'
  , `name` TEXT default '' not null comment 'マッサージ施術種別区分名'
  , `short_name` TEXT default '' not null comment 'マッサージ施術種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0078_PKC` primary key (`rid`)
) comment 'マッサージ施術種別区分マスタ' ;

-- 転帰区分マスタ
drop table if exists `CNAM0071` cascade;

create table `CNAM0071` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '転帰区分値'
  , `name` TEXT default '' not null comment '転帰区分名'
  , `short_name` TEXT default '' not null comment '転帰区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0071_PKC` primary key (`rid`)
) comment '転帰区分マスタ' ;

-- 前月からの改善状態区分マスタ
drop table if exists `CNAM0081` cascade;

create table `CNAM0081` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '前月からの改善状態区分値'
  , `name` TEXT default '' not null comment '前月からの改善状態区分名'
  , `short_name` TEXT default '' not null comment '前月からの改善状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0081_PKC` primary key (`rid`)
) comment '前月からの改善状態区分マスタ' ;

-- 証明書区分マスタ
drop table if exists `CNAM0079` cascade;

create table `CNAM0079` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '証明書区分値'
  , `name` TEXT default '' not null comment '証明書区分名'
  , `short_name` TEXT default '' not null comment '証明書区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0079_PKC` primary key (`rid`)
) comment '証明書区分マスタ' ;

-- 同意書種別区分マスタ
drop table if exists `CNAM0076` cascade;

create table `CNAM0076` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '同意書種別区分値'
  , `name` TEXT default '' not null comment '同意書種別区分名'
  , `short_name` TEXT default '' not null comment '同意書種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0076_PKC` primary key (`rid`)
) comment '同意書種別区分マスタ' ;

-- 柔整通院間隔区分マスタ
drop table if exists `CNAM0089` cascade;

create table `CNAM0089` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整通院間隔区分値'
  , `name` TEXT default '' not null comment '柔整通院間隔区分名'
  , `short_name` TEXT default '' not null comment '柔整通院間隔区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0089_PKC` primary key (`rid`)
) comment '柔整通院間隔区分マスタ' ;

-- 通院間隔単位区分マスタ
drop table if exists `CNAM0090` cascade;

create table `CNAM0090` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '通院間隔単位区分値'
  , `name` TEXT default '' not null comment '通院間隔単位区分名'
  , `short_name` TEXT default '' not null comment '通院間隔単位区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0090_PKC` primary key (`rid`)
) comment '通院間隔単位区分マスタ' ;

-- 柔整施術内容区分マスタ
drop table if exists `CNAM0086` cascade;

create table `CNAM0086` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整施術内容区分値'
  , `name` TEXT default '' not null comment '柔整施術内容区分名'
  , `short_name` TEXT default '' not null comment '柔整施術内容区分略称'
  , `other_input_flag` TINYINT default 0 not null comment 'その他入力フラグ'
  , `group_class` INT default 0 not null comment 'グループ区分:1:手技、2:物療、3:特別材料、4:包帯交換、9:その他'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0086_PKC` primary key (`rid`)
) comment '柔整施術内容区分マスタ' ;

-- 鍼灸マ負傷マスタ
drop table if exists `IJPT0002` cascade;

create table `IJPT0002` (
  `rid` CHAR(40) not null comment 'RID'
  , `injury_code` VARCHAR(255) default '' not null comment '負傷コード'
  , `injury_name` TEXT default '' not null comment '負傷名'
  , `injury_class_id` CHAR(40) not null comment '鍼灸傷病区分'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IJPT0002_PKC` primary key (`rid`)
) comment '鍼灸マ負傷マスタ' ;

-- 質問グループマスタ
drop table if exists `QEST0001` cascade;

create table `QEST0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `question_type_class_id` CHAR(40) not null comment '質問種別区分'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日:各施術所で自由に選択する方がよいのかどうかは検討'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `question_group_name` TEXT default '' not null comment '質問グループ名'
  , `comment` TEXT default '' not null comment 'コメント'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `QEST0001_PKC` primary key (`rid`)
) comment '質問グループマスタ' ;

-- 自費診療科目マスタ
drop table if exists `SBIS0301` cascade;

create table `SBIS0301` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0301_PKC` primary key (`rid`)
) comment '自費診療科目マスタ' ;

-- 柔整自賠責料金パターンマスタ
drop table if exists `SBLI0001` cascade;

create table `SBLI0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_name` TEXT default '' not null comment 'パターン名'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `liability_id` CHAR(40) not null comment '自賠責保険会社ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBLI0001_PKC` primary key (`rid`)
) comment '柔整自賠責料金パターンマスタ' ;

-- 柔整労災診療科目負傷部位マスタ
drop table if exists `SBIS0030` cascade;

create table `SBIS0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_id` CHAR(40) not null comment '柔整診療科目ID'
  , `injury_class_id` CHAR(40) not null comment '柔整傷病区分'
  , `part_class_id` CHAR(40) not null comment '柔整部位区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0030_PKC` primary key (`rid`)
) comment '柔整労災診療科目負傷部位マスタ' ;

-- 柔整自賠責診療科目負傷部位マスタ
drop table if exists `SBIS0050` cascade;

create table `SBIS0050` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_id` CHAR(40) not null comment '柔整診療科目ID'
  , `injury_class_id` CHAR(40) not null comment '柔整傷病区分'
  , `part_class_id` CHAR(40) not null comment '柔整部位区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0050_PKC` primary key (`rid`)
) comment '柔整自賠責診療科目負傷部位マスタ' ;

-- 鍼灸マ労災診療科目マスタ
drop table if exists `SBIS0120` cascade;

create table `SBIS0120` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_class_id` CHAR(40) not null comment '鍼灸マ科目区分'
  , `worker_subject_class_id` CHAR(40) not null comment '鍼灸マ労災科目区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `real_flag` TINYINT default 0 not null comment '実費フラグ:1:金額はその時の時価を入力させる場合'
  , `part_flag` TINYINT not null comment '部位単位で算定フラグ:1: 部位単位'
  , `one_day_flag` TINYINT default 0 not null comment '1日1回算定フラグ'
  , `calc_class_id` CHAR(40) not null comment '算定日区分:1: 回目、2: 日目､ 3: 週目、4: 月目、5: 年目'
  , `from_days_count` INT default 0 not null comment '算定開始日数:算定区分の単位での開始数'
  , `to_days_count` INT default 0 not null comment '算定終了日数:算定区分の単位での終了数'
  , `from_distance` INT default 0 not null comment '往療開始距離'
  , `to_distance` INT default 0 not null comment '往療終了距離'
  , `interval_distance` INT default 0 not null comment '往療間隔距離'
  , `reasion_flag` TINYINT default 0 not null comment '摘要理由有無フラグ:1: レセプトで摘要理由が必要である場合'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0120_PKC` primary key (`rid`)
) comment '鍼灸マ労災診療科目マスタ' ;

-- 柔整自賠責診療科目パターンマスタ
drop table if exists `SBLI0010` cascade;

create table `SBLI0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_id` CHAR(40) not null comment '柔整自賠責料金パターンID'
  , `subject_id` CHAR(40) not null comment '柔整診療科目ID'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBLI0010_PKC` primary key (`rid`)
) comment '柔整自賠責診療科目パターンマスタ' ;

-- 鍼灸マ労災診療科目パターンマスタ
drop table if exists `SBWC0030` cascade;

create table `SBWC0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_id` CHAR(40) not null comment '鍼灸マ労災料金パターンID:自賠責保険共通の場合は0'
  , `subject_id` CHAR(40) not null comment '鍼灸マ診療科目ID'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBWC0030_PKC` primary key (`rid`)
) comment '鍼灸マ労災診療科目パターンマスタ' ;

-- 鍼灸マ自賠責診療科目パターンマスタ
drop table if exists `SBLI0030` cascade;

create table `SBLI0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_id` CHAR(40) not null comment '鍼灸マ自賠責料金パターンID'
  , `subject_id` CHAR(40) not null comment '鍼灸マ診療科目ID'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBLI0030_PKC` primary key (`rid`)
) comment '鍼灸マ自賠責診療科目パターンマスタ' ;

-- 鍼灸マ保険診療科目マスタ
drop table if exists `SBIS0101` cascade;

create table `SBIS0101` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `department_class_id` CHAR(40) not null comment '診療科目区分'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_class_id` CHAR(40) not null comment '鍼灸マ科目区分'
  , `receipt_subject_class_id` CHAR(40) not null comment '鍼灸マレセプト科目区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `real_flag` TINYINT default 0 not null comment '実費フラグ:1:金額はその時の時価を入力させる場合'
  , `part_flag` TINYINT default 0 not null comment '部位単位で算定フラグ'
  , `one_day_flag` TINYINT default 0 not null comment '1日1回算定フラグ'
  , `calc_class_id` CHAR(40) not null comment '算定日区分:1: 回目、2: 日目､ 3: 週目、4: 月目、5: 年目'
  , `from_days_count` INT default 0 not null comment '算定開始日数:算定区分の単位での開始数'
  , `to_days_count` INT default 0 not null comment '算定終了日数:算定区分の単位での終了数'
  , `from_distance` INT default 0 not null comment '往療開始距離'
  , `to_distance` INT default 0 not null comment '往療終了距離'
  , `interval_distance` INT default 0 not null comment '往療間隔距離'
  , `reasion_flag` TINYINT default 0 not null comment '摘要理由有無フラグ:1: レセプトで摘要理由が必要である場合'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0101_PKC` primary key (`rid`)
) comment '鍼灸マ保険診療科目マスタ' ;

-- 柔整診療科目負傷部位マスタ
drop table if exists `SBIS0010` cascade;

create table `SBIS0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_id` CHAR(40) not null comment '柔整診療科目ID'
  , `injury_class_id` CHAR(40) not null comment '柔整傷病区分'
  , `part_class_id` CHAR(40) not null comment '柔整部位区分'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0010_PKC` primary key (`rid`)
) comment '柔整診療科目負傷部位マスタ' ;

-- 柔整労災診療科目パターンマスタ
drop table if exists `SBWC0010` cascade;

create table `SBWC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `pattern_id` CHAR(40) not null comment '柔整労災料金パターンID:自賠責保険共通の場合は0'
  , `subject_id` CHAR(40) not null comment '柔整診療科目ID'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBWC0010_PKC` primary key (`rid`)
) comment '柔整労災診療科目パターンマスタ' ;

-- 柔整保険診療科目マスタ
drop table if exists `SBIS0001` cascade;

create table `SBIS0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_class_id` CHAR(40) not null comment '柔整科目区分'
  , `receipt_subject_class_id` CHAR(40) not null comment '柔整レセプト科目区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `real_flag` TINYINT default 0 not null comment '実費フラグ:1:金額変更可'
  , `regressive_flag` TINYINT default 0 not null comment '逓減対象フラグ'
  , `part_flag` TINYINT default 0 not null comment '部位単位で算定フラグ:1: 部位単位'
  , `one_day_flag` TINYINT default 0 not null comment '1日1回算定フラグ'
  , `calc_class_id` CHAR(40) not null comment '算定日区分:1: 回目、2: 日目､ 3: 週目、4: 月目、5: 年目'
  , `from_days_count` INT default 0 not null comment '算定開始日数:算定区分の単位での開始数'
  , `to_days_count` INT default 0 not null comment '算定終了日数:算定区分の単位での終了数'
  , `from_part_count` INT default 0 not null comment '算定開始部位数'
  , `to_part_count` INT default 0 not null comment '算定終了部位数'
  , `first_week_max_count` INT default 0 not null comment '初検週の最大回数:初検日が含まれる週の最大回数'
  , `first_month_max_count` INT default 0 not null comment '初検月の最大回数:初検日が含まれる月の最大回数'
  , `week_max_count` INT default 0 not null comment '週の最大回数'
  , `month_max_count` INT default 0 not null comment '月の最大回数'
  , `max_count` INT default 0 not null comment '合計最大回数'
  , `from_distance` INT default 0 not null comment '往療開始距離'
  , `to_distance` INT default 0 not null comment '往療終了距離'
  , `interval_distance` INT default 0 not null comment '往療間隔距離'
  , `reasion_flag` TINYINT default 0 not null comment '摘要理由有無フラグ:1: レセプトで摘要理由が必要である場合'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0001_PKC` primary key (`rid`)
) comment '柔整保険診療科目マスタ' ;

-- 柔整労災診療科目マスタ
drop table if exists `SBIS0020` cascade;

create table `SBIS0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `special_class_id` CHAR(40) not null comment '特殊区分'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_class_id` CHAR(40) not null comment '柔整科目区分'
  , `worker_subject_class_id` CHAR(40) not null comment '柔整労災科目区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `real_flag` TINYINT default 0 not null comment '実費フラグ:1:金額はその時の時価を入力させる場合'
  , `regressive_flag` TINYINT default 0 not null comment '逓減対象フラグ'
  , `part_flag` TINYINT default 0 not null comment '部位単位で算定フラグ:1: 部位単位'
  , `one_day_flag` TINYINT default 0 not null comment '1日1回算定フラグ'
  , `calc_class_id` CHAR(40) not null comment '算定日区分:1: 回目、2: 日目､ 3: 週目、4: 月目、5: 年目'
  , `from_days_count` INT default 0 not null comment '算定開始日数:算定区分の単位での開始数'
  , `to_days_count` INT default 0 not null comment '算定終了日数:算定区分の単位での終了数'
  , `from_part_count` INT default 0 not null comment '算定開始部位数'
  , `to_part_count` INT default 0 not null comment '算定終了部位数'
  , `first_week_max_count` INT default 0 not null comment '初検週の最大回数:初検日が含まれる週の最大回数'
  , `first_month_max_count` INT default 0 not null comment '初検月の最大回数:初検日が含まれる月の最大回数'
  , `week_max_count` INT default 0 not null comment '週の最大回数'
  , `month_max_count` INT default 0 not null comment '月の最大回数'
  , `max_count` INT default 0 not null comment '合計最大回数'
  , `from_distance` INT default 0 not null comment '往療開始距離'
  , `to_distance` INT default 0 not null comment '往療終了距離'
  , `interval_distance` INT default 0 not null comment '往療間隔距離'
  , `reasion_flag` TINYINT default 0 not null comment '摘要理由有無フラグ:1: レセプトで摘要理由が必要である場合'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0020_PKC` primary key (`rid`)
) comment '柔整労災診療科目マスタ' ;

-- 柔整自賠責診療科目マスタ
drop table if exists `SBIS0040` cascade;

create table `SBIS0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `special_class_id` CHAR(40) not null comment '特殊区分'
  , `subject_code` TEXT not null comment '診療科目コード'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `subject_type_class_id` CHAR(40) not null comment '科目種別区分'
  , `subject_class_id` CHAR(40) not null comment '柔整科目区分'
  , `liability_subject_class_id` CHAR(40) not null comment '柔整自賠責科目区分'
  , `subject_name` TEXT default '' not null comment '診療科目名'
  , `price` DECIMAL(13,2) default 0 not null comment '金額'
  , `real_flag` TINYINT default 0 not null comment '実費フラグ:1:金額はその時の時価を入力させる場合'
  , `regressive_flag` TINYINT default 0 not null comment '逓減対象フラグ'
  , `part_flag` TINYINT default 0 not null comment '部位単位で算定フラグ:1: 部位単位'
  , `one_day_flag` TINYINT default 0 not null comment '1日1回算定フラグ'
  , `calc_class_id` CHAR(40) not null comment '算定日区分:1: 回目、2: 日目､ 3: 週目、4: 月目、5: 年目'
  , `from_days_count` INT default 0 not null comment '算定開始日数:算定区分の単位での開始数'
  , `to_days_count` INT default 0 not null comment '算定終了日数:算定区分の単位での終了数'
  , `from_part_count` INT default 0 not null comment '算定開始部位数'
  , `to_part_count` INT default 0 not null comment '算定終了部位数'
  , `first_week_max_count` INT default 0 not null comment '初検週の最大回数:初検日が含まれる週の最大回数'
  , `first_month_max_count` INT default 0 not null comment '初検月の最大回数:初検日が含まれる月の最大回数'
  , `week_max_count` INT default 0 not null comment '週の最大回数'
  , `month_max_count` INT default 0 not null comment '月の最大回数'
  , `max_count` INT default 0 not null comment '合計最大回数'
  , `from_distance` INT default 0 not null comment '往療開始距離'
  , `to_distance` INT default 0 not null comment '往療終了距離'
  , `interval_distance` INT default 0 not null comment '往療間隔距離'
  , `reasion_flag` TINYINT default 0 not null comment '摘要理由有無フラグ:1: レセプトで摘要理由が必要である場合'
  , `office_id` CHAR(40) not null comment '施術所ID:施術所側で作成した場合のみ'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `SBIS0040_PKC` primary key (`rid`)
) comment '柔整自賠責診療科目マスタ' ;

-- 施術者保険請求マスタ
drop table if exists `OFST0010` cascade;

create table `OFST0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `dept_staff_id` CHAR(40) not null comment '診療科施術担当者ID'
  , `old_insurance_class_id` CHAR(40) not null comment '老健区分:1:率、2:額'
  , `welfare_flag` TINYINT default 0 not null comment '生活保護申請済フラグ:1: 申請済'
  , `welfare_date` DATE default '1900-1-1' not null comment '生活保護申請日'
  , `process_flag` TINYINT default 0 not null comment '明細処理フラグ:明細処理（仕分け）の有無'
  , `receipt_start_date` DATE default '1900-1-1' not null comment '保険請求開始日'
  , `receipt_end_date` DATE default '9999-12-31' not null comment '保険請求終了日'
  , `state_class_id` CHAR(40) not null comment '保険請求状態区分'
  , `package_send_member_id` CHAR(40) not null comment '一括送付先会員ID'
  , `remark` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFST0010_PKC` primary key (`rid`)
) comment '施術者保険請求マスタ' ;

-- 鍼灸マレセプト対象施術情報
drop table if exists `RCPT0130` cascade;

create table `RCPT0130` (
  `rid` CHAR(40) not null comment 'RID'
  , `request_detail_id` CHAR(40) not null comment '鍼灸マレセプト傷病ID'
  , `treatment_id` CHAR(40) not null comment '鍼灸マ施術ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0130_PKC` primary key (`rid`)
) comment '鍼灸マレセプト対象施術情報' ;

-- 鍼灸マレセプト科目集計情報
drop table if exists `RCPT0120` cascade;

create table `RCPT0120` (
  `rid` CHAR(40) not null comment 'RID'
  , `receipt_id` CHAR(40) not null comment '鍼灸マレセプト申請ID'
  , `receipt_subject_class_id` CHAR(40) not null comment '鍼灸マレセプト科目区分'
  , `receipt_injury_id` CHAR(40) comment '鍼灸マレセプト傷病ID'
  , `unit_count` INT default 0 not null comment '部位数・往療距離:変形徒手矯正術の時の部位数、往療の時の距離'
  , `price` DECIMAL(13,2) default 0 not null comment '単価'
  , `count` INT default 0 not null comment '回数'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険金額'
  , `part_amount` DECIMAL(13,2) default 0 not null comment '一部負担金'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0120_PKC` primary key (`rid`)
) comment '鍼灸マレセプト科目集計情報' ;

-- 捻挫部位区分マスタ
drop table if exists `CNAM0022` cascade;

create table `CNAM0022` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '捻挫部位区分値'
  , `name` TEXT default '' not null comment '捻挫部位区分名'
  , `short_name` TEXT default '' not null comment '捻挫部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0022_PKC` primary key (`rid`)
) comment '捻挫部位区分マスタ' ;

-- 計画書種別区分マスタ
drop table if exists `CNAM0116` cascade;

create table `CNAM0116` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '計画書種別区分値'
  , `name` TEXT default '' not null comment '計画書種別区分名'
  , `short_name` TEXT default '' not null comment '計画書種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0116_PKC` primary key (`rid`)
) comment '計画書種別区分マスタ' ;

-- 適用範囲区分マスタ
drop table if exists `CNAM0115` cascade;

create table `CNAM0115` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '適用範囲区分値'
  , `name` TEXT default '' not null comment '適用範囲区分名'
  , `short_name` TEXT default '' not null comment '適用範囲区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0115_PKC` primary key (`rid`)
) comment '適用範囲区分マスタ' ;

-- 施術単位区分マスタ
drop table if exists `CNAM0114` cascade;

create table `CNAM0114` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '施術単位区分値'
  , `name` TEXT default '' not null comment '施術単位区分名'
  , `short_name` TEXT default '' not null comment '施術単位区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0114_PKC` primary key (`rid`)
) comment '施術単位区分マスタ' ;

-- 施術所診療科マスタ
drop table if exists `OFDP0001` cascade;

create table `OFDP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `office_id` CHAR(40) not null comment '施術所ID'
  , `department_class_id` CHAR(40) not null comment '診療科区分'
  , `notify_start_date` DATE default '1900-1-1' not null comment '開設日'
  , `notify_end_date` DATE default '9999-12-31' not null comment '閉設日'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `state_class_id` CHAR(40) not null comment '診療科状態区分:1: 休業、9: 廃業'
  , `stop_reason_class_id` CHAR(40) not null comment '休止理由区分'
  , `close_reason_class_id` CHAR(40) not null comment '廃業理由区分'
  , `receipt_flag` TINYINT default 0 not null comment '保険請求対象フラグ'
  , `am_mon_start_time` TIME default '00:00:00' not null comment '月曜日午前の勤務開始時間'
  , `am_mon_end_time` TIME default '00:00:00' not null comment '月曜日午前の勤務終了時間'
  , `am_tue_start_time` TIME default '00:00:00' not null comment '火曜日午前の勤務開始時間'
  , `am_tue_end_time` TIME default '00:00:00' not null comment '火曜日午前の勤務終了時間'
  , `am_wed_start_time` TIME default '00:00:00' not null comment '水曜日午前の勤務開始時間'
  , `am_wed_end_time` TIME default '00:00:00' not null comment '水曜日午前の勤務終了時間'
  , `am_thu_start_time` TIME default '00:00:00' not null comment '木曜日午前の勤務開始時間'
  , `am_thu_end_time` TIME default '00:00:00' not null comment '木曜日午前の勤務終了時間'
  , `am_fri_start_time` TIME default '00:00:00' not null comment '金曜日午前の勤務開始時間'
  , `am_fri_end_time` TIME default '00:00:00' not null comment '金曜日午前の勤務終了時間'
  , `am_sat_start_time` TIME default '00:00:00' not null comment '土曜日午前の勤務開始時間'
  , `am_sat_end_time` TIME default '00:00:00' not null comment '土曜日午前の勤務終了時間'
  , `am_sun_start_time` TIME default '00:00:00' not null comment '日曜日午前の勤務開始時間'
  , `am_sun_end_time` TIME default '00:00:00' not null comment '日曜日午前の勤務終了時間'
  , `am_hol_start_time` TIME default '00:00:00' not null comment '祝日午後の勤務開始時間'
  , `am_hol_end_time` TIME default '00:00:00' not null comment '祝日午後の勤務終了時間'
  , `pm_mon_start_time` TIME default '00:00:00' not null comment '月曜日午後の勤務開始時間'
  , `pm_mon_end_time` TIME default '00:00:00' not null comment '月曜日午後の勤務終了時間'
  , `pm_tue_start_time` TIME default '00:00:00' not null comment '火曜日午後の勤務開始時間'
  , `pm_tue_end_time` TIME default '00:00:00' not null comment '火曜日午後の勤務終了時間'
  , `pm_wed_start_time` TIME default '00:00:00' not null comment '水曜日午後の勤務開始時間'
  , `pm_wed_end_time` TIME default '00:00:00' not null comment '水曜日午後の勤務終了時間'
  , `pm_thu_start_time` TIME default '00:00:00' not null comment '木曜日午後の勤務開始時間'
  , `pm_thu_end_time` TIME default '00:00:00' not null comment '木曜日午後の勤務終了時間'
  , `pm_fri_start_time` TIME default '00:00:00' not null comment '金曜日午後の勤務開始時間'
  , `pm_fri_end_time` TIME default '00:00:00' not null comment '金曜日午後の勤務終了時間'
  , `pm_sat_start_time` TIME default '00:00:00' not null comment '土曜日午後の勤務開始時間'
  , `pm_sat_end_time` TIME default '00:00:00' not null comment '土曜日午後の勤務終了時間'
  , `pm_sun_start_time` TIME default '00:00:00' not null comment '日曜日午後の勤務開始時間'
  , `pm_sun_end_time` TIME default '00:00:00' not null comment '日曜日午後の勤務終了時間'
  , `pm_hol_start_time` TIME default '00:00:00' not null comment '祝日午後の勤務開始時間'
  , `pm_hol_end_time` TIME default '00:00:00' not null comment '祝日午後の勤務終了時間'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFDP0001_PKC` primary key (`rid`)
) comment '施術所診療科マスタ' ;

-- 採番マスタ
drop table if exists `CNUM0001` cascade;

create table `CNUM0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `number_type` INT default 0 not null comment '採番種別'
  , `current_no` bigint default 0 not null comment '現行番号'
  , `min_no` bigint default 0 not null comment '最少値'
  , `max_no` bigint default 0 not null comment '最大値'
  , `interval` bigint default 1 not null comment '間隔'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNUM0001_PKC` primary key (`rid`)
) comment '採番マスタ' ;

-- 柔整レセプト申請情報
drop table if exists `RCPT0001` cascade;

create table `RCPT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `office_id` CHAR(40) not null comment '施術所ID:会員番号から取得'
  , `office_revision` INT UNSIGNED not null comment '施術所リビジョン'
  , `membership_no` TEXT not null comment '会員番号'
  , `membership_id` CHAR(40) not null comment '会員ID'
  , `membership_revision` INT UNSIGNED not null comment '会員リビジョン'
  , `seq_no` INT default 0 not null comment '会員別連番:明細のソート順'
  , `patient_id` CHAR(40) not null comment '患者ID:施術所システムより'
  , `patient_hist_id` CHAR(40) not null comment '患者履歴ID:施術所システムより'
  , `karte_no` TEXT default '' not null comment 'カルテ番号'
  , `reception_date` DATE default '1900-1-1' not null comment '受付年月日'
  , `application_month` DATE default '1900-1-1' not null comment '請求年月:yyyy/mm/01'
  , `treatment_month` DATE default '1900-1-1' not null comment '施術年月:yyyy/mm/01'
  , `receipt_type` INT default 0 not null comment 'レセプト種別:0:保険、1:医療助成、2:生活保護'
  , `prefecture_class_id` CHAR(40) not null comment '都道府県区分'
  , `start_date` DATE default '1900-1-1' not null comment '対象施術開始日'
  , `end_date` DATE default '9999-12-31' not null comment '対象施術終了日'
  , `report_date` DATETIME default '1900-1-1' not null comment '申請書作成日'
  , `insurance_card_id` CHAR(40) comment '保険証ID:施術所システムより'
  , `insurance_card_hist_id` CHAR(40) comment '保険証履歴ID:施術所システムより'
  , `patient_medical_assist_id` CHAR(40) comment '患者医療助成ID'
  , `life_protection_id` CHAR(40) comment '会員生活保護ID'
  , `osaka_life_protection_id` TEXT default '' not null comment '生活保護大阪市コード:大阪市保険者(項目"大阪市内"=0)のみ管理
区コード(2桁)＋地区コード(2桁)＋ケース(7桁)＋世帯員(2桁)'
  , `receipt_direct_flag` TINYINT default 0 not null comment '生保会員直接入金フラグ:0:保険者大阪市内(全柔協入金)、1:保険者大阪市外(会員直接入金)'
  , `insurer_type` TEXT not null comment '保険者種別'
  , `law_no` TEXT default '' not null comment '法制番号:保険者法制コード(全柔協独自設定)※4'
  , `insurer_no` text default '' not null comment '保険者番号:保険者番号/公費負担者番号(全柔協独自設定)'
  , `insurer_age` TEXT default '' not null comment '保険者番号枝番:保険者番号枝番(全柔協独自設定)
以下の保険者のみ管理
・全国歯科医師国保組合(42-90-093013)の時、Ａ～T
・全国土木建築国民保険組合(42-90-133033)の時、1～9'
  , `insurer_id` CHAR(40) comment '保険者ID'
  , `medical_assist_id` CHAR(40) comment '医療助成ID'
  , `before_insurer_type` TEXT not null comment '修正前保険者種別:修正前の種別(未修正の時、空白)'
  , `before_law_no` TEXT not null comment '修正前法制番号:修正前の法制(未修正の時、空白)'
  , `before_insurer_no` TEXT not null comment '修正前保険者番号:修正前の保険者番号(未修正の時、空白)'
  , `before_insurer_age` TEXT not null comment '修正前保険者番号枝番:修正前の保険者番号枝番(未修正の時、空白)'
  , `before_insurer_id` CHAR(40) comment '修正前保険者ID'
  , `before_patient_medical_assist_id` CHAR(40) comment '修正前医療助成ID'
  , `mark` TEXT default '' not null comment '被保険者記号'
  , `number` TEXT default '' not null comment '被保険者番号'
  , `recipient_no` TEXT default '' not null comment '公費受給者番号'
  , `licence_no` TEXT not null comment '登録記号番号:会員の契約者番号'
  , `office_code` TEXT default '' not null comment '施術機関コード'
  , `office_code_id` CHAR(40) comment '施術機関コードID:施術機関コードより取得'
  , `patient_last_kana` TEXT default '' not null comment '患者カナ苗字:半角（旧システムの場合は氏名は全て含む）'
  , `patient_first_kana` TEXT default '' not null comment '患者カナ名前:半角'
  , `patient_last_name` TEXT default '' not null comment '患者苗字:全角（旧システムの場合は氏名は全て含む）'
  , `patient_first_name` TEXT default '' not null comment '患者名前:全角'
  , `patient_sex_class_id` CHAR(40) not null comment '患者性別区分:1:男、2:女'
  , `patient_postal_code` TINYTEXT default '' not null comment '患者郵便番号'
  , `patient_address_pref` TEXT default '' not null comment '患者都道府県'
  , `patient_address_city` TEXT default '' not null comment '患者市区町村'
  , `patient_address_town` TEXT default '' not null comment '患者町域'
  , `patient_address_street` TEXT default '' not null comment '患者団地・マンション'
  , `patient_birthday` DATE default '1800-1-1' not null comment '患者生年月日'
  , `insured_last_kana` TEXT default '' not null comment '被保険者カナ苗字:半角（旧システムの場合は氏名は全て含む）'
  , `insured_first_kana` TEXT default '' not null comment '被保険者カナ名前:半角'
  , `insured_last_name` TEXT default '' not null comment '被保険者苗字:全角（旧システムの場合は氏名は全て含む）'
  , `insured_first_name` TEXT default '' not null comment '被保険者名前:全角'
  , `insured_sex_class_id` CHAR(40) comment '被保険者性別区分:1:男、2:女'
  , `relation_class_id` CHAR(40) comment '健康保険証続柄区分:マキシーレセコンのみ管理'
  , `insured_postal_code` TINYTEXT default '' not null comment '被保険者郵便番号:FD(USB)転送のみ管理
被保険者の郵便番号'
  , `insured_address_pref` TEXT default '' not null comment '被保険者都道府県:（旧システムの場合は住所は全て含む）
FD(USB)転送のみ管理
被保険者の郵便番号'
  , `insured_address_city` TEXT default '' not null comment '被保険者市区町村'
  , `insured_address_town` TEXT default '' not null comment '被保険者町域'
  , `insured_address_street` TEXT default '' not null comment '被保険者団地・マンション'
  , `insured_birthday` DATE default '1800-1-1' not null comment '被保険者生年月日'
  , `attend_days` CHAR(31) default '' not null comment '通院日:1カラムが１日を表す 0;なし､1:通院'
  , `house_visit_days` CHAR(31) default '' not null comment '往診日:1カラムが１日を表す 0;なし､1:往診'
  , `ratio` SMALLINT default 0 not null comment '負担割合'
  , `charge_amount` DECIMAL(13,2) default 0 not null comment '保険請求金額'
  , `insurance_amount` DECIMAL(13,2) default 0 not null comment '保険対象金額:合計'
  , `bear_amount` DECIMAL(13,2) default 0 not null comment '一部負担金額:患者の窓口負担額'
  , `main_total_amount` DECIMAL(13,2) default 0 not null comment '助成時本体合計額:助成レコードの時、本体の合計額'
  , `main_recipient_amount` DECIMAL(13,2) default 0 not null comment '助成時本体一部負担額:助成レコードの時、本体の合計額'
  , `main_charge_amount` DECIMAL(13,2) default 0 not null comment '助成時本体請求額:助成レコードの時、本体の一部負担額'
  , `main_ratio` SMALLINT default 0 not null comment '助成時本体負担割合:助成レコードの時、本体の負担割合'
  , `exempt_class_id` CHAR(40) not null comment '一部負担金免除区分:?'
  , `social_insurance_raio` SMALLINT default 0 comment '社保負担割合:生活保護のみ使用'
  , `social_insurance_amount` DECIMAL(13,2) default 0 not null comment '社保請求金額:生活保護のみ使用'
  , `sign_date` DATE default '1900-1-1' not null comment 'サイン受領日'
  , `other_print_flag` TINYINT default '0' not null comment '付属情報印字フラグ'
  , `medical_assist_class_id` CHAR(40) comment '単併区分:1:単独、2:2併､3:3併'
  , `head_family_class_id` CHAR(40) comment '本人家族区分:1:本人、2:六歳、3:家族､4:高一、5:高七'
  , `charge_class_id` CHAR(40) comment '請求区分:1:新規、2:継続､3:新規＆継続'
  , `factor_class_id` CHAR(40) comment '負傷要因区分'
  , `summary_front` TEXT default '' not null comment '摘要(表）'
  , `summary_back` TEXT default '' not null comment '摘要(裏）'
  , `elderly_class_id` CHAR(40) comment '高齢区分'
  , `no_work_class_id` CHAR(40) comment '未就区分'
  , `trader_class_id` CHAR(40) comment '業者区分:レセコンメーカー
空白…手入力
21…マキシー
22…マキシー
90…全柔協
(21,22の違いについては不明)'
  , `electropathy_class_id` CHAR(40) comment '電療区分'
  , `insurer_move_flag` TINYINT default 0 not null comment '保険異動後フラグ'
  , `ijp_no` TEXT default '' not null comment 'IJP連番(レセプト画像番号):処理年月(西暦下2桁＋月2桁)＋号機(2桁)＋"1"(固定)＋連番(6桁)
例)1712061001358
処理年月=1712,号機=06号機,"1",連番=001358'
  , `qr_process_class` INT default 0 not null comment 'QR処理区分:0:オフコン手入力/FD(USB)転送データ、1:QR取り込みデータ、2:エントリー入力(全項目)データ、3:QR当月外取り込みデータ'
  , `update_sign` INT default 0 not null comment '更新ｻｲﾝ:0:QR/FD(USB)取り込み、1:手入力'
  , `receipt_version` TEXT default '' not null comment 'レセプトバージョン'
  , `modify_user_id` CHAR(40) comment '修正担当者ID:レセプト修正した操作員ID'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RCPT0001_PKC` primary key (`rid`)
) comment '柔整レセプト申請情報' ;

-- グループ権限機能マスタ
drop table if exists `USER0002` cascade;

create table `USER0002` (
  `rid` CHAR(40) not null comment 'RID'
  , `authority_id` CHAR(40) not null comment 'グループ権限ID'
  , `function_id` INT default 0 not null comment '画面ID(機能ID）'
  , `security_level_class_id` CHAR(40) not null comment 'セキュリティレベル区分:0:使用不可､1: 表示のみ、2: 編集、9:管理者'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `USER0002_PKC` primary key (`rid`)
) comment 'グループ権限機能マスタ' ;

-- ユーザーマスタ
drop table if exists `USER0010` cascade;

create table `USER0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `user_code` VARCHAR(255) default '' not null comment 'ユーザーコード'
  , `user_name` TEXT default '' not null comment 'ユーザー名'
  , `login_id` TEXT default '' not null comment 'ログインID'
  , `authority_id` CHAR(40) not null comment 'グループ権限ID:グループ権限マスタより'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `USER0010_PKC` primary key (`rid`)
) comment 'ユーザーマスタ' ;

-- 質問マスタ
drop table if exists `QEST0010` cascade;

create table `QEST0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `question_group_id` CHAR(40) not null comment '質問グループID'
  , `question_no` INT default 0 not null comment '質問番号'
  , `parent_id` CHAR(40) not null comment '親質問ID'
  , `question_level` INT default 0 not null comment '質問レベル:階層表示用'
  , `content` TEXT default '' not null comment '質問内容'
  , `answer_type_class_id` CHAR(40) not null comment '回答タイプ区分:1: リスト、2:ラジオボタン、3:チェックボックス、4:日付、5:任意入力、6:FromTo、7: 画像選択、8:電話番号、9:メールアドレス、10: url'
  , `data_type_class_id` CHAR(40) not null comment '回答データ種別区分:1: 数値、2: 文字、3: 日付、4: 時間、5: 日時、6: 座標'
  , `answer_group_id` CHAR(40) not null comment '回答グループID:回答グループマスタより'
  , `format` TEXT default '' not null comment 'フォーマット:表示書式'
  , `input_check` TEXT default '' not null comment '入力制御:正規表現等'
  , `relation_id` CHAR(40) not null comment '関連質問ID:影響される質問番号'
  , `relation_control_type` CHAR(40) not null comment '関連質問制御区分:影響される質問がどういう状態のときに制御が必要か（入力の有無、特定値のとき等）'
  , `remark` TEXT default '' not null comment '備考'
  , `seq_no` INT default 0 not null comment '並び順'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `QEST0010_PKC` primary key (`rid`)
) comment '質問マスタ' ;

-- 施術所口座用途マスタ
drop table if exists `OFAC0010` cascade;

create table `OFAC0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `master_id` CHAR(40) not null comment '施術所口座ID'
  , `use_class_id` TEXT default '' not null comment '口座用途区分'
  , `start_date` DATE default '1900-1-1' not null comment '適用開始日'
  , `end_date` DATE default '9999-12-31' not null comment '適用終了日'
  , `change_date` DATE default '1900-1-1' not null comment '状態異動日'
  , `reason_class_id` TEXT default '' not null comment '口座異動理由区分:1: 口座変更、2: 口座廃止、9: その他'
  , `remak` TEXT default '' not null comment '備考'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `OFAC0010_PKC` primary key (`rid`)
) comment '施術所口座用途マスタ' ;

-- グループ権限マスタ
drop table if exists `USER0001` cascade;

create table `USER0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID:今は未使用'
  , `authority_no` INT default 0 not null comment 'グループ権限番号'
  , `authority_name` TEXT default '' not null comment 'グループ権限名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `USER0001_PKC` primary key (`rid`)
) comment 'グループ権限マスタ' ;

-- レセプトエラー内容マスタ
drop table if exists `RERR0001` cascade;

create table `RERR0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `error_code` VARCHAR(255) default '' not null comment 'エラーコード'
  , `error_class_id` CHAR(40) not null comment 'エラー区分:1: 注意、2: 確認、3:警告'
  , `content` TEXT default '' not null comment 'エラー内容'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `RERR0001_PKC` primary key (`rid`)
) comment 'レセプトエラー内容マスタ' ;

-- 関連質問回答マスタ
drop table if exists `QEST0011` cascade;

create table `QEST0011` (
  `rid` CHAR(40) not null comment 'RID'
  , `question_id` CHAR(40) not null comment '質問ID'
  , `relation_answer_id` CHAR(40) not null comment '関連質問回答ID:影響される質問の回答がどういう状態のときに制御が必要か'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `QEST0011_PKC` primary key (`rid`)
) comment '関連質問回答マスタ' ;

-- 郵便番号マスタ
drop table if exists `CZIP0001` cascade;

create table `CZIP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `prefecture_code` TEXT default '' not null comment '都道府県コード'
  , `municipality_code` TEXT default '' not null comment '全国地方公共団体コード'
  , `old_postal_code` VARCHAR(255) default '' not null comment '郵便番号(旧)'
  , `postal_code` VARCHAR(255) default '' not null comment '郵便番号'
  , `prefecture_kana` VARCHAR(255) default '' not null comment '都道府県カナ名'
  , `city_kana` VARCHAR(255) default '' not null comment '市区町村カナ名'
  , `town_kana` VARCHAR(255) default '' not null comment '町域カナ名'
  , `aza_kana` VARCHAR(255) default '' not null comment '字カナ名'
  , `prefecture_name` VARCHAR(255) default '' not null comment '都道府県名'
  , `city_name` VARCHAR(255) default '' not null comment '市区町村名'
  , `town_name` VARCHAR(255) default '' not null comment '町域名'
  , `aza_name` VARCHAR(255) default '' not null comment '字名'
  , `control_flag_1` TINYINT default 0 not null comment '一町域が二以上の郵便番号で表される場合の表示フラグ'
  , `control_flag_2` TINYINT default 0 not null comment '小字毎に番地が起番されている町域の表示フラグ'
  , `control_flag_3` TINYINT default 0 not null comment '丁目を有する町域の場合の表示フラグ'
  , `control_flag_4` TINYINT default 0 not null comment '一つの郵便番号で二以上の町域を表す場合の表示フラグ'
  , `update_class` TEXT default '' not null comment '更新の表示'
  , `update_reason_class` TEXT default '' not null comment '変更理由'
  , `seino_code` VARCHAR(255) not null comment '仕分コード（西濃運輸）:西濃運輸より取得(ＨＰにはない為、電話して依頼)した仕分コード一覧'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CZIP0001_PKC` primary key (`rid`)
) comment '郵便番号マスタ' ;

create index `CZIP0001_IDX1`
  on `CZIP0001`(`postal_code`);

create index `CZIP0001_IDX2`
  on `CZIP0001`(`prefecture_kana`,`city_kana`,`town_kana`);

create index `CZIP0001_IDX3`
  on `CZIP0001`(`prefecture_name`,`city_name`,`town_name`);

-- 回答マスタ
drop table if exists `QEST0030` cascade;

create table `QEST0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `answer_group_id` CHAR(40) not null comment '回答グループID'
  , `answer_no` INT default 0 not null comment '回答番号'
  , `answer_name` TEXT default '' not null comment '回答名'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `QEST0030_PKC` primary key (`rid`)
) comment '回答マスタ' ;

-- 柔整負傷マスタ
drop table if exists `IJPT0001` cascade;

create table `IJPT0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `injury_code` VARCHAR(255) default '' not null comment '負傷コード'
  , `injury_name` TEXT default '' not null comment '負傷名'
  , `injury_class_id` CHAR(40) not null comment '柔整傷病区分'
  , `part_class_id` CHAR(40) not null comment '部位区分:柔整傷病区分によって取得する部位区分を切り替える'
  , `part_no` INT default 0 not null comment '部位番号'
  , `up_flag` TINYINT default 0 not null comment '上部フラグ:1:対象'
  , `down_flag` TINYINT default 0 not null comment '下部フラグ:1:対象'
  , `left_flag` TINYINT default 0 not null comment '左側フラグ:1:対象'
  , `right_flag` TINYINT default 0 not null comment '右側フラグ:1:対象'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IJPT0001_PKC` primary key (`rid`)
) comment '柔整負傷マスタ' ;

-- 柔整部位画像マスタ
drop table if exists `IMGP0001` cascade;

create table `IMGP0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `injury_part_id` CHAR(40) not null comment '柔整負傷ID'
  , `image_type_class_id` CHAR(40) not null comment '画像種別区分'
  , `filename` TINYTEXT default '' not null comment 'ファイル名'
  , `width` REAL default 0 not null comment '幅'
  , `height` REAL default 0 not null comment '高さ'
  , `level` INT default 0 not null comment '詳細レベル'
  , `control_1` TEXT default '' not null comment '制御情報１'
  , `control_2` TEXT default '' not null comment '制御情報２'
  , `control_3` TEXT default '' not null comment '制御情報３'
  , `control_4` TEXT default '' not null comment '制御情報４'
  , `control_5` TEXT default '' not null comment '制御情報５'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IMGP0001_PKC` primary key (`rid`)
) comment '柔整部位画像マスタ' ;

-- 回答グループマスタ
drop table if exists `QEST0020` cascade;

create table `QEST0020` (
  `rid` CHAR(40) not null comment 'RID'
  , `answer_group_name` TEXT default '' not null comment '回答グループ名'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `QEST0020_PKC` primary key (`rid`)
) comment '回答グループマスタ' ;

-- オーナー区分マスタ
drop table if exists `CNAM0001` cascade;

create table `CNAM0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'オーナー区分値'
  , `name` TEXT default '' not null comment 'オーナー区分名'
  , `short_name` TEXT default '' not null comment 'オーナー区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0001_PKC` primary key (`rid`)
) comment 'オーナー区分マスタ' ;

-- 開設者区分マスタ
drop table if exists `CNAM0002` cascade;

create table `CNAM0002` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '開設者区分値'
  , `name` TEXT default '' not null comment '開設者区分名'
  , `short_name` TEXT default '' not null comment '開設者区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0002_PKC` primary key (`rid`)
) comment '開設者区分マスタ' ;

-- 都道府県区分マスタ
drop table if exists `CNAM0003` cascade;

create table `CNAM0003` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '都道府県値'
  , `name` TEXT default '' not null comment '都道府県名'
  , `short_name` TEXT default '' not null comment '都道府県略称'
  , `kana_name` TEXT default '' not null comment '都道府県カナ名'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0003_PKC` primary key (`rid`)
) comment '都道府県区分マスタ' ;

-- 元号区分マスタ
drop table if exists `CNAM0005` cascade;

create table `CNAM0005` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '元号区分値'
  , `name` TEXT default '' not null comment '元号区分名'
  , `short_name` TEXT default '' not null comment '元号区分略称'
  , `era_code` TEXT not null comment '元号コード'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0005_PKC` primary key (`rid`)
) comment '元号区分マスタ' ;

-- 許可番号通知区分マスタ
drop table if exists `CNAM0007` cascade;

create table `CNAM0007` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '許可番号通知区分値'
  , `name` TEXT default '' not null comment '許可番号通知区分名'
  , `short_name` TEXT default '' not null comment '許可番号通知区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0007_PKC` primary key (`rid`)
) comment '許可番号通知区分マスタ' ;

-- 支払方法区分マスタ
drop table if exists `CNAM0008` cascade;

create table `CNAM0008` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '支払方法区分値'
  , `name` TEXT default '' not null comment '支払方法区分名'
  , `short_name` TEXT default '' not null comment '支払方法区分略称'
  , `installment_flag` TINYINT default 0 not null comment '割賦フラグ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0008_PKC` primary key (`rid`)
) comment '支払方法区分マスタ' ;

-- 保険取扱区分マスタ
drop table if exists `CNAM0009` cascade;

create table `CNAM0009` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '保険取扱区分値'
  , `name` TEXT default '' not null comment '保険取扱区分名'
  , `short_name` TEXT default '' not null comment '保険取扱区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0009_PKC` primary key (`rid`)
) comment '保険取扱区分マスタ' ;

-- 入会講習区分マスタ
drop table if exists `CNAM0010` cascade;

create table `CNAM0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '入会講習区分値'
  , `name` TEXT default '' not null comment '入会講習区分名'
  , `short_name` TEXT default '' not null comment '入会講習区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0010_PKC` primary key (`rid`)
) comment '入会講習区分マスタ' ;

-- 送付方法区分マスタ
drop table if exists `CNAM0012` cascade;

create table `CNAM0012` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '送付方法区分値'
  , `name` TEXT default '' not null comment '送付方法区分名'
  , `short_name` TEXT default '' not null comment '送付方法区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0012_PKC` primary key (`rid`)
) comment '送付方法区分マスタ' ;

-- 住所区分マスタ
drop table if exists `CNAM0013` cascade;

create table `CNAM0013` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '住所区分値'
  , `name` TEXT default '' not null comment '住所区分名'
  , `short_name` TEXT default '' not null comment '住所区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0013_PKC` primary key (`rid`)
) comment '住所区分マスタ' ;

-- 担当区分マスタ
drop table if exists `CNAM0014` cascade;

create table `CNAM0014` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '担当区分値'
  , `name` TEXT default '' not null comment '担当区分名'
  , `short_name` TEXT default '' not null comment '担当区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0014_PKC` primary key (`rid`)
) comment '担当区分マスタ' ;

-- 性別区分マスタ
drop table if exists `CNAM0015` cascade;

create table `CNAM0015` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '性別区分値'
  , `name` TEXT default '' not null comment '性別区分名'
  , `short_name` TEXT default '' not null comment '性別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0015_PKC` primary key (`rid`)
) comment '性別区分マスタ' ;

-- 医療助成種別区分マスタ
drop table if exists `CNAM0018` cascade;

create table `CNAM0018` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '医療助成種別区分値'
  , `name` TEXT default '' not null comment '医療助成種別区分名'
  , `short_name` TEXT default '' not null comment '医療助成種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0018_PKC` primary key (`rid`)
) comment '医療助成種別区分マスタ' ;

-- 柔整傷病区分マスタ
drop table if exists `CNAM0019` cascade;

create table `CNAM0019` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整傷病区分値'
  , `name` TEXT default '' not null comment '柔整傷病区分名'
  , `short_name` TEXT default '' not null comment '柔整傷病区分略称'
  , `input_flag` TINYINT default 0 not null comment '入力フラグ:1: 入力あり'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0019_PKC` primary key (`rid`)
) comment '柔整傷病区分マスタ' ;

-- あん摩マッサージ症状区分マスタ
drop table if exists `CNAM0021` cascade;

create table `CNAM0021` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'あん摩マッサージ症状区分値'
  , `name` TEXT default '' not null comment 'あん摩マッサージ症状区分名'
  , `short_name` TEXT default '' not null comment 'あん摩マッサージ症状区分略称'
  , `input_flag` TINYINT default 0 not null comment '入力フラグ:1: 入力あり'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0021_PKC` primary key (`rid`)
) comment 'あん摩マッサージ症状区分マスタ' ;

-- 打撲部位区分マスタ
drop table if exists `CNAM0023` cascade;

create table `CNAM0023` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '打撲部位区分値'
  , `name` TEXT default '' not null comment '打撲部位区分名'
  , `short_name` TEXT default '' not null comment '打撲部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0023_PKC` primary key (`rid`)
) comment '打撲部位区分マスタ' ;

-- 挫傷部位区分マスタ
drop table if exists `CNAM0024` cascade;

create table `CNAM0024` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '挫傷部位区分値'
  , `name` TEXT default '' not null comment '挫傷部位区分名'
  , `short_name` TEXT default '' not null comment '挫傷部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0024_PKC` primary key (`rid`)
) comment '挫傷部位区分マスタ' ;

-- 脱臼部位区分マスタ
drop table if exists `CNAM0025` cascade;

create table `CNAM0025` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '脱臼部位区分値'
  , `name` TEXT default '' not null comment '脱臼部位区分名'
  , `short_name` TEXT default '' not null comment '脱臼部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0025_PKC` primary key (`rid`)
) comment '脱臼部位区分マスタ' ;

-- 骨折部位区分マスタ
drop table if exists `CNAM0026` cascade;

create table `CNAM0026` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '骨折部位区分値'
  , `name` TEXT default '' not null comment '骨折部位区分名'
  , `short_name` TEXT default '' not null comment '骨折部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0026_PKC` primary key (`rid`)
) comment '骨折部位区分マスタ' ;

-- 不全骨折部位区分マスタ
drop table if exists `CNAM0027` cascade;

create table `CNAM0027` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '不全骨折部位区分値'
  , `name` TEXT default '' not null comment '不全骨折部位区分名'
  , `short_name` TEXT default '' not null comment '不全骨折部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0027_PKC` primary key (`rid`)
) comment '不全骨折部位区分マスタ' ;

-- 骨折拘縮後療部位区分マスタ
drop table if exists `CNAM0028` cascade;

create table `CNAM0028` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '骨折拘縮後療部位区分値'
  , `name` TEXT default '' not null comment '骨折拘縮後療部位区分名'
  , `short_name` TEXT default '' not null comment '骨折拘縮後療部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0028_PKC` primary key (`rid`)
) comment '骨折拘縮後療部位区分マスタ' ;

-- 不全骨折拘縮後療部位区分マスタ
drop table if exists `CNAM0029` cascade;

create table `CNAM0029` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '不全骨折拘縮後療部位区分値'
  , `name` TEXT default '' not null comment '不全骨折拘縮後療部位区分名'
  , `short_name` TEXT default '' not null comment '不全骨折拘縮後療部位区分略称'
  , `part_class` TEXT default '' not null comment '部位区分:'': なし、1:左右、2:上下、3:上下左右'
  , `part_min` INT default 0 not null comment '部位最小番号'
  , `part_max` INT default 0 not null comment '部位最大番号'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0029_PKC` primary key (`rid`)
) comment '不全骨折拘縮後療部位区分マスタ' ;

-- 鍼灸部位区分マスタ
drop table if exists `CNAM0030` cascade;

create table `CNAM0030` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸部位区分値'
  , `name` TEXT default '' not null comment '鍼灸部位区分名'
  , `short_name` TEXT default '' not null comment '鍼灸部位区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0030_PKC` primary key (`rid`)
) comment '鍼灸部位区分マスタ' ;

-- あん摩マッサージ部位区分マスタ
drop table if exists `CNAM0031` cascade;

create table `CNAM0031` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'あん摩マッサージ部位区分値'
  , `name` TEXT default '' not null comment 'あん摩マッサージ部位区分名'
  , `short_name` TEXT default '' not null comment 'あん摩マッサージ部位区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0031_PKC` primary key (`rid`)
) comment 'あん摩マッサージ部位区分マスタ' ;

-- 診療科区分マスタ
drop table if exists `CNAM0032` cascade;

create table `CNAM0032` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '診療科区分値'
  , `name` TEXT default '' not null comment '診療科区分名'
  , `short_name` TEXT default '' not null comment '診療科区分略称'
  , `j_flag` TINYINT default 0 not null comment '柔整フラグ'
  , `h_flag` TINYINT default 0 not null comment '鍼フラグ'
  , `q_flag` TINYINT default 0 not null comment '灸フラグ'
  , `m_flag` TINYINT default 0 not null comment 'あん摩・マッサージフラグ'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0032_PKC` primary key (`rid`)
) comment '診療科区分マスタ' ;

-- 口座種別区分マスタ
drop table if exists `CNAM0036` cascade;

create table `CNAM0036` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '口座種別区分値'
  , `name` TEXT default '' not null comment '口座種別区分名'
  , `short_name` TEXT default '' not null comment '口座種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0036_PKC` primary key (`rid`)
) comment '口座種別区分マスタ' ;

-- 口座所有者区分マスタ
drop table if exists `CNAM0037` cascade;

create table `CNAM0037` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '口座所有者区分値'
  , `name` TEXT default '' not null comment '口座所有者区分名'
  , `short_name` TEXT default '' not null comment '口座所有者区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0037_PKC` primary key (`rid`)
) comment '口座所有者区分マスタ' ;

-- 休止理由区分マスタ
drop table if exists `CNAM0038` cascade;

create table `CNAM0038` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '休止理由区分値'
  , `name` TEXT default '' not null comment '休止理由区分名'
  , `short_name` TEXT default '' not null comment '休止理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0038_PKC` primary key (`rid`)
) comment '休止理由区分マスタ' ;

-- 廃業理由区分マスタ
drop table if exists `CNAM0039` cascade;

create table `CNAM0039` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '廃業理由区分値'
  , `name` TEXT default '' not null comment '廃業理由区分名'
  , `short_name` TEXT default '' not null comment '廃業理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0039_PKC` primary key (`rid`)
) comment '廃業理由区分マスタ' ;

-- 口座用途区分マスタ
drop table if exists `CNAM0040` cascade;

create table `CNAM0040` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '口座用途区分値'
  , `name` TEXT default '' not null comment '口座用途区分名'
  , `short_name` TEXT default '' not null comment '口座用途区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0040_PKC` primary key (`rid`)
) comment '口座用途区分マスタ' ;

-- 口座異動理由区分マスタ
drop table if exists `CNAM0041` cascade;

create table `CNAM0041` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '口座異動理由区分値'
  , `name` TEXT default '' not null comment '口座異動理由区分名'
  , `short_name` TEXT default '' not null comment '口座異動理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0041_PKC` primary key (`rid`)
) comment '口座異動理由区分マスタ' ;

-- 担当者状態区分マスタ
drop table if exists `CNAM0042` cascade;

create table `CNAM0042` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '担当者状態区分値'
  , `name` TEXT default '' not null comment '担当者状態区分名'
  , `short_name` TEXT default '' not null comment '担当者状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0042_PKC` primary key (`rid`)
) comment '担当者状態区分マスタ' ;

-- 診療科状態区分マスタ
drop table if exists `CNAM0043` cascade;

create table `CNAM0043` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '診療科状態区分値'
  , `name` TEXT default '' not null comment '診療科状態区分名'
  , `short_name` TEXT default '' not null comment '診療科状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0043_PKC` primary key (`rid`)
) comment '診療科状態区分マスタ' ;

-- 老健区分マスタ
drop table if exists `CNAM0044` cascade;

create table `CNAM0044` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '老健区分値'
  , `name` TEXT default '' not null comment '老健区分名'
  , `short_name` TEXT default '' not null comment '老健区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0044_PKC` primary key (`rid`)
) comment '老健区分マスタ' ;

-- 算定日区分マスタ
drop table if exists `CNAM0048` cascade;

create table `CNAM0048` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '算定日区分値'
  , `name` TEXT default '' not null comment '算定日区分名'
  , `short_name` TEXT default '' not null comment '算定日区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0048_PKC` primary key (`rid`)
) comment '算定日区分マスタ' ;

-- 回答タイプ区分マスタ
drop table if exists `CNAM0051` cascade;

create table `CNAM0051` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '回答タイプ区分値'
  , `name` TEXT default '' not null comment '回答タイプ区分名'
  , `short_name` TEXT default '' not null comment '回答タイプ区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0051_PKC` primary key (`rid`)
) comment '回答タイプ区分マスタ' ;

-- 回答データ種別区分マスタ
drop table if exists `CNAM0052` cascade;

create table `CNAM0052` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '回答データ種別区分値'
  , `name` TEXT default '' not null comment '回答データ種別区分名'
  , `short_name` TEXT default '' not null comment '回答データ種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0052_PKC` primary key (`rid`)
) comment '回答データ種別区分マスタ' ;

-- 関連質問制御区分マスタ
drop table if exists `CNAM0053` cascade;

create table `CNAM0053` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '関連質問制御区分値'
  , `name` TEXT default '' not null comment '関連質問制御区分名'
  , `short_name` TEXT default '' not null comment '関連質問制御区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0053_PKC` primary key (`rid`)
) comment '関連質問制御区分マスタ' ;

-- セキュリティレベル区分マスタ
drop table if exists `CNAM0054` cascade;

create table `CNAM0054` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'セキュリティレベル区分値'
  , `name` TEXT default '' not null comment 'セキュリティレベル区分名'
  , `short_name` TEXT default '' not null comment 'セキュリティレベル区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0054_PKC` primary key (`rid`)
) comment 'セキュリティレベル区分マスタ' ;

-- 診療オプション区分マスタ
drop table if exists `CNAM0055` cascade;

create table `CNAM0055` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '診療オプション区分値'
  , `name` TEXT default '' not null comment '診療オプション区分名'
  , `short_name` TEXT default '' not null comment '診療オプション区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0055_PKC` primary key (`rid`)
) comment '診療オプション区分マスタ' ;

-- 高齢受給者区分マスタ
drop table if exists `CNAM0056` cascade;

create table `CNAM0056` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '高齢受給者区分値'
  , `name` TEXT default '' not null comment '高齢受給者区分名'
  , `short_name` TEXT default '' not null comment '高齢受給者区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0056_PKC` primary key (`rid`)
) comment '高齢受給者区分マスタ' ;

-- 保険証異動理由区分マスタ
drop table if exists `CNAM0057` cascade;

create table `CNAM0057` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '保険証異動理由区分値'
  , `name` TEXT default '' not null comment '保険証異動理由区分名'
  , `short_name` TEXT default '' not null comment '保険証異動理由区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0057_PKC` primary key (`rid`)
) comment '保険証異動理由区分マスタ' ;

-- 法別区分マスタ
drop table if exists `CNAM0058` cascade;

create table `CNAM0058` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '法別区分値'
  , `name` TEXT default '' not null comment '法別区分名'
  , `short_name` TEXT default '' not null comment '法別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0058_PKC` primary key (`rid`)
) comment '法別区分マスタ' ;

-- 健康保険証続柄区分マスタ
drop table if exists `CNAM0059` cascade;

create table `CNAM0059` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '健康保険証続柄区分値'
  , `name` TEXT default '' not null comment '健康保険証続柄区分名'
  , `short_name` TEXT default '' not null comment '健康保険証続柄区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0059_PKC` primary key (`rid`)
) comment '健康保険証続柄区分マスタ' ;

-- アラート区分マスタ
drop table if exists `CNAM0061` cascade;

create table `CNAM0061` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'アラート区分値'
  , `name` TEXT default '' not null comment 'アラート区分名'
  , `short_name` TEXT default '' not null comment 'アラート区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0061_PKC` primary key (`rid`)
) comment 'アラート区分マスタ' ;

-- アラート状態区分マスタ
drop table if exists `CNAM0062` cascade;

create table `CNAM0062` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'アラート状態区分値'
  , `name` TEXT default '' not null comment 'アラート状態区分名'
  , `short_name` TEXT default '' not null comment 'アラート状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0062_PKC` primary key (`rid`)
) comment 'アラート状態区分マスタ' ;

-- 受付状態区分マスタ
drop table if exists `CNAM0063` cascade;

create table `CNAM0063` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '受付状態区分値'
  , `name` TEXT default '' not null comment '受付状態区分名'
  , `short_name` TEXT default '' not null comment '受付状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0063_PKC` primary key (`rid`)
) comment '受付状態区分マスタ' ;

-- バイタル区分マスタ
drop table if exists `CNAM0065` cascade;

create table `CNAM0065` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'バイタル区分値'
  , `name` TEXT default '' not null comment 'バイタル区分名'
  , `short_name` TEXT default '' not null comment 'バイタル区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0065_PKC` primary key (`rid`)
) comment 'バイタル区分マスタ' ;

-- 来院状態メイン区分マスタ
drop table if exists `CNAM0066` cascade;

create table `CNAM0066` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '来院状態メイン区分値'
  , `name` TEXT default '' not null comment '来院状態メイン区分名'
  , `short_name` TEXT default '' not null comment '来院状態メイン区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0066_PKC` primary key (`rid`)
) comment '来院状態メイン区分マスタ' ;

-- 来院状態サブ区分マスタ
drop table if exists `CNAM0067` cascade;

create table `CNAM0067` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '来院状態サブ区分値'
  , `name` TEXT default '' not null comment '来院状態サブ区分名'
  , `short_name` TEXT default '' not null comment '来院状態サブ区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0067_PKC` primary key (`rid`)
) comment '来院状態サブ区分マスタ' ;

-- 特殊区分マスタ
drop table if exists `CNAM0068` cascade;

create table `CNAM0068` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '特殊区分値'
  , `name` TEXT default '' not null comment '特殊区分名'
  , `short_name` TEXT default '' not null comment '特殊区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0068_PKC` primary key (`rid`)
) comment '特殊区分マスタ' ;

-- 負傷要因区分マスタ
drop table if exists `CNAM0069` cascade;

create table `CNAM0069` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '負傷要因区分値'
  , `name` TEXT default '' not null comment '負傷要因区分名'
  , `short_name` TEXT default '' not null comment '負傷要因区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0069_PKC` primary key (`rid`)
) comment '負傷要因区分マスタ' ;

-- レセプト状態区分マスタ
drop table if exists `CNAM0073` cascade;

create table `CNAM0073` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセプト状態区分値'
  , `name` TEXT default '' not null comment 'レセプト状態区分名'
  , `short_name` TEXT default '' not null comment 'レセプト状態区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0073_PKC` primary key (`rid`)
) comment 'レセプト状態区分マスタ' ;

-- 領収書発行区分マスタ
drop table if exists `CNAM0075` cascade;

create table `CNAM0075` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '領収書発行区分値'
  , `name` TEXT default '' not null comment '領収書発行区分名'
  , `short_name` TEXT default '' not null comment '領収書発行区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0075_PKC` primary key (`rid`)
) comment '領収書発行区分マスタ' ;

-- 鍼灸施術種別区分マスタ
drop table if exists `CNAM0077` cascade;

create table `CNAM0077` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸施術種別区分値'
  , `name` TEXT default '' not null comment '鍼灸施術種別区分名'
  , `short_name` TEXT default '' not null comment '鍼灸施術種別区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0077_PKC` primary key (`rid`)
) comment '鍼灸施術種別区分マスタ' ;

-- 鍼灸評価項目区分マスタ
drop table if exists `CNAM0082` cascade;

create table `CNAM0082` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '鍼灸評価項目区分値'
  , `name` TEXT default '' not null comment '鍼灸評価項目区分名'
  , `short_name` TEXT default '' not null comment '鍼灸評価項目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0082_PKC` primary key (`rid`)
) comment '鍼灸評価項目区分マスタ' ;

-- 単併区分マスタ
drop table if exists `CNAM0091` cascade;

create table `CNAM0091` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '単併区分値'
  , `name` TEXT default '' not null comment '単併区分名'
  , `short_name` TEXT default '' not null comment '単併区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0091_PKC` primary key (`rid`)
) comment '単併区分マスタ' ;

-- 税理士・会計士区分マスタ
drop table if exists `CNAM0096` cascade;

create table `CNAM0096` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '税理士・会計士区分値'
  , `name` TEXT default '' not null comment '税理士・会計士区分名'
  , `short_name` TEXT default '' not null comment '税理士・会計士区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0096_PKC` primary key (`rid`)
) comment '税理士・会計士区分マスタ' ;

-- 部局区分マスタ
drop table if exists `CNAM0097` cascade;

create table `CNAM0097` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '部局区分値'
  , `name` TEXT default '' not null comment '部局区分名'
  , `short_name` TEXT default '' not null comment '部局区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0097_PKC` primary key (`rid`)
) comment '部局区分マスタ' ;

-- 算定項目区分マスタ
drop table if exists `CNAM0098` cascade;

create table `CNAM0098` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '算定項目区分値'
  , `name` TEXT default '' not null comment '算定項目区分名'
  , `short_name` TEXT default '' not null comment '算定項目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0098_PKC` primary key (`rid`)
) comment '算定項目区分マスタ' ;

-- レセコン印字箇所区分マスタ
drop table if exists `CNAM0099` cascade;

create table `CNAM0099` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment 'レセコン印字箇所区分値'
  , `name` TEXT default '' not null comment 'レセコン印字箇所区分名'
  , `short_name` TEXT default '' not null comment 'レセコン印字箇所区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0099_PKC` primary key (`rid`)
) comment 'レセコン印字箇所区分マスタ' ;

-- 傷病区分マスタ
drop table if exists `CNAM0100` cascade;

create table `CNAM0100` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '傷病区分値'
  , `name` TEXT default '' not null comment '傷病区分名'
  , `short_name` TEXT default '' not null comment '傷病区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0100_PKC` primary key (`rid`)
) comment '傷病区分マスタ' ;

-- 患部区分マスタ
drop table if exists `CNAM0101` cascade;

create table `CNAM0101` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '患部区分値'
  , `name` TEXT default '' not null comment '患部区分名'
  , `short_name` TEXT default '' not null comment '患部区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0101_PKC` primary key (`rid`)
) comment '患部区分マスタ' ;

-- 柔整科目区分マスタ
drop table if exists `CNAM0102` cascade;

create table `CNAM0102` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整科目区分値'
  , `name` TEXT default '' not null comment '柔整科目区分名'
  , `short_name` TEXT default '' not null comment '柔整科目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0102_PKC` primary key (`rid`)
) comment '柔整科目区分マスタ' ;

-- 柔整レセプト科目区分マスタ
drop table if exists `CNAM0106` cascade;

create table `CNAM0106` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '柔整レセプト科目区分値'
  , `name` TEXT default '' not null comment '柔整レセプト科目区分名'
  , `short_name` TEXT default '' not null comment '柔整レセプト科目区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0106_PKC` primary key (`rid`)
) comment '柔整レセプト科目区分マスタ' ;

-- 保健所登録区分マスタ
drop table if exists `CNAM0109` cascade;

create table `CNAM0109` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '保健所登録区分値'
  , `name` TEXT default '' not null comment '保健所登録区分名'
  , `short_name` TEXT default '' not null comment '保健所登録区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0109_PKC` primary key (`rid`)
) comment '保健所登録区分マスタ' ;

-- 請求区分マスタ
drop table if exists `CNAM0110` cascade;

create table `CNAM0110` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '請求区分値'
  , `name` TEXT default '' not null comment '請求区分名'
  , `short_name` TEXT default '' not null comment '請求区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0110_PKC` primary key (`rid`)
) comment '請求区分マスタ' ;

-- 会員紹介者区分マスタ
drop table if exists `CNAM0113` cascade;

create table `CNAM0113` (
  `rid` CHAR(40) not null comment 'RID'
  , `clazz` TEXT default '' not null comment '会員紹介者区分値'
  , `name` TEXT default '' not null comment '会員紹介者区分名'
  , `short_name` TEXT default '' not null comment '会員紹介者区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `CNAM0113_PKC` primary key (`rid`)
) comment '会員紹介者区分マスタ' ;

-- 近接部位算定禁止マスタ
drop table if exists `IJPT0010` cascade;

create table `IJPT0010` (
  `rid` CHAR(40) not null comment 'RID'
  , `injury_part_id` CHAR(40) not null comment '柔整負傷ID:負傷部位マスタより'
  , `near_injury_part_id` CHAR(40) not null comment '近接柔整負傷ID:負傷部位マスタより'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `IJPT0010_PKC` primary key (`rid`)
) comment '近接部位算定禁止マスタ' ;

-- 開催会場地域区分マスタ
drop table if exists `MNAM0001` cascade;

create table `MNAM0001` (
  `rid` CHAR(40) not null comment 'RID'
  , `manage_company_id` CHAR(40) not null comment '管理企業ID'
  , `clazz` TEXT default '' not null comment '開催会場区分値'
  , `name` TEXT default '' not null comment '開催会場区分名'
  , `short_name` TEXT default '' not null comment '開催会場区分略称'
  , `default_flag` TINYINT default 0 not null comment 'デフォルトフラグ:1: デフォルト選択'
  , `rflag` TINYINT default 0 comment 'レコードフラグ'
  , `renable` TINYINT default 1 comment 'レコード有効フラグ'
  , `create_date` TIMESTAMP default '0000-00-00 00:00:00' not null comment '作成日'
  , `update_date` TIMESTAMP default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP not null comment '更新日'
  , `create_user` VARCHAR(255) comment '作成者'
  , `update_user` VARCHAR(255) comment '更新者'
  , constraint `MNAM0001_PKC` primary key (`rid`)
) comment '開催会場地域区分マスタ' ;


#!/bin/bash
# @file: create_samba_default_user.sh
# @brief: A bash shell script to create a samaba-ad default user.
# @explaination:
#   [ユーザー]
#     [Command]
#       samba-tool user create {username} --{option} {option name} 
#     [Option]
#       [姓]
#         --surname=SURNAME
#             User's surname
#       [名]
#         --given-name=GIVEN_NAME
#             User's given name
#       [メール]
#         --mail-address=MAIL_ADDRESS
#             User's email address
#       [部署]
#         --department=DEPARTMENT
#             User's department
#       [役職]
#         --job-title=JOB_TITLE
#             User's job title
#   [グループ（admin）]
#     [Command]
#       samba-tool group add {group name}
#       samba-tool group addmembers {group name} {account name}
# @author: AHAN SOU
# @email: ahan.sou@e-software.company
# @date: 2018/08/24

# user info setting
account="djangoadmin"
surName="Django"
givenName="Admin"
mailAddress="django.admin@e-software.company"
department="RD"
jobTitle="System Engineer"
password="Passw0rd"
groupAdmin="Group Admin Users"

# if user account does not exist, create default user account and group
if ! samba-tool user list | grep "${account}"; then
  # create user account
  samba-tool user create "${account}" \
    --surname="${surName}" \
    --given-name="${givenName}" \
    --mail-address="${mailAddress}" \
    --department="${department}" \
    --job-title="${jobTitle}" "${password}"
  
  # create group and add user to group
  samba-tool group add "${groupAdmin}"
  samba-tool group addmembers "${groupAdmin}" "${account}"
  samba-tool user setexpiry Administrator --noexpiry
  samba-tool user setexpiry "${account}" --noexpiry
fi
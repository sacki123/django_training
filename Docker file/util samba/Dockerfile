FROM sonohara/samba4-ad-dc
COPY ./new_entry_point.sh /new_entry_point.sh
COPY ./create_samba_default_user.sh /create_samba_default_user.sh
RUN chmod +x /new_entry_point.sh
ENTRYPOINT ["/new_entry_point.sh"]
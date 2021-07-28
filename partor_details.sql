CREATE OR REPLACE VIEW public.pastor_details
AS SELECT pastors.id AS pastor_id,
    bases.name AS base_name,
    base_branches.name AS branch_name,
    pastors.district_id,
    districts.name AS district_name,
    provinces.name AS province_name,
    cities.name AS city_name,
    barangays.name AS barangay_name,
    concat(pastors.firstname, ' ', pastors.lastname) AS pastor_name,
    pastors.middlename AS pastor_middlename,
    pastors.gender AS pastor_gender,
    floor((('now'::text::date - pastors.birth_date) / 365)::double precision) AS pastor_age,
    pastors.birth_date AS pastor_birthdate,
    pastors."position" AS church_position,
    pastor_church_count.data_count AS pastor_church_count,
    pastors.educational_attainment AS pastor_education,
    pastors.seminary AS pastor_seminary,
    pastors.messenger_id,
    pastors.has_smartphone,
        CASE
            WHEN appl_comm_lv1.data_count IS NULL THEN 0::bigint
            ELSE appl_comm_lv1.data_count
        END AS lv1_communities,
        CASE
            WHEN appl_comm_lv1fa.data_count IS NULL THEN 0::bigint
            ELSE appl_comm_lv1fa.data_count
        END AS lv1_wfa_communities,
        CASE
            WHEN appl_comm_lv2.data_count IS NULL THEN 0::bigint
            ELSE appl_comm_lv2.data_count
        END AS lv2_communities,
        CASE
            WHEN appl_comm_lv1.data_count IS NULL THEN 0::bigint
            ELSE appl_comm_lv1.data_count
        END +
        CASE
            WHEN appl_comm_lv1fa.data_count IS NULL THEN 0::bigint
            ELSE appl_comm_lv1fa.data_count
        END -
        CASE
            WHEN appl_comm_lv2.data_count IS NULL THEN 0::bigint
            ELSE appl_comm_lv2.data_count
        END AS communities_nolv2,
    appl_count.data_count AS denied_appl,
        CASE
            WHEN pastor_all_cards.data_count >= 3 THEN true
            ELSE
            CASE
                WHEN pastor_all_cards.data_count < 3 THEN false
                ELSE NULL::boolean
            END
        END AS thrive_membership,
        CASE
            WHEN pastor_data_cards.data_count > 5 THEN 'Active - Gold'::text
            ELSE
            CASE
                WHEN pastor_data_cards.data_count >= 3 THEN 'Active - Silver'::text
                ELSE
                CASE
                    WHEN pastor_data_cards.data_count > 0 THEN 'Active - Bronze'::text
                    ELSE 'Inactive'::text
                END
            END
        END AS thrive_status,
    pastor_precovid.data_count AS thrive_preecq,
    pastor_data_cards.data_count AS thrive_last12,
    pastor_all_cards.data_count AS thrive_all,
    pastor_all_cards.max_date AS thrive_lastattend,
    pastors.membership_date,
    pastors.registration_date,
    pastors.created_at,
    pastors.updated_at
   FROM pastors
     LEFT JOIN bases ON bases.id = pastors.base_id
     LEFT JOIN provinces ON provinces.id = pastors.province_id
     LEFT JOIN cities ON cities.id = pastors.city_id
     LEFT JOIN barangays ON barangays.id = pastors.barangay_id
     LEFT JOIN districts ON districts.id::text = pastors.district_id::text
     LEFT JOIN base_branches ON base_branches.id = districts.branch_id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id
           FROM data_cards
          WHERE data_cards.attended_at >= ('now'::text::date - '1 year'::interval)
          GROUP BY data_cards.pastor_id) pastor_data_cards ON pastor_data_cards.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id,
            max(data_cards.attended_at) AS max_date
           FROM data_cards
          GROUP BY data_cards.pastor_id) pastor_all_cards ON pastor_all_cards.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id
           FROM data_cards
          WHERE data_cards.attended_at < '2020-05-01'::date
          GROUP BY data_cards.pastor_id) pastor_precovid ON pastor_precovid.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            pc.pastor_id
           FROM pastor_church pc
          GROUP BY pc.pastor_id) pastor_church_count ON pastor_church_count.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            a.pastor_id
           FROM communities c2
             LEFT JOIN applications a ON a.id = c2.application_id
          WHERE a.program_id = 1
          GROUP BY a.pastor_id) appl_comm_lv1 ON appl_comm_lv1.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            a.pastor_id
           FROM communities c2
             LEFT JOIN applications a ON a.id = c2.application_id
          WHERE a.program_id = 6
          GROUP BY a.pastor_id) appl_comm_lv1fa ON appl_comm_lv1fa.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            a.pastor_id
           FROM communities c2
             LEFT JOIN applications a ON a.id = c2.application_id
          WHERE a.program_id = 7
          GROUP BY a.pastor_id) appl_comm_lv2 ON appl_comm_lv2.pastor_id = pastors.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            a2.pastor_id
           FROM applications a2
          WHERE a2.approved IS FALSE
          GROUP BY a2.pastor_id) appl_count ON appl_count.pastor_id = pastors.id
  WHERE pastors.deleted_at IS NULL;

CREATE OR REPLACE VIEW public.hbf_program
AS SELECT bases.old_id AS icm_base_id,
    bases.name AS base_name,
    base_branches.name AS branch_name,
    concat(bases.name, ' ', base_branches.name) AS base_branch_name,
    concat('B', batches.batch_no, ' of FY', "right"(batches.fiscal_year::text, 2), "right"(batches.end_year::text, 2)) AS batch_name,
    applications.program_id,
        CASE
            WHEN applications.program_id = 1 THEN 'Transform Level 1'::text
            WHEN applications.program_id = 6 THEN 'Transform Level 1'::text
            ELSE 'Transform Level 2'::text
        END AS program_name,
    communities.community_id AS icm_community_id,
    communities.id AS tbl_community_id,
    concat(pastors.firstname, ' ', pastors.lastname) AS pastor_name,
        CASE
            WHEN pastor_data_cards.data_count > 5 THEN 'Active - Gold'::text
            WHEN pastor_data_cards.data_count >= 3 THEN 'Active - Silver'::text
            WHEN pastor_data_cards.data_count > 0 THEN 'Active - Bronze'::text
            ELSE 'Inactive'::text
        END AS pastor_status,
    concat(communities.community_id, participants.participant_id) AS icm_participant_id,
    participants.id AS tbl_participant_id,
        CASE
            WHEN community_hbfs.participant_id IS NULL THEN community_hbfs.guest_name::text
            ELSE concat(participants.firstname, ' ', participants.lastname)
        END AS participant_name,
    participants.gender,
    participants.type AS participant_type,
    participants.is_visitor,
        CASE
            WHEN participants.is_visitor IS TRUE THEN 'Visitor'::text
            WHEN participants.type::text = ANY (ARRAY['original'::character varying::text, 'original_replacement'::character varying::text]) THEN 'Participant'::text
            WHEN participants.type::text = ANY (ARRAY['counselor'::character varying::text, 'counselor_replacement'::character varying::text]) THEN 'Counselor'::text
            WHEN participants.type::text = 'pastor'::text THEN 'Pastor'::text
            ELSE 'Guest - not Linked'::text
        END AS participant_category,
        CASE
            WHEN community_hbfs.guest_name IS NULL THEN false
            ELSE true
        END AS participant_is_guest,
    participants.status,
    participants.total_income,
    participants.phone_number AS contact_no1,
    community_hbfs.contact_no AS contact_no2,
    community_hbfs.id AS hbf_tbl_id,
    community_hbfs.relationship,
    concat(community_hbfs.child_firstname, ' ', community_hbfs.child_lastname) AS child_name,
    community_hbfs.birthdate AS child_birthdate,
    starting_info.first_week,
    starting_info.last_week AS current_week,
    community_hbfs.is_extended AS extended_hbf,
        CASE
            WHEN starting_info.first_week = 2 THEN weightat_date.week2_date
            WHEN starting_info.first_week = 3 THEN weightat_date.week3_date
            WHEN starting_info.first_week = 4 THEN weightat_date.week4_date
            WHEN starting_info.first_week = 5 THEN weightat_date.week5_date
            WHEN starting_info.first_week = 6 THEN weightat_date.week6_date
            ELSE NULL::timestamp without time zone
        END AS weight_at,
        CASE
            WHEN starting_info.first_week = 2 THEN height.week2_height
            WHEN starting_info.first_week = 3 THEN height.week3_height
            WHEN starting_info.first_week = 4 THEN height.week4_height
            WHEN starting_info.first_week = 5 THEN height.week5_height
            WHEN starting_info.first_week = 6 THEN height.week6_height
            ELSE NULL::double precision
        END AS initial_height,
        CASE
            WHEN starting_info.first_week = 2 THEN weight.week2_weight
            WHEN starting_info.first_week = 3 THEN weight.week3_weight
            WHEN starting_info.first_week = 4 THEN weight.week4_weight
            WHEN starting_info.first_week = 5 THEN weight.week5_weight
            WHEN starting_info.first_week = 6 THEN weight.week6_weight
            ELSE NULL::double precision
        END AS initial_weight,
        CASE
            WHEN starting_info.first_week = 2 THEN zscore.week2_zscore
            WHEN starting_info.first_week = 3 THEN zscore.week3_zscore
            WHEN starting_info.first_week = 4 THEN zscore.week4_zscore
            WHEN starting_info.first_week = 5 THEN zscore.week5_zscore
            WHEN starting_info.first_week = 6 THEN zscore.week6_zscore
            ELSE NULL::double precision
        END AS initial_zscore,
        CASE
            WHEN starting_info.first_week = 2 THEN tweight.week2_tweight
            WHEN starting_info.first_week = 3 THEN tweight.week3_tweight
            WHEN starting_info.first_week = 4 THEN tweight.week4_tweight
            WHEN starting_info.first_week = 5 THEN tweight.week5_tweight
            WHEN starting_info.first_week = 6 THEN tweight.week6_tweight
            ELSE NULL::double precision
        END AS initial_tweight,
    tweight.week15_tweight,
        CASE
            WHEN starting_info.last_week = 2 THEN weight.week2_weight
            WHEN starting_info.last_week = 3 THEN weight.week3_weight
            WHEN starting_info.last_week = 4 THEN weight.week4_weight
            WHEN starting_info.last_week = 5 THEN weight.week5_weight
            WHEN starting_info.last_week = 6 THEN weight.week6_weight
            WHEN starting_info.last_week = 7 THEN weight.week7_weight
            WHEN starting_info.last_week = 8 THEN weight.week8_weight
            WHEN starting_info.last_week = 9 THEN weight.week9_weight
            WHEN starting_info.last_week = 10 THEN weight.week10_weight
            WHEN starting_info.last_week = 11 THEN weight.week11_weight
            WHEN starting_info.last_week = 12 THEN weight.week12_weight
            WHEN starting_info.last_week = 13 THEN weight.week13_weight
            WHEN starting_info.last_week = 14 THEN weight.week14_weight
            WHEN starting_info.last_week = 15 THEN weight.week15_weight
            WHEN starting_info.last_week = 17 THEN weight.week17_weight
            WHEN starting_info.last_week = 19 THEN weight.week19_weight
            WHEN starting_info.last_week = 21 THEN weight.week21_weight
            WHEN starting_info.last_week = 23 THEN weight.week23_weight
            ELSE NULL::double precision
        END AS current_weight,
        CASE
            WHEN starting_info.last_week = 2 THEN zscore.week2_zscore
            WHEN starting_info.last_week = 3 THEN zscore.week3_zscore
            WHEN starting_info.last_week = 4 THEN zscore.week4_zscore
            WHEN starting_info.last_week = 5 THEN zscore.week5_zscore
            WHEN starting_info.last_week = 6 THEN zscore.week6_zscore
            WHEN starting_info.last_week = 7 THEN zscore.week7_zscore
            WHEN starting_info.last_week = 8 THEN zscore.week8_zscore
            WHEN starting_info.last_week = 9 THEN zscore.week9_zscore
            WHEN starting_info.last_week = 10 THEN zscore.week10_zscore
            WHEN starting_info.last_week = 11 THEN zscore.week11_zscore
            WHEN starting_info.last_week = 12 THEN zscore.week12_zscore
            WHEN starting_info.last_week = 13 THEN zscore.week13_zscore
            WHEN starting_info.last_week = 14 THEN zscore.week14_zscore
            WHEN starting_info.last_week = 15 THEN zscore.week15_zscore
            WHEN starting_info.last_week = 17 THEN zscore.week17_zscore
            WHEN starting_info.last_week = 19 THEN zscore.week19_zscore
            WHEN starting_info.last_week = 21 THEN zscore.week21_zscore
            WHEN starting_info.last_week = 23 THEN zscore.week23_zscore
            ELSE NULL::double precision
        END AS current_zscore,
    weight.week2_weight,
    weight.week3_weight,
    weight.week4_weight,
    weight.week5_weight,
    weight.week6_weight,
    weight.week7_weight,
    weight.week8_weight,
    weight.week9_weight,
    weight.week10_weight,
    weight.week11_weight,
    weight.week12_weight,
    weight.week13_weight,
    weight.week14_weight,
    weight.week15_weight,
    weight.week17_weight,
    weight.week19_weight,
    weight.week21_weight,
    weight.week23_weight,
    pa.h2h_week1 AS part_h2h_wk1,
    pa.h2h_week2 AS part_h2h_wk2,
    pa.h2h_week3 AS part_h2h_wk3,
    pa.h2h_week4 AS part_h2h_wk4,
    pa.week1 AS part_attend_wk1,
    pa.week2 AS part_attend_wk2,
    pa.week3 AS part_attend_wk3,
    pa.week4 AS part_attend_wk4,
    pa.week5 AS part_attend_wk5,
    pa.week6 AS part_attend_wk6,
    pa.week7 AS part_attend_wk7,
    pa.week8 AS part_attend_wk8,
    pa.week9 AS part_attend_wk9,
    pa.week10 AS part_attend_wk10,
    pa.week11 AS part_attend_wk11,
    pa.week12 AS part_attend_wk12,
    pa.week13 AS part_attend_wk13,
    pa.week14 AS part_attend_wk14,
    pa.week15 AS part_attend_wk15,
    pa.graduate AS part_graduate
   FROM community_hbfs
     LEFT JOIN participants ON participants.id = community_hbfs.participant_id
     LEFT JOIN communities ON communities.id = community_hbfs.community_id
     LEFT JOIN applications ON applications.id = communities.application_id
     LEFT JOIN churches ON churches.id = applications.church_id
     LEFT JOIN cities ON cities.id = churches.city_id
     LEFT JOIN barangays ON barangays.id = churches.barangay_id
     LEFT JOIN programs ON programs.id = applications.program_id
     LEFT JOIN bases ON bases.id = applications.base_id
     LEFT JOIN base_branches ON base_branches.id = applications.base_branch_id
     LEFT JOIN pastors ON pastors.id = applications.pastor_id
     LEFT JOIN batches ON batches.id = communities.batch_id
     LEFT JOIN participant_attendance pa ON participants.id = pa.participant_id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id
           FROM data_cards
          WHERE data_cards.attended_at >= ('now'::text::date - '1 year'::interval)
          GROUP BY data_cards.pastor_id) pastor_data_cards ON pastor_data_cards.pastor_id = pastors.id
     LEFT JOIN ( SELECT community_hbf_weight_logs.community_hbf_id AS id,
            min(community_hbf_weight_logs.week_no) AS first_week,
            max(community_hbf_weight_logs.week_no) AS last_week
           FROM community_hbf_weight_logs
          GROUP BY community_hbf_weight_logs.community_hbf_id
          ORDER BY community_hbf_weight_logs.community_hbf_id) starting_info ON starting_info.id = community_hbfs.id
     LEFT JOIN ( SELECT crosstab.id,
            crosstab.week2_weight,
            crosstab.week3_weight,
            crosstab.week4_weight,
            crosstab.week5_weight,
            crosstab.week6_weight,
            crosstab.week7_weight,
            crosstab.week8_weight,
            crosstab.week9_weight,
            crosstab.week10_weight,
            crosstab.week11_weight,
            crosstab.week12_weight,
            crosstab.week13_weight,
            crosstab.week14_weight,
            crosstab.week15_weight,
            crosstab.week17_weight,
            crosstab.week19_weight,
            crosstab.week21_weight,
            crosstab.week23_weight
           FROM crosstab('select community_hbf_id as id, week_no, weight_kg from community_hbf_weight_logs order by id'::text, 'select DISTINCT week_no from community_hbf_weight_logs m order by week_no'::text) crosstab(id integer, week2_weight double precision, week3_weight double precision, week4_weight double precision, week5_weight double precision, week6_weight double precision, week7_weight double precision, week8_weight double precision, week9_weight double precision, week10_weight double precision, week11_weight double precision, week12_weight double precision, week13_weight double precision, week14_weight double precision, week15_weight double precision, week17_weight double precision, week19_weight double precision, week21_weight double precision, week23_weight double precision)) weight ON weight.id = community_hbfs.id
     LEFT JOIN ( SELECT crosstab.id,
            crosstab.week2_height,
            crosstab.week3_height,
            crosstab.week4_height,
            crosstab.week5_height,
            crosstab.week6_height,
            crosstab.week7_height,
            crosstab.week8_height,
            crosstab.week9_height,
            crosstab.week10_height,
            crosstab.week11_height,
            crosstab.week12_height,
            crosstab.week13_height,
            crosstab.week14_height,
            crosstab.week15_height,
            crosstab.week17_height,
            crosstab.week19_height,
            crosstab.week21_height,
            crosstab.week23_height
           FROM crosstab('select community_hbf_id as id, week_no, height_cm from community_hbf_weight_logs order by id'::text, 'select DISTINCT week_no from community_hbf_weight_logs m order by week_no'::text) crosstab(id integer, week2_height double precision, week3_height double precision, week4_height double precision, week5_height double precision, week6_height double precision, week7_height double precision, week8_height double precision, week9_height double precision, week10_height double precision, week11_height double precision, week12_height double precision, week13_height double precision, week14_height double precision, week15_height double precision, week17_height double precision, week19_height double precision, week21_height double precision, week23_height double precision)) height ON height.id = community_hbfs.id
     LEFT JOIN ( SELECT crosstab.id,
            crosstab.week2_zscore,
            crosstab.week3_zscore,
            crosstab.week4_zscore,
            crosstab.week5_zscore,
            crosstab.week6_zscore,
            crosstab.week7_zscore,
            crosstab.week8_zscore,
            crosstab.week9_zscore,
            crosstab.week10_zscore,
            crosstab.week11_zscore,
            crosstab.week12_zscore,
            crosstab.week13_zscore,
            crosstab.week14_zscore,
            crosstab.week15_zscore,
            crosstab.week17_zscore,
            crosstab.week19_zscore,
            crosstab.week21_zscore,
            crosstab.week23_zscore
           FROM crosstab('select community_hbf_id as id, week_no, wasting_score from community_hbf_weight_logs order by id'::text, 'select DISTINCT week_no from community_hbf_weight_logs m order by week_no'::text) crosstab(id integer, week2_zscore double precision, week3_zscore double precision, week4_zscore double precision, week5_zscore double precision, week6_zscore double precision, week7_zscore double precision, week8_zscore double precision, week9_zscore double precision, week10_zscore double precision, week11_zscore double precision, week12_zscore double precision, week13_zscore double precision, week14_zscore double precision, week15_zscore double precision, week17_zscore double precision, week19_zscore double precision, week21_zscore double precision, week23_zscore double precision)) zscore ON zscore.id = community_hbfs.id
     LEFT JOIN ( SELECT crosstab.id,
            crosstab.week2_tweight,
            crosstab.week3_tweight,
            crosstab.week4_tweight,
            crosstab.week5_tweight,
            crosstab.week6_tweight,
            crosstab.week7_tweight,
            crosstab.week8_tweight,
            crosstab.week9_tweight,
            crosstab.week10_tweight,
            crosstab.week11_tweight,
            crosstab.week12_tweight,
            crosstab.week13_tweight,
            crosstab.week14_tweight,
            crosstab.week15_tweight,
            crosstab.week17_tweight,
            crosstab.week19_tweight,
            crosstab.week21_tweight,
            crosstab.week23_tweight
           FROM crosstab('select community_hbf_id as id, week_no, target_weight from community_hbf_weight_logs order by id'::text, 'select DISTINCT week_no from community_hbf_weight_logs m order by week_no'::text) crosstab(id integer, week2_tweight double precision, week3_tweight double precision, week4_tweight double precision, week5_tweight double precision, week6_tweight double precision, week7_tweight double precision, week8_tweight double precision, week9_tweight double precision, week10_tweight double precision, week11_tweight double precision, week12_tweight double precision, week13_tweight double precision, week14_tweight double precision, week15_tweight double precision, week17_tweight double precision, week19_tweight double precision, week21_tweight double precision, week23_tweight double precision)) tweight ON tweight.id = community_hbfs.id
     LEFT JOIN ( SELECT crosstab.id,
            crosstab.week2_date,
            crosstab.week3_date,
            crosstab.week4_date,
            crosstab.week5_date,
            crosstab.week6_date,
            crosstab.week7_date,
            crosstab.week8_date,
            crosstab.week9_date,
            crosstab.week10_date,
            crosstab.week11_date,
            crosstab.week12_date,
            crosstab.week13_date,
            crosstab.week14_date,
            crosstab.week15_date,
            crosstab.week17_date,
            crosstab.week19_date,
            crosstab.week21_date,
            crosstab.week23_date
           FROM crosstab('select community_hbf_id as id, week_no, weight_at from community_hbf_weight_logs order by id'::text, 'select DISTINCT week_no from community_hbf_weight_logs m order by week_no'::text) crosstab(id integer, week2_date timestamp without time zone, week3_date timestamp without time zone, week4_date timestamp without time zone, week5_date timestamp without time zone, week6_date timestamp without time zone, week7_date timestamp without time zone, week8_date timestamp without time zone, week9_date timestamp without time zone, week10_date timestamp without time zone, week11_date timestamp without time zone, week12_date timestamp without time zone, week13_date timestamp without time zone, week14_date timestamp without time zone, week15_date timestamp without time zone, week17_date timestamp without time zone, week19_date timestamp without time zone, week21_date timestamp without time zone, week23_date timestamp without time zone)) weightat_date ON weightat_date.id = community_hbfs.id
  WHERE community_hbfs.deleted_at IS NULL AND bases.name::text <> 'Manila - Beta Test'::text;
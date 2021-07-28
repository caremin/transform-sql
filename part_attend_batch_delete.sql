CREATE OR REPLACE VIEW public.part_attend_batch_delete
AS SELECT p.id AS sys_participant_id,
    concat(c.community_id, p.participant_id) AS participant_id,
    p.original_participant_id,
    pa.id AS sys_partattend_id,
    c.id AS sys_community_id,
    c.community_id,
    c.savings_group_id AS sg_id,
    concat('FY', "right"(b.fiscal_year::character varying::text, 2), '-', "right"(b.end_year::character varying::text, 2), ' B', b.batch_no) AS batch_name,
    p.application_id,
    a.program_id,
    p3.name AS program_name,
        CASE
            WHEN p4.name IS NULL THEN 'not applicable'::character varying
            ELSE p4.name
        END AS parent_program_name,
    bases.name AS base_name,
    bb.name AS branch_name,
    p2.id AS pastor_id,
    concat(p2.firstname, ' ', p2.lastname) AS pastor_name,
    p2.middlename AS pastor_middlename,
        CASE
            WHEN pastor_data_cards.data_count > 5 THEN 'Active - Gold'::text
            WHEN pastor_data_cards.data_count >= 3 THEN 'Active - Silver'::text
            WHEN pastor_data_cards.data_count > 0 THEN 'Active - Bronze'::text
            ELSE 'Inactive'::text
        END AS pastor_status,
    concat(p.firstname, ' ', p.lastname) AS participant_name,
    p.middlename AS part_middlename,
    p.gender AS part_gender,
    "left"(now()::character varying::text, 4)::integer - "left"(p.birthdate::text, 4)::integer AS participant_age_est,
    p.birthdate AS part_birthdate,
    p.phone_number AS part_phonenumber,
    p.type AS part_type,
    p.status AS part_status,
    p.is_visitor AS part_isvisitor,
    p.total_income AS part_income,
    p.total_poverty_score AS part_povscore,
    p.selection_score AS part_selectionscore,
        CASE
            WHEN p.is_non_sg IS TRUE THEN 'non-member'::character varying
            WHEN p.is_kid_saver IS TRUE THEN 'kid saver'::character varying
            WHEN p.is_non_icm_participant IS TRUE THEN 'non-icm member'::character varying
            ELSE p.sg_role
        END AS part_sg_role,
    pa.h2h_week1::integer AS h2h_week1,
    pa.h2h_week1_proxy::integer AS h2h_week1_proxy,
    pa.h2h_week2::integer AS h2h_week2,
    pa.h2h_week2_proxy::integer AS h2h_week2_proxy,
    pa.h2h_week3::integer AS h2h_week3,
    pa.h2h_week3_proxy::integer AS h2h_week3_proxy,
    pa.h2h_week4::integer AS h2h_week4,
    pa.h2h_week4_proxy::integer AS h2h_week4_proxy,
    pa.week1::integer AS week1,
    pa.week1_proxy::integer AS week1_proxy,
    pa.week1::integer - pa.week1_proxy::integer AS week1_real,
    pa.week2::integer AS week2,
    pa.week2_proxy::integer AS week2_proxy,
    pa.week2::integer - pa.week2_proxy::integer AS week2_real,
    pa.week3::integer AS week3,
    pa.week3_proxy::integer AS week3_proxy,
    pa.week3::integer - pa.week3_proxy::integer AS week3_real,
    pa.week4::integer AS week4,
    pa.week4_proxy::integer AS week4_proxy,
    pa.week4::integer - pa.week4_proxy::integer AS week4_real,
    pa.week5::integer AS week5,
    pa.week5_proxy::integer AS week5_proxy,
    pa.week5::integer - pa.week5_proxy::integer AS week5_real,
    pa.week6::integer AS week6,
    pa.week6_proxy::integer AS week6_proxy,
    pa.week5::integer - pa.week6_proxy::integer AS week6_real,
    pa.week7::integer AS week7,
    pa.week7_proxy::integer AS week7_proxy,
    pa.week7::integer - pa.week7_proxy::integer AS week7_real,
    pa.week8::integer AS week8,
    pa.week8_proxy::integer AS week8_proxy,
    pa.week8::integer - pa.week8_proxy::integer AS week8_real,
    pa.week9::integer AS week9,
    pa.week9_proxy::integer AS week9_proxy,
    pa.week9::integer - pa.week9_proxy::integer AS week9_real,
    pa.week10::integer AS week10,
    pa.week10_proxy::integer AS week10_proxy,
    pa.week10::integer - pa.week10_proxy::integer AS week10_real,
    pa.week11::integer AS week11,
    pa.week11_proxy::integer AS week11_proxy,
    pa.week11::integer - pa.week11_proxy::integer AS week11_real,
    pa.week12::integer AS week12,
    pa.week12_proxy::integer AS week12_proxy,
    pa.week12::integer - pa.week12_proxy::integer AS week12_real,
    pa.week13::integer AS week13,
    pa.week13_proxy::integer AS week13_proxy,
    pa.week13::integer - pa.week13_proxy::integer AS week13_real,
    pa.week14::integer AS week14,
    pa.week14_proxy::integer AS week14_proxy,
    pa.week14::integer - pa.week14_proxy::integer AS week14_real,
    pa.week15::integer AS week15,
    pa.week15_proxy::integer AS week15_proxy,
    pa.week15::integer - pa.week15_proxy::integer AS week15_real,
    pa.graduate,
    pa.week1::integer + pa.week2::integer + pa.week3::integer + pa.week4::integer + pa.week5::integer + pa.week6::integer + pa.week7::integer + pa.week8::integer + pa.week9::integer + pa.week10::integer + pa.week11::integer + pa.week12::integer + pa.week13::integer + pa.week14::integer + pa.week15::integer AS part_attend_wproxy,
    pa.week1::integer + pa.week2::integer + pa.week3::integer + pa.week4::integer + pa.week5::integer + pa.week6::integer + pa.week7::integer + pa.week8::integer + pa.week9::integer + pa.week10::integer + pa.week11::integer + pa.week12::integer + pa.week13::integer + pa.week14::integer + pa.week15::integer - (pa.week1_proxy::integer + pa.week2_proxy::integer + pa.week3_proxy::integer + pa.week4_proxy::integer + pa.week5_proxy::integer + pa.week6_proxy::integer + pa.week7_proxy::integer + pa.week8_proxy::integer + pa.week9_proxy::integer + pa.week10_proxy::integer + pa.week11_proxy::integer + pa.week12_proxy::integer + pa.week13_proxy::integer + pa.week14_proxy::integer + pa.week15_proxy::integer) AS part_attend_only,
    pa.garden_week1,
    pa.garden_week14,
    p.deleted_at AS part_deleted_at,
    p.created_at AS part_created_at,
    p.updated_at AS part_updated_at
   FROM participants p
     LEFT JOIN participant_attendances pa ON p.id = pa.participant_id
     LEFT JOIN applications a ON p.application_id = a.id
     LEFT JOIN communities c ON a.id = c.application_id
     LEFT JOIN batches b ON c.batch_id = b.id
     LEFT JOIN pastors p2 ON a.pastor_id = p2.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id
           FROM data_cards
          WHERE data_cards.attended_at >= ('now'::text::date - '1 year'::interval)
          GROUP BY data_cards.pastor_id) pastor_data_cards ON pastor_data_cards.pastor_id = p2.id
     LEFT JOIN programs p3 ON a.program_id = p3.id
     LEFT JOIN programs p4 ON p3.parent_program_id = p4.id
     LEFT JOIN bases ON a.base_id = bases.id
     LEFT JOIN base_branches bb ON a.base_branch_id = bb.id
  WHERE b.id = 28 AND bases.name::text <> 'Manila - Beta Test'::text AND p.status::text <> 'disqualified'::text AND p.deleted_at IS NOT NULL;
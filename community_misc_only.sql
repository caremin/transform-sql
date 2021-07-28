CREATE OR REPLACE VIEW public.community_misc_only
AS SELECT applications.id AS application_id,
    bases.old_id AS icm_base_id,
    communities.id AS sys_community_id,
        CASE
            WHEN communities.community_id::text = ''::text THEN 0
            ELSE communities.community_id::integer
        END AS icm_community_id,
    bases.name AS base_name,
    base_branches.name AS branch_name,
    concat(bases.name, ' ', base_branches.name) AS base_branch_name,
    concat('FY', "right"(batches.fiscal_year::text, 2), '-', "right"(batches.end_year::text, 2), ' B', batches.batch_no) AS batch_name,
    community_garden.comm_garden_week1,
    community_garden.comm_garden_week14,
    community_vermi.vermi_week1,
    community_vermi.vermi_week14,
    community_pastoralh2h.aint1 AS pastor_h2h_week1,
    community_pastoralh2h.aint2 AS pastor_h2h_week2,
    community_pastoralh2h.aint3 AS pastor_h2h_week3,
    community_pastoralh2h.aint4 AS pastor_h2h_week4,
    community_pastoralh2h.aint5 AS pastor_h2h_week5,
    community_pastoralh2h.aint6 AS pastor_h2h_week6,
    community_pastoralh2h.aint7 AS pastor_h2h_week7,
    community_pastoralh2h.aint8 AS pastor_h2h_week8,
    community_pastoralh2h.aint9 AS pastor_h2h_week9,
    community_pastoralh2h.aint10 AS pastor_h2h_week10,
    community_pastoralh2h.aint11 AS pastor_h2h_week11,
    community_pastoralh2h.aint12 AS pastor_h2h_week12,
    community_pastoralh2h.aint13 AS pastor_h2h_week13,
    community_pastoralh2h.aint14 AS pastor_h2h_week14,
    visitor_count.aint1 AS visitors_week1,
    visitor_count.aint2 AS visitors_week2,
    visitor_count.aint3 AS visitors_week3,
    visitor_count.aint4 AS visitors_week4,
    visitor_count.aint5 AS visitors_week5,
    visitor_count.aint6 AS visitors_week6,
    visitor_count.aint7 AS visitors_week7,
    visitor_count.aint8 AS visitors_week8,
    visitor_count.aint9 AS visitors_week9,
    visitor_count.aint10 AS visitors_week10,
    visitor_count.aint11 AS visitors_week11,
    visitor_count.aint12 AS visitors_week12,
    visitor_count.aint13 AS visitors_week13,
    visitor_count.aint14 AS visitors_week14,
    visitor_count.aint15 AS visitors_week15,
    children_count.aint1 AS children_week1,
    children_count.aint2 AS children_week2,
    children_count.aint3 AS children_week3,
    children_count.aint4 AS children_week4,
    children_count.aint5 AS children_week5,
    children_count.aint6 AS children_week6,
    children_count.aint7 AS children_week7,
    children_count.aint8 AS children_week8,
    children_count.aint9 AS children_week9,
    children_count.aint10 AS children_week10,
    children_count.aint11 AS children_week11,
    children_count.aint12 AS children_week12,
    children_count.aint13 AS children_week13,
    children_count.aint14 AS children_week14,
    children_count.aint15 AS children_week15,
    lesson_count.aint1 AS doublelesson_week1,
    lesson_count.aint2 AS doublelesson_week2,
    lesson_count.aint3 AS doublelesson_week3,
    lesson_count.aint4 AS doublelesson_week4,
    lesson_count.aint5 AS doublelesson_week5,
    lesson_count.aint6 AS doublelesson_week6,
    lesson_count.aint7 AS doublelesson_week7,
    lesson_count.aint8 AS doublelesson_week8,
    lesson_count.aint9 AS doublelesson_week9,
    lesson_count.aint10 AS doublelesson_week10,
    lesson_count.aint11 AS doublelesson_week11,
    lesson_count.aint12 AS doublelesson_week12,
    lesson_count.aint13 AS doublelesson_week13,
    lesson_count.aint14 AS doublelesson_week14,
    lesson_count.aint15 AS doublelesson_week15,
    nutripacks_count.afloat1 AS nutripacks_week1,
    nutripacks_count.afloat2 AS nutripacks_week2,
    nutripacks_count.afloat3 AS nutripacks_week3,
    nutripacks_count.afloat4 AS nutripacks_week4,
    nutripacks_count.afloat5 AS nutripacks_week5,
    nutripacks_count.afloat6 AS nutripacks_week6,
    nutripacks_count.afloat7 AS nutripacks_week7,
    nutripacks_count.afloat8 AS nutripacks_week8,
    nutripacks_count.afloat9 AS nutripacks_week9,
    nutripacks_count.afloat10 AS nutripacks_week10,
    nutripacks_count.afloat11 AS nutripacks_week11,
    nutripacks_count.afloat12 AS nutripacks_week12,
    nutripacks_count.afloat13 AS nutripacks_week13,
    nutripacks_count.afloat14 AS nutripacks_week14,
    nutripacks_count.afloat15 AS nutripacks_week15,
    weeklyhuddle_count.afloat1 AS huddle_week1,
    weeklyhuddle_count.afloat2 AS huddle_week2,
    weeklyhuddle_count.afloat3 AS huddle_week3,
    weeklyhuddle_count.afloat4 AS huddle_week4,
    weeklyhuddle_count.afloat5 AS huddle_week5,
    weeklyhuddle_count.afloat6 AS huddle_week6,
    weeklyhuddle_count.afloat7 AS huddle_week7,
    weeklyhuddle_count.afloat8 AS huddle_week8,
    weeklyhuddle_count.afloat9 AS huddle_week9,
    weeklyhuddle_count.afloat10 AS huddle_week10,
    weeklyhuddle_count.afloat11 AS huddle_week11,
    weeklyhuddle_count.afloat12 AS huddle_week12,
    weeklyhuddle_count.afloat13 AS huddle_week13,
    weeklyhuddle_count.afloat14 AS huddle_week14,
    weeklyhuddle_count.afloat15 AS huddle_week15,
    vermikit_count.afloat1 AS vermikit_week1,
    vermikit_count.afloat2 AS vermikit_week2,
    vermikit_count.afloat3 AS vermikit_week3,
    vermikit_count.afloat4 AS vermikit_week4,
    vermikit_count.afloat5 AS vermikit_week5,
    vermikit_count.afloat6 AS vermikit_week6,
    vermikit_count.afloat7 AS vermikit_week7,
    vermikit_count.afloat8 AS vermikit_week8,
    vermikit_count.afloat9 AS vermikit_week9,
    vermikit_count.afloat10 AS vermikit_week10,
    vermikit_count.afloat11 AS vermikit_week11,
    vermikit_count.afloat12 AS vermikit_week12,
    vermikit_count.afloat13 AS vermikit_week13,
    vermikit_count.afloat14 AS vermikit_week14,
    gibkit_count.afloat1 AS gibkit_week1,
    gibkit_count.afloat2 AS gibkit_week2,
    gibkit_count.afloat3 AS gibkit_week3,
    gibkit_count.afloat4 AS gibkit_week4,
    gibkit_count.afloat5 AS gibkit_week5,
    gibkit_count.afloat6 AS gibkit_week6,
    gibkit_count.afloat7 AS gibkit_week7,
    gibkit_count.afloat8 AS gibkit_week8,
    gibkit_count.afloat9 AS gibkit_week9,
    gibkit_count.afloat10 AS gibkit_week10,
    gibkit_count.afloat11 AS gibkit_week11,
    gibkit_count.afloat12 AS gibkit_week12,
    gibkit_count.afloat13 AS gibkit_week13,
    gibkit_count.afloat14 AS gibkit_week14
   FROM communities
     LEFT JOIN applications ON applications.id = communities.application_id
     LEFT JOIN batches ON batches.id = communities.batch_id
     LEFT JOIN bases ON bases.id = applications.base_id
     LEFT JOIN base_branches ON base_branches.id = applications.base_branch_id
     LEFT JOIN programs ON programs.id = applications.program_id
     LEFT JOIN pastors ON pastors.id = applications.pastor_id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
            community_weekly_stats.week1 AS comm_garden_week1,
            community_weekly_stats.week14 AS comm_garden_week14
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'with_community_garden'::text) community_garden ON communities.id = community_garden.community_id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
            community_weekly_stats.week1 AS vermi_week1,
            community_weekly_stats.week14 AS vermi_week14
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'with_vermiculture'::text) community_vermi ON communities.id = community_vermi.community_id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0
                    ELSE community_weekly_stats.week1::integer
                END AS aint1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0
                    ELSE community_weekly_stats.week2::integer
                END AS aint2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0
                    ELSE community_weekly_stats.week3::integer
                END AS aint3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0
                    ELSE community_weekly_stats.week4::integer
                END AS aint4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0
                    ELSE community_weekly_stats.week5::integer
                END AS aint5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0
                    ELSE community_weekly_stats.week6::integer
                END AS aint6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0
                    ELSE community_weekly_stats.week7::integer
                END AS aint7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0
                    ELSE community_weekly_stats.week8::integer
                END AS aint8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0
                    ELSE community_weekly_stats.week9::integer
                END AS aint9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0
                    ELSE community_weekly_stats.week10::integer
                END AS aint10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0
                    ELSE community_weekly_stats.week11::integer
                END AS aint11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0
                    ELSE community_weekly_stats.week12::integer
                END AS aint12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0
                    ELSE community_weekly_stats.week13::integer
                END AS aint13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0
                    ELSE community_weekly_stats.week14::integer
                END AS aint14,
                CASE
                    WHEN community_weekly_stats.week15::text = ''::text THEN 0
                    ELSE community_weekly_stats.week15::integer
                END AS aint15
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'no_of_h2h_by_pastor_and_counselors'::text) community_pastoralh2h ON communities.id = community_pastoralh2h.community_id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0
                    ELSE community_weekly_stats.week1::integer
                END AS aint1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0
                    ELSE community_weekly_stats.week2::integer
                END AS aint2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0
                    ELSE community_weekly_stats.week3::integer
                END AS aint3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0
                    ELSE community_weekly_stats.week4::integer
                END AS aint4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0
                    ELSE community_weekly_stats.week5::integer
                END AS aint5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0
                    ELSE community_weekly_stats.week6::integer
                END AS aint6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0
                    ELSE community_weekly_stats.week7::integer
                END AS aint7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0
                    ELSE community_weekly_stats.week8::integer
                END AS aint8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0
                    ELSE community_weekly_stats.week9::integer
                END AS aint9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0
                    ELSE community_weekly_stats.week10::integer
                END AS aint10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0
                    ELSE community_weekly_stats.week11::integer
                END AS aint11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0
                    ELSE community_weekly_stats.week12::integer
                END AS aint12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0
                    ELSE community_weekly_stats.week13::integer
                END AS aint13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0
                    ELSE community_weekly_stats.week14::integer
                END AS aint14,
                CASE
                    WHEN community_weekly_stats.week15::text = ''::text THEN 0
                    ELSE community_weekly_stats.week15::integer
                END AS aint15
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'weekly_visitor_count'::text) visitor_count ON visitor_count.community_id = communities.id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0
                    ELSE community_weekly_stats.week1::integer
                END AS aint1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0
                    ELSE community_weekly_stats.week2::integer
                END AS aint2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0
                    ELSE community_weekly_stats.week3::integer
                END AS aint3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0
                    ELSE community_weekly_stats.week4::integer
                END AS aint4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0
                    ELSE community_weekly_stats.week5::integer
                END AS aint5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0
                    ELSE community_weekly_stats.week6::integer
                END AS aint6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0
                    ELSE community_weekly_stats.week7::integer
                END AS aint7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0
                    ELSE community_weekly_stats.week8::integer
                END AS aint8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0
                    ELSE community_weekly_stats.week9::integer
                END AS aint9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0
                    ELSE community_weekly_stats.week10::integer
                END AS aint10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0
                    ELSE community_weekly_stats.week11::integer
                END AS aint11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0
                    ELSE community_weekly_stats.week12::integer
                END AS aint12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0
                    ELSE community_weekly_stats.week13::integer
                END AS aint13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0
                    ELSE community_weekly_stats.week14::integer
                END AS aint14,
                CASE
                    WHEN community_weekly_stats.week15::text = ''::text THEN 0
                    ELSE community_weekly_stats.week15::integer
                END AS aint15
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'weekly_children_count'::text) children_count ON children_count.community_id = communities.id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
            community_weekly_stats.week1 AS aint1,
            community_weekly_stats.week2 AS aint2,
            community_weekly_stats.week3 AS aint3,
            community_weekly_stats.week4 AS aint4,
            community_weekly_stats.week5 AS aint5,
            community_weekly_stats.week6 AS aint6,
            community_weekly_stats.week7 AS aint7,
            community_weekly_stats.week8 AS aint8,
            community_weekly_stats.week9 AS aint9,
            community_weekly_stats.week10 AS aint10,
            community_weekly_stats.week11 AS aint11,
            community_weekly_stats.week12 AS aint12,
            community_weekly_stats.week13 AS aint13,
            community_weekly_stats.week14 AS aint14,
            community_weekly_stats.week15 AS aint15
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'weekly_double_lesson'::text) lesson_count ON lesson_count.community_id = communities.id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week1::double precision
                END AS afloat1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week2::double precision
                END AS afloat2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week3::double precision
                END AS afloat3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week4::double precision
                END AS afloat4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week5::double precision
                END AS afloat5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week6::double precision
                END AS afloat6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week7::double precision
                END AS afloat7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week8::double precision
                END AS afloat8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week9::double precision
                END AS afloat9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week10::double precision
                END AS afloat10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week11::double precision
                END AS afloat11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week12::double precision
                END AS afloat12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week13::double precision
                END AS afloat13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week14::double precision
                END AS afloat14,
                CASE
                    WHEN community_weekly_stats.week15::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week15::double precision
                END AS afloat15
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'weekly_overall_nutripacks'::text) nutripacks_count ON nutripacks_count.community_id = communities.id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week1::double precision
                END AS afloat1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week2::double precision
                END AS afloat2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week3::double precision
                END AS afloat3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week4::double precision
                END AS afloat4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week5::double precision
                END AS afloat5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week6::double precision
                END AS afloat6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week7::double precision
                END AS afloat7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week8::double precision
                END AS afloat8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week9::double precision
                END AS afloat9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week10::double precision
                END AS afloat10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week11::double precision
                END AS afloat11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week12::double precision
                END AS afloat12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week13::double precision
                END AS afloat13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week14::double precision
                END AS afloat14,
                CASE
                    WHEN community_weekly_stats.week15::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week15::double precision
                END AS afloat15
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'weekly_huddle'::text) weeklyhuddle_count ON weeklyhuddle_count.community_id = communities.id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week1::double precision
                END AS afloat1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week2::double precision
                END AS afloat2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week3::double precision
                END AS afloat3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week4::double precision
                END AS afloat4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week5::double precision
                END AS afloat5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week6::double precision
                END AS afloat6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week7::double precision
                END AS afloat7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week8::double precision
                END AS afloat8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week9::double precision
                END AS afloat9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week10::double precision
                END AS afloat10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week11::double precision
                END AS afloat11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week12::double precision
                END AS afloat12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week13::double precision
                END AS afloat13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week14::double precision
                END AS afloat14
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'no_of_free_vermi_kit_dispersed'::text) vermikit_count ON vermikit_count.community_id = communities.id
     LEFT JOIN ( SELECT community_weekly_stats.community_id,
                CASE
                    WHEN community_weekly_stats.week1::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week1::double precision
                END AS afloat1,
                CASE
                    WHEN community_weekly_stats.week2::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week2::double precision
                END AS afloat2,
                CASE
                    WHEN community_weekly_stats.week3::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week3::double precision
                END AS afloat3,
                CASE
                    WHEN community_weekly_stats.week4::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week4::double precision
                END AS afloat4,
                CASE
                    WHEN community_weekly_stats.week5::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week5::double precision
                END AS afloat5,
                CASE
                    WHEN community_weekly_stats.week6::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week6::double precision
                END AS afloat6,
                CASE
                    WHEN community_weekly_stats.week7::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week7::double precision
                END AS afloat7,
                CASE
                    WHEN community_weekly_stats.week8::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week8::double precision
                END AS afloat8,
                CASE
                    WHEN community_weekly_stats.week9::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week9::double precision
                END AS afloat9,
                CASE
                    WHEN community_weekly_stats.week10::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week10::double precision
                END AS afloat10,
                CASE
                    WHEN community_weekly_stats.week11::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week11::double precision
                END AS afloat11,
                CASE
                    WHEN community_weekly_stats.week12::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week12::double precision
                END AS afloat12,
                CASE
                    WHEN community_weekly_stats.week13::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week13::double precision
                END AS afloat13,
                CASE
                    WHEN community_weekly_stats.week14::text = ''::text THEN 0::double precision
                    ELSE community_weekly_stats.week14::double precision
                END AS afloat14
           FROM community_weekly_stats
          WHERE community_weekly_stats.name::text = 'no_of_free_gib_kit_dispersed'::text) gibkit_count ON gibkit_count.community_id = communities.id;
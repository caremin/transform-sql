CREATE OR REPLACE VIEW public.sg_livelihood_prevail
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
        CASE
            WHEN b2.stream_name IS NULL THEN 'none'::text
            WHEN b2.stream_name::text = batches.stream_name::text THEN 'new'::text
            WHEN b2.stream_name::integer < batches.stream_name::integer THEN 'merged'::text
            WHEN b2.stream_name::integer > batches.stream_name::integer THEN 'merged forward'::text
            ELSE 'other'::text
        END AS sg_creation,
    b2.stream_name AS sg_stream,
    batches.start_at AS community_batchstart,
    batches.end_at AS community_batchend,
    applications.program_id,
        CASE
            WHEN applications.program_id = 1 THEN 'Transform Level 1'::text
            ELSE
            CASE
                WHEN applications.program_id = 6 THEN 'Transform Level 1'::text
                ELSE 'Transform Level 2'::text
            END
        END AS program_name,
    pastors.id AS pastor_id,
    concat(pastors.firstname, ' ', pastors.lastname) AS pastor_name,
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
        END AS pastor_status,
    pastors.gender AS pastor_gender,
    savings_groups.name AS sg_name,
    savings_groups.id AS sg_id,
    savings_groups.deleted_at AS sg_deleted,
    savings_groups.pastor_id AS sg_pastor_id,
    clusters.id AS cluster_id,
    clusters.name AS cluster_name,
    districts.id AS district_id,
    districts.name AS district_name,
    sg_role.sg_treasurer,
    sg_role.sg_auditor,
    sg_role.sg_secretary,
    sg_role.sg_leader,
    sg_role.sg_officer,
        CASE
            WHEN sg_role.sg_officer > 0 THEN 'officers'::text
            ELSE 'no officers'::text
        END AS sg_formation,
    sg_summary_upd.sg_end AS sg_batch_end,
    sg_summary_upd.prevail_attend AS sg_prevail_attend,
        CASE
            WHEN sg_summary_upd.prevail_attend = 1 AND sg_summary_upd.transform_attend = 0 THEN 'not transitioned'::text
            WHEN sg_summary_upd.sg_id IS NULL THEN 'no sg'::text
            WHEN sg_summary_upd.sg_id IS NOT NULL AND sg_summary_upd.prevail_attend >= 1 THEN 'transitioned'::text
            ELSE 'not transitioned'::text
        END AS sg_prevail_transition,
    sg_summary_upd.transform_attend AS sg_transform_attend,
    sg_summary_upd.prevail_status12 AS sg_prevail_attend_last12,
    sg_summary_upd.first_report AS sg_first_report,
    sg_summary_upd.last_report AS sg_last_report,
    sg_summary_upd.max_reported_savings AS sg_max_savings,
    sg_summary_upd.max_loans_released AS sg_max_loans
   FROM communities
     LEFT JOIN applications ON applications.id = communities.application_id
     LEFT JOIN batches ON batches.id = communities.batch_id
     LEFT JOIN churches ON churches.id = applications.church_id
     LEFT JOIN bases ON bases.id = applications.base_id
     LEFT JOIN donors ON donors.id = communities.donor_id
     LEFT JOIN base_branches ON base_branches.id = applications.base_branch_id
     LEFT JOIN programs ON programs.id = applications.program_id
     LEFT JOIN pastors ON pastors.id = applications.pastor_id
     LEFT JOIN savings_groups ON savings_groups.id = communities.savings_group_id
     LEFT JOIN batches b2 ON b2.id = savings_groups.batch_id
     LEFT JOIN clusters ON clusters.id = savings_groups.cluster_id
     LEFT JOIN districts ON districts.id::text = pastors.district_id::text
     LEFT JOIN sg_summary_upd ON sg_summary_upd.sg_id = communities.savings_group_id
     LEFT JOIN ( SELECT p.application_id,
            count(NULLIF((p.sg_role::text = 'treasurer'::text) = false, true)) AS sg_treasurer,
            count(NULLIF((p.sg_role::text = 'auditor'::text) = false, true)) AS sg_auditor,
            count(NULLIF((p.sg_role::text = 'secretary'::text) = false, true)) AS sg_secretary,
            count(NULLIF((p.sg_role::text = 'leader'::text) = false, true)) AS sg_leader,
            count(NULLIF((p.sg_role::text = ANY (ARRAY['treasurer'::character varying, 'auditor'::character varying, 'secretary'::character varying, 'leader'::character varying]::text[])) = false, true)) AS sg_officer
           FROM participants p
          GROUP BY p.application_id) sg_role ON sg_role.application_id = applications.id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id
           FROM data_cards
          WHERE data_cards.attended_at >= ('2021-05-18'::date - '1 year'::interval)
          GROUP BY data_cards.pastor_id) pastor_data_cards ON pastor_data_cards.pastor_id = pastors.id;
CREATE OR REPLACE VIEW public.community_sg
AS SELECT concat('FY', "right"(b.fiscal_year::text, 2), '-', "right"(b.fiscal_year::text, 2)::integer + 1, ' B', b.batch_no) AS fy_batch,
    b.stream_name AS sg_stream,
    b2.name AS base_name,
    bb.name AS branch_name,
    c.community_id,
    c.old_community_id,
    c.savings_group_id,
    concat(p.firstname, ' ', p.lastname) AS pastor_name,
    a.pastor_id,
    sg.name AS sg_name,
    sg.deleted_at AS sg_deleted,
    sg.cluster_id,
    sg.created_at AS sg_created_at,
    a.id AS application_id,
    a.community_city,
    a.community_barangay,
    a.community_street,
    a.program_id,
    a.applied_at,
    a.approved
   FROM communities c
     LEFT JOIN applications a ON c.application_id = a.id
     LEFT JOIN pastors p ON a.pastor_id = p.id
     LEFT JOIN batches b ON c.batch_id = b.id
     LEFT JOIN base_branches bb ON a.base_branch_id = bb.id
     LEFT JOIN bases b2 ON a.base_id = b2.id
     LEFT JOIN savings_groups sg ON c.savings_group_id = sg.id;
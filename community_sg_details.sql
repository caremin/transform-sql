CREATE OR REPLACE VIEW public.community_sg_details
AS SELECT cs.fy_batch,
    cs.sg_stream,
    cs.base_name,
    cs.branch_name,
    cs.community_id,
    cs.old_community_id,
    cs.savings_group_id,
    cs.pastor_name,
    cs.pastor_id,
    cs.sg_name,
    cs.sg_deleted,
    cs.cluster_id,
    cs.sg_created_at,
    cs.application_id,
    cs.community_city,
    cs.community_barangay,
    cs.community_street,
    cs.program_id,
    cs.applied_at,
    cs.approved,
    ss.batch_end,
    ss.first_report,
    ss.last_report,
    ss.prevail_attend AS prevail_attend_aftertr,
    ss.transform_attend AS prevail_attend_beforetr,
    ss.prevail_status12 AS prevail_attend_last12mo,
    ss.max_reported_savings,
    ss.max_loans_released
   FROM community_sg cs
     LEFT JOIN sg_summary ss ON cs.savings_group_id = ss.sg_id;
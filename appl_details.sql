CREATE OR REPLACE VIEW public.appl_details
AS SELECT a.id AS application_id,
    b.name AS base_name,
    bb.name AS branch_name,
    pr.name AS appl_program,
    a.approved AS appl_approved,
    pd.pastor_name,
    pd.church_position,
    pd.denied_appl,
    pd.lv1_communities,
    pd.lv1_wfa_communities,
    pd.lv2_communities,
    pd.thrive_membership,
    pd.thrive_status,
    a.church_name,
    a.church_street,
    a.church_barangay,
    a.community_street,
    a.community_barangay,
    a.community_city,
    a.program_venue,
    a.means_of_transportation,
    a.source_of_water,
    a.source_of_income,
    a.brgy_chairman,
    a.distance AS dist_to_office,
    a.geo_type AS geotype,
    a.applied_at AS appl_applied_at,
    a.approved_at AS appl_approved_at,
    a.created_at AS appl_created_at,
    a.deleted_at AS appl_deleted_at,
    u1.username AS appl_created_by,
    u1.roles AS appl_created_role,
    u2.username AS appl_updated_by,
    u2.roles AS appl_updated_role
   FROM applications a
     LEFT JOIN pastors p ON p.id = a.pastor_id
     LEFT JOIN bases b ON b.id = a.base_id
     LEFT JOIN base_branches bb ON bb.id = a.base_branch_id
     LEFT JOIN programs pr ON a.program_id = pr.id
     LEFT JOIN users u1 ON a.created_by = u1.id
     LEFT JOIN users u2 ON a.updated_by = u2.id
     LEFT JOIN pastor_details pd ON pd.pastor_id = a.pastor_id
  WHERE a.deleted_at IS NULL;
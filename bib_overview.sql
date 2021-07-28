CREATE OR REPLACE VIEW public.bib_overview
AS SELECT communities.id AS sys_community_id,
    participants.id AS sys_participant_id,
    bases.name AS base_name,
    base_branches.name AS branch_name,
    concat(bases.name, ' ', base_branches.name) AS base_branch_name,
    concat('B', batches.batch_no, ' of FY', "right"(batches.fiscal_year::text, 2), "right"(batches.end_year::text, 2)) AS batch_name,
    applications.program_id,
        CASE
            WHEN applications.program_id = 1 THEN 'Transform Level 1'::text
            ELSE
            CASE
                WHEN applications.program_id = 6 THEN 'Transform Level 1'::text
                ELSE 'Transform Level 2'::text
            END
        END AS program_name,
    communities.community_id,
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
    churches.name AS church_name,
    applications.community_street,
    applications.community_barangay,
    applications.community_city,
    participants.original_participant_id AS initial_participant_id,
    concat(communities.community_id, participants.participant_id) AS participant_id,
    concat(participants.firstname, ' ', participants.lastname) AS participant_name,
    participants.gender,
    participants.type AS participant_type,
    participants.is_visitor,
        CASE
            WHEN participants.is_visitor IS TRUE THEN 'Visitor'::text
            WHEN participants.type::text = ANY (ARRAY['original'::character varying::text, 'original_replacement'::character varying::text]) THEN 'Participant'::text
            WHEN participants.type::text = ANY (ARRAY['counselor'::character varying::text, 'counselor_replacement'::character varying::text]) THEN 'Counselor'::text
            ELSE 'Pastor'::text
        END AS participant_category,
        CASE
            WHEN community_bib_participants.participant_id IS NULL THEN concat('past', community_bib_participants.pastor_id)
            ELSE community_bib_participants.participant_id::text
        END AS combined_part_past_id,
    participants.status AS poverty_scorecard,
    participants.total_income,
    community_bibs.id AS bib_id,
    concat('Week ', community_bibs.week) AS bib_week,
    products.name AS product_name,
    community_bib_participants.type AS bib_uptake,
    community_bib_participants.base_capital AS capital,
    community_bib_participants.total_capital,
    community_bib_participants.kits AS kits_given,
    payments.total_non_cash AS non_cash_payments,
    payments.total_cash AS cash_payments,
    community_bib_participants.total_payments,
    community_bib_participants.balance,
    payments.total_sales,
        CASE
            WHEN community_bib_participants.total_capital <> 0::double precision THEN LEAST(community_bib_participants.total_payments / community_bib_participants.total_capital, 1::double precision)
            ELSE 0::double precision
        END AS repayment_rate,
        CASE
            WHEN payments.total_sales > 0 THEN 'Yes'::text
            ELSE 'No'::text
        END AS made_a_sale
   FROM community_bib_participants
     LEFT JOIN participants ON participants.id = community_bib_participants.participant_id
     LEFT JOIN community_bibs ON community_bibs.id = community_bib_participants.community_bib_id
     LEFT JOIN communities ON communities.id = community_bibs.community_id
     LEFT JOIN applications ON applications.id = communities.application_id
     LEFT JOIN products ON products.id = community_bibs.product_id
     LEFT JOIN batches ON batches.id = communities.batch_id
     LEFT JOIN churches ON churches.id = applications.church_id
     LEFT JOIN bases ON bases.id = applications.base_id
     LEFT JOIN base_branches ON base_branches.id = applications.base_branch_id
     LEFT JOIN programs ON programs.id = applications.program_id
     LEFT JOIN pastors ON pastors.id = applications.pastor_id
     LEFT JOIN ( SELECT count(*) AS data_count,
            data_cards.pastor_id
           FROM data_cards
          WHERE data_cards.attended_at >= ('2021-05-18'::date - '1 year'::interval)
          GROUP BY data_cards.pastor_id) pastor_data_cards ON pastor_data_cards.pastor_id = pastors.id
     LEFT JOIN ( SELECT community_bib_participant_payments.bib_participant_id,
            sum(community_bib_participant_payments.cash) AS total_cash,
            sum(community_bib_participant_payments.non_cash) AS total_non_cash,
            sum(
                CASE
                    WHEN community_bib_participant_payments.sale THEN 1
                    ELSE 0
                END) AS total_sales
           FROM community_bib_participant_payments
          GROUP BY community_bib_participant_payments.bib_participant_id) payments ON payments.bib_participant_id = community_bib_participants.id
  WHERE (applications.id <> ALL (ARRAY[11, 15])) AND community_bibs.deleted_at IS NULL AND programs.active IS TRUE
  ORDER BY communities.community_id, participants.participant_id, community_bibs.community_id, community_bibs.updated_at DESC;

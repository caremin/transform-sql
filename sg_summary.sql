CREATE OR REPLACE VIEW public.sg_summary
AS SELECT sgd.savings_group_id AS sg_id,
    b.end_at AS batch_end,
    sum(
        CASE
            WHEN sgd.report_at > b.end_at THEN 1
            ELSE 0
        END) AS prevail_attend,
    sum(
        CASE
            WHEN sgd.report_at <= b.end_at THEN 1
            ELSE 0
        END) AS transform_attend,
    sum(
        CASE
            WHEN sgd.report_at > b.end_at AND sgd.report_at >= ('now'::text::date - '1 year'::interval) THEN 1
            ELSE 0
        END) AS prevail_status12,
    min(sgd.report_at) AS first_report,
    max(sgd.report_at) AS last_report,
    max(sgd.total_contributions) AS max_reported_savings,
    max(sgd.total_loans_released) AS max_loans_released
   FROM savings_group_data sgd
     LEFT JOIN savings_groups sg2 ON sg2.id = sgd.savings_group_id
     LEFT JOIN batches b ON b.id = sg2.batch_id
  GROUP BY sgd.savings_group_id, b.end_at;

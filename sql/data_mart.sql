-- финальная таблица агрегатов для дашбордов и аналитики
create or replace table `nth-plexus-489708-i1.marts.company_daily_metrics` as
select
  date(t.trip_start_tmp) as date,
  c.company_name,
  count(t.trip_id) as trips,
  round(sum(t.trip_total),0) as revenue,
  round(avg(t.trip_total),0) as avg_check
from 
  `nth-plexus-489708-i1.marts.fact_trips` t
  join `nth-plexus-489708-i1.marts.dim_company` c on t.company_id = c.company_id
group by
  date,
  c.company_name;

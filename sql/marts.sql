-- создаем dim (dimensions) которые потом можно будет использовать как отдельную бд и закрепляем за уникальными значениями id
-- сначала dim с информацией о компаниях
create or replace table `nth-plexus-489708-i1.marts.dim_company` as
select distinct
  row_number() over () as company_id,  -- создаем уникальный id
  company as company_name
from
  `nth-plexus-489708-i1.staging.trips`
group by
  company_name;

-- потом dim с информацией о типах оплаты
create or replace table `nth-plexus-489708-i1.marts.dim_payment_type` as
select distinct
  row_number() over () as payment_type_id,
  payment_type
from
  `nth-plexus-489708-i1.staging.trips`
group by
  payment_type;

-- создаем финальную таблицу с ссылками на уникальные id из dim (сразу проверка на join только с dim's)
create or replace table `nth-plexus-489708-i1.marts.fact_trips` as
select
  trip_id,
  taxi_id,
  trip_start_tmp,
  trip_end_tmp,
  trip_duration_seconds as trip_duration_sec,
  distance_miles as distance_mil,
  fare as fare_amt,
  tips as tips_amt,
  tolls as tolls_amt,
  trip_total,
  c.company_id,
  p.payment_type_id
from
  `nth-plexus-489708-i1.staging.trips` t
  join `nth-plexus-489708-i1.marts.dim_company` c on t.company = c.company_name
  join `nth-plexus-489708-i1.marts.dim_payment_type` p on t.payment_type = p.payment_type;

-- потом делаем календарь (с нуля потому что в таблице не каждый день были трипы)
create or replace table `nth-plexus-489708-i1.marts.dim_date` as
select
  date_day,
  extract(year from date_day) as year,
  extract(month from date_day) as month,
  extract(day from date_day) as day,
  extract(dayofweek from date_day) as day_of_week,
  case when extract(dayofweek from date_day) in (6, 7) then 'weekend' else 'weekday' end as day_type
from 
  unnest(generate_date_array((
    select min(cast(trip_start_tmp as date))
    from `nth-plexus-489708-i1.staging.trips`),
    (select max(cast(trip_start_tmp as date))
    from  `nth-plexus-489708-i1.staging.trips`))) as date_day;

-- создаем витрину агрегатов по дням
create or replace table `nth-plexus-489708-i1.marts.agg_trips_daily` as
select
  d.date_day,
  d.day_type,
  count(t.trip_id) as trips,
  round(sum(t.trip_total), 0) as revenue
from 
  `nth-plexus-489708-i1.marts.fact_trips` t
  join `nth-plexus-489708-i1.marts.dim_date` d on date(t.trip_start_tmp) = d.date_day
group by
  d.date_day,
  d.day_type;



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


-- таблица для логов тестов (тут будут храниться результаты проверок)
create or replace table `nth-plexus-489708-i1.marts.data_quality_log` (
  test_name string,
  test_result string,
  affected_rows int64,
  check_timestamp timestamp
);

-- test 1 - null в включах
insert into `nth-plexus-489708-i1.marts.data_quality_log`

select
  'trip_id_not_null' as test_name,
  case when countif(trip_id is null) = 0 then 'PASS' else 'FAIL'
  end as test_result,
  countif(trip_id is null) as affected_rows,
  current_timestamp() as check_timestamp
from 
  `nth-plexus-489708-i1.marts.fact_trips`;

-- test 2 - уникальность trip_id
insert into `nth-plexus-489708-i1.marts.data_quality_log`

select
  'trip_id_unique' as test_name,
  case when count(*) = count(distinct trip_id) then 'PASS' else 'FAIL'
  end as test_result,
  count(*) - count(distinct trip_id) as affected_rows,
  current_timestamp()
from 
  `nth-plexus-489708-i1.marts.fact_trips`;

-- смотрим лог
select *
from `nth-plexus-489708-i1.marts.data_quality_log`
order by check_timestamp desc;


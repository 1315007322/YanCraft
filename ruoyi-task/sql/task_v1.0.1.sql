-- task v1.0.1 task quantity tracking
-- encoding: UTF-8
-- idempotent migration for databases that already ran task_v1.0.0.sql

set @total_quantity_exists = (
  select count(*)
  from information_schema.columns
  where table_schema = database()
    and table_name = 'task_item'
    and column_name = 'total_quantity'
);

set @total_quantity_sql = if(
  @total_quantity_exists = 0,
  'alter table task_item add column total_quantity int(11) default null comment ''task total quantity'' after progress',
  'select 1'
);

prepare total_quantity_statement from @total_quantity_sql;
execute total_quantity_statement;
deallocate prepare total_quantity_statement;

set @completed_quantity_exists = (
  select count(*)
  from information_schema.columns
  where table_schema = database()
    and table_name = 'task_item'
    and column_name = 'completed_quantity'
);

set @completed_quantity_sql = if(
  @completed_quantity_exists = 0,
  'alter table task_item add column completed_quantity int(11) default null comment ''completed quantity'' after total_quantity',
  'select 1'
);

prepare completed_quantity_statement from @completed_quantity_sql;
execute completed_quantity_statement;
deallocate prepare completed_quantity_statement;

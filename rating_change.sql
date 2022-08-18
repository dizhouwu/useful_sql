create temporary table fuck ( rating VARCHAR,  d date);


insert into fuck (rating, d) values ('A', '2022-07-01');
insert into fuck (rating, d) values ('A', '2022-08-01');
insert into fuck (rating, d) values ('B', '2022-08-05');
insert into fuck (rating, d) values ('C', '2022-08-09');

select fuck.d as startTime,
       lead(fuck.d) over (order by fuck.d) as endTime,
       fuck.rating
from (select fuck.*, 
             lag(rating) over (order by d) as prev_rating
      from fuck
     ) fuck
where prev_rating is null or prev_rating <> rating;



select symbol, min(date), max(date)
from (select s.*,
             (row_number() over (order by date) - 
              row_number() over (partition by symbol order by date)
             ) as grp
      from s
     ) grp
group by grp, symbol;

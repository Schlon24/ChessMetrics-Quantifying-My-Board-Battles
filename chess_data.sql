select * from chess_schema.lichess_tbl;


with lichess_data_format as (
Select timestamp(createdat) as date,speed, status, winner, SUBSTRING_INDEX(opening, ':', 1) as opening,
SUBSTRING_INDEX(opening, ':', -1) as variation,
case when white_username = 'schlon24' then 1 else 0 end as played_white, black_username, white_username, white_rating, black_rating

 from chess_schema.lichess_tbl
where rated = 1),

chesscom_data_format as (
Select timestamp(date) as date, time_class, white_result, black_result, SUBSTRING_INDEX(opening_name, ':', 1) as opening,
SUBSTRING_INDEX(opening_name, ':', -1) as variation,
case when white_username = 'schloni' then 1 else 0 end as played_white, black_username, white_username, white_rating, black_rating

 from chess_schema.chesscom_tbl
)

select date,'lichess' as plattform,speed, opening,variation,played_white, white_username,black_username, white_rating, black_rating,

 case when played_white = 1 then black_username else white_username end as opponent_name, 
case when played_white = 1 then white_rating else black_rating end as my_rating,  
case when played_white = 1 then black_rating  else white_rating end as opp_rating ,
case when played_white = 1 and winner = 'white' then 'won'
	when played_white = 1 and winner = 'black' then 'lost'
   when played_white = 0 and winner = 'white' then 'lost'
   when played_white = 0 and winner = 'black' then 'won'
	when status in ('draw', 'stalemate') then 'draw' end as outcome 

from lichess_data_format


union all 

select date,'chesscom' as plattform,time_class as speed, opening,variation,played_white, white_username,black_username, white_rating, black_rating
, case when played_white = 1 then black_username else white_username end as opponent_name, 
case when played_white = 1 then white_rating else black_rating end as my_rating,  
case when played_white = 1 then black_rating  else white_rating end as opp_rating ,
case when played_white = 1 and white_result = 'win' then 'won'
	when played_white = 1 and black_result = 'win' then 'lost'
   when played_white = 0 and white_result = 'win' then 'lost'
   when played_white = 0 and black_result = 'win' then 'won'
	when white_result in ('draw', 'stalemate','repetition','timevsinsufficient') then 'draw' end as outcome 

from chesscom_data_format
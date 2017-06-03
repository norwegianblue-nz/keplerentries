USE drupal7;
/*
 * Initial Population
 */
 
TRUNCATE keplerentry_RaceNumbers ;
INSERT INTO keplerentry_RaceNumbers (racenum, RegID, uid, regentid, reg_state, lastname, firstname, city, year)
SELECT
 0, 
 regg.`registration_id` ,
 regg.`user_uid` AS registration_user_uid,
 regg.`entity_id` AS registration_entity_id,
 regg.`state` AS registration_state ,
 nadd.`field_name_address_last_name` ,
 nadd.`field_name_address_first_name` ,
 nadd.`field_name_address_locality` ,
 '2016-12-03 00:00:01'

FROM 
`drupal7`.`keplerentry_registration` regg

LEFT JOIN `keplerentry_users` ON regg.`user_uid` = `keplerentry_users`.uid
LEFT JOIN `keplerentry_profile` prof ON `keplerentry_users`.uid = prof.uid
LEFT JOIN `keplerentry_field_data_field_name_address` nadd on prof.pid = nadd.entity_id
WHERE regg.`state` in  ('paid','waitlist','invited', 'complete')
;

/*
 * Initial "SET" of the race numbers
 */
 
SET @rank=0;
UPDATE keplerentry_RaceNumbers SET racenum = (@rank:=@rank+1)
WHERE regentid = 3 and reg_state in ('paid' , 'complete','invited')
ORDER BY LASTNAME ASC , firstname asc, city asc;
SET @rank=700;
UPDATE keplerentry_RaceNumbers SET racenum = (@rank:=@rank+1)
WHERE regentid = 4 and reg_state in ('paid' , 'complete','invited')
ORDER BY LASTNAME ASC, firstname asc, city asc;

/* 
 * Adding in new race numbers
 *
 * All the below needs cusomising for the specific reg id's affected
 *
 */

/*Check if registration is in race no table */
SELECT * FROM `keplerentry_RaceNumbers` WHERE regid in(
    919, 963, 1030, 982);

/* Create missing entries (registrations moved from waitlist etc */
INSERT INTO keplerentry_RaceNumbers (racenum, RegID, uid, regentid, reg_state, lastname, firstname, city, year)
SELECT
 0, 
 regg.`registration_id` ,
 regg.`user_uid` AS registration_user_uid,
 regg.`entity_id` AS registration_entity_id,
 regg.`state` AS registration_state ,
 nadd.`field_name_address_last_name` ,
 nadd.`field_name_address_first_name` ,
 nadd.`field_name_address_locality` ,
 '2016-12-03 00:00:01'

FROM 
`drupal7`.`keplerentry_registration` regg

LEFT JOIN `keplerentry_users` ON regg.`user_uid` = `keplerentry_users`.uid
LEFT JOIN `keplerentry_profile` prof ON `keplerentry_users`.uid = prof.uid
LEFT JOIN `keplerentry_field_data_field_name_address` nadd on prof.pid = nadd.entity_id
WHERE regg.`registration_id` in  (1150,1152,1151,1153);

/*Update the race numbers */

UPDATE keplerentry_RaceNumbers SET racenum = 472 WHERE RegID = 919  ;
UPDATE keplerentry_RaceNumbers SET racenum = 473 WHERE RegID = 963  ;
UPDATE keplerentry_RaceNumbers SET racenum = 474 WHERE RegID = 1030 ;
UPDATE keplerentry_RaceNumbers SET racenum = 475 WHERE RegID = 982  ;
UPDATE keplerentry_RaceNumbers SET racenum = 466 WHERE RegID = 818  ;
UPDATE keplerentry_RaceNumbers SET racenum = 467 WHERE RegID = 826  ;
UPDATE keplerentry_RaceNumbers SET racenum = 468 WHERE RegID = 828  ;
UPDATE keplerentry_RaceNumbers SET racenum = 469 WHERE RegID = 845  ;
UPDATE keplerentry_RaceNumbers SET racenum = 470 WHERE RegID = 1153 ;
UPDATE keplerentry_RaceNumbers SET racenum = 471 WHERE RegID = 892  ;

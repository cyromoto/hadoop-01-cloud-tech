    --start pig
pig -useHCatalog

    --loading table values to the relation musictable
musictable= load 'musicset' using org.apache.hive.hcatalog.pig.HCatLoader() 
as (review_id,customer_id,review_body,review_headline,helpful_votes);

    --FILTER & GETTING TOP 10 SPAM ACCOUNTS
music_spam = FILTER musictable BY (UPPER(review_body) matches '.*(MOBILE|WIN|APPLY|AWARD|GUARANTEED|LATEST|150P|1ST|COLLECTION|MESSAGE|TONE|3|KNOW|WORD|LANDLINE|ENTRY|16|SELECTED|MINS|18|16|ORANGE|500|GUARANTEED|ATTEMPT|100|WEEKLY|NETWORK|UR|BACK|SEND|CALL|SAE|HOLIDAY|8007|2000|VALID|2ND|BOX|MSG|UK|CHANCE|PRIZE|AWAIT|TIME).*');

spammers = GROUP music_spam by customer_id;
s_account_count = FOREACH spammers GENERATE group,COUNT(music_spam) AS Total;
spam_accounts = ORDER s_account_count BY Total DESC;
top_spammers = LIMIT spam_accounts 10;

    --FILTER & GETTING TOP 10 HAM ACCOUNTS
music_ham = FILTER musictable BY (UPPER(review_body) matches '.*(TELL|NA|WORK|HEY|ALREADY|RE|AMP|GIVE|ASK|SAY|RIGHT|GREAT|VE|SAID|MAKE|PHONE|TOMORROW|OH|WAN|WAT|REALLY|E|HI|WOULD|MEET|YES|GOOD|K|WELL|PLS|PICK|DEAR|TEXT|SURE|SOMETHING|WEEK|MORNING|NUMBER|LIFE|BUY|ANYTHING|THING|GON|AROUND|CARE|FEEL|LOL|MESSAGE|YEAH|KEEP).*');

hammers = GROUP music_ham by customer_id;
h_account_count = FOREACH hammers GENERATE group,COUNT(music_ham) AS Total;
ham_accounts = ORDER h_account_count BY Total DESC;
top_hammers = LIMIT ham_accounts 10;





START TRANSACTION;

DROP TABLE IF EXISTS member, interest_group, event, event_member CASCADE;

CREATE TABLE member
(
	member_id serial,
	member_name varchar(32) NOT null,
	email varchar(40) null,
	phone varchar(13) null,
	birthday date null,
	email_reminder boolean,
	
	CONSTRAINT pk_member_id PRIMARY KEY (member_id)
);

CREATE TABLE interest_group
(
	group_id serial,
	group_name varchar(40) NOT null UNIQUE,
	member_id int null,
	
	CONSTRAINT pk_group_id PRIMARY KEY (group_id)
);

CREATE TABLE event
(
	event_id serial,
	event_name varchar(50) NOT null,
	description varchar(100) NOT null,
	start_time time NOT null,
	duration_in_minutes int NOT null CHECK (duration_in_minutes > 30),
	group_id int NOT null,
	
	CONSTRAINT pk_event_id PRIMARY KEY (event_id),
	CONSTRAINT fk_event_organizer FOREIGN KEY (group_id) REFERENCES interest_group(group_id)
);

CREATE TABLE event_member
(
	member_id int,
	event_id int,
	
	CONSTRAINT pk_event_member_id PRIMARY KEY (member_id, event_id),
	CONSTRAINT fk_member_id FOREIGN KEY (member_id) REFERENCES member (member_id),
	CONSTRAINT fk_event_id FOREIGN KEY (event_id) REFERENCES event (event_id)
);

INSERT INTO member (member_id, member_name, email, phone, birthday, email_reminder) VALUES 
	(1, 'Tom Bradshaw', 'tbshaw@gmail.com', '708-222-2222', null, true),
	(2, 'Brian Taylor', 'bt101@gmail.com', '773-765-4321', '03/12/1989', false),
	(3, 'Hello World', 'hithere@hotmail.com', '630-842-5555', '12/24/1990', true),
	(4, 'Tommy Twofeet', 'tt22@aol.com', '312-897-8823', null, true),
	(5, 'Brianne Belfort', 'bribel@outlook.com', '212-321-8845', '10/11/1982', true),
	(6, 'Fanny May', null, null, '11/11/1911', false),
	(7, 'Jill Jackrabbit', 'jj232@askjeeves.com', '737-222-3333', null, false),
	(8, 'Albert Fienstien', 'albetros@redfin.com', null, '03/14/1879', true),
	(9, 'Donald Duck', 'doubled45@nick.com', '312-425-5728', '6/9/1934', true),
	(10, 'Mickey Mouse', 'mightymick@gmail.com', null, '12/12/1928', false);
	
INSERT INTO interest_group (group_id, group_name, member_id) VALUES
	(1, 'ACLU', 2),
	(2, 'OxFam', 3),
	(3, 'AARP', 2),
	(4, 'NRA', 5),
	(5, 'Greenpeace', 6),
	(6, 'ATF', 9),
	(7, 'EPA', 10),
	(8, 'Environmental Defense Fund', 1),
	(9, 'The Sierra Club', null),
	(10, 'The American Alpine Club', 4),
	(11, 'Backcountry Skiing Club', null);
	
INSERT INTO event (event_id, event_name, description, start_time, duration_in_minutes, group_id) VALUES
	(1, 'Jumping into Backcountry Skiing', 'Learn important info to keep you safe in any backcounrty', '2/18/2024 10:00', 60, 11),
	(2, 'Saving our Planet', 'Come hear an expert panel on what we can do to keep the planet from destruction', '2/24/2024 15:00', 120, 8),
	(3, 'Guns for All!', 'Why owning a gun for protection is so important in 2024', '2/29/2024 16:00', 90, 4),
	(4, 'Dangers of Alcohol, Tobacco, and Firearms', 'ATF agents share the horrors of alcohol, tobacco and firearms in America', '2/22/2024 14:00', 60, 6),
	(5, 'Importance of A Retirment IRA', 'Listen to financial experts on why you need to save early and save often', '2/20/2024 11:00', 45, 3);

INSERT INTO event_member (event_id, member_id) VALUES
	(4, 5),
	(4, 3),
	(4, 1),
	(2, 2),
	(2, 4),
	(1, 10),
	(1, 9),
	(3, 8),
	(3, 7),
	(5, 6),
	(5, 3),
	(5, 8);

COMMIT;
--ROLLBACK;

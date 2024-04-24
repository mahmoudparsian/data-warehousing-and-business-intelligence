use music;

-- users table
-- This table defines users of the music streaming service
--
--	user_id: The unique identifier of the user
--	user_name: The name of the user
--	email: The email address of the user
--	country: The country where the user is located
--	plan: The subscription plan of the user, either ‘free’ or ‘premium’
--
DROP TABLE IF EXISTS users;
--
create table users(
	user_id int,
	user_name text,
	email text,
	country text,
	plan text
);

insert into users(user_id, user_name, email, country, plan)
values
(100, 'alex',   'alex@apple.com',    'USA',    'premium'),
(150, 'bob',    'bob@cnn.com',       'USA',    'premium'),
(200, 'jane',   'jane@cbs.com',      'USA',    'premium'),
(300, 'betty',  'bet@fb.com',        'USA',    'free'),
(400, 'rafa',   'rafa@tennis.com',   'USA',    'free'),
(500, 'ted',    'ted@tennis.com',    'CANADA', 'premium'),
(600, 'jeff',   'jeff@tennis.com',   'CANADA', 'premium'),
(700, 'max',    'max@tennis.com',    'CANADA', 'free'),
(750, 'terry',  'terry@tennis.com',  'CANADA', 'free'),
(800, 'al',     'al@gmail.com',      'SPAIN',  'premium'),
(900, 'david',  'david@tennis.com',  'SPAIN',  'premium'),
(800, 'carlos', 'carlos@tennis.com', 'SPAIN',  'free'),
(900, 'fiona',  'fiona@gmail.com',   'SPAIN',  'free'),
(500, 'albert', 'albert@pbs.com',    'FRANCE', 'premium'),
(550, 'suzie',  'suzie@tennis.com',  'FRANCE', 'premium'),
(570, 'ted',    'ted@tennis.com',    'FRANCE', null);


-- songs table
-- This table hits the right notes with details on 
-- the service’s song library. It includes:
--
--	song_id: The unique identifier of the song
--  title: The title of the song
--	artist: The name of the artist who performed the song
--	genre: The genre of the song
--	duration: The duration of the song in seconds
--
DROP TABLE IF EXISTS songs;
--
create table songs (
 song_id int,
 title text,
 artist text,
 genre text,
 duration int
);

insert into songs (song_id, title, artist, genre, duration)
values
(1, 'The 1',               'Taylor Swift', 'country', 195),
(2, 'Afterglow',           'Taylor Swift', 'country', 191),
(3, 'All Too Well',        'Taylor Swift', 'country', 182),
(4, 'Please Please Me',    'Beatles',      'rock', 175),
(5, 'With the Beatles',    'Beatles',      'rock', 181),
(6, 'Beatles for Sale',    'Beatles',      'rock', 189),
(7, '1000 Nights',         'Ed Sheeran',      'pop', 125),
(8, '2step',               'Ed Sheeran',      'pop', 181),
(9, 'The A Team',          'Ed Sheeran',      'pop', 199),
(10, 'Clarinet Quintet',   'Mozart',      'classic', 302),
(11, 'Requiem In D Minor', 'Mozart',      'classic', 290),
(12, 'Piano Concerto',     'Mozart',      'classic', 249),
(13, 'Symphony No. 3',        'Beethoven',      'classic', 302),
(14, 'Symphony No. 9',        'Beethoven',      'classic', 290),
(15, 'String Quartet No. 14', 'Beethoven',      'classic', 249),
(16, 'Ocean Eyes',        'Billie Eilish',      'pop', 260),
(17, 'Six Feet Under',    'Billie Eilish',      'pop', 270),
(18, 'Bored',             'Billie Eilish',      'pop', 280),
(19, 'Bad Guy',           'Billie Eilish',      'pop', 230),
(20, 'My Future',         'Billie Eilish',      'pop', 240);


-- plays table
-- 
-- And here, we track every time a user plays a song. 
-- It’s filled with information on:
--
--	play_id: The unique identifier of the play
--	user_id: The user who played the song
--	song_id: The song that was played
--	timestamp: The date and time when the song was played
--	device: The device used to play the song, either ‘mobile’ or ‘desktop’
--
DROP TABLE IF EXISTS plays;
--
create table plays (
 play_id int,
 user_id int,
 song_id int,
 time_stamp text, -- 2017-07-23 00:00:00
 device text      -- 'mobile' or 'desktop'
);

insert into plays (play_id, user_id, song_id, time_stamp, device)
values
(1,  100, 1, '2020-07-23 00:00:00', 'desktop'),
(2,  100, 1, '2020-07-23 00:00:00', 'desktop'),
(3,  100, 1, '2020-08-23 00:00:00', 'mobile'),
(4,  100, 2, '2020-09-23 00:00:00', 'mobile'),
(5,  100, 2, '2020-10-23 00:00:00', 'mobile'),
(6,  100, 9, '2020-09-23 00:00:00', 'mobile'),
(7,  100, 9, '2020-10-23 00:00:00', 'mobile'),
(8,  100, 4, '2021-07-23 00:00:00', 'desktop'),
(9,  100, 4, '2021-07-23 00:00:00', 'desktop'),
(10, 100, 4, '2021-08-23 00:00:00', 'mobile'),

(11,  200, 1, '2020-07-23 00:00:00', 'desktop'),
(12,  200, 1, '2020-07-23 00:00:00', 'desktop'),
(13,  200, 1, '2020-08-23 00:00:00', 'mobile'),
(14,  200, 3, '2020-09-23 00:00:00', 'mobile'),
(15,  200, 3, '2020-10-23 00:00:00', 'mobile'),
(16,  200, 3, '2020-09-23 00:00:00', 'mobile'),
(17,  200, 7, '2020-10-23 00:00:00', 'mobile'),
(18,  200, 7, '2021-07-23 00:00:00', 'desktop'),
(19,  200, 7, '2021-07-23 00:00:00', 'desktop'),
(20,  200, 8, '2021-08-23 00:00:00', 'mobile'),

(21,  300, 14, '2020-07-23 00:00:00', 'desktop'),
(22,  300, 15, '2020-07-23 00:00:00', 'desktop'),
(23,  300, 16, '2020-08-23 00:00:00', 'mobile'),
(24,  300, 3,  '2020-09-23 00:00:00', 'mobile'),
(25,  300, 3,  '2020-10-23 00:00:00', 'mobile'),

(26,  400, 10, '2020-09-23 00:00:00', 'mobile'),
(27,  400, 10, '2020-10-23 00:00:00', 'mobile'),
(28,  400, 11, '2021-07-23 00:00:00', 'desktop'),
(29,  400, 11, '2021-07-23 00:00:00', 'desktop'),
(30,  400, 12, '2021-08-23 00:00:00', 'mobile'),

(31,  500, 1, '2020-07-23 00:00:00', 'desktop'),
(32,  500, 1, '2020-07-23 00:00:00', 'desktop'),
(33,  500, 7, '2020-08-23 00:00:00', 'mobile'),
(34,  500, 7,  '2020-09-23 00:00:00', 'mobile'),
(35,  500, 7,  '2020-10-23 00:00:00', 'mobile'),

(36,  600, 10, '2020-09-23 00:00:00', 'mobile'),
(37,  600, 10, '2020-10-23 00:00:00', 'mobile'),
(38,  600, 14, '2021-07-23 00:00:00', 'desktop'),
(39,  600, 14, '2021-07-23 00:00:00', 'desktop'),
(40,  600, 14, '2021-08-23 00:00:00', 'mobile'),

(41,  700, 14, '2020-07-23 00:00:00', 'desktop'),
(42,  700, 14, '2020-07-23 00:00:00', 'desktop'),
(43,  700, 17, '2020-08-23 00:00:00', 'mobile'),
(44,  700, 17,  '2020-09-23 00:00:00', 'mobile'),
(45,  700, 17,  '2020-10-23 00:00:00', 'mobile'),

(46,  800, 8, '2020-09-23 00:00:00', 'mobile'),
(47,  800, 8, '2020-10-23 00:00:00', 'mobile'),
(48,  800, 9, '2021-07-23 00:00:00', 'desktop'),
(49,  800, 9, '2021-07-23 00:00:00', 'desktop'),
(50,  800, 9, '2021-08-23 00:00:00', 'mobile'),

(51,  900, 1, '2020-07-23 00:00:00', 'desktop'),
(52,  900, 1, '2020-07-23 00:00:00', 'desktop'),
(53,  900, 1, '2020-08-23 00:00:00', 'mobile'),
(54,  900, 5, '2020-09-23 00:00:00', 'mobile'),
(55,  900, 5, '2020-10-23 00:00:00', 'mobile'),
(56,  900, 6, '2020-09-23 00:00:00', 'mobile'),
(57,  900, 6, '2020-10-23 00:00:00', 'mobile'),
(58,  900, 8, '2021-07-23 00:00:00', 'desktop'),
(59,  900, 8, '2021-07-23 00:00:00', 'desktop'),
(60, 900, 8, '2021-08-23 00:00:00', 'mobile'),

(61,  100, 11, '2020-07-23 00:00:00', 'desktop'),
(62,  100, 11, '2020-07-23 00:00:00', 'desktop'),
(63,  100, 12, '2020-08-23 00:00:00', 'mobile'),
(64,  100, 12, '2020-09-23 00:00:00', 'mobile'),
(65,  100, 12, '2020-10-23 00:00:00', 'mobile'),
(66,  100, 4, '2020-09-23 00:00:00', 'mobile'),
(67,  100, 4, '2020-10-23 00:00:00', 'mobile'),
(68,  100, 8, '2021-07-23 00:00:00', 'desktop'),
(69,  100, 8, '2021-07-23 00:00:00', 'desktop'),
(70,  100, 8, '2021-08-23 00:00:00', 'mobile'),

(71,  300, 1, '2020-07-23 00:00:00', 'desktop'),
(72,  300, 1, '2020-07-23 00:00:00', 'desktop'),
(73,  300, 3, '2020-08-23 00:00:00', 'mobile'),
(74,  300, 3, '2020-09-23 00:00:00', 'mobile'),
(75,  300, 7, '2020-10-23 00:00:00', 'mobile'),
(76,  300, 7, '2020-09-23 00:00:00', 'mobile'),
(77,  300, 9, '2020-10-23 00:00:00', 'mobile'),
(78,  300, 9, '2021-07-23 00:00:00', 'desktop'),
(79,  300, 14, '2021-07-23 00:00:00', 'desktop'),
(80,  300, 14, '2021-08-23 00:00:00', 'mobile'),

(81,  400, 8, '2020-07-23 00:00:00', 'desktop'),
(82,  400, 8, '2020-07-23 00:00:00', 'desktop'),
(83,  400, 9, '2020-08-23 00:00:00', 'mobile'),
(84,  400, 9, '2020-09-23 00:00:00', 'mobile'),
(85,  400, 7, '2020-10-23 00:00:00', 'mobile'),
(86,  400, 7, '2020-09-23 00:00:00', 'mobile'),
(87,  400, 1, '2020-10-23 00:00:00', 'mobile'),
(88,  400, 1, '2021-07-23 00:00:00', 'desktop'),
(89,  400, 14, '2021-07-23 00:00:00', 'desktop'),
(90,  400, 14, '2021-08-23 00:00:00', 'mobile'),

(91,  600, 10, '2020-07-23 00:00:00', 'desktop'),
(92,  600, 10, '2020-07-23 00:00:00', 'desktop'),
(93,  600, 11, '2020-08-23 00:00:00', 'mobile'),
(94,  600, 11, '2020-09-23 00:00:00', 'mobile'),
(95,  600, 14, '2020-10-23 00:00:00', 'mobile'),
(96,  600, 14, '2020-09-23 00:00:00', 'mobile'),
(97,  600, 16, '2020-10-23 00:00:00', 'mobile'),
(98,  600, 16, '2021-07-23 00:00:00', 'desktop'),
(99,  600, 4, '2021-07-23 00:00:00', 'desktop'),
(100, 600, 4, '2021-08-23 00:00:00', 'mobile');

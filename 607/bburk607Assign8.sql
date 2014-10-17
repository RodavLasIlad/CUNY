/*
1.
http://phenomena.nationalgeographic.com
A generally interesting blog, but my favorite is the weekly links roundup they put on the weekend (I've got your missing link right here)
*/

/*
2.
See attached .png, please note that I tried to use the symbols for 1:M and M:M, if it is not clear then it is:
USER:COMMENTS (1:M) (Comments can only be made by one author)
USER:POST (1:M) (all the posts are by a single author, in other blogs it might be M:M )
POST:COMMENTS (1:M) (Comments can only apply to one post)
POST:TAGS (M:M) (One post may have many tags, many tags may apply to many posts)
*/

/*
3.
*/

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS tags;

CREATE TABLE users(
user_id			INT 			PRIMARY KEY,
username		VARCHAR(255)	NOT NULL,
email			VARCHAR(255)	NOT NULL
);

CREATE TABLE  posts(
post_id			INT								PRIMARY KEY,
title			VARCHAR(255)					NOT NULL,
post_content	TEXT							NOT NULL,
post_date		DATE							NOT NULL,
user_id			INT REFERENCES users(user_id)	NOT NULL
);

CREATE TABLE comments(
comment_id		INT								PRIMARY KEY,
user_id			INT REFERENCES users(user_id)	NOT NULL,
post_id			INT REFERENCES posts(post_id)	NOT NULL,
comment_content	TEXT							NOT NULL,
comment_date	DATE							NOT NULL,
notify_fut_com	VARCHAR(1)						NOT NULL,
notify_fut_post	VARCHAR(1)						NOT NULL
);

CREATE TABLE tags(
tag_id			INT				PRIMARY KEY,
tag				VARCHAR(255)	NOT NULL,
post_id			INT REFERENCES posts(post_id)
);

 /*
 4.
 You may notice this data is similar to the quiz data--thats because I lifted it for simplicity in creating users
 */
 
INSERT INTO users(user_id, username, email) 
VALUES (1, 'Steve Jobs', 'steve.jobs@apple.com'),
(2, 'Scott Forstall', 'scott.forstall@apple.com'),
(3, 'Isabel Ge Mahe', 'isabel.ge.mahe@apple.com'),
(4, 'Kim Vorrath', 'kim.vorrath@apple.com');

INSERT INTO posts(post_id, title, post_content, post_date, user_id)
VALUES (1, 'IS 607', 'This is class is so much fun!', '2014-10-17', 1),
(2, 'Merry Christmas!', 'Christmas is my favorite holiday', '2013-12-25', 1),
(3, 'Happy Halloween!', 'Halloween is my favorite holiday', '2013-10-31', 2),
(4, 'Happy Easter!', 'Easter is my favorite holiday', '2013-03-31', 4);

INSERT INTO comments(comment_id, user_id, post_id, comment_content, comment_date, notify_fut_com, notify_fut_post)
VALUES (1, 1, 2, 'I agree, Christmas is my favorite too!', '2013-12-25', 'Y', 'N'),
(2, 2, 1, 'Best class ever!', '2014-10-18', 'N', 'Y'),
(3, 3, 1, 'I agree, and not just because you are my boss!', '2014-10-19', 'N', 'Y'),
(4, 1, 3, 'Strongly disagree', '2013-12-25', 'Y', 'N'),
(5, 1, 4, 'No way', '2013-12-25', 'Y', 'N');

INSERT INTO tags(tag_id, tag, post_id)
VALUES (1, 'School', 1),
(2, 'CUNY', 1),
(3, 'Holidays', 2),
(4, 'Holidays', 3),
(5, 'Holidays', 4);

/*
5.a.
*/

SELECT * FROM posts
INNER JOIN comments ON (posts.post_id = comments.post_id)
INNER JOIN tags ON (posts.post_id = tags.post_id);

/*
5.b.
*/

SELECT * FROM posts
INNER JOIN tags ON (posts.post_id = tags.post_id)
WHERE (tags.tag = 'Holidays');
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEST NOT NULL
);

  INSERT INTO 
    users (fname, lname)
  VALUES  
    ("David", "Bane"), ("Richard", "Lane"), ("Draven", "Marquez");


-- QUESTIONS

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  student_id INTEGER NOT NULL,

  FOREIGN KEY (student_id) REFERENCES users(id)
);

INSERT INTO 
  questions (title, body, student_id)
SELECT 
  "David's question", "ORTYUETPOUY?", users.id
FROM 
  users 
WHERE 
  users.fname = "David" AND users.lname = "Bane";

INSERT INTO 
  questions (title, body, student_id)
SELECT
  "Richard's question", "ALFJDALKJLFJ?", users.id
FROM 
  users
WHERE 
  users.fname = "Richard" AND users.lname = "Lane";

INSERT INTO 
  questions (title, body, student_id)
SELECT 
  "Draven's question", ";LJJOIJLKLKANFLKAF?", users.id
FROM 
  users
WHERE 
  users.fname = "Draven" AND users.lname = "Marquez";

-- QUESTION_FOLLOWS

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = "David" AND lname = "Bane"),
    (SELECT id FROM questions WHERE title = "David's question")
);

INSERT INTO 
  question_follows (user_id, question_id)
VALUES  
  ((SELECT id FROM users WHERE fname = "Richard" AND lname = "Lane"),
    (SELECT id FROM questions WHERE title = "Richard's question")
);


CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  parent_reply_id INTEGER,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

  INSERT INTO   
    replies (parent_reply_id, question_id, user_id, body)
  VALUES  
    (NULL,
    (SELECT id FROM questions WHERE title = "David's question"),
    
    (SELECT id FROM users WHERE fname = "David" AND lname = "Bane"),
    "Please restate the question"
  );

  INSERT INTO
    replies (parent_reply_id, question_id, user_id, body)
  VALUES 
    ((SELECT id FROM replies WHERE body = "Please restate the question"),
      (SELECT id FROM questions WHERE title = "David's question"),
      (SELECT id FROM users WHERE fname = "David" AND lname = "Bane"),
      "This answer is the answer"
  );

-- QUESTION_LIKES 

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  question_likes (user_id, question_id)
VALUES 
    ((SELECT id FROM users WHERE fname = "David" AND lname = "Bane"),
    (SELECT id FROM questions WHERE title = "David's question")
);
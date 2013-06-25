CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
  username TEXT NOT NULL,
  password TEXT NOT NULL,
  dob TEXT NOT NULL,
  email TEXT NOT NULL,
  joindate TEXT NOT NULL,
  location TEXT NOT NULL,
  admin_level INT NOT NULL,
  bio TEXT
);

CREATE TABLE IF NOT EXISTS paragraphs (
    id INTEGER NOT NULL,
    content TEXT NOT NULL,
    parent_id INT,
    votes INT NOT NULL,
    author_id INT NOT NULL,
    approved INT NOT NULL,
    story_id INT NOT NULL,
    created TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS stories (
    id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    created_time TEXT NOT NULL,
    author_init_comment TEXT NOT NULL,
    votes INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS rules (
    id INTEGER NOT NULL,
    story_id INTEGER NOT NULL,
    rule_def_id INTEGER NOT NULL,
    params TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ruleDefs (
    id INTEGER NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS comments (
    id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    story_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    created_time TEXT NOT NULL,
    PRIMARY KEY (id)
) ;

REPLACE INTO users (id, fname, lname, username, password, dob, email, joindate, location, admin_level, bio)
    VALUES (0, 'Barry', 'Schultz', 'barry_1233', "261da58a9c89ca6e5840cc9a65d9968a15a8b52599df61ef770210b5c2c8d09a", "2000-11-16 00:00:00.00000",
    'barry.sucks@gmail.com', "2000-11-16", 'Sydney', 0, "Hi, I'm Barry!");
REPLACE INTO users (id, fname, lname, username, password, dob, email, joindate, location, admin_level, bio)
    VALUES (1, 'Larry', 'Schultz', 'larry', '6ed3e9a7197a1f208b29862d810e2fc31b71184a0c3fb78c6f21b17f828a86e6', "2000-11-16",
    'larry.rocks@gmail.com', "2000-11-16", 'Sydney', 0, "Hi, I'm not Barry!");  
REPLACE INTO users (id, fname, lname, username, password, dob, email, joindate, location, admin_level, bio)
    VALUES (2, 'Harry', 'Potter', 'chosenone', '160b72c738761404143b4e87265c306b12e8811c68d46f87e54fb3ce25c5985f', "31-7-1980",
    'killvoldemort@hogwarts.net.uk', "2000-11-16", 'London', 0, "Hi, I defeated Voldy, suckers!");  
REPLACE INTO users (id, fname, lname, username, password, dob, email, joindate, location, admin_level, bio)
    VALUES (3, 'Carry', 'Schultz', 'carry', '42c0386aedba0ad607852945a9ab3854055fe41f721989b8954f8993f829a8ce', "1998-09-22",
    'carry@gmail.com', "2000-11-16", 'Sydney', 0, "My brothers are twins.");
REPLACE INTO users (id, fname, lname, username, password, dob, email, joindate, location, admin_level, bio)
    VALUES (4, 'Dominic', 'May', 'Lord_DeathMatch', '2cce3767941bb4bb3368bc6a70eba2fa53d4431213a4f4a25010c04f79a4cb5d', "1996-08-07",
    'jack.thatch@gmail.com', "2000-11-16", 'Sydney', 10, "Hi, I'm Dom!!");
     
REPLACE INTO stories (id,  author_id, title, created_time, author_init_comment, votes)
    VALUES (0, 0, "Wizard Gandalf Style", "2013-01-13 13:14:27.044000", "Comment", 0);
REPLACE INTO stories (id,  author_id, title, created_time, author_init_comment, votes)
    VALUES (1, 2, "Harry Potter and the Philosopher's Stone", "2013-01-13 13:14:27.044000",
    "Joint autobiography", 0);
REPLACE INTO stories (id,  author_id, title, created_time, author_init_comment, votes)
    VALUES (5, 0, "Alex's old forum roleplay", "2013-01-13 16:14:27.044000",
    "This is an old online roleplay I participated in.", 0);

   
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (0, '"You shall not pass!"', -1, 10, 0, 1, 0, "2013-01-13 14:13:29.324000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (1, '"But you can dance!"', 0, 10,  0, 1, 0, "2013-01-13 14:14:09.884000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (2, 'Wizard Gandalf style!', 1, 10, 0, 1, 0, "2013-01-13 14:14:27.044000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (3, 'Wizard Gandalf style 2!', 1, 10, 0, 1, 0, "2013-01-13 14:24:27.000000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (4, "It's a cave troll! Save the hobbits!", 0, 10, 0, 1, 0, "2013-01-13 16:24:27.000000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (5, "Aragorn!", 2, 10, 0, 1, 0, "2013-01-13 16:24:27.000000");   
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (6, "Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say that they were perfectly normal, 
    thank you very much. They were the last people you'd expect to be involved in anything strange or mysterious, because 
    they just didn't hold with such nonsense. Mr. Dursley was the director of a firm called Grunnings, which made drills. 
    He was a big, beefy man with hardly any neck, although he did have a very large mustache. Mrs. Dursley was thin and 
    blonde and had nearly twice the usual amount of neck, which came in very useful as she spent so much of her time craning 
    over garden fences, spying on the neighbors. The Dursleys had a small son called Dudley and in their opinion there was 
    no finer boy anywhere. The Dursleys had everything they wanted, but they also had a secret, and their greatest fear 
    was that somebody would discover it. They didn't think they could bear it if anyone found out about the Potters.", 
    -1, 10, 2, 1, 1, "2013-01-13 16:24:27.000000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (7, "Mrs. Potter was Mrs. Dursley's sister, but they hadn't met for several years; in fact, Mrs. Dursley 
    pretended she didn't have a sister, because her sister and her good-for-nothing husband were as unDursleyish as 
    it was possible to be. The Dursleys shuddered to think what the neighbors would say if the Potters arrived in the 
    street. The Dursleys knew that the Potters had a small son, too, but they had never even seen him.", 
    6, 10, 2, 1, 1, "2013-01-13 16:24:27.000000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (8, "Mrs. Pot", 
    6, 10, 2, 1, 1, "2013-01-13 16:24:27.000000");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (9, "The Gate Keeper had been having a long day.
    But then, most days were long. In his entire life, nothing very exciting had ever happened,
    and he had never let in any important assembly of any kind. Maybe it was because none had come
    to visit this land for a good couple of centuries, but the Keeper felt sure it was some kind of evil
    trick that life was playing on him.", 
    -1, 0, 0, 1, 5, "2013-01-13 16:50:27.000001");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (10, "It was then he saw this man covered in filthy rags walking up to the gate.
    This was strange, there were very rarely any men this badly off in Protonia, as the rulers were very
    kind, and there was always work at the massive farms of the kingdom. It was very possible that 
    was an outsider to the kingdom. The Keeper thought for a moment. If this was a stranger from another
    ..land.. that would make him the one who started contact with another race! This could be his big
    chance! It was very strange that the watch towers hadn't spotted him from afar though. Either
    they were slacking off, or this man was very stealthy. It was more likely they were slacking off.", 
    9, 0, 0, 1, 5, "2013-01-13 16:51:27.000001");
REPLACE INTO paragraphs (id, content, parent_id, votes, author_id, approved, story_id, created) 
    VALUES (11, "'Hail! Welcome to the kingdom of Protonia. You seem to be a stranger of this land.
    How may I ..um.. help you?', the Gate Keeper had never needed to say anything in that manner
    that wasn't written on a script for him to announce before.", 
    10, 0, 0, 1, 5, "2013-01-13 17:00:01.000099");
 


REPLACE INTO rules (id, story_id, rule_def_id, params)
    VALUES (0, 0, 0, "0||6");
REPLACE INTO rules (id, story_id, rule_def_id, params)
    VALUES (1, 0, 1, "cat||dog");

REPLACE INTO ruleDefs (id, name, description)
    VALUES (0, "letters_per_word", "Returns False if the word is not within (or equal to) the minimum or maximum values set by the user.");
REPLACE INTO ruleDefs (id, name, description)
    VALUES (1, "banned_words", "Returns False if a banned word is found within the text.");
REPLACE INTO ruleDefs (id, name, description)
    VALUES (2, "max_num_words", "The number of words in submission must be <= host's input");
REPLACE INTO ruleDefs (id, name, description)
    VALUES (3, "forced_words", "User's text must include the words host submits");
REPLACE INTO ruleDefs (id, name, description)
    VALUES (4, "include_number_words", "host sets requirement for certain word to be used in writers submission every ___ words");

REPLACE INTO comments (id, author_id, story_id, content, created_time)
    VALUES (0, 1, 1, "Oh my Rowling, this is totally plagiarism", "2000-11-16 00:00:00.00000");
REPLACE INTO comments (id, author_id, story_id, content, created_time)
    VALUES (1, 2, 1, "Wow, you should make a seven book series for this idea!", "2010-11-16 00:00:00.00000");

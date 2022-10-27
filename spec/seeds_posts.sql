TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO posts (title, content, views) VALUES ('update', 'I am trying to be a developer!', 1);
INSERT INTO posts (title, content, views) VALUES ('success', 'I AM HIRED AS A DEVELOPER!', 1000000);
INSERT INTO posts (title, content, views) VALUES ('test', 'This is a test', 99);
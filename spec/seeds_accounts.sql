TRUNCATE TABLE accounts RESTART IDENTITY CASCADE; -- I've added the CASCADE part to allow RSPEC to work here

INSERT INTO accounts (email, username) VALUES ('Alastair10@gmail.com', 'Alastair2022');
INSERT INTO accounts (email, username) VALUES ('Gunel10@gmail.com', 'Gunel2022');
INSERT INTO accounts (email, username) VALUES ('Test@gmail.com', 'Test2022');
-- create_tables.sql
DROP TABLE IF EXISTS "public"."posts";
-- Drop posts first as it relies on users
DROP TABLE IF EXISTS "public"."users";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Create the table without the foreign key first.

CREATE TABLE "public"."users" (
"id" SERIAL,
"email_address" text,
"username" text,
PRIMARY KEY ("id")
);

-- Then the table with the foreign key first.
CREATE TABLE "public"."posts"(

"id" SERIAL,
"title" text,
"content" text,
"view_number" int,
"user_account" int,
  constraint FK_User FOREIGN KEY ("user_account")
    references "public"."users"("id")
    on delete cascade
);

INSERT INTO "public"."users"("email_address", "username")
VALUES('user1@email.com', 'User1');
INSERT INTO "public"."users"("email_address", "username")
VALUES('user2@email.com', 'User2');
INSERT INTO "public"."users"("email_address", "username")
VALUES('user3@email.com', 'User3');

INSERT INTO "public"."posts"("title", "content", "view_number", "user_account")
VALUES(
    'My first blog', 
    'This is my first blog post yadda yadda...',
    '123',
    '1'
);

INSERT INTO "public"."posts"("title", "content", "view_number", "user_account")
VALUES(
    'I love cake', 
    'Cake is the best thing ever ....',
    '7000',
    '2'
);

INSERT INTO "public"."posts"("title", "content", "view_number", "user_account")
VALUES(
    'I''m getting married', 
    'I''m very excited and it''s not until next year but...',
    '5',
    '3'
);
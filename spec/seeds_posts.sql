TRUNCATE TABLE "public"."posts" RESTART IDENTITY;


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
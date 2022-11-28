1. Extract nouns from the user stories or specification
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.


Nouns:

USER
email address, username

POSTS
user account, title, content, number of views


2. Infer the Table Name and Columns
Put the different nouns in this table. Replace the example with your own nouns.

Record  |  Properties

user    | id, email_address, username
post    | id, title, content, view_number, user_account

3. Decide the column types.
Here's a full documentation of PostgreSQL data types.

Most of the time, you'll need either text, int, bigint, numeric, or boolean. If you're in doubt, do some research or ask your peers.

Remember to always have the primary key id as a first column. Its type will always be SERIAL.

# EXAMPLE:

Table: users

id: SERIAL
email_address: text
username: text

Table: posts

id: SERIAL
title: text
content: text
view_number: int
user_account: int

4. Decide on The Tables Relationship

# EXAMPLE

1. Can one user have many posts? YES
2. Can one post have many users? NO

-> Therefore,
-> A user HAS MANY posts
-> A post BELONGS TO a user

-> Therefore, the foreign key is on the posts table.


4. Write the SQL.
```sql
-- create_tables.sql

-- Create the table without the foreign key first.

CREATE TABLE users (
id SERIAL,
email_address text,
username text,
PRIMARY KEY (ID)
);

-- Then the table with the foreign key first.
CREATE TABLE posts(

id SERIAL
title text
content text
view_number int
user_account int
  constraint fk_user foreign key(user_account)
    references users(id)
    on delete cascade
);

INSERT INTO ....

```
5. Create the tables.
psql -h 127.0.0.1 social_network_test < create_tables.sql

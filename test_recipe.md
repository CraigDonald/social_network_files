{{TABLE NAME}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table
If the table is already created in the database, you can skip this step.

Otherwise, follow this recipe to design and create the SQL schema for your table.

In this template, we'll use an example table students

# EXAMPLE

Table: users

Columns:
id | email_address | username

Table: posts

Columns:
id | title | content | view_number | user_account



2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
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

psql -h 127.0.0.1 social_network_test < seeds_posts.sql


```
3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

```ruby

# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end


# Table name: posts

# Model class
# (in lib/post.rb)

class Post
end

# Repo class
# (in lib/post_repository.rb)

class PostRepository
end

```
4. Implement the Model classes
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

``` ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :email_address, :username
end

# Table name: posts
# Model class
# (in lib/post.rb)


class Post
    attr_accessor :id, :title, :content, :view_number, :user_account
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
# You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

```

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby

# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users WHERE id = $1;

    # Returns a single User object.
  end

  def create(user)
    #takes an artist object in argument
    # executes SQL: 
    # INSERT INTO users(email_address, username) VALUES($1, $2);
    #returns nothing, only creates
  end

  def delete(id)
    #takes an ID as argument
    # executes SQL: 
    # DELETE FROM users WHERE id = $1;
    # returns nothing, only deletes
  end

  def update(artist)
    # takes artist as argument
    # executes SQL: 
    # UPDATE users SET name = $1, genre = $2 WHERE id = $3;
    # returns nothing, only updates record
    # raises error if record does not exist
  end
end


# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, view_number, user_account FROM posts;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, view_number, user_account FROM posts WHERE id = $1;

    # Returns a single User object.
  end

  def create(user)
    #takes an artist object in argument
    # executes SQL: 
    # INSERT INTO posts(title, content, view_number, user_account) VALUES($1, $2, $3, $4);
    #returns nothing, only creates
  end

  def delete(id)
    #takes an ID as argument
    # executes SQL: 
    # DELETE FROM posts WHERE id = $1;
    # returns nothing, only deletes
  end

  def update(artist)
    # takes artist as argument
    # executes SQL: 
    # UPDATE posts SET title = $1, content = $2, view_number = $3, user_account =$4 WHERE id = $5;
    # returns nothing, only updates record
    # raises error if record does not exist
  end
end
```

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

``` ruby
# EXAMPLES

# user_repository.rb

# 1
# Get all students

repo = UserRepository.new

users = repo.all

users.length # =>  3

users[0].id # =>  1
users[0].email_address # =>  'user1@email.com'
users[0].username # =>  'User1'

users[1].id # =>  2
users[1].email_address # =>  'user2@email.com'
users[1].username # =>  'User2'

# 2
# Get a single student

repo = StudentRepository.new

user = repo.find(1)

user.id # =>  1
users[0].email_address # =>  'user1@email.com'
users[0].username # =>  'User1'

# Add more examples for each method
Encode this example as a test.

```

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb
```ruby
def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end
```
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
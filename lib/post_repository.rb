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
  
    def create(post)
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
  
    def update(post)
      # takes post as argument
      # executes SQL: 
      # UPDATE posts SET title = $1, content = $2, view_number = $3, user_account =$4 WHERE id = $5;
      # returns nothing, only updates record
      # raises error if record does not exist
    end
  end
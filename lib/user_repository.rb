# Table name: users

# Repository class
# (in lib/user_repository.rb)

require_relative 'user'

class UserRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, email_address, username FROM users;
      # Returns an array of User objects.
        sql = 'SELECT id, email_address, username FROM users;'
        result_set = DatabaseConnection.exec_params(sql, [])

        users = []

        result_set.each do |record|
            user = User.new
            user.id = record['id']
            user.email_address = record['email_address']
            user.username = record['username']

            users << user
        end
        return users
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
  
    def update(user)
      # takes artist as argument
      # executes SQL: 
      # UPDATE users SET name = $1, genre = $2 WHERE id = $3;
      # returns nothing, only updates record
      # raises error if record does not exist
    end
  end
require 'user_repository'

RSpec.describe UserRepository do
    
    def reset_users_table
        seed_sql = File.read('spec/seeds_users.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end

    before(:each) do
        reset_users_table
    end

    it 'Returns all users' do
        repo = UserRepository.new
        
        users = repo.all

        expect(users.length).to eq(3) # =>  3
        expect(users[0].id).to eq('1') # =>  1
        expect(users[0].email_address).to eq('user1@email.com') # =>  'user1@email.com'
        expect(users[0].username).to eq('User1') # =>  'User1'

        expect(users[1].id).to eq('2') # =>  2
        expect(users[1].email_address).to eq('user2@email.com') # =>  'user2@email.com'
        expect(users[1].username).to eq('User2') # =>  'User2
    end
end
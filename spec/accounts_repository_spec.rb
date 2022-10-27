require 'accounts_repository'

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe 'AccountsRepository' do
  before(:each) do 
    reset_accounts_table
  end
  
  context "tests the ALL method" do
    it "returns a list of all accounts" do
      repo = AccountsRepository.new

      accounts = repo.all

      expect(accounts.length).to eq(3)
      expect(accounts.first.id).to eq(1)
      expect(accounts.first.email).to eq('Alastair10@gmail.com')
      expect(accounts.first.username).to eq('Alastair2022')
    end
  end

  context "tests the FIND method" do
    it "returns a single record of Alastair" do
      repo = AccountsRepository.new

      account = repo.find(1)
      expect(account.email).to eq('Alastair10@gmail.com')
      expect(account.username).to eq('Alastair2022')
    end
  end

  context "tests the CREATE method" do
    it "creates a single record of thanos" do

      repo = AccountsRepository.new

      account = Accounts.new
      account.email = 'Thanos@gmail.com'
      account.username = 'Thanos2022'
      
      # this will create the account
      repo.create(account) 
      
      # need to verify that the account appears by looking at all accounts
      accounts = repo.all
      last_account = accounts.last

      expect(last_account.email).to eq('Thanos@gmail.com')
      expect(last_account.username).to eq('Thanos2022')
    end
  end

  context "it tests the DELETE method" do
    it "deletes the first record with id = 1" do
      repo = AccountsRepository.new

      id_to_delete = 1
      repo.delete(id_to_delete)

      # need to verify by looking at all records and confirming there is only 1 left
      all_accounts = repo.all
      expect(all_accounts.length).to eq(2)
      expect(all_accounts.first.id).to eq(2)
    end
  end
end

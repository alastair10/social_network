require_relative './accounts'

class AccountsRepository

  def all
    # Executes the SQL query:
    sql = 'SELECT id, email, username FROM accounts;'
    result_set = DatabaseConnection.exec_params(sql,[]) # returns array of Accounts objects

    accounts = []

    result_set.each do |record|
      account = Accounts.new
      account.id = record['id'].to_i
      account.email = record['email']
      account.username = record['username']

      accounts << account
    end
    return accounts
  end

  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, email, username FROM accounts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    # this accesses the first instance of the set
    record = result_set[0] 

    account = Accounts.new
    account.id = record['id'].to_i
    account.email = record['email']
    account.username = record['username']
    
    # Returns a single Account object.
    return account
  end

  def create(account)
    # Executes the SQL query
    sql = 'INSERT INTO accounts (email, username) VALUES ($1, $2);'
    sql_params = [account.email, account.username]

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    # doesn't return anything since we're just creating
  end

  def delete(id)
    # executes SQL code
    sql = 'DELETE FROM accounts WHERE id = $1'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql,sql_params)

    # this will not return anything, only deleting
  end




end

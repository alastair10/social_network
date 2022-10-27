# ACCOUNTS Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

done

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email, username) VALUES ('Alastair10@gmail.com', 'Alastair2022');
INSERT INTO accounts (email, username) VALUES ('Gunel10@gmail.com', 'Gunel2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Accounts
end

# Repository class
# (in lib/student_repository.rb)
class AccountsRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Accounts

  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class AccountsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, username FROM accounts;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email, username FROM accounts WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(account)
    # Executes the SQL query
    # INSERT INTO accounts (email, username) VALUES ($1, $2);

    # doesn't return anything since we're just creating
  end

  # def update(account)
  # end

  def delete(id)
    # executes SQL code
    # DELETE FROM accounts WHERE id = $1

    # this will not return anything, only deleting
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 Get all students

repo = AccountsRepository.new

accounts = repo.all

accounts.length # =>  2
accounts.first.id # =>  1
accounts.first.email # =>  'Alastair10@gmail.com'
accounts.first.username # =>  'Alastair2022'

# 2 Get a single student

repo = AccountsRepository.new

accounts = repo.find(1)

accounts.email # =>  'Alastair10@gmail.com'
accounts.username # =>  'Alastair2022'

# 3 Creates a new account

repo = AccountsRepository.new

account = Accounts.new
account.email = 'Thanos@gmail.com'
account.username = 'Thanos2022'

# this will create the account
repo.create(account) 

# need to verify that the account appears by looking at all accounts
accounts = repo.all
last_account = accounts.last
last_account.email # => 'Thanos@gmail.com'
last_account.username # => 'Thanos2022'

# 4 Delets an account

repo = AccountsRepository.new

id_to_delete = 1
repo.delete(id_to_delete)

# need to verify by looking at all records and confirming there is only 1 left
all_accounts = repo.all
all_accounts.length # => 1
all_accounts.first.id # => 2



```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

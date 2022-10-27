# POSTS Model and Repository Classes Design Recipe


## 1. Design and create the Table

DONE

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

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, account_id) VALUES ('update', 'I am trying to be a developer!', 2, 1)
INSERT INTO posts (title, content, views, account_id) VALUES ('success', 'I AM HIRED AS A DEVELOPER!', 1000000, 2)


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
class Posts
end

# Repository class
# (in lib/student_repository.rb)
class PostsRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Posts

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :account_id
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

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, account_id FROM posts WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    # execute SQL query
    # INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);

    # Returns nothing
  end

  # def update(student)
  # end

  def delete(post)
    # execute SQL code
    # DELETE FROM posts WHERE id = $1;
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 ALL Method
# get all posts

repo = PostsRepository.new

posts = repo.all

posts.length # =>  2
posts.first.title # => 'update
posts.last.contents # => 'I AM HIRED AS A DEVELOPER!'

# 2 FIND Method
# Get a single student

repo = PostsRepository.new

posts = repo.find(2)

posts.id # =>  2
posts.title # =>  'success'
posts.content # =>  'I AM HIRED AS A DEVELOPER!'
posts.views # => 1000000
posts.account_id # => 2

# 3 CREATE Method

repo = PostsRepository.new

post = Post.new
post.title # => 'encouragement'
post.content # => "Don't worry. Keep going."
post.views # => 0
post.account_id # => 1

#create the post
repo.create(post)

#verify new post appears
posts = repo.all
last_post = posts.last
last_post.title # => 'encouragement'
last_post.content # => "Don't worry. Keep going."
last_post.views # => 0
last_post.account_id # => 1

# 4 DELETE Method

repo = PostsRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

#check the deletion worked
all_posts = repo.all
all_posts.length # => 1
all_posts.first.id # => 2




```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostsRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

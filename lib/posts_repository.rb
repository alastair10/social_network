require_relative 'posts'

class PostsRepository
  
  def all
    # Executes the SQL query:
    sql = 'SELECT id, title, content, views, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql,[])

    posts = []

    result_set.each do |record|
      post = Posts.new
      post.id = record['id'].to_i
      post.title = record['title']
      post.content = record['content']
      post.views = record['views']
      post.account_id = record['account_id']

      posts << post
    end

    # Returns an array of Student objects.
    return posts
  end

  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, title, content, views, account_id FROM posts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    post = Posts.new
    post.id = record['id'].to_i
    post.title = record['title']
    post.content = record['content']
    post.views = record['views'].to_i
    post.account_id = record['account_id'].to_i

    # Returns a single Student object.
    return post
  end

  def create(post)
    # execute SQL query
    sql = 'INSERT INTO posts (title, content, views, account_id) VALUES ($1, $2, $3, $4);'
    sql_params = [post.title, post.content, post.views, post.account_id]

    DatabaseConnection.exec_params(sql, sql_params)

    # Returns nothing
  end

  def delete(id)
    # execute SQL code
    sql = 'DELETE FROM posts WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)

  end

end
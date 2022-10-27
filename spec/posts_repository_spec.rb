require 'posts_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostsRepository do

  before(:each) do 
    reset_posts_table
  end

  context "ALL method test" do
    it "returns a list of posts" do
      repo = PostsRepository.new

      posts = repo.all

      expect(posts.length).to eq(3)
      expect(posts.first.title).to eq('update')
      expect(posts.first.content).to eq('I am trying to be a developer!')
      expect(posts.first.id).to eq(1)
      expect(posts.first.account_id).to eq(0)
    end
  end

  context "FIND method test" do
    it "returns the second post about being hired" do
      repo = PostsRepository.new

      posts = repo.find(2)

      expect(posts.id).to eq(2)
      expect(posts.title).to eq('success')  
      expect(posts.content).to eq('I AM HIRED AS A DEVELOPER!')  
      expect(posts.views).to eq(1000000)
    end
  end

  context "CREATE method test" do
    it "creates a new post" do
      # 3 CREATE Method

      repo = PostsRepository.new

      post = Posts.new
      post.title = 'encouragement'
      post.content = "Don't worry. Keep going."
      post.views = 0

      #create the post
      repo.create(post)

      #verify new post appears
      posts = repo.all
      last_post = posts.last

      expect(last_post.title).to eq('encouragement') 
      expect(last_post.content).to eq("Don't worry. Keep going.") 
      expect(last_post.views).to eq(0)

    end
  end

  context "DELETE method test" do
    it "deletes the first post" do
      repo = PostsRepository.new

      id_to_delete = 1
      repo.delete(id_to_delete)

      #check the deletion worked
      all_posts = repo.all
      expect(all_posts.length).to eq(2)
      expect(all_posts.first.id).to eq(2)
    end
  end
end
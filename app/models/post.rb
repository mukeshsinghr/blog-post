class Post < ActiveRecord::Base
  validates :title, :presence => true
  #  validates :title, :format=> {
  #    :with => /a-zA-Z\s/,
  #    :message => " should be alphanumeric"
  #  }
  validates :body, :presence => true
  before_validation :before_validate_callback
  around_save :monitor_post_creation
  before_destroy :post_destroyed

  has_many :comments
  
  def before_validate_callback
    puts "Inside before_validate_callback"
  end

  def monitor_post_creation
    puts "Before creating the post"
    yield
    puts "Post creation is done"
  end

  def post_destroyed
    puts "Post deleted successfully"
  end
end

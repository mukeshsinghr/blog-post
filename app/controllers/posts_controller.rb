class PostsController < ApplicationController
  #  before_filter :authenticate, only: [:show, :edit, :update]
  before_filter :set_post, only: [:show, :edit, :destroy]
  around_filter :audit_log
  layout "post"
  def page1
    render :static_content , :layout => "post" and return
    redirect_to :root
  end

  def render_nothing
    render nothing: true

  end

  def render_home
    #    redirect_to "/welcome/home"
    redirect_to :controller=> :welcome, :action => :home
  end

  def inline_res
    render :inline => "Y"
  end

  def post_exists
    result = "N"
    result = "Y" if Post.exists? params[:id]
    respond_to do |format|
      format.json { render :json => {:body => {:code => 200, :is_exist => result}, :status => 304} }
      format.html { render :inline => result }
      format.xml { render :xml => {:body => {:code => 200, :is_exist => result}, :status => 304} }
      format.js { render :js => 'alert("THis is alrt msg")'}
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    puts "INside show action"
  end

  # GET /posts/new
  def new
    @post = Post.new
    puts "Contents inside post=#{@post.inspect}"
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    puts "params=#{params}"
    puts "form parms=#{post_params}"
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post created successfully.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @p = Post.find(params[:id])
    respond_to do |format|
      if @p.update(post_params)
        format.html { redirect_to @p, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    #    Post.destroy_all :id => @post.id
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
    puts "Post data is=#{@post.inspect}"
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def audit_log
    Rails.logger.debug "#{Time.now} request came from IP=#{request.ip}"
    yield # Action code execution takes place
    Rails.logger.debug "#{Time.now} request served for IP=#{request.ip}"
  end
end

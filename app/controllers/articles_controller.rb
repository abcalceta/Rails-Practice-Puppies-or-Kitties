require 'flickr'
require 'httparty'

class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    @puppy_num = Article.where(tag: "puppy").count
    @kitten_num = Article.where(tag: "kitten").count
  end

  def show
    @article = Article.find(params[:id])
    @image = get_random_image(@article.id)
    @inspiration = get_inspiring_message()
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end

  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end


  def search
    if params[:search].blank?
      @search_results = []
    else
      @search_param = params[:search].downcase
      @search_results = Article.where("title LIKE ?", "%" + @search_param + "%")
    end
    # redirect_to search_path
  end


  def get_random_image(id)
    article = Article.find(id)
    flickr = Flickr.new # set the api key in the environment variables
    whichGroup = "92986953@N00" # kitties by default!
    if article.tag == "puppy"
      whichGroup = "40269516@N00" # this group is full of puppy photos!
    end
    search_results = flickr.photos.search :api_key => ENV['FLICKR_API_KEY'], :group_id => whichGroup
    #if I use :tags => [@article.tag] we get sketchy images... safer to use groups dedicated to cats and dogs
    image = Flickr.url_c(search_results[rand(100)])
    return image
  end


  helper_method :get_random_image

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :tag, :search)
    end

end

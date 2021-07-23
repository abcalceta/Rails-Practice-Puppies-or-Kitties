require 'flickr'

class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])

    flickr = Flickr.new #set the api key in the environment variables
    search_results = flickr.photos.search :api_key => ENV['FLICKR_API_KEY'], :tags => [@article.tag]
    @image = Flickr.url_m(search_results[0])

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


  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :tag)
    end

end

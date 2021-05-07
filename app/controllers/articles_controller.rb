require 'active_support/core_ext/object/blank.rb'

class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  # before_action :authenticate
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end
  def edit
    @article = Article.find(params[:id])
  end
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def show_comments
    @article = Article.find(params[:id])
    # render plain: "hello!"
  end


  private
  def article_params
    params.require(:article).permit(:title, :text, comments_attributes: [:commenter,:body,:_destroy])
  end

  private
  def authenticate
    authenticate_or_request_with_http_digest do |username|
      User.find_by(username: username)
    end
  end
end

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
  private
  def article_params
    params.require(:article).permit(:title, :text, comments_attributes: [:commenter,:body,:_destroy])
  end

  def download_pdf
    article = Article.find(article_params)
    send_data generate_pdf(article),
              filename: "#{article.title}.pdf",
              type: "application/pdf"
  end

  private
  def generate_pdf(article)
    Prawn::Document.new do
      text article.title, align: :center
      text "标题: #{article.title}"
      text "内容: #{article.text}"
    end.render
  end

  private
  def authenticate
    authenticate_or_request_with_http_digest do |username|
      User.find_by(username: username)
    end
  end
end

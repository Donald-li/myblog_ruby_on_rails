class CommentsController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    if @comment.commenter == comment_params.commenter && @comment.body == comment_params.body
      render "new"
    else
      redirect_to @article
    end
    redirect_to article_path(@article)
  end

  def update
    @comment = @article.comments.new(comment_params)
    if @comment.commenter == comment_params.commenter && @comment.body == comment_params.body
      render "new"
    else
      redirect_to @article
    end
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end

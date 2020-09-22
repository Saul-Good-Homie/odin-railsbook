class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:create]

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(body: params[:comment][:body], post_id: params[:post_id], user_id: current_user.id)
    
        @comment.save
    
        redirect_to root_path
    end

    def destroy
        @comment = Comment.find(params[:id])
    
        @comment.destroy
    
        redirect_to root_path
    end

    def comment_params
        params.require(:comment).permit(:body)
    end

end
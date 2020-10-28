class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post

    def new
        @comment = Comment.new
    end

    def create
        #@comment = @post.comments.new(body: params[:comment][:body], post_id: params[:post_id], 
        #                        user_id: current_user.id)
        @comment = @post.comments.new(comment_params)
        @comment.user = current_user

        if @comment.save
            # Create the notifications
            # (@post.users.uniq - [current_user]).each do |user|
            # Notification.create(recipient: user, actor: current_user, 
            #                     action: "commented", notifiable: @post)
            # end
            if current_user != @post.user
                Notification.create(recipient: @post.user, actor: current_user, 
                    action: "commented", notifiable: @post)
            end
            redirect_to root_path
        else 

            redirect_to root_path
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
    
        @comment.destroy
    
        redirect_to root_path
    end

    private 
    
    def comment_params
        params.require(:comment).permit(:body)
    end

    def set_post
        @post = Post.find(params[:post_id])
    end

end
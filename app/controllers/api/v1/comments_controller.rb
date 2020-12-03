module Api
  module V1
    class CommentsController < MainController
      before_action :authorize_request
      before_action :set_comment, only: [:edit, :create, :update, :destroy]

      def index
        @comments = @current_user.comments.all
        render json: {comments: ActiveModelSerializers::SerializableResource.new(@comments, each_serializer: CommentSerializer), status: 200}, status: 200
      end

      def create
        @comment = @current_user.comments.create(comment_params)
        render json: {comment: CommentSerializer.new(@comment), status: 200}, status: 200
      end

      def update
        if @comment.update(comment_params)
          render json: {comment: CommentSerializer.new(@comment), status: 200}, status: 200
        else
          render json: {message: "can not update", status: 400}, status: 200
        end
      end

      def destroy
        @comment.destroy
        render json: {message: "deleted", status: 200}, status: 200
      end

      private
        def set_comment
          @comment = @current_user.comments.find(params[:id])
        end

        def comment_params
          params.require(:comment).permit(:title, :description)
        end
    end
  end
end

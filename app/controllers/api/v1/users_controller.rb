module Api
  module V1
    class UsersController < MainController
      before_action :authorize_request, except: [:forgot_password]
      def check
        render json: {user: UserSerializer.new(@current_user, root: false, serializer_options: {token: JsonWebToken.encode(user_id: @current_user.id)}), message: "Authenticated", status: 100}, status: 200
      end
    end
  end
end

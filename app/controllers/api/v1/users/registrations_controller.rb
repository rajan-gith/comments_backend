class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    @old_user = User.find_by(email: params[:user][:email])
    if !@old_user
      @user = User.new(configure_sign_up_params)
      if @user.save
        token = JsonWebToken.encode(user_id: @user.id)
        render json: {user: UserSerializer.new(@user, root: false, serializer_options: {token: token}), status: 201}, status: 200
      else
        render json: { message: "Can not add user.", error: "User save error", status: 400}, status: 200
      end
    else
      render json: { message: "User already exist with this email or phone number.", error: "User exists", status: 409}, status: 200
    end
  end

  private
  def configure_sign_up_params
    params.require(:user).permit(:email, :password)
  end
end

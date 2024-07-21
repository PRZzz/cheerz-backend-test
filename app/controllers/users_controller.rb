class UsersController < ApplicationController
  def create
    signup = Users::Signup.call(username: params[:username])

    if signup.success?
      data = UserSerializer.new(signup.user).as_json
      render json: { data: data }, status: :ok
    else
      render json: { error: signup.error }, status: :bad_request
    end
  end
end

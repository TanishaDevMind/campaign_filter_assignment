class UsersController < ApplicationController

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def filter
    campaign_names = params[:campaign_names].split(',')
    @users = User.all
    if campaign_names.present?
      @filtered_users = @users.select do |user|
        user_campaign_names = user.campaigns_list.map { |c| c["campaign_name"] }
        (user_campaign_names & campaign_names).any?
      end
    end
    @users = @filtered_users if @filtered_users.present?
    render json: @users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, campaigns_list: [:campaign_name, :campaign_id])
  end
end

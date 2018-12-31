class ReviewsController < ApplicationController

  before_action :authenticate

  def create
    user = User.find(review_params[:user_id])
    Review.create(title:   review_params[:title],
                  rating:  review_params[:rating],
                  review:  review_params[:review],
                  # author:  user.first_name,
                  # ^^ This shouldn't be stored here, only in user
                  user: user,
                  restaurant_id: params[:restaurant_id])
    redirect_to restaurant_path(params[:restaurant_id])
  end

private

  def review_params
    params.require(:review).permit(:user_id, :title, :rating, :review)
  end

end

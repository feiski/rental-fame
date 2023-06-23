class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @offers = Offer.order(:date).limit(3)
  end

  def profil
    @user = current_user
    @offers_count = Offer.where(user: current_user).count
    @reservations_count = Reservation.where(user: current_user).count
  end

  def profilshow
    @user = User.find(params[:id])
    @offers_count = Offer.where(user: @user).count
    @reservations_count = Reservation.where(user: @user).count
    render :profil
  end
end

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @offers = Offer.order(:date).limit(3)
  end

  def profil
  end
end

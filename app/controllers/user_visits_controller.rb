class UserVisitsController < ApplicationController
  before_filter :require_county!

  def create
    current_user.mark_visited!(@country)
    redirect_to :back, :notice => I18n.t('controllers.user_visits.visited', :country_name => @country.name)
  end

  def destroy
    current_user.mark_not_visited!(@country)
    redirect_to :back, :notice => I18n.t('controllers.user_visits.not_visited', :country_name => @country.name)
  end

  private

  def require_county!
    @country = Country.find params[:country_id]
  end
end
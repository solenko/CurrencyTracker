class UserVisitsController < ApplicationController
  before_filter :require_county!, :only => [:create, :destroy]

  respond_to :html, :js

  def create
    current_user.mark_visited!(@country)
    redirect_to :back, :notice => I18n.t('controllers.user_visits.visited', :country_name => @country.name)
  end

  def destroy
    current_user.mark_not_visited!(@country)
    redirect_to :back, :notice => I18n.t('controllers.user_visits.not_visited', :country_name => @country.name)
  end

  def bulk_create
    @countries = Country.not_visited_by(current_user).where(:code => params[:country_ids])
    current_user.bulk_mark_visited!(@countries)
    respond_with(@countries,
                 :notice => I18n.t('controllers.user_visits.bulk_visit', :count => @countries.count),
                 :location => countries_path
    )
  end

  private

  def require_county!
    @country = Country.find params[:country_id]
  end
end
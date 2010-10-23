#   Copyright (c) 2010, Diaspora Inc.  This file is
#   licensed under the Affero General Public License version 3 or later.  See
#   the COPYRIGHT file.


class OmniauthServicesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @services = current_user.services
  end

  def create
    auth = request.env['omniauth.auth']


    puts auth['extra']['access_token'].inspect

    current_user.services.create(:provider => auth['provider'], :uid => auth['uid'])
    flash[:notice] = "Authentication successful."
    redirect_to omniauth_services_url
  end

  def destroy
    @service = current_user.services.find(params[:id])
    @service.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to omniauth_services_url
  end
end
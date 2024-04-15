class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about, :search]
  before_action :authenticate_admin!, except: [:top, :about, :search]

end

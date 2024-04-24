class Public::PunchesController < ApplicationController

  def new
    @labels = current_user.labels.all
  end

  def index
    @punches = current_user.punches.all
  end

  def show
    @punch = Punch.find_by(id: params[:id])
    if @punch.nil?
      redirect_to root_path
      return
    end
  end

  def edit
    @punch = Punch.find_by(id: params[:id])
    if @punch.nil?
      redirect_to root_path
      return
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

  def start
  end

  def stop
  end

end

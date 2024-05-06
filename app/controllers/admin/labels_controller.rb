class Admin::LabelsController < ApplicationController

  def index
    @labels = Label.order(created_at: :desc).page(params[:page])
  end

  def show
    @label = Label.find_by(id: params[:id])
    if @label.nil?
      redirect_to admin_labels_path
      return
    end
    @punches = @label.punches.order(created_at: :desc).page(params[:page])
  end

  def destroy
    label = Label.find(params[:id])
    label.destroy
    redirect_to admin_labels_path
  end

end

class Public::LabelsController < ApplicationController

  def index
    @label = Label.new
    @labels = current_user.labels.all
  end

  def edit
    @label = Label.find_by(id: params[:id])
    if @label.nil?
      redirect_to root_path
      return
    end
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to labels_path, notice: "保存しました"
    else
      @labels = Label.all
      render 'index'
    end
  end

  def update
    @label = Label.find_by(id: params[:id])
    if @label.nil?
      redirect_to root_path
      return
    end
    if @label.update(label_params)
      redirect_to labels_path, notice: "保存しました"
    else
      render "edit"
    end
  end

  def destroy
    label = Label.find_by(id: params[:id])
    if label.nil?
      redirect_to root_path
      return
    end
    label.destroy
    redirect_to labels_path, flash: { center_notice: '削除しました' }
  end

  private

  def label_params
    params.require(:label).permit(:genre, :name)
  end

end

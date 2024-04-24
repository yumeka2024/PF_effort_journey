class Public::LabelsController < ApplicationController

  def index
    @label = Label.new
    @labels = Label.all
  end

  def edit
    @label = Label.find(params[:id])
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
    @label = Label.find(params[:id])
    if @label.update(label_params)
      redirect_to labels_path, notice: "保存しました"
    else
      render "edit"
    end
  end

  def destroy
    label = Label.find(params[:id])
    label.destroy
    redirect_to labels_path, flash: { center_notice: '削除しました' }
  end

  private

  def label_params
    params.require(:label).permit(:genre, :name)
  end

end

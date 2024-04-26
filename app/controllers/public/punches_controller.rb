class Public::PunchesController < ApplicationController

  def new
    @labels = current_user.labels.all.order(genre: :asc)
    @day = Date.today
    @punches = current_user.punches.where(in: @day.all_day)

    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def index
    @punch = Punch.new
    @punches = current_user.punches.all
  end

  def show
    @punch = Punch.find_by(id: params[:id])
    if @punch.nil? || @punch.out.present?
      redirect_to root_path
      return
    end
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
  end

  def edit
    @punch = Punch.find_by(id: params[:id])
    if @punch.nil?
      redirect_to root_path
      return
    end
  end

  def create
    punch = current_user.punches.new(punch_params)
    if punch.save
      punch_log = punch.punch_logs.build(detail: punch.detail, in: punch.in, out: punch.out)
      punch_log.save
      redirect_to punches_path, flash: { center_notice: '保存しました' }
    else
      render :index
    end
  end

  def update
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to root_path
      return
    end
    if punch.out.blank?
      punch_log = PunchLog.find_by(punch_id: punch.id, out: nil)
      if punch.update(punch_params) && punch_log.update(punch_params.slice(:reason, :detail, :in, :out))
        redirect_to punches_path, flash: { center_notice: '編集しました' }
      else
        render :edit
      end
    else
      punch_log = punch.punch_logs.build(punch_params.slice(:reason, :detail, :in, :out))
      if punch.update(punch_params) && punch_log.save
        redirect_to punches_path, flash: { center_notice: '編集しました' }
      else
        render :edit
      end
    end
  end

  def destroy
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to root_path
      return
    end
    punch.destroy
    redirect_to punches_path, flash: { center_notice: '削除しました' }
  end

  def start
    prev_punch = current_user.punches.where(out: nil)
    if prev_punch.present?
      prev_punch.update_all(out: DateTime.now)
    end
    punch = current_user.punches.new(label_params.merge(in: DateTime.now))
    if punch.save
      punch_log = punch.punch_logs.build(in: punch.in)
      punch_log.save
      redirect_to punch_path(punch), flash: { center_notice: '開始しました' }
    else
      render :new
    end
  end

  def stop
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to root_path
      return
    end
    punch.update(punch_params.merge(out: DateTime.now))
    punch_log = punch.punch_logs.find_by(out: nil)
    punch_log&.update(detail: punch.detail, out: punch.out)
    redirect_to punches_path, flash: { center_notice: '終了しました' }
  end

  private

  def punch_params
    params.require(:punch).permit(:label_id, :reason, :detail, :in, :out)
  end

  def label_params
    params.require(:label).permit(:label_id)
  end

end

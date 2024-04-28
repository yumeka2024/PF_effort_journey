class Public::PunchesController < ApplicationController

  def new
    @labels = current_user.labels.all.order(genre: :asc)
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @day = Time.zone.today
    @punches = current_user.punches.where(in_time: @day.all_day).order(in_time: :asc)
    @punch = Punch.new
  end

  def index
    @search_params = search_params
    @search_results = Punch.search(@search_params)
  end

  def show
    @this_punch = Punch.find_by(id: params[:id])
    if @this_punch.nil? || @this_punch.out_time.present?
      redirect_to notfound_path
      return
    end
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @day = Time.zone.today
    @punches = current_user.punches.where(in_time: @day.all_day)
    @punch = Punch.new
    @labels = current_user.labels.all.order(genre: :asc)
  end

  def edit
    @this_punch = Punch.find_by(id: params[:id])
    if @this_punch.nil?
      redirect_to notfound_path
      return
    end
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @day = Time.zone.today
    @punches = current_user.punches.where(in_time: @day.all_day)
    @punch = Punch.new
    @labels = current_user.labels.all.order(genre: :asc)
  end

  def create
    punch = current_user.punches.new(punch_params)
    if punch.label_id.nil? || punch.in_time.nil? || punch.out_time.nil?
      redirect_to new_punch_path, flash: { center_notice: '入力内容を確認してください' }
    else
      if punch.save
        punch_log = punch.punch_logs.build(detail: punch.detail, in_time: punch.in_time, out_time: punch.out_time)
        punch_log.save
        redirect_to new_punch_path, flash: { center_notice: '保存しました' }
      else
        redirect_to new_punch_path, flash: { center_notice: '入力内容を確認してください' }
      end
    end
  end

  def update
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to notfound_path
      return
    end
    if params[:punch][:in_time].nil? || params[:punch][:out_time].nil?
      redirect_to edit_punch_path(punch), flash: { center_notice: '入力内容を確認してください' }
    else
      if punch.out_time.blank?
        punch_log = PunchLog.find_by(punch_id: punch.id, out_time: nil)
        if punch.update(punch_params) && punch_log.update(punch_params.slice(:reason, :detail, :in_time, :out_time))
          redirect_to edit_punch_path(punch), flash: { center_notice: '編集しました' }
        else
          render :edit
        end
      else
        punch_log = punch.punch_logs.build(punch_params.slice(:reason, :detail, :in_time, :out_time))
        if punch.update(punch_params) && punch_log.save
          redirect_to edit_punch_path(punch), flash: { center_notice: '編集しました' }
        else
          render :edit
        end
      end
    end
  end

  def destroy
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to notfound_path
      return
    end
    punch.destroy
    redirect_to new_punch_path, flash: { center_notice: '削除しました' }
  end

  def start
    prev_punch = current_user.punches.where(out_time: nil)
    if prev_punch.present?
      prev_punch.update_all(out_time: DateTime.now)
    end
    punch = current_user.punches.new(label_params.merge(in_time: DateTime.now))
    if punch.save
      punch_log = punch.punch_logs.build(in_time: punch.in_time)
      punch_log.save
      redirect_to punch_path(punch), flash: { center_notice: '開始しました' }
    else
      render :new
    end
  end

  def stop
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to notfound_path
      return
    end
    punch.update(punch_params.merge(out_time: DateTime.now))
    punch_log = punch.punch_logs.find_by(out_time: nil)
    punch_log&.update(detail: punch.detail, out_time: punch.out_time)
    redirect_to new_punch_path, flash: { center_notice: '終了しました' }
  end


  private

  def punch_params
    params.require(:punch).permit(:label_id, :reason, :detail, :in_time, :out_time)
  end

  def label_params
    params.require(:label).permit(:label_id)
  end

  def search_params
    params.fetch(:search, {}).permit(:in_time_from, :in_time_to, genre: [])
  end

end

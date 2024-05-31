class Public::PunchesController < ApplicationController
  before_action :is_matching_login_user, only: [:show, :edit, :update, :destroy, :stop]

  def new
    @labels = current_user.labels.all.order(genre: :asc)
    @prev_punch = current_user.punches.find_by(out_time: nil)
    @user = current_user
    @approved_followers = @user.followers.where('relationships.approved = ?', true)
    @approved_following = @user.followings.where('relationships.approved = ?', true)
    @prev_punch = current_user.punches.find_by(out_time: nil)
    @day = Time.zone.today
    @punches = current_user.punches.where(in_time: @day.all_day).order(in_time: :asc)
    @punch = Punch.new
  end

  def index
    @search_params = search_params
    @search_results = current_user.punches.search(@search_params)
    @prev_punch = current_user.punches.find_by(out_time: nil)
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
    @prev_punch = current_user.punches.find_by(out_time: nil)
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
    @prev_punch = current_user.punches.find_by(out_time: nil)
    @day = Time.zone.today
    @punches = current_user.punches.where(in_time: @day.all_day)
    @punch = Punch.new
    @labels = current_user.labels.all.order(genre: :asc)
  end

  def create
    punch = current_user.punches.new(punch_params)
    # バリデーション（startやstopアクションがあるため、モデル側でのバリデーション不可）
    if punch.label_id.nil? || punch.in_time.nil? || punch.out_time.nil?
      redirect_to new_punch_path, flash: { danger: '入力内容を確認してください' }
    else
      if punch.save
        # punchと全く同じ内容でpunch_logにもレコード作成
        punch_log = punch.punch_logs.build(detail: punch.detail, in_time: punch.in_time, out_time: punch.out_time)
        punch_log.save
        redirect_to new_punch_path, flash: { success: '保存しました' }
      else
        redirect_to new_punch_path, flash: { danger: '入力内容を確認してください' }
      end
    end
  end

  def update
    punch = Punch.find_by(id: params[:id])
    if punch.nil?
      redirect_to notfound_path
      return
    end
    # バリデーション
    if params[:punch][:in_time].blank? || params[:punch][:out_time].blank?
      redirect_to edit_punch_path(punch), flash: { danger: '入力内容を確認してください' }
      return
    end
    if punch.out_time.blank?
      # 更新対象の終了時刻が空だった場合は、同様のpunch_logレコードを探し更新する
      punch_log = PunchLog.find_by(punch_id: punch.id, out_time: nil)
      if punch.update(punch_params) && punch_log.update(punch_params.slice(:reason, :detail, :in_time, :out_time))
        redirect_to edit_punch_path(punch), flash: { success: '編集しました' }
      else
        render :edit
      end
    else
      # 更新対象の終了打刻が空でなければ、新たにpunch_logレコードを作成する
      punch_log = punch.punch_logs.build(punch_params.slice(:reason, :detail, :in_time, :out_time))
      if punch.update(punch_params) && punch_log.save
        redirect_to edit_punch_path(punch), flash: { success: '編集しました' }
      else
        render :edit
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
    redirect_to new_punch_path, flash: { success: '削除しました' }
  end

  def start
    # 終了打刻が空のレコードがあった場合、終了打刻に現在日時を記録してから、操作対象のpunchレコードを作成する
    # 終了打刻が空のレコードを1つしか探さない(更新しない)仕様
    # 理由：コンソール操作で終了打刻が空のレコードが複数になる可能性はあるが、その場合その全てを現在日時で埋めると意図と異なる操作になる可能性が高い為
    prev_punch = current_user.punches.find_by(out_time: nil)
    if prev_punch.present?
      prev_punch.update(out_time: DateTime.now)
    end
    punch = current_user.punches.new(label_params.merge(in_time: DateTime.now))
    if punch.save
      punch_log = punch.punch_logs.build(in_time: punch.in_time)
      punch_log.save
      redirect_to punch_path(punch), flash: { success: '開始しました' }
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
    redirect_to new_punch_path, flash: { success: '終了しました' }
  end


  private

  def is_matching_login_user
    punch = Punch.find(params[:id])
    unless punch.user_id == current_user.id
      redirect_to notfound_path
    end
  end

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

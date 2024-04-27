class Punch < ApplicationRecord

  belongs_to :user, optional:true
  belongs_to :label, optional:true
  has_many :punch_logs, dependent: :destroy

  scope :search, -> (search_params) do
    return if search_params.blank?

    in_from = search_params[:in_from].to_time
    in_to = search_params[:in_to].present? ? search_params[:in_to].to_time + 1.day : nil

    in_from(in_from).in_to(in_to).genre_like(search_params[:genre])
  end

  scope :genre_like, -> (genre) { joins(:label).where(label:{ genre: genre }) if genre.present? }
  scope :in_from, -> (from) { where('? <= `in`', from) if from.present? }
  scope :in_to, -> (to) { where('`in` < ?', to) if to.present? }
  # inはSQLiteの予約語である為、カラム名として使えない。救済措置をしたが後日修正する

end

class Punch < ApplicationRecord

  belongs_to :user
  belongs_to :label
  has_many :punch_logs, dependent: :destroy

  scope :search, -> (search_params) do
    return if search_params.blank?

    in_time_from = search_params[:in_time_from].to_time
    in_time_to = search_params[:in_time_to].present? ? search_params[:in_time_to].to_time + 1.day : nil

    in_time_from(in_time_from).in_time_to(in_time_to).genre_like(search_params[:genre])
  end

  scope :genre_like, -> (genre) { joins(:label).where(label:{ genre: genre }) if genre.present? }
  scope :in_time_from, -> (from) { where('? <= in_time', from) if from.present? }
  scope :in_time_to, -> (to) { where('in_time < ?', to) if to.present? }

end

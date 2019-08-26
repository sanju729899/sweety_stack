class Reading < ApplicationRecord

  belongs_to :user

  validates :title,
      presence: true,
      length: { minimum: 3 }
  validates :blood_sugar,
      presence: true,
      numericality: { only_integer: true,greater_than_or_equal_to: 0 }
       mattr_accessor :current_user

   validate :over_daily_readings_limit

  MAX_READINGS = 4
  ERROR_MESSAGE = "Maximum of #{MAX_READINGS} blood glucose readings per day."

  def over_daily_readings_limit
    if user.readings.daily_range(readed_date).count >= MAX_READINGS
      errors.add(:base,ERROR_MESSAGE)
    end
  end

  def self.glucose_max
    self.maximum(:blood_sugar)
  end

  def self.glucose_min
    self.minimum(:blood_sugar)
  end

  def self.glucose_avg
    (self.sum(:blood_sugar).to_f / self.count.to_f).round(2)
  end

  def self.oldest_report
    (self.minimum(:readed_date)).strftime('%d/%m/%Y')
  end

  def self.newest_report
    (self.maximum(:readed_date)).strftime('%d/%m/%Y')
  end

  def self.daily_range(date)
    return (self.where(:readed_date =>  (self.date_range(date, date).call)))
  end

  def self.monthly_range(date)
    return (self.where(:readed_date =>  (self.monthly_range_ret(date).call)))
  end

  def self.monthlyToDate_range(start_date, end_date)
    return (self.where(:readed_date => (self.date_range(start_date, end_date).call)))
  end

    def self.date_range(start_date, end_date)
    	Proc.new{(start_date.to_date.beginning_of_day..end_date.to_date.end_of_day)}
    end

    def self.monthly_range_ret(date)
    	Proc.new{(date.to_date.beginning_of_month..date.to_date.end_of_month)}
    end

end

class ReportsController < ApplicationController

	def index	
	end

  def daily
    @readings = current_user.readings
    # If no dates picked, default to today
    report_end = params[:report_end] ||= Time.now
    @report_end = Time.parse(report_end.to_s)

    @report = @readings.daily_range(@report_end)
  end

  def monthly
    @readings = current_user.readings

    # If no dates picked, default to today
    report_end = params[:report_end] ||= Time.now
    @report_end = Time.parse(report_end.to_s)

    @report = @readings.monthly_range(@report_end)
  end

  def date_wise
    @readings = current_user.readings

    # If no dates picked, default to today
    report_start = params[:report_start] ||= Time.now
    report_end = params[:report_end] ||= Time.now

    @report_start = Time.parse(report_start.to_s)
    @report_end = Time.parse(report_end.to_s)

    @report = @readings.monthlyToDate_range(@report_start, @report_end)
  end

end

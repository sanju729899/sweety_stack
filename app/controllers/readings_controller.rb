class ReadingsController < ApplicationController
 before_action :authenticate_user!

  def index
    @readings = current_user.readings.group_by{|t| t.readed_date.strftime("%d-%m-%Y")}
  end

  def show
    @reading = current_user.readings.find(params[:id])
  end

  def new
    @reading = current_user.readings.build
  end

  def edit
  	
    @reading = Reading.find(params[:id])
  end

  def create
    @reading = current_user.readings.build(reading_params)

    if @reading.save
      redirect_to @reading
    else
      render 'new'
    end

  end

  def update
    @reading = Reading.find(params[:id])

    if @reading.update(reading_params)
      redirect_to @reading
    else
      render 'edit'
    end

  end

  def destroy
    @reading = Reading.find(params[:id])
    @reading.destroy

    redirect_to @reading
  end


  private
    def reading_params
      massAssignable = [:title, :blood_sugar,:readed_date]
      params.require(:reading).permit(massAssignable)
    end

end

class GardensController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @gardens = Garden.all
    # pry.byebug
  end

  def show
    @garden = Garden.find(params[:id])
    @plant = Plant.new
    @plants = @garden.plants
  end

  def new
    @garden = Garden.new
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.user = current_user
    if @garden.save
      redirect_to garden_path(@garden)
    else
      render :new
    end
  end

  def destroy
    @garden = Garden.find(params[:id])
    @garden.destroy
    redirect_to root_path
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :banner_url)
  end
end

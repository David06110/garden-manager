class GardensController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @gardens = Garden.all
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

  def edit
    @garden = Garden.find(params[:id])
  end

  def update
    @garden = Garden.find(params[:id])
    @garden.update(garden_params)
    if @garden.save
      redirect_to garden_path(@garden)
    else
      render :edit
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :banner_url)
  end
end

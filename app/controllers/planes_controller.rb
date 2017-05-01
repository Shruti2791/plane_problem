class PlanesController < ApplicationController
  before_action :load_planes, only: :index
  before_action :load_plane, only: [:edit, :update, :edit, :show, :book_tickets]

  def index
  end

  def new
    @plane = Plane.new
  end

  def create
    @plane = Plane.new(plane_params)
    if @plane.save
      flash[:notice] = 'Plane created.'
      redirect_to planes_path
    else
      flash[:alert] = @plane.errors.messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @plane.update(plane_params)
      flash[:notice] = 'Plane saved.'
      redirect_to planes_path
    else
      flash[:alert] = @plane.errors.messages.to_sentence
      render :edit
    end
  end

  def show
    @filled_seats = @plane.filled_seats.to_json
  end

  def book_tickets
    filled_seats = @plane.book_tickets(params[:count].to_i)
    if filled_seats
      render json: filled_seats
    else
      render json: { alert: 'Sorry!! We are full' }, status: :unprocessable_entity
    end
  end

  private

  def plane_params
    params.require(:plane).permit(:name, lanes_attributes: [:id, :row, :column, :_destroy])
  end

  def load_planes
    @planes = Plane.all
  end

  def load_plane
    @plane = Plane.find_by(id: params[:id] || params[:plane_id])
    return if @plane
    flash[:alert] = 'No plane found.'
    redirect_to planes_path
  end
end

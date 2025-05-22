class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  def index
    if params[:query].present?
      @lists = List.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @lists = List.all
    end
  end

  # GET /lists/:id
  def show
    @bookmarks = @list.bookmarks
    @bookmark = Bookmark.new
    @bookmark.list = @list
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # POST /lists
  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'
    else
      render :new
    end
  end

  # GET /lists/:id/edit
  def edit
  end

  # PATCH/PUT /lists/:id
  def update
    if @list.update(list_params)
      redirect_to @list, notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lists/:id
  def destroy
    @list.destroy
    redirect_to lists_url, notice: 'List was successfully destroyed.'
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end

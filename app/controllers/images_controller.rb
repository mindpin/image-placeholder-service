class ImagesController < ApplicationController
  require 'open-uri'
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  #def edit
  #end

  # POST /images
  # POST /images.json
  def create
    @image_4ye = Image4ye.upload(image_params[:file].tempfile)
    @mini_image = MiniMagick::Image.read(image_params[:file].tempfile)
    @image = Image.new(image_params)
    @image.url = @image_4ye.url
    @image.width = @mini_image[:width]
    @image.height = @mini_image[:height]

    respond_to do |format|
      if @image.save
        format.html { redirect_to images_path, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  #def update
    #respond_to do |format|
      #if @image.update(image_params)
        #format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        #format.json { render :show, status: :ok, location: @image }
      #else
        #format.html { render :edit }
        #format.json { render json: @image.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def fill_image
    @image = Image.random
    @width = params[:width].to_i
    @height = params[:height].to_i
    @url = "#{@image.url}@#{@width}w_#{@height}h_1e_1c.png"
    result = open(@url)

    case result.class.name
    when "StringIO"
      file = Tempfile.new(result.meta['x-img-request-id'])
      file.binmode
      file.write result.read
      file.flush
      send_file file, type: 'image/png', disposition: 'inline'
      file.close
    when "Tempfile"
      send_file result, type: 'image/png', disposition: 'inline'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      #params.require(:image).permit(:url, :width, :height, :ratio)
      params.require(:image).permit(:file)
    end
end

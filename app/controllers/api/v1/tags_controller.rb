class Api::V1::TagsController < Api::V1::BaseController
  before_action :set_api_v1_tag, only: [:create, :show, :update, :destroy]

  # GET /api/v1/tags
  # GET /api/v1/tags.json
  def index
    @api_v1_tags = Api::V1::Tag.all
  end

  # GET /api/v1/tags/1
  # GET /api/v1/tags/1.json
  def show
  end

  # # GET /api/v1/tags/new
  # def new
  #   @api_v1_tag = Api::V1::Tag.new
  # end

  # GET /api/v1/tags/1/edit
  def edit
  end

  # POST /api/v1/tags
  # POST /api/v1/tags.json
  def create
    @api_v1_tag = Api::V1::Tag.new(api_v1_tag_params)

    respond_to do |format|
      if @api_v1_tag.save
        format.html { redirect_to @api_v1_tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @api_v1_tag }
      else
        format.html { render :new }
        format.json { render json: @api_v1_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/tags/1
  # PATCH/PUT /api/v1/tags/1.json
  def update
    respond_to do |format|
      if @api_v1_tag.update(api_v1_tag_params)
        format.html { redirect_to @api_v1_tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @api_v1_tag }
      else
        format.html { render :edit }
        format.json { render json: @api_v1_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/tags/1
  # DELETE /api/v1/tags/1.json
  def destroy
    @api_v1_tag.destroy
    respond_to do |format|
      format.html { redirect_to api_v1_tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_tag
      @api_v1_tag = Api::V1::Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_tag_params
      params.fetch(:api_v1_tag, {})
    end
end

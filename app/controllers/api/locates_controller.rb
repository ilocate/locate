class Api::LocatesController < ApiController
  before_action :set_locate, only: [:show, :edit, :update, :destroy]

  # GET /locates
  # GET /locates.json
  def index
    @locates = Locate.all
  end

  # GET /locates/1
  # GET /locates/1.json
  def show
  end

  # GET /locates/new
  def new
    @locate = Locate.new
  end

  # GET /locates/1/edit
  def edit
  end

  # POST /locates
  # POST /locates.json


# | user_id | integer | 用户id，非必填|
# | latitude | decimal | 纬度，必填 |
# | longitude | decimal |经度，必填 |
# | label | string |标签，非必填|
# | note | string | 备注，非必填 |
# | is_manual | boolean | 是否手动，必填 ，默认自动|

  def create

    label_info = Label.create(name: locate_params[:label])  if locate_params[:label].present?
    # 有记录，判断记录时长3分钟
    # 无记录，创建
    last_track = Track.last

    if last_track.present? && (Time.now - last_track.created_at) < 180
      @track = last_track
    else
      track_info = {
        start_at: Time.now,
        user_id: locate_params[:user_id],
        label_id: (label_info.id rescue 1 ),
        note: locate_params[:note],
        is_manual: locate_params[:is_manual]
      }
      @track = Track.create(track_info)
    end

    point_params = {
      track_id: (@track .id rescue ''),
      latitude: locate_params[:latitude],
      longitude: locate_params[:longitude]
    }

    @locate = Point.new(point_params)

    respond_to do |format|
      if @locate.save
        format.html { redirect_to @locate, notice: 'Locate was successfully created.' }
        format.json { render json: @locate }

      else
        format.html { render :new }
        format.json { render json: @locate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locates/1
  # PATCH/PUT /locates/1.json
  def update
    respond_to do |format|
      if @locate.update(locate_params)
        format.html { redirect_to @locate, notice: 'Locate was successfully updated.' }
        format.json { render :show, status: :ok, location: @locate }
      else
        format.html { render :edit }
        format.json { render json: @locate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locates/1
  # DELETE /locates/1.json
  def destroy
    @locate.destroy
    respond_to do |format|
      format.html { redirect_to locates_url, notice: 'Locate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_locate
      @locate = Locate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def locate_params
      params.permit(:user_id, :latitude, :longitude, :label_id, :note, :is_manual)
    end
end


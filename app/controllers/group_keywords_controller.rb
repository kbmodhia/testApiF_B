class GroupKeywordsController < ApplicationController
  before_action :set_group_keyword, only: %i[ show edit update destroy ]

  # GET /group_keywords or /group_keywords.json
  def index    
    @group_keywords = GroupKeyword.all
  end

  # GET /group_keywords/1 or /group_keywords/1.json
  def show
  end

  # GET /group_keywords/new
  def new
    @group_keyword = GroupKeyword.new
    @group_keyword.groupid = !params['groupid'].nil? ? params['groupid'] : ''
    @group_keyword.userid = !params['userid'].nil? ? params['userid'] : ''
  end

  # GET /group_keywords/1/edit
  def edit
  end

  # POST /group_keywords or /group_keywords.json
  def create
    @group_keyword = GroupKeyword.new(group_keyword_params)

    respond_to do |format|
      if @group_keyword.save
        # schedule job for selected recored
        # execute at every 5 minutes, ex: 12:05, 12:10, 12:15...etc
        jobId = Sidekiq::Cron::Job.create(name: "Hard worker - every 5min userid-#{@group_keyword.id}", cron: '*/5 * * * *', class: 'FbkeywordNotificationJob', args: @group_keyword.id) 

        format.html { redirect_to @group_keyword, notice: "Group keyword was successfully created." }
        format.json { render :show, status: :created, location: @group_keyword }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_keywords/1 or /group_keywords/1.json
  def update
    respond_to do |format|
      if @group_keyword.update(group_keyword_params)
        format.html { redirect_to @group_keyword, notice: "Group keyword was successfully updated." }
        format.json { render :show, status: :ok, location: @group_keyword }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_keywords/1 or /group_keywords/1.json
  def destroy
    @group_keyword.destroy
    respond_to do |format|
      format.html { redirect_to group_keywords_url, notice: "Group keyword was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_keyword
      @group_keyword = GroupKeyword.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_keyword_params
      params.require(:group_keyword).permit(:groupid, :userid, :keyword)
    end
end

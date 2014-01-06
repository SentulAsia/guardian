class PortalsController < ApplicationController
  require 'uri'
  skip_before_filter :verify_authenticity_token
  # GET /portals
  # GET /portals.json
  def index
    @now = Time.now
    @portals = Portal.paginate(:page => params[:page], :per_page => 30).order('captured_date ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @portals }
    end
  end

  # GET /portals/1
  # GET /portals/1.json
  def show
    @portal = Portal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @portal }
    end
  end

  # GET /portals/new
  # GET /portals/new.json
  def new
    @portal = Portal.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @portal }
    end
  end

  # GET /portals/1/edit
  def edit
    @portal = Portal.find(params[:id])
    @portal.destruction_date = Time.now if @portal.status_string == 'Live'
  end

  # POST /portals
  # POST /portals.json
  def create
    @portal = Portal.new(params[:portal])

    respond_to do |format|
      if @portal.save
        format.html { redirect_to portals_url, notice: 'Portal was successfully created.' }
        format.json { render json: @portal, status: :created, location: @portal }
      else
        format.html { render action: "new" }
        format.json { render json: @portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /portals/seed
  def seed
    @portal = Portal.find_or_initialize_by_portal_guid(params[:portal_guid])
    @portal.agent_name = '@' + params[:agent_name]
    @portal.portal_name = URI.decode(params[:portal_name])
    @portal.captured_date = Time.at(params[:captured_date].to_f/1000)
    @portal.lng_coordinate = params[:lng_coordinate].to_f / 1000000
    @portal.lat_coordinate = params[:lat_coordinate].to_f / 1000000
    @portal.location = URI.decode(params[:location])
    @portal.link = 'http://ingress.com/intel?ll=' + @portal.lat_coordinate.to_s + ',' + @portal.lng_coordinate.to_s + '&z=17&pll=' + @portal.lat_coordinate.to_s + ',' + @portal.lng_coordinate.to_s + ';'
    @portal.day_of_150 = @portal.captured_date + 150.days
    @portal.status_string = "Live"
    @portal.destroyed_by = nil
    @portal.destruction_date = nil

    respond_to do |format|
      if @portal.save
        format.html { redirect_to portals_url, notice: 'Portal was successfully seeded.' }
        format.json { render json: @portal, status: :created, location: @portal }
      else
        format.html { render action: "new" }
        format.json { render json: @portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /portals/1
  # PUT /portals/1.json
  def update
    @portal = Portal.find(params[:id])
    @page = params[:portal][:page] unless params[:portal][:page].blank?

    respond_to do |format|
      if @portal.update_attributes(params[:portal])
        format.html { redirect_to portals_url(:page => @page), notice: 'Portal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @portal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portals/1
  # DELETE /portals/1.json
  def destroy
    @portal = Portal.find(params[:id])
    @portal.destroy

    respond_to do |format|
      format.html { redirect_to portals_url }
      format.json { head :no_content }
    end
  end
end

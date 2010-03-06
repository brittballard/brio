class SonarsController < ApplicationController
  # GET /sonars
  # GET /sonars.xml
  def index
    @sonars = Sonar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sonars }
      format.json { render :json => @sonars }
    end
  end

  # GET /sonars/1
  # GET /sonars/1.xml
  def show
    @sonar = Sonar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sonar }
      format.json { render :json => @sonar }
    end
  end

  # GET /sonars/new
  # GET /sonars/new.xml
  def new
    @sonar = Sonar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sonar }
      format.json { render :json => @sonar }
    end
  end

  # GET /sonars/1/edit
  def edit
    @sonar = Sonar.find(params[:id])
      
      respond_to do |format|
        format.html
        format.json { render :json => @sonar}
      end
  end

  # POST /sonars
  # POST /sonars.xml
  def create
    @sonar = Sonar.new(params[:sonar])

    respond_to do |format|
      if @sonar.save
        flash[:notice] = 'Sonar was successfully created.'
        format.html { redirect_to(@sonar) }
        format.xml  { render :xml => @sonar, :status => :created, :location => @sonar }
        format.json { render :json => @sonar, :status => :created, :location => @sonar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sonar.errors, :status => :unprocessable_entity }
        format.json { render :json => @sonar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sonars/1
  # PUT /sonars/1.xml
  def update
    @sonar = Sonar.find(params[:id])

    respond_to do |format|
      if @sonar.update_attributes(params[:sonar])
        flash[:notice] = 'Sonar was successfully updated.'
        format.html { redirect_to(@sonar) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sonar.errors, :status => :unprocessable_entity }
        format.json { render :json => @sonar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sonars/1
  # DELETE /sonars/1.xml
  def destroy
    @sonar = Sonar.find(params[:id])
    @sonar.destroy

    respond_to do |format|
      format.html { redirect_to(sonars_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end

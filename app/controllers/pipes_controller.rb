class PipesController < ApplicationController
  # GET /pipes
  # GET /pipes.xml
  def index
    @pipes = Pipe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pipes }
    end
  end

  # GET /pipes/1
  # GET /pipes/1.xml
  def show
    @pipe = Pipe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pipe }
    end
  end

  # GET /pipes/new
  # GET /pipes/new.xml
  def new
    @pipe = Pipe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pipe }
    end
  end

  # GET /pipes/1/edit
  def edit
    @pipe = Pipe.find(params[:id])
  end

  # POST /pipes
  # POST /pipes.xml
  def create
    @pipe = Pipe.new(params[:pipe])

    respond_to do |format|
      if @pipe.save
        flash[:notice] = 'Pipe was successfully created.'
        format.html { redirect_to(@pipe) }
        format.xml  { render :xml => @pipe, :status => :created, :location => @pipe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pipes/1
  # PUT /pipes/1.xml
  def update
    @pipe = Pipe.find(params[:id])

    respond_to do |format|
      if @pipe.update_attributes(params[:pipe])
        flash[:notice] = 'Pipe was successfully updated.'
        format.html { redirect_to(@pipe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pipes/1
  # DELETE /pipes/1.xml
  def destroy
    @pipe = Pipe.find(params[:id])
    @pipe.destroy

    respond_to do |format|
      format.html { redirect_to(pipes_url) }
      format.xml  { head :ok }
    end
  end
end

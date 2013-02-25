# encoding: utf-8
class WorkersController < ApplicationController
  # GET /workers
  # GET /workers.json
  def index

    @workers = Worker.all

    # dla formularza new
    @worker = current_user.workers.build if signed_in?

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workers }
    end
  end

  # GET /workers/1
  # GET /workers/1.json
  def show
    @worker = Worker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @worker }
    end
  end

  def add_product
    # dodanie powiazania pracownik - product (usluga)
    @worker = Worker.find(params[:id])
    if !@worker.products.exists?(Product.find(params[:product_id]))
      @worker.products << Product.find(params[:product_id])
    end

    render 'show'

  end

  def del_product
    @worker = Worker.find(params[:id])
    @worker.products.delete(@worker.products.find(params[:product_id]))

    render 'show'

  end

  # GET /workers/new
  # GET /workers/new.json
  def new
    @worker = Worker.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @worker }
    end
  end

  # GET /workers/1/edit
  def edit
    @worker = Worker.find(params[:id])

    # dla tabeli index
    @workers = Worker.find(:all, :conditions => ["user_id = ?", current_user.id])

    render 'index'
  end

  # POST /workers
  # POST /workers.json
  def create
    # user = User.find(params[:worker][:user_id])
    # @worker = Worker.new(params[:worker])
    @worker = current_user.workers.build(params[:worker])

    respond_to do |format|
      if @worker.save
        format.html { redirect_to @worker, notice: 'Utworzono pracownika.' }
        format.json { render json: @worker, status: :created, location: @worker }
      else
        format.html { render action: "new" }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /workers/1
  # PUT /workers/1.json
  def update
    @worker = Worker.find(params[:id])

    respond_to do |format|
      if @worker.update_attributes(params[:worker])
        format.html { redirect_to @worker, notice: 'Zaktualizowano dane pracownika.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workers/1
  # DELETE /workers/1.json
  def destroy
    @worker = Worker.find(params[:id])
    @worker.destroy

    respond_to do |format|
      format.html { redirect_to workers_url }
      format.json { head :no_content }
    end
  end
end

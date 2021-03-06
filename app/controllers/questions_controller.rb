class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.mobject_id = params[:mobject_id]
    @mobject = Mobject.find(params[:mobject_id])
    if @mobject
      num = @mobject.questions.maximum(:sequence)
    end 
    if num 
      @question.sequence = num + 1
    else
      @question.sequence = 1
    end
    @question.name = "Frage Nr.x"
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to mobject_path(:id => @question.mobject, :topic => "objekte_fragen"), notice: (I18n.t :act_create) }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to mobject_path(:id => @question.mobject, :topic => "objekte_fragen"), notice: (I18n.t :act_update) }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question_mobject_id = @question.mobject_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to mobject_path(:id => @question_mobject_id, :topic => "objekte_fragen"), notice: (I18n.t :act_delete) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:mobject_id, :name, :description, :sequence, :mcategory_id)
    end
end

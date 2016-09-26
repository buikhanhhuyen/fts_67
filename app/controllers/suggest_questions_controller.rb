class SuggestQuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :find_suggest_question, only: [:edit, :update]
  before_action :load_subjects, except: [:index, :show, :destroy]

  def new
    @suggest_question = SuggestQuestion.new
  end

  def create
    @suggest_question =
      current_user.suggest_questions.new suggest_question_params
    if @suggest_question.save
      flash[:success] = t "suggest_question.create_success"
      redirect_to @suggest_question
    else
      load_subjects
      render :new
    end
  end

  def edit
  end

  def update
    if @suggest_question.update_attributes suggest_question_params
      flash[:success] = t "suggest_question.update_success"
      redirect_to @suggest_question
    else
      load_subjects
      render :edit
    end
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :id, :content,:subject_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def find_suggest_question
    @suggest_question = SuggestQuestion.find_by id: params[:id]
    if @suggest_question.nil?
      flash[:danger] = t "suggest_question.not_found"
      redirect_to suggest_questions_path
    end
  end
end

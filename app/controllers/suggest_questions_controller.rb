class SuggestQuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :find_suggest_question, except: [:new, :create, :index]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :check_unapproved, except: [:new, :index, :create]
  before_action :load_subjects, only: [:new, :edit, :show]

  def show
  end

  def index
    @suggest_questions = SuggestQuestion.paginate page: params[:page],
      per_page: Settings.suggest_questions
  end

  def new
    @suggest_question = SuggestQuestion.new
  end

  def create
    @suggest_question =
      current_user.suggest_questions.new suggest_question_params
    if @suggest_question.save
      flash[:success] = t "suggest_question.create_success"
      redirect_to suggest_questions_path
    else
      load_subjects
      flash.now[:danger] = t "suggest_question.create_error"
      render :new
    end
  end

  def update
    if @suggest_question.update_attributes suggest_question_params
      flash[:success] = t "suggest_question.update_success"
      redirect_to @suggest_question
    else
      load_subjects
      render :show
    end
  end

  def destroy
    if @suggest_question.destroy
      flash[:success] = t "suggest_question.update_success"
      redirect_to suggest_questions_path
    else
      flash[:danger] = t "suggest_question.update_error"
      redirect_to root_url
    end
  end

  private
  def suggest_question_params
    params.require(:suggest_question).permit :content,:subject_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def find_suggest_question
    @suggest_question = SuggestQuestion.find_by id: params[:id]
    if @suggest_question.nil?
      flash[:danger] = t "suggest_question.not_found"
      redirect_to suggest_questions_path
    end
  end

  def correct_user
    unless current_user.current_user? @suggest_question.user
      redirect_to root_url
    end
  end

  def check_unapproved
    redirect_to root_url if @suggest_question.approved?
  end
end

class Admin::SuggestQuestionsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_suggest_question, except: :index

  def index
    @suggest_questions = SuggestQuestion.paginate page: params[:page]
  end

  def show
  end

  def update
    if @suggest_question.update_attributes status: params[:status]
      flash[:success] = t "suggest_question.update_success"
    else
      flash[:danger] = t "suggest_question.update_error"
    end
    redirect_to admin_suggest_questions_path
  end

  def destroy
    if @suggest_question.destroy
      flash[:success] = t "suggest_question.update_success"
    else
      flash[:danger] = t "suggest_question.update_error"
    end
    redirect_to admin_suggest_questions_path
  end

  private
  def find_suggest_question
    @suggest_question = SuggestQuestion.find_by id: params[:id]
    if @suggest_question.nil?
      flash[:danger] = t "find_suggest.danger"
      redirect_to admin_suggest_questions_path
    end
  end
end

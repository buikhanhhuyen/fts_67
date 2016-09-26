class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :find_subject, except: [:index, :new, :create]

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
    @questions = @subject.questions.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash.now[:success] = t "subject.success"
      render @subject
    else
      flash.now[:danger] = t "subject.fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subject.updated"
      redirect_to admin_subjects_url
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "subject.success"
      redirect_to admin_subjects_url
    else
      flash[:danger] = t "subject.danger"
      redirect_to root_url
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :duration, :description
  end

  def find_subject
    @subject = Subject.find_by id: params[:id]
    if @subject.nil?
      flash[:danger] = t "find_subject.danger"
      redirect_to root_url
    end
  end
end

class SubmissionsController < ApplicationController
  include Authorization

  # GET /submissions
  def index
    authenticate_account!
    authorize Submission
    find_submissions
  end

  # GET /submissions/1/edit
  def edit
    authenticate_account!
    find_submission
    authorize_record!
  end

  # PATCH/PUT /submissions/1
  def update
    authenticate_account!
    find_submission
    authorize_account!

    if @record.update!(submission_params)
      redirect_to @record, notice: 'Submission was successfully updated.'
    else
      render :edit
    end
  end

  private def find_submission
    @record = SubmissionDecorator.decorate(pundit_scoped.find(params[:id]))
  end

  private def find_submissions
    @records = SubmissionDecorator.decorate_collection(pundit_scoped)
  end

  # Only allow a trusted parameter "white list" through.
  private def submission_params
    {

    }
  end

  private def pundit_scoped
    policy_scope(Submission)
  end
end

class MembersController < BaseController
  def index
    params[:sort_by] ||= :generation

    @members = {
      role: Member.all.sorted_by_role,
      major: Member.all.sorted_by_major,
      status: Member.all.sorted_by_status,
      generation: Member.all.sorted_by_generation,
    }.fetch(params[:sort_by]&.to_sym)
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member
    else
      flash[:error] = t('messages.errors.could_not_save_member')
      redirect_to new_member_path
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      redirect_to @member
    else
      flash[:error] = t('messages.errors.could_not_save_member')
      redirect_to edit_member_path(params[:id])
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    redirect_to members_path
  end

  private

  def member_params
    params.require(:member).permit(
      :first_name,
      :fathers_last_name,
      :mothers_last_name,
      :email,
      :major,
      :avatar,
      :github_username,
      :github_url,
      :linkedin_username,
      :linkedin_url,
      :resume_url,
      :status,
      :role,
      :description,
      :start_date,
      :end_date,
      :generation,
      :username
    )
  end
end

class TeamsController < BaseController
  def index
    @teams = Team.all;
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team
    else
      flash[:error] = t('messages.errors.could_not_save_team')
      redirect_to :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to @team
    else
      flash[:error] = t('messages.errors.could_not_save_team')
      redirect_to :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(
      :name,
      :github_url,
      :category_id
    )
  end
end

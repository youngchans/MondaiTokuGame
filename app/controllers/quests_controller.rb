class QuestsController < ApplicationController
  before_action :set_quest, only: %i[ show edit update destroy search]

  def index
    if params[:search].present?
      @quests = Quest.where("question LIKE ?", "%#{params[:search]}%")
    else
      @quests = Quest.all
    end
  end

  def show
  end

  def new
    @quest = Quest.new
  end

  def edit
  end

  def create
    @quest = Quest.new(quest_params)

    respond_to do |format|
      if @quest.save
        format.html { redirect_to quest_url(@quest), notice: "単語作成を成功しました。" }
        format.json { render :show, status: :created, location: @quest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.html { redirect_to quest_url(@quest), notice: "単語アップデートを成功しました。" }
        format.json { render :show, status: :ok, location: @quest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quests/1 or /quests/1.json
  def destroy
    @quest.destroy

    respond_to do |format|
      format.html { redirect_to quests_url, notice: "単語削除を成功しました。" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quest
      @quest = Quest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quest_params
      params.require(:quest).permit(:question, :description, :wrong_f, :wrong_s)
    end
end

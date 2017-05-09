class TreasurersController < ApplicationController
  
  before_action :authenticate_user!
# 会計の一覧を表示
  def index
    @treasurer = Treasurer.new
    @treasurers = current_user.treasurers

    respond_to do |format|
      format.html { render template: "treasurers/index" }
      format.json {
        render json: @treasurers.map(&:for_js)
        } 
    end
  end

# 会計を保存する
  def create
    treasurer = Treasurer.new(treasurer_params)
    if treasurer.category == "" && treasurer.comment == ""
      treasurer.category << "入力されていません"
      treasurer.comment << "入力されていません"
    elsif treasurer.category == ""
      treasurer.category << "入力されていません"
    elsif treasurer.comment == ""
      treasurer.comment << "入力されていません"
    end
    if treasurer.save
      respond_to do |format|
        format.html { redirect_to user_treasurers_path}
        format.json {
          render json: {
            date: treasurer.date,
            price: treasurer.price,
            comment: treasurer.comment,
            category: treasurer.category,
            }
          } #入力されたデータを保存する。
      end
    end
  end

# 会計を編集する
  def edit
  end

# 会計を削除する
  def destroy
  end

  private

  def treasurer_params
    params.require(:treasurer).permit(:date, :comment, :price, :category).merge(user_id: current_user.id)
  end

end

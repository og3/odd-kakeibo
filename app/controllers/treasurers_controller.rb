class TreasurersController < ApplicationController
# Helperメソッドからsort_direction、sort_columnを使用できるように
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!
# 会計の一覧を表示
  def index
    @date = Date.today
    @treasurer = Treasurer.new
    # sort_direction、sort_columnの値に基いて並び替えたデータを取得するため
    @treasurers = current_user.treasurers.order(sort_column + ' ' + sort_direction)

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
# sort_directionではViewから受け取るparams[:direction]がasc、もしくはdescのどちらかに含まれるかを三項演算子を使用して判定しています。params[:direction]が指定されていない場合はascとなります。すなわちデフォルトの状態ではascで並び替えられたテーブルが表示されます。
  def sort_direction
    %w(asc desc).include?(params[:direction]) ?  params[:direction] : "asc"
  end
# Viewから受け取るparams[:sort]が実際に存在するカラム名であるかを三項演算子を使用して判定しています。params[:sort]が指定されていない場合はnameで並び替えます。すなわちデフォルトの状態ではdateカラムで並び替えられたテーブルが表示されます。
  def sort_column
      Treasurer.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end
end

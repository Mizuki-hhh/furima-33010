class RecordsController < ApplicationController

  def index
    @purchase_record = PurchaseRecord.new
    @item = Item.find(params[:item_id])

  
  end

  def create
    @purchase_record = PurchaseRecord.new(record_params)
    if @purchase_record.valid?
      @purchase_record.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def record_params
    params.require(:purchase_record).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :record_id).merge(user_id: current_user.id, item_id: params[:item_id] )
  end

end

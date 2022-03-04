class Public::CustomersController < ApplicationController
    def show
    @customer = current_customer
    end

   def edit
     @customer = current_customer
   end

   def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_customer_path(current_customer)
   end

   def quit
    @customer = Customer.find_by(email: params[:email])
   end

   def out
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_customer_session_path
   end


 private
  def customer_params
   params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end

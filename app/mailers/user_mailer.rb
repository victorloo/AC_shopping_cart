class UserMailer < ApplicationMailer
  default from: "My Cart <info@alphacamp.co>"

  def notify_order_create(order)
    @order = order
    @content = "Your order is created. Thank you!"
    # 顯示在信件裡的內容

    mail to: order.user.email,
    subject: "ALPHA Camp | 訂單成立︰#{@order.id}"
    # 設定 mail 的主旨
  end

end
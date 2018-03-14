class SpgatewayController < ActionController::Base

  def return
    # 比對回傳的 SHA 和我們自行加密的 SHA 是否一樣
    hash_key = "1xPGwF7Ntyqrozd7CupSNhf7LFS0YWC9"
    hash_iv = "mK0q3ME9laL6LJQX"
    trade_info = spgateway_params['TradeInfo']
    trade_sha = spgateway_params['TradeSha']

    str = "HashKey=#{hash_key}&#{trade_info}&HashIV=#{hash_iv}"
    check_sha = Digest::SHA256.hexdigest(str).upcase

    # 若 SHA 驗證通過，將智付通回傳的 TradeInfo 解密，取得參數內容
    if check_sha == trade_sha
      decipher = OpenSSL::Cipher::AES256.new(:CBC)
      decipher.decrypt
      decipher.key = hash_key
      decipher.iv = hash_iv

      # hex to binary
      binary_encrypted = [trade_info].pack('H*')

      plain = decipher.update(binary_encrypted)

      # strip last padding
      if plain[-1] != '}'
        plain = plain[0, plain.index(plain[-1])]
      end
      data = JSON.parse(plain)
    end
    
    # 根據參數的 MerchantOrderNo，查出 payment 實例
    # 更新相關的 payment 與 order 屬性
    if data
      payment = Payment.find(data['Result']['MerchantOrderNo'].to_i)
      if params['Status'] == 'SUCCESS'
        payment.paid_at = Time.now
      end
      payment.params = data
    end

    if payment&.save
      order = payment.order
      order.update(payment_status: "paid")

      # send paid email
      flash[:notice] = "#{payment.sn} paid"
    else
      flash[:alert] = "Something wrong!!!"
    end

    # 動作完成，導回訂單索引頁
    redirect_to orders_path
  end

  private

  # 取出必要參數
  def spgateway_params
    params.slice("Status", "MerchantID", "Version", "TradeInfo", "TradeSha")
  end

end

=begin
class的定義有另一種寫法可以通過CSRF
class SpgatewayController < ApplicationController
  skip_before_action :verify_authenticity_token
end
=end
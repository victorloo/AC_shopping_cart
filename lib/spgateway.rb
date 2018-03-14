class Spgateway

  mattr_accessor :merchant_id
  mattr_accessor :hash_key
  mattr_accessor :hash_iv
  mattr_accessor :url

  def initialize(payment)
    @payment = payment
    self.merchant_id = "MS33470893"
    self.hash_key = "1xPGwF7Ntyqrozd7CupSNhf7LFS0YWC9"
    self.hash_iv = "mK0q3ME9laL6LJQX"
    self.url = "https://ccore.spgateway.com/MPG/mpg_gateway"
  end

  def generate_form_data(return_url)
    spgateway_data = {
      MerchantID: self.merchant_id,
      RespondType: "JSON",
      TimeStamp: @payment.created_at.to_i,
      Version: 1.4,
      MerchantOrderNo: "#{@payment.id}AC",
      Amt: @payment.amount,
      ReturnURL: return_url,
      ItemDesc: @payment.order.name,
      Email: @payment.order.user.email,
      LoginType: 0        
    }
    # MerchantOrderNo 要用 string

    trade_info = self.encrypt(spgateway_data)
    trade_sha = self.class.generate_aes_sha256(trade_info)

    return {
      MerchantID: self.merchant_id,
      TradeInfo: trade_info,
      TradeSha: trade_sha,
      Version: '1.4'
    }
  end

  def encrypt(params_data)
    cipher = OpenSSL::Cipher::AES256.new(:CBC)
    cipher.encrypt
    cipher.key = self.hash_key
    cipher.iv = self.hash_iv
    encrypted = cipher.update(params_data.to_query) + cipher.final #將 hash 轉成 query string
    aes = encrypted.unpack('H*').first # binary 轉 hex
  end

  def self.generate_aes_sha256(trade_info)
    str = "HashKey=#{self.hash_key}&#{trade_info}&HashIV=#{self.hash_iv}"
    Digest::SHA256.hexdigest(str).upcase
  end

  def self.decrypt(trade_info, trade_sha)
    return nil if self.generate_aes_sha256(trade_info) != trade_sha

    decipher = OpenSSL::Cipher::AES256.new(:CBC)
    decipher.decrypt
    decipher.key = self.hash_key
    decipher.iv = self.hash_iv

    # hex to binary
    binary_encrypted = [trade_info].pack('H*')

    plain = decipher.update(binary_encrypted)

    # strip last padding
    if plain[-1] != '}'
      plain = plain[0, plain.index(plain[-1])]
    end

    return JSON.parse(plain)
  end

end
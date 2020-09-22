class JsonWebToken
  def self.encode(payload, exp = 1.day.from_now.to_i)
    JWT.encode({ data: payload, exp: exp }, ENV['JSON_WEB_TOKEN_SECRET'], 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode token, ENV['JSON_WEB_TOKEN_SECRET'], true, { algorithm: 'HS256' }
    decoded[0]['data']['user_id']
  rescue StandardError
    nil
  end
end


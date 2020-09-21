class JsonWebToken
  def self.encode(payload, exp = Time.now.to_i + 1 * 3600)
    JWT.encode({ data: payload, exp: exp }, ENV['JSON_WEB_TOKEN_SECRET'], 'HS256')
  end

  def self.decode(token)
    JWT.decode token, ENV['JSON_WEB_TOKEN_SECRET'], true, { algorithm: 'HS256' }
  end
end
# TODO: Work more on token
# TODO: account for errors if the web token fails

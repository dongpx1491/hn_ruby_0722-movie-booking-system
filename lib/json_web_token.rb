require "jwt"

class JsonWebToken
  ALGORITHM = "HS256".freeze

  class << self
    def encode payload, _expiry = 24.hours.from_now
      # payload[:expiry] = expiry.to_i
      JWT.encode(payload, ENV["auth_secret"], ALGORITHM)
    end

    def decode token
      JWT.decode(token, ENV["auth_secret"], true, {algorithm: ALGORITHM}).first
    end
  end
end

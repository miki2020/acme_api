module Fakeapi
require "net/http"

  FAKEAPI_URI = "https://www.fakepay.io/purchase"

  def self.post_payment(args = {})

    url = URI(FAKEAPI_URI)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{ENV['FAKEAPI_TOKEN']}"
    request["Content-Type"] = "application/json"
    args = args.include?(:payment_token) ? {"amount": args[:amount], "token": args[:payment_token]} : args
    request.body = JSON.dump(args)

    response = https.request(request)
    JSON.parse(response.body)

  end

end

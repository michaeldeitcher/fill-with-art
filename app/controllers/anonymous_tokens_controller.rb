class AnonymousTokensController < ApplicationController
  def create
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
    render json: {token: token}.to_json, status: 201
  end
end

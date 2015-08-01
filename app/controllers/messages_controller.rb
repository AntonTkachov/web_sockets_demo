class MessagesController < ApplicationController
  def create
    params = JSON.parse(request.raw_post)
    response_json = {
      message: params['message'], user_id: params['user_id']
    }.to_json
    WebsocketRails[:chat].trigger('message', response_json)
    render nothing: true, status: 204
  end
end

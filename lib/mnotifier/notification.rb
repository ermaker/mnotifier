require 'sinatra'
require 'digest/sha1'

post '/notifications' do
  filename = "#{request.url}/#{Digest::SHA1.hexdigest(params[:detail])}"
  filename
end

require 'sinatra/base'
require 'digest/sha1'

module MNotifier
  class Notification < Sinatra::Base
    configure do
      @@notifications = {}
    end

    get '/notifications' do
      <<-EOS
<form method=post enctype='multipart/form-data'>
  <input name=detail />
  <input type=submit />
</form>
      EOS
    end

    get '/notifications/*' do |key|
      @@notifications[key]
    end

    post '/notifications' do
      value = params[:detail]
      key = Digest::SHA1.hexdigest(value)
      @@notifications[key] = value
      "#{request.url}/#{key}"
    end
  end
end

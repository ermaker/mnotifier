require 'sinatra/base'
require 'digest/sha1'

class Notification < Sinatra::Base
  get '/notifications' do
    <<-EOS
<form method=post enctype='multipart/form-data'>
  <input name=detail />
  <input type=submit />
</form>
    EOS
  end

  post '/notifications' do
    contents = params[:detail]
    filename = Digest::SHA1.hexdigest(contents)
    FileUtils.mkdir_p 'notifications', :mode => 0700
    File.open(File.join('notifications', filename), 'w', 0600) do |f|
      f << contents
    end
    "#{request.url}/#{filename}"
  end
end

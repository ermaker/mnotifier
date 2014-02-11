ENV['RACK_ENV'] = 'test'

require 'spec_helper'
require 'rack/test'
require 'mnotifier/notification'

describe 'MNotifier App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'posts notifications' do
    post '/notifications', detail: 'detail description'
    last_response.body.should == "http://example.org/notifications/033d92cc16d782809355e5800042faedf4005641"
    last_response.should be_ok
  end
end

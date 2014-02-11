ENV['RACK_ENV'] = 'test'

require 'spec_helper'
require 'rack/test'
require 'fakefs/spec_helpers'
require 'mnotifier/notification'

describe 'MNotifier App' do
  include Rack::Test::Methods
  include FakeFS::SpecHelpers

  def app
    MNotifier::Notification.new
  end

  it 'posts notifications and gets the notification' do
    post '/notifications', detail: 'detail description'
    last_response.body.should == 'http://example.org/notifications/033d92cc16d782809355e5800042faedf4005641'
    last_response.should be_ok

    get '/notifications/033d92cc16d782809355e5800042faedf4005641'
    last_response.body.should ==  'detail description'
    last_response.should be_ok
  end
end

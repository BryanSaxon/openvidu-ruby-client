require 'test_helper'

class FakeSession < Object
  attr_reader :params, :from_find, :server

  def initialize(server, params={}, from_find=false)
    @server = server
    @params = params
    @from_find = from_find
  end

  def find(id)
    self.class.new(server, {}, true)
  end
end

class TestResponder < Minitest::Test
  def test_record_destroyed
    r = OpenVidu::Responder.new
    response = r.execute(server, :session, nil)
    assert_equal(true, response)
  end

  def test_get_complete_record
    r = OpenVidu::Responder.new
    response = r.execute(server, :fake_session, {
        'sessionId' => 'test_id'
    })

    assert_equal('test_id', response.params[:sessionId])
  end

  def test_record_lookup
    r = OpenVidu::Responder.new
    response = r.execute(server, :fake_session, {
      'id' => 'test',
      'createdAt' => Time.new.to_s
    })

    assert_equal(true, response.from_find)
  end

  def server
    OpenVidu::Server.new('https://127.0.0.1:4443?token=MY_SECRET&verify_peer=false')
  end
end

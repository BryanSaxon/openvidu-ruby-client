require 'test_helper'

class FakeSession < Object
  attr_reader :params, :from_find

  def initialize(params={}, from_find=false)
    @params = params
    @from_find = from_find
  end

  def self.find(id)
    new({}, true)
  end
end

class TestResponder < Minitest::Test
  def test_record_destroyed
    r = OpenVidu::Responder.new
    response = r.execute(:session, nil)
    assert_equal(true, response)
  end

  def test_get_complete_record
    r = OpenVidu::Responder.new
    response = r.execute(:fake_session, {
        'sessionId' => 'test_id'
    })

    assert_equal('test_id', response.params[:sessionId])
  end

  def test_record_lookup
    r = OpenVidu::Responder.new
    response = r.execute(:fake_session, {
      'id' => 'test',
      'createdAt' => Time.new.to_s
    })

    assert_equal(true, response.from_find)
  end
end
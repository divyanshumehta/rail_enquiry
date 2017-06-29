require 'test_helper'

class EnquiryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get enquiry_index_url
    assert_response :success
  end

end

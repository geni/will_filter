require 'test_helper'

module WillFilter
  class CalendarControllerTest < WillFilter::ControllerTest

    test 'index' do
      get :index
      assert_response :success
    end

  end # class CalendarControllerTest
end # module WillFilter

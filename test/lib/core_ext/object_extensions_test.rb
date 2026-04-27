require 'test_helper'

class ObjectExtensionsTest < ActiveSupport::TestCase

  # There was an Array extension that I removed
  # because there was also an Object extension
  test 'Array gets wf_filter moethod' do
    thing = []
    thing.wf_filter = 'thing'
    assert_equal 'thing', thing.wf_filter
  end

end
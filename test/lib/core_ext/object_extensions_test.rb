require_relative '../../test_helper'

class ObjectExtensionsTest < Test::Unit::TestCase

  # There was an Array extension that I removed
  # because there was also an Object extension
  test 'Array gets wf_filter moethod' do
    foo = []
    foo.wf_filter = 'foo'
    assert_equal 'foo', foo.wf_filter
  end

end
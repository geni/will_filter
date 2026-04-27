require 'test_helper'

TestFilter = Class.new(WillFilter::Filter) unless defined?(TestFilter)

class FilterTest < ActiveSupport::TestCase

  def setup
    @filters = [
      TestFilter.create! { |ii| ii.name = 'one' },
      TestFilter.create! { |ii| ii.name = 'two' },
    ]
  end

  def teardown
    # Also test Wf module alias
    Wf::Filter.delete_all
  end

  test 'new with no parameter' do
    filter = TestFilter.new
    assert_equal 'Test', filter.model_class.name
  end

  test 'new with invalid class' do
    assert_raise RuntimeError do
      InvalidKlassFilter = Class.new(WillFilter::Filter)
      filter = InvalidKlassFilter.new
    end
  end

  test 'new with valid class' do
    filter = TestFilter.new(WillFilter::Filter)
    assert_equal 'WillFilter::Filter', filter.model_class.name
  end

  test 'deserialize_from_params' do
    params = {
      :wf_type  => 'TestFilter',
      :wf_model => 'WillFilter::Filter',
      'wf_c0'   => 'name',
      'wf_o0'   => 'equals',
      'wf_v0_0' => 'one',
    }
    filter = WillFilter::Filter.deserialize_from_params(params)

    assert_equal [@filters.first], filter.results
  end

end # class FilterTest

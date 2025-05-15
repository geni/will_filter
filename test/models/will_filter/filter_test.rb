require 'test_helper'

TestFilter = Class.new(WillFilter::Filter) unless defined?(TestFilter)

class FilterTest < ActiveSupport::TestCase

  def setup
    @filters = [
      TestFilter.create! { |ii| ii.name = 'one' },
      TestFilter.create! { |ii| ii.name = 'two' },
    ]
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

  test 'empty conditions' do
    params = {
      :wf_type  => 'TestFilter',
      :wf_model => 'WillFilter::Filter',
    }
    filter = WillFilter::Filter.deserialize_from_params(params)

    assert_equal 2, filter.results.size
  end

  test 'sum' do
    params = {
      :wf_type  => 'TestFilter',
      :wf_model => 'WillFilter::Filter',
    }
    filter = WillFilter::Filter.deserialize_from_params(params)

    expected = @filters.reduce(0) {|sum, ii| sum + ii.id }
    assert_equal expected, filter.sum(:id)
  end

  test 'save and load filter' do
    params = {
      :wf_name  => 'test',
      :wf_type  => 'TestFilter',
      :wf_model => 'WillFilter::Filter',
      'wf_c0'   => 'name',
      'wf_o0'   => 'equals',
      'wf_v0_0' => 'one',
    }
    filter = WillFilter::Filter.deserialize_from_params(params)
    filter.save!

    loaded_filter = WillFilter::Filter.new.load_filter!(filter.id)

    assert_equal filter.id, loaded_filter.id
    assert_equal filter.data, loaded_filter.data
  end

end # class FilterTest
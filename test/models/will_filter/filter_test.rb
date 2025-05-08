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

  test 'legacy wf module compatability' do
    params = {
      :wf_type  => 'TestFilter',
      :wf_model => 'Wf::Filter',
      'wf_c0'   => 'name',
      'wf_o0'   => 'equals',
      'wf_v0_0' => 'one',
    }
    filter = Wf::Filter.deserialize_from_params(params)

    assert_equal [@filters.first], filter.results
  end


end # class FilterTest
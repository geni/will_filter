require_relative '../../test_helper'

TestFilter = Class.new(Wf::Filter)

class FilterTest < ActiveRecord::TestCase

  def setup
    @filters = [
      TestFilter.create! { |ii| ii.name = 'one' },
      TestFilter.create! { |ii| ii.name = 'two' },
    ]
  end

  def teardown
    # Where are our transactions?
    Wf::Filter.delete_all
  end

  test 'deserialize_from_params' do
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
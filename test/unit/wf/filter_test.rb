require_relative '../../test_helper'

TestFilter = Class.new(Wf::Filter) unless defined?(TestFilter)

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

  test 'new with no parameter' do
    filter = TestFilter.new
    assert_equal 'Test', filter.model_class.name
  end

  test 'new with invalid class' do
    assert_raise RuntimeError do
      InvalidKlassFilter = Class.new(Wf::Filter)
      filter = InvalidKlassFilter.new
    end
  end

  test 'new with valid class' do
    filter = TestFilter.new(Wf::Filter)
    assert_equal 'Wf::Filter', filter.model_class.name
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
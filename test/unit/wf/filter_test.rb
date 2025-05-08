require_relative '../../test_helper'

class FilterTest < ActiveRecord::TestCase

  def setup
    @filter = Wf::Filter.create!(:name => 'test_filter', :user_id => 1, :model_class_name => 'Wf::Filter')
  end

  test 'filter' do
    assert true
  end

end # class FilterTest
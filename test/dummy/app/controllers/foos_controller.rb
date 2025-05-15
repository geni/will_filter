class FoosController < ApplicationController
  helper WillFilter::HelperMethods

  def index
    @foos = Foo.filter(:params => params, :filter => ::Filters::FooFilter)
  end

end # class FoosController
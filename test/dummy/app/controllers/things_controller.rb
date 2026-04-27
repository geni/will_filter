class ThingsController < ApplicationController
  helper WillFilter::HelperMethods

  def index
    @things = Thing.filter(:params => params, :filter => ::Filters::ThingFilter)
  end

end # class ThingsController

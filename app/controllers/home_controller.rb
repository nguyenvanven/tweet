# frozen_string_literal: true

class HomeController < ApplicationController
  before_action { @page_title = 'Home' }

  def index
  end
end

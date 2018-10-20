class SearchController < ApplicationController
 
  def index
	@documents = Document.where(approved: true)
	@current_user = current_user
  end
  
end

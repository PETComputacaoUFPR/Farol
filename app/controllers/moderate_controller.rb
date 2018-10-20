class ModerateController < ApplicationController
	load_and_authorize_resource

    before_action :authenticate_user!

	def index
		@documents = Document.where(approved: false)
	end

	def show_approved
		@documents = Document.where(approved: true)
	end

end

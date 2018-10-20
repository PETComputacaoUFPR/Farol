class DocumentController < ApplicationController

	require 'rmagick'

	rescue_from	Exception,
		:with => :render_error_all

	rescue_from ActiveRecord::RecordNotFound,
		:with => :render_error_doc_not_found
	
	rescue_from	ActionController::ParameterMissing,
		:with => :render_error_param

	rescue_from	CanCan::AccessDenied,
		:with => :render_error_access_denied

	load_and_authorize_resource

	before_action :authenticate_user!, :except => [:show]

	def index
	end

	def create
		if current_user.num_uploads > 10
			flash[:num_max_req] = "Número de uploads máximo ultrapassado(10)!"
			redirect_to "/document"
			return
		end

		@document = Document.new(create_params)
		@document.file = @document.typedoc+"_"+@document.subject+"_"+@document.teacher+"_"+@document.year.to_s+@document.indexdoc.to_s+"_"+Time.now.to_s + Time.now.usec.to_s
		@document.file = sanitize(@document.file)
		@document.file = @document.file + ".pdf"

		begin
			img = Magick::ImageList.new
			params[:document][:datafile].each do |d|
				img.from_blob(d.read)
			end
			img.write("db/documents/" + @document.file)
		rescue
			flash[:num_max_req] = "Formato de arquivo inválido!"
			redirect_to "/document"
			return
		end

		@document.user = current_user

		if not (current_user.client? or current_user.admin?)
			current_user.num_uploads += 1
			current_user.save
		end

		@document.approved = false

		if not @document.save
			render "create"
		end

		redirect_to route_for(:home)
	end

	def delete
		@document = Document.find(params[:id])
		File.delete("db/documents/"+@document.file);
		@document.destroy

		redirect_back fallback_location: root_path
	end

	def approve
		@document = Document.find(params[:id])
		@document.approved = true
		@document.save

		redirect_back fallback_location: root_path
	end

	def edit
		@document = Document.find(params[:id])
	end

	def update

		@document = Document.find(params[:id])
		if not @document.update(params[:document].permit(:teacher, :subject, :year, :typedoc, :indexdoc))
			render "edit"
		end

		redirect_to "/moderate"
	end

	def show
		@document = Document.where(id: params[:id])
		if @document.exists?
			send_file(File.open("db/documents/"+@document[0].file), filename: @document[0].file, type: 'application/pdf', disposition: :inline )
		else
		  render plain: "Documento não encontrado", content_type: "text/plain"
		end
	end

	private

	def create_params
		params.require(:document).permit(:teacher, :subject, :year, :typedoc, :indexdoc)
	end

	def render_error_doc_not_found
		render plain: "Documento não encontrado ou usuario sem permissao para acessa-lo.", content_type: "text/plain"
	end
	
	def render_error_param
		render plain: "Erro nos parametros.", content_type: "text/plain"
	end

	def render_error_all
		render plain: "Algo de errado nao esta certo\nFavor enviar um email para pet@inf.ufpr.br relatando este erro.", content_type: "text/plain"
	end

	def render_error_access_denied
		render plain: "Documento nao encontrado ou usuario sem permissao para acessa-lo.", content_type: "text/plain"
	end

	def sanitize(filename)
  		# Bad as defined by wikipedia: https://en.wikipedia.org/wiki/Filename#Reserved_characters_and_words
		# Also have to escape the backslash
 	 	bad_chars = [ '/', '\\', '?', '%', '*', ':', '|', '"', '<', '>', '.', ' ' ]
  		bad_chars.each do |bad_char|
    			filename.gsub!(bad_char, '_')
 	 	end
  		filename
	end


end

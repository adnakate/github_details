class GithubDetailsController < ApplicationController
	before_action :ensure_logged_in, only: [:repositories]
	# home page
	def home
		
	end

	# user repositories
	def repositories
		
	end
end

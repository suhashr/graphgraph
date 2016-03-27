require 'rails/generators'

module Grapher
	module Generators
		class ViewsGenerator < Rails::Generators::Base
			argument :scope, :required => false, :default => nil,
                   :desc => "The scope to copy views to"
			 source_root File.expand_path("../../templates/views", __FILE__)

	      def copy_views
	        directory "graphers","app/views/#{scope || 'grapher'}/graphers/"
	      end
		end
	end
end

require 'rails/generators'

module Graphgraph
	module Generators
		class ViewsGenerator < Rails::Generators::Base
			argument :scope, :required => false, :default => nil,
                   :desc => "The scope to copy views to"
			 source_root File.expand_path("../../templates/views", __FILE__)

	      def copy_views
	        directory "graphgraphs","app/views/#{scope || 'graphgraph'}/graphgraphs/"
	      end
		end
	end
end

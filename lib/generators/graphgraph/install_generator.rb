require 'rails/generators'

module Graphgraph
	module Generators
		class InstallGenerator < Rails::Generators::Base
			CONTROLLERS = %w(graphgraphs).freeze
			source_root File.expand_path("../../templates/", __FILE__)
		    argument :scope, required: true,
		        desc: "The scope to create controllers in"
		    class_option :controllers, aliases: "-c", type: :array,
		        desc: "Select specific controllers to generate (#{CONTROLLERS.join(', ')})"

		    def create_controllers
		        @scope_prefix = scope.blank? ? '' : (scope.camelize + '::')
		        controllers = options[:controllers] || CONTROLLERS
		        controllers.each do |name|
		          template "controllers/#{name}_controller.rb",
		                   "app/controllers/#{scope}/#{name}_controller.rb"
		        end
		    end

		    def setup_routes
  				route("get '#{scope}s/graphgraph' => '#{scope}/graphgraphs#graphgraph'")
					route("post '#{scope}s/graphgraph' => '#{scope}/graphgraphs#graphgraph'")
			end

		    # def show_readme
		    #     readme "README" if behavior == :invoke
		    # end

		    # argument :scope, :required => false, :default => nil,
                   # :desc => "The scope to copy views to"
			 # source_root File.expand_path("../templates/", __FILE__)

	      def copy_views
	        directory "views/graphgraphs","app/views/#{scope || 'graphgraph'}/graphgraphs/"
	      end
		end
	end
end

require 'rails/generators'

module Grapher
	module Generators
		class InstallGenerator < Rails::Generators::Base
			CONTROLLERS = %w(graphers).freeze
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
  				route("get '#{scope}s/grapher' => '#{scope}/graphers#grapher'")
			end

		    # def show_readme
		    #     readme "README" if behavior == :invoke
		    # end

		    # argument :scope, :required => false, :default => nil,
                   # :desc => "The scope to copy views to"
			 # source_root File.expand_path("../templates/", __FILE__)

	      def copy_views
	        directory "views/graphers","app/views/#{scope || 'grapher'}/graphers/"
	      end
		end
	end
end
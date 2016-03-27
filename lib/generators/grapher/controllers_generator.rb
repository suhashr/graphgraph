module Grapher
	module Generators
		class ControllersGenerator < Rails::Generators::Base
			source_root File.expand_path("../../templates/controllers", __FILE__)
		    argument :scope, required: true,
		        desc: "The scope to create controllers in"
		    class_option :controllers, aliases: "-c", type: :array,
		        desc: "Select specific controllers to generate (#{CONTROLLERS.join(', ')})"

		    def create_controllers
		        @scope_prefix = scope.blank? ? '' : (scope.camelize + '::')
		        controllers = options[:controllers] || CONTROLLERS
		        controllers.each do |name|
		          template "#{name}_controller.rb",
		                   "app/controllers/#{scope}/#{name}_controller.rb"
		        end
		    end

		    def show_readme
		        readme "README" if behavior == :invoke
		    end
		end
	end
end
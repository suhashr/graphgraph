class <%= @scope_prefix %>GraphgraphsController < ApplicationController
	def graphgraph
		@scopeName= <%= @scope.capitalize %>
		@testData= <%= @scope.capitalize %>.all
		@columnNames = <%= @scope.capitalize %>.column_names
	end
	# def testMethod
	# 	super
	# end
end
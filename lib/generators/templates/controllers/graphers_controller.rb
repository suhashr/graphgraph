class <%= @scope_prefix %>GraphersController < ApplicationController
	def grapher
		@scopeName= <%= @scope.capitalize %>
		@testData= <%= @scope.capitalize %>.all
		@columnNames = <%= @scope.capitalize %>.column_names
	end
	# def testMethod
	# 	super
	# end
end
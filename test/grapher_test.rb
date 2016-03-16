require "test_helper"

class GrapherTest < Test::Unit::TestCase
	def test_version
		assert_equal "0.1.0", Grapher::VERSION
	end
end
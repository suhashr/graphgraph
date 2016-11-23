class <%= @scope_prefix %>GraphgraphsController < ApplicationController
	def graphgraph

		@scopeName= <%= @scope.capitalize %>
		@testData= <%= @scope.capitalize %>.all
		@columnNames = <%= @scope.capitalize %>.column_names
		@columnHash = %= @scope.capitalize %>.columns_hash.each {|k,v| puts "#{k} => #{v.type}"}
		@selectoptions =[]
		@columnNames.each do 	|c|
			@selectoptions << c.to_s + " : " + @columnHash[c].type.to_s
		end
		call_counts
		set_graph
		set_user_template
		puts @foruser
		set_bargraph
		set_linegraph
		set_areagraph
		set_scattergraph

		if params[:fromuser]=="fromuser"
			call_counts
			set_graph
			set_user_template
			puts @foruser
			set_bargraph
			set_linegraph
			set_areagraph
			set_scattergraph
			@mainchart=@chartline||@chartbar||@chartarea||@chartscatter
			redirect_to <%= @scope.capitalize %>s_path(options: @mainchart.objects.to_s, placeholder: @mainchart.placeholder.to_s, series_data: @mainchart.series_data.to_s)
		end
	end

	private
	def call_counts
		if (params[:xaxis]!=nil)
			if params[:xaxis].include? "datetime"
				get_counts(params[:xaxis],params[:yaxis],params[:xstart].split(/\s+/),params[:xend].split(/\s+/))
			end
		end
	end

	def set_graph
		@graphtype=["Bar Graph", "Line Graph", "Area Graph", "Scatter Graph"]
	end

	def set_scattergraph
		if (params[:graphtype].to_s == "Scatter Graph")

			# puts "import !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			tempx = params[:xaxis].slice(0..(params[:xaxis].index(' '))) # determine user-given variable name
			final_x = tempx.strip
			tempy = params[:yaxis].slice(0..(params[:yaxis].index(' '))) # determine user-given variable name
			final_y = tempy.strip
			# instance_variable_set("@#{variable_name}", params[:xaxis])
			# puts <%= @scope.capitalize %>.pluck(final_x)
			@scattercat=[]
			@scatterdata=[]
			@chartscatter = LazyHighCharts::HighChart.new('scatter') do |f2|
				if (@x_ticks!=nil)
					@x_ticks.each do |x|
						@scattercat << x[0]
						@scatterdata << x[1]
					end
					f2.xAxis(:categories => @scattercat)
					f2.series(:data=> @scatterdata)
				else
					f2.xAxis(:categories => <%= @scope.capitalize %>.pluck(final_x))
					f2.series(:data=> <%= @scope.capitalize %>.pluck(final_y))
				end
        # f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )
        f2.title({ :text=>params[:title].to_s})
        f2.plot_options(series: {
                            stacking:'normal'
                        })
				f2.chart({ defaultSeriesType: 'scatter'})
        f2.legend(:layout=> 'horizontal',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})


        ### Options for Bar
        ### f.options[:chart][:defaultSeriesType] = "bar"
        ### f.plot_options({:series=>{:stacking=>"normal"}})

        ## or options for column
        # f.options[:chart][:defaultSeriesType] = "column"
        # f.plot_options({:column=>{:stacking=>"percent"}})

    	end
		end
	end

	def set_areagraph
		if (params[:graphtype].to_s == "Area Graph")

			# puts "import !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			tempx = params[:xaxis].slice(0..(params[:xaxis].index(' '))) # determine user-given variable name
			final_x = tempx.strip
			tempy = params[:yaxis].slice(0..(params[:yaxis].index(' '))) # determine user-given variable name
			final_y = tempy.strip
			# instance_variable_set("@#{variable_name}", params[:xaxis])
			# puts <%= @scope.capitalize %>.pluck(final_x)
			@areacat=[]
			@areadata=[]
			@chartarea = LazyHighCharts::HighChart.new('area') do |f2|
				if (@x_ticks!=nil)
					@x_ticks.each do |x|
						@areacat << x[0]
						@areadata << x[1]
					end
					f2.xAxis(:categories => @areacat)
					f2.series(:data=> @areadata)
				else
					f2.xAxis(:categories => <%= @scope.capitalize %>.pluck(final_x))
					f2.series(:data=> <%= @scope.capitalize %>.pluck(final_y))
				end
        # f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )
        f2.title({ :text=>params[:title].to_s})
        f2.plot_options(series: {
                            stacking:'normal'
                        })
				f2.chart({ defaultSeriesType: 'area'})
        f2.legend(:layout=> 'horizontal',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})


        ### Options for Bar
        ### f.options[:chart][:defaultSeriesType] = "bar"
        ### f.plot_options({:series=>{:stacking=>"normal"}})

        ## or options for column
        # f.options[:chart][:defaultSeriesType] = "column"
        # f.plot_options({:column=>{:stacking=>"percent"}})

    	end
		end
	end

	def set_linegraph
		if (params[:graphtype].to_s == "Line Graph")

			# puts "import !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			tempx = params[:xaxis].slice(0..(params[:xaxis].index(' '))) # determine user-given variable name
			final_x = tempx.strip
			tempy = params[:yaxis].slice(0..(params[:yaxis].index(' '))) # determine user-given variable name
			final_y = tempy.strip
			# instance_variable_set("@#{variable_name}", params[:xaxis])
			# puts <%= @scope.capitalize %>.pluck(final_x)
			@linecat=[]
			@linedata=[]
			@chartline = LazyHighCharts::HighChart.new('line') do |f|
					if (@x_ticks!=nil)
						@x_ticks.each do |x|
							@linecat << x[0]
							@linedata << x[1]
						end
						f.xAxis(:categories => @linecat)
						f.series(:data=> @linedata)
					else
						f.xAxis(:categories => <%= @scope.capitalize %>.pluck(final_x))
						f.series(:data=> <%= @scope.capitalize %>.pluck(final_y))
					end
		        # f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )
		        f.title({ :text=>params[:title].to_s})
		        f.legend(:layout=> 'horizontal',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})


		        ### Options for Bar
		        ### f.options[:chart][:defaultSeriesType] = "bar"
		        ### f.plot_options({:series=>{:stacking=>"normal"}})

		        ## or options for column
		        # f.options[:chart][:defaultSeriesType] = "column"
		        # f.plot_options({:column=>{:stacking=>"percent"}})
		    end
		end
	end

	def set_bargraph
		if (params[:graphtype].to_s == "Bar Graph")

			# puts "import !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			tempx = params[:xaxis].slice(0..(params[:xaxis].index(' '))) # determine user-given variable name
			final_x = tempx.strip
			tempy = params[:yaxis].slice(0..(params[:yaxis].index(' '))) # determine user-given variable name
			final_y = tempy.strip
			# instance_variable_set("@#{variable_name}", params[:xaxis])
			# puts <%= @scope.capitalize %>.pluck(final_x)
			@barcat=[]
			@bardata=[]
			@chartbar = LazyHighCharts::HighChart.new('column') do |f|
						if (@x_ticks!=nil)
							@x_ticks.each do |x|
								@barcat << x[0]
								@bardata << x[1]
							end
							f.xAxis(:categories => @barcat)
							f.series(:data=> @bardata)
						else
							f.xAxis(:categories => <%= @scope.capitalize %>.pluck(final_x))
							f.series(:data=> <%= @scope.capitalize %>.pluck(final_y))
						end

						# f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )
						f.title({ :text=>params[:title].to_s})
						f.legend(:layout=> 'horizontal',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})


						### Options for Bar
						### f.options[:chart][:defaultSeriesType] = "bar"
						### f.plot_options({:series=>{:stacking=>"normal"}})

						## or options for column
						f.options[:chart][:defaultSeriesType] = "column"
						# f.plot_options({:column=>{:stacking=>"percent"}})
				end
		end
	end

	def set_user_template
		current_model_path=<%= @scope.capitalize %>.to_s.downcase + "s"
		@foruserencode=CGI.escapeHTML("<%= form_tag(\"/#{current_model_path}/graphgraph\", method: \"get\") do %>
		<input type=\"text\" name=\"graphtype\" id=\"graphtype\" value=\"#{params[:graphtype]}\" hidden>
		<input type=\"text\" name=\"yaxis\" id=\"yaxis\" value=\"#{params[:yaxis]}\" hidden>
		<input type=\"text\" name=\"xaxis\" id=\"xaxis\" value=\"#{params[:xaxis]}\" hidden>
		<input type=\"text\" name=\"fromuser\" id=\"fromuser\" value=\"fromuser\" hidden>

	  <div class='col-sm-2' id=\"datepickerforxview\" hidden>
	      <input type='text' name=\"xstart\" class=\"form-control\" id='datetimepicker1view' />
	      to
	      <input type='text' name=\"xend\" class=\"form-control\" id='datetimepicker2view' /></br>
	      <input type=\"radio\" name=\"rangetypex\" value=\"minute\"> per Minute<br>
	      <input type=\"radio\" name=\"rangetypex\" value=\"hourly\" checked> Hourly<br>
	      <input type=\"radio\" name=\"rangetypex\" value=\"daily\"> Daily<br>
	      <input type=\"radio\" name=\"rangetypex\" value=\"monthly\"> Monthly<br>
	  </div>
		<%= submit_tag 'Generate Graph', :id=>\"submitselection\"%>
		<% end %>
		<script>
		  $(function () {
		    $('#datetimepicker1view').datetimepicker();
		    $('#datetimepicker2view').datetimepicker({
		        useCurrent: false //Important! See issue #1075
		    });
		    $(\"#datetimepicker1view\").on(\"dp.change\", function (e) {
		        $('#datetimepicker2view').data(\"DateTimePicker\").minDate(e.date);
		    });
		    $(\"#datetimepicker2view\").on(\"dp.change\", function (e) {
		        $('#datetimepicker1view').data(\"DateTimePicker\").maxDate(e.date);
		    });
			});
			$(document).ready(function() {
        if (document.getElementById('xaxis').value.indexOf('datetime')!=-1)
          document.getElementById('datepickerforxview').style.display= \"inline\";
        else
          document.getElementById('datepickerforxview').style.display= \"none\";
      });
		</script>
		<% if params[:options]!=nil %>
			<% newchart=LazyHighCharts::HighChart.new() %>
			<% newchart.options=eval(params[:options]) %>
			<% newchart.placeholder=params[:placeholder] %>
			<% newchart.series_data=eval(params[:series_data]) %>
			<% if (\"#{params[:graphtype]}\"==\"Bar Graph\") %>
			    <%= high_chart(\"my_bar_div\", newchart) %>
			   <% end %>
			<% if (\"#{params[:graphtype]}\"==\"Line Graph\") %>
			    <%= high_chart(\"my_line_div\", newchart) %>
			<% end %>
			<% if (\"#{params[:graphtype]}\"==\"Area Graph\") %>
			    <%= high_chart(\"my_area_div\", newchart) %>
			<% end %>
			<% if (\"#{params[:graphtype]}\"==\"Scatter Graph\") %>
			    <%= high_chart(\"my_scatter_div\", newchart) %>
			<% end %>
		<% end %>")
		# @foruser=CGI.unescapeHTML(@foruserencode) comment out after install
	end

	def get_counts(dateValue,pluckValue,startvalue,endvalue)
	@newx= startvalue
	@newendx= endvalue

	@begin_date = Date.strptime(@newx[0], '%m/%d/%Y')
	@end_date = Date.strptime(@newendx[0], '%m/%d/%Y')
	@starttimehour=(@newx[1].split(':')[0].to_i)
	@starttimeminute=(@newx[1].split(':')[1].to_i)
	@endtimehour=(@newendx[1].split(':')[0].to_i)
	@endtimeminute=(@newendx[1].split(':')[1].to_i)
	# if @newx[2]=="PM"
	# 	@starttimehour=@starttimehour+12
	# end
	# if @newendx[2]=="PM"
	# 	@endtimehour=@endtimehour+12
	# end
	@begincount="#{@begin_date} #{@starttimehour}:#{@starttimeminute} #{@newx[2]}"
	@endcount="#{@end_date} #{@endtimehour}:#{@endtimeminute} #{@newendx[2]}"
	num_days = (@end_date - @begin_date).to_i
	tempval = dateValue.slice(0..(dateValue.index(' '))) # determine user-given variable name
	finalval = tempval.strip
	temppluckval = pluckValue.slice(0..(pluckValue.index(' '))) # determine user-given variable name
	finalpluckval = temppluckval.strip
	# puts <%= @scope.capitalize %>.where(finalval + ' >= ? AND '+ finalval +' <= ?', @begin_date.at_beginning_of_day, @end_date.at_end_of_day)
	@x_unit = params[:rangetypex]
	# if num_days >= 31
	# 	@x_unit = 'monthly'
	# elsif num_days >= 1
	# 	@x_unit = 'daily'
	# end
	@x_ticks = []
	ts_conversion = "convert_tz(timestamp, '+00:00', '#{Time.now.strftime('%:z')}')"
						Time.zone="Bangkok"
	case @x_unit
		when 'minute'
			(Time.zone.parse(@begincount).to_i .. Time.zone.parse(@endcount).to_i).step(1.minute) do |date|
				time =   Time.zone.at(Time.at(date))
				@x_ticks << ["#{time.day}/#{time.month}/#{time.year} #{time.hour}:#{time.min}:00-#{time.hour}:#{time.min}:59" , <%= @scope.capitalize %>.where(finalval + ' >= ? AND '+ finalval +' <= ?', DateTime.parse("#{time.year}/#{time.month}/#{time.day} #{time.hour}:#{time.min}:00:000000"), DateTime.parse("#{time.year}/#{time.month}/#{time.day} #{time.hour}:#{time.min}:59:999999")).pluck(finalpluckval).inject(0, :+)]
		end
		when 'hourly'
			(Time.zone.parse(@begincount).to_i .. Time.zone.parse(@endcount).to_i).step(1.hour) do |date|
				time =   Time.zone.at(Time.at(date))
				@x_ticks << ["#{time.day}/#{time.month}/#{time.year} #{time.hour}:00-#{time.hour}:59" , <%= @scope.capitalize %>.where(finalval + ' >= ? AND '+ finalval +' <= ?', DateTime.parse("#{time.year}/#{time.month}/#{time.day} #{time.hour}:00:00:000000"), DateTime.parse("#{time.year}/#{time.month}/#{time.day} #{time.hour}:59:59:999999")).pluck(finalpluckval).inject(0, :+)]
			end
			# @groups = [:camera_id, "year(#{ts_conversion})", "month(#{ts_conversion})", "day(#{ts_conversion})", "hour(#{ts_conversion})"]

		when 'daily'
			(Time.zone.parse(@begincount).to_i .. Time.zone.parse(@endcount).to_i).step(1.day) do |date|
				time =   Time.zone.at(Time.at(date))
				@x_ticks << ["#{time.day}/#{time.month}/#{time.year}" , <%= @scope.capitalize %>.where(finalval + ' >= ? AND '+ finalval +' <= ?', DateTime.parse("#{time.year}/#{time.month}/#{time.day} 00:00:00:000000"), DateTime.parse("#{time.year}/#{time.month}/#{time.day} 23:59:59:999999")).pluck(finalpluckval).inject(0, :+)]
			end
			when 'monthly'
			(@begin_date.clone.to_time.localtime.at_beginning_of_month.to_date .. @end_date.clone.to_time.localtime.at_end_of_month.to_date).select {|d| d.day == 1}.each do |date|
				@x_ticks << ["#{date.month}/#{date.year}" , <%= @scope.capitalize %>.where(finalval + ' >= ? AND '+ finalval +' <= ?', DateTime.parse("#{date.year}/#{date.month}/1 00:00:00:000000"), DateTime.parse("#{date.year}/#{date.month}/#{date.end_of_month.day} 23:59:59:999999")).pluck(finalpluckval).inject(0, :+)]
			end
			# @groups = [:camera_id, "year(#{ts_conversion})", "month(#{ts_conversion})"]
	end


	# @counts = LicensePlate.
	# 		where(camera_id: @cameras.map { |cam| cam.id }).
	# 		where('timestamp >= ?', @begin_date).
	# 		where('timestamp <= ?', @end_date).
	# 		where('license_id like ?', "%#{@plate_query}%").
	# 		group(@groups).count
	# @series = @cameras.map do |cam|
	# 	{ name: cam.name, yAxis: 0, data: @x_ticks.map { |xtick| @counts[counts_index(cam, xtick)] || 0 } }
	# end
end
end

class <%= @scope_prefix %>GraphgraphsController < ApplicationController
	def graphgraph
		@scopeName= <%= @scope.capitalize %>
		@testData= <%= @scope.capitalize %>.all
		@columnNames = <%= @scope.capitalize %>.column_names

		@columnHash = <%= @scope.capitalize %>.columns_hash.each {|k,v| puts "#{k} => #{v.type}"}
		@selectoptions =[]
		@columnNames.each do 	|c|
			@selectoptions << c.to_s + " : " + @columnHash[c].type.to_s
		end
		if (params[:xaxis]!=nil)
			if params[:xaxis].include? "datetime"
				get_counts(params[:xaxis],params[:yaxis],params[:xstart].split(/\s+/),params[:xend].split(/\s+/))
			end
		end
		@graphtype=["Bar Graph", "Line Graph", "Area Graph", "Scatter Graph"]
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

	private

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
	end
	# def testMethod
	# 	super
	# end
end

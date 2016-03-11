class PageController < ApplicationController

	def collect_data
		Resque.enqueue(OldHistoricalDataJob)
		@quotes = Quote.all.first(100)
	end

end

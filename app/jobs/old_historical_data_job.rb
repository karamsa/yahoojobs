class OldHistoricalDataJob
  @queue = :financial_data

  def self.perform
  	
  	puts "*************Start of the job: Old historical data***************"
  	yahoo_client = YahooFinance::Client.new
  	symbol = "YHOO"
  	start_date = Date.strptime("{ 2009-09-11 }", "{ %Y-%m-%d }")
  	end_date = Date.strptime("{ 2010-03-10 }", "{ %Y-%m-%d }")
  	data = yahoo_client.historical_quotes("YHOO", { start_date: start_date, end_date: end_date }) # 10 days worth of data
  	
  	data.each do |row|
  		puts "Staring row creation"
  		Quote.create(symbol:row.symbol,
  					 trade_date:row.trade_date,
  					 open:row.open,
  					 high:row.high,
  					 low:row.low,
  					 close:row.close,
  					 volume:row.volume,
  					 adjusted_close:row.adjusted_close)
  		puts "Row Created"
  	end
  	puts "*************End of the job*************"

  end
end



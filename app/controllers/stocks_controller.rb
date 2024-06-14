class StocksController < ApplicationController
   
    def stock_symbols
        market = params[:market] || 'US'
        @stocks = FINNHUB_CLIENT.stock_symbols(market)
    end
    def quote
        @forex_rates = FINNHUB_CLIENT.quote('AAPL')
        render plain:  @forex_rates
    end
    def symbol_search
        @results = FINNHUB_CLIENT.symbol_search('AAPL')
        render plain: @results
    end

    # def similarity_index
    #     @similarity_index = FINNHUB_CLIENT.similarity_index({ symbol: 'AAPL' })
    #     Rails.logger.error("Finnhub API Error: #{e.message}")
    # end
    def search
        ticker_symbol = params[:ticker_symbol]
        @forex_rates = FINNHUB_CLIENT.quote(ticker_symbol)
        render plain: @forex_rates
    end
end
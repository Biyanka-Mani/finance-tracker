class StocksController < ApplicationController
   
    def stock_symbols
        market = params[:market] || 'US'
        @stocks = FINNHUB_CLIENT.stock_symbols(market)
    end
    def quote
        if params[:stock].present?
            ticker_symbol = params[:stock]
            begin
                @forex_rates = FINNHUB_CLIENT.quote(ticker_symbol)        
                # render plain:   @forex_rates
                
                company_name=FINNHUB_CLIENT.company_profile2({symbol: ticker_symbol})
                if @forex_rates.c != 0.0
                    @stock=Stock.new(ticker:ticker_symbol,name:company_name.name,ast_price: @forex_rates.c)
                     render 'users/my_portfolio'
                    # respond_to do |format|
                        
                    #     format.html { render partial: 'users/stocksearchResult', locals: { stock: @stock } }
                    #     format.json { render json: { message: "Success", stock: @stock } }                   
                    #  end 
                     
                else
                    flash[:alert]='Please Enter Valid Ticker To Search'
                    redirect_to my_portfolio_path
                end
            rescue => e
                flash[:alert]= "Something went wrong: #{e.message}"
                redirect_to my_portfolio_path
            end
        else
            flash[:alert]='Please Enter A Ticker'
            redirect_to my_portfolio_path
        end
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
class StocksController < ApplicationController
   
    # def stock_symbols
    #     market = params[:market] || 'US'
    #     @stocks = FINNHUB_CLIENT.stock_symbols(market)
    # end
    def quote
        if params[:stock].present?
            # ticker_symbol = params[:stock]
            # begin
            
            #     @forex_rates = FINNHUB_CLIENT.quote(ticker_symbol)        
            #     # render plain:   @forex_rates
                
            #     company_name=FINNHUB_CLIENT.company_profile2({symbol: ticker_symbol})
            #     if @forex_rates.c != 0.0
            #         @stock=Stock.new(ticker:ticker_symbol,name:company_name.name,ast_price: @forex_rates.c)
                   
            #         respond_to do |format|                        
            #             format.js{render partial:'users/stocksearchResult'}
            #         end
            #         #  render 'users/my_portfolio'
            #     else
            #         respond_to do |format|
            #             flash[:alert]='Please Enter Valid Ticker To Search'
            #             format.html { render 'users/my_portfolio' }
            #             format.js{render partial:'users/stocksearchResult'}
            #         end
                    
            #     end
            # rescue => e
            #     respond_to do |format|
            #          flash[:alert]= "Something went wrong: #{e.message}"
            #         format.html { render 'users/my_portfolio' }
            #         format.js{render partial:'users/stocksearchResult'}
            #     end
            # end

            @stock = Stock.new_lookup(params[:stock])
            
           
            if @stock.ast_price  != 0.0
                respond_to do |format|  
                    format.js { render partial:'users/stocksearchResult' }
                end
            else 
                flash.now[:alert] = 'Please Enter Valid Ticker To Search'
                respond_to do |format|
                    format.js { render partial: 'users/stocksearchResult' }
                end

            end
            
           
        else
            respond_to do |format|
                flash.now[:alert]='Please Enter Valid Ticker To Search'
                format.js{render partial:'users/stocksearchResult'}
            end


        end
    end
    # def symbol_search
    #     @results = FINNHUB_CLIENT.symbol_search('AAPL')
    #     render plain: @results
    # end

    # def similarity_index
    #     @similarity_index = FINNHUB_CLIENT.similarity_index({ symbol: 'AAPL' })
    #     Rails.logger.error("Finnhub API Error: #{e.message}")
    # end
    
    # def search
    #     ticker_symbol = params[:ticker_symbol]
    #     @forex_rates = FINNHUB_CLIENT.quote(ticker_symbol)
    #     render plain: @forex_rates
    # end
end
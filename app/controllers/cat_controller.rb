class CatController < ApplicationController
    def index # GET /cat
      # int request.params[:limit] times of get Cat fact 
      limit = params[:limit] || 1
      max_length = params[:max_length] || ''
      # get Cat fact limit times, store in @items['data]  and save to db
      @items = []
      (1..limit.to_i).each do |i|
        fact = get_catFact(max_length)
        @items << fact
        CatFact.create(fact: fact['fact'])
      end
    end

    def list
        @items = CatFact.all
    end

    def album
        @items = CatFact.all
    end

    # GET /cat/:id or fallback to index and flash "Select something from the album"
    def show
        @item = CatFact.find_by(id: params[:id])
        if @item.nil?
            redirect_to '/album', notice: "Select something from the album"
        end
    end

    private
    def request_api(url)
      response = Excon.get(url)
      return nil if response.status != 200
      JSON.parse(response.body)
    end
    
    def get_catFact(max_length = '')
      url = "https://catfact.ninja/fact?max_length=#{max_length}"
      request_api(url)
    end
end


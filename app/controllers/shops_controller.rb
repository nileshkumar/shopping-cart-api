class ShopsController < ApplicationController

  def index
    @response = fetch_products_price([10,12,15])
  end

  def fetch_products_price(ids)
    price = []
    conn = Faraday.new(
        url: STORE_API,
        headers: {'Content-Type' => 'application/json'}
      )
    ids.each do |i|
      response = conn.get("products/#{i}") 
      if !response.body.blank?
       price << JSON.parse(response.body)["price"] 
      else
       return "Record Not found!"
      end
    end
    return "Total Price: $#{price.sum}"
  end
end

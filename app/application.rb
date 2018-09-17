class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if !@@cart.empty?
        @@cart.each do |item|
          resp.write "#{item}\n"
        end # end cart loop
      else resp.write "Your cart is empty"
      end # end cart if
      elsif req.path.match(/add/)
        check_items = req.params["item"]
        resp.write add_item(check_items)
    else
      resp.write "Path Not Found"
    end # end if




    resp.finish
  end # end call

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #End handle search

  def add_item(check_items)
    if @@items.include?(check_items)
      @@cart << check_items
    else
      return "We don't have that item"
    end
    return "added #{check_items}"
  end

end #end class

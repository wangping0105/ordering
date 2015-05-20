module OrdersHelper
  def do_about(orders)
    arr=Array.new
    arr<<orders[0]
    i=0
    orders.each do |y|
      if i==0
        i+=1
      elsif !contained?(arr,y)
        arr<<y
      end
    end
    arr
  end
  def contained?(arr,y)
    flag=false
    arr.each do |x|
      p "#{x.name} and #{y.name}"
      if x.name == y.name
        x.num+= y.num
        flag=true
      end
    end
    flag
  end
end

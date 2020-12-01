module Enumerable
  # 1.my_each
  def my_each
    if !block_given?

    else
      for item in self
        yield(item)
      end
    end
  end

  # 2.my_each_with_index
  def my_each_with_index
    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
  end

  # 3.my_select
  def my_select
    select_arr_result = []
    each do |item|
      select_arr_result << item if yield(item)
    end
    select_arr_result
  end

  # 4.my_all?
  def my_all?(_parameter = nil)
    length_array = size
    true_counter1 = 0
    true_counter = 0
    # Check if there is block given
    if block_given?
      my_each do |x|
        true_counter += 1 if yield(x)
      end
      true_counter == length_array
    else
      my_each do |element|
        true_counter1 += 1 if !element.nil? == true
      end
      true_counter1 == length_array
    end
  end

  # 5.my_any?
  def my_any?(parameter = nil)
    initial_value = false
    if block_given?
      my_each do |x|
        initial_value = true if yield(x)
      end
      initial_value
    else
      case parameter
      when Regexp
        my_each { |x| return true if x =~ parameter }
      else
        my_each do |element|
          initial_value = true unless element.nil?
        end
      end
      initial_value
    end
  end

  # 6.my_none?
  def my_none?(parameter = nil)
    initial_value = true

    if block_given?
      my_each do |x|
        initial_value = false if yield(x)
      end
      initial_value
    else
      case parameter
      when nil
        my_each { |x| return false unless x.nil? || !x }
      when Regexp
        my_each { |x| return false if x =~ parameter }
      when Class
        my_each { |x| return false if x.is_a? parameter }
      else
        my_each { |x| return false if x == parameter }
      end
    end
    initial_value
  end

  # 7.my_count
  def my_count(parameter = nil)
    counter = 0
    
    if block_given?
      my_each do |x|
        if yield(x)
          counter += 1
        end
      end
      counter
    else
      case parameter
      when nil
        size
      when Numeric
        my_each {|x| counter += 1 if parameter == x}
        counter
      end
    end
  end

  # 8.my_map
  def my_map(parameter = nil)
    # puts parameter
    result_arr = []
    my_each {|x| result_arr << yield(x)} if parameter.nil?
    
    my_each {|x| result_arr << parameter.call(x)} unless parameter.nil?
    result_arr
  end

  # 9.my_inject
  def my_inject(*parameter)
    (raise LocalJumpError if !block_given? && parameter[0].nil? && parameter[1].nil?)
    if block_given?
      net = parameter[0] ? yield(first, parameter[0]) : first
      drop(1).my_each { |item| net = yield(net, item) }
    elsif parameter[0]
      if parameter[1]
        net = parameter[0]
        my_each { |item| net = net.send(parameter[1], item) }
      else
        net = first
        drop(1).my_each { |item| net = net.send(parameter[0], item) }
      end
    end
    net
  end  
end

def multiply_els(parameter)
  parameter.my_inject {|sum, x| sum * x}
end



# 1. my_each
puts 'my_each'
puts '-------'
puts [1, 2, 3].my_each { |elem| print "#{elem + 1} " } # => 2 3 4
p (5..10).my_each { |i| puts "#{i}" }
puts
# 2. my_each_with_index
puts 'my_each_with_index'
puts '------------------'
print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } # => 1 : 0, 2 : 1, 3 : 2
# p (1..3).my_each_with_index { |elem, idx| puts "
# my_each_with_index_output = ''
# enum=(1..5)
# block = proc { |num, idx| my_each_with_index_output += "Num: #{num}, idx: #{idx}\n" }
p enum.each_with_index(&block)
my_each_with_index_output = ''
p enum.my_each_with_index(&block)
puts
# 3. my_select
puts 'my_select'
puts '---------'
p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
p [6, 11, 13].my_select(&:odd?) # => [11, 13]
p (1..5).my_select(&:odd?) # => [1, 3, 5]
puts

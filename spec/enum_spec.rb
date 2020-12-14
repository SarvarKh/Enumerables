require_relative '../main.rb'

describe Enumerable do
  describe '#my_each' do
    it 'Adding 1 to each array item' do
      array = []
      [1, 2, 3].my_each { |x| array.push(x + 1) }
      expect(array).to eql([2, 3, 4])
    end
  end

  describe '#my_each_with_index' do
    it 'prints out elements and their indices' do
      [1, 2, 3].my_each_with_index { |elem, idx| "#{elem} : #{idx}" }
      expect([1, 0, 2, 1, 3, 2]).to eql([1, 0, 2, 1, 3, 2])
    end
  end

  describe '#my_select' do
    it 'Fetch even numbers' do
      expect([1, 2, 3, 8].my_select(&:even?)).to eql([2, 8])
    end

    it 'Fetch those greater than 0' do
      expect([0, 2018, 1994, -7].my_select { |item| item > 0 }).to eql([2018, 1994])
    end
  end

  describe '#my_all?' do
    it 'check if all items are odd' do
      expect([3, 5, 7, 11].my_all?(&:odd?)).to eql(true)
    end

    it 'check if all items are even' do
      expect([2, 4, 6, 7].my_all?(&:even?)).to eql(false)
    end

    it 'check if all items are integers' do
      expect([1, 2, 3].my_all?(Integer)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'check if any of the numbers is even' do
      expect([7, 10, 4, 5].my_any?(&:even?)).to eql(true)
    end

    it 'check if a particular character is available' do
      expect(%w[q r s t].my_any? { |char| 'aeiou'.include?(char) }).to eql(false)
    end

    it 'check if a number is present' do
      expect([1.1, nil, false].my_any?(Numeric)).to eql(true)
    end
  end

  describe '#my_none' do
    it 'checks if none of the numbers is even' do
      expect([3, 5, 7, 11].my_none?(&:even?)).to eql(true)
    end

    it 'checks if none of the numbers is greater than 4' do
      expect([1, 2, 3, 4].my_none? { |x| x > 4 }).to eql(true)
    end

    it 'checks if the array contains a word with a specific letter' do
      expect(%w[sushi pizza burrito].my_none? { |word| word[0] == 'a' }).to eql(true)
    end
  end

  describe '#my_count' do
    it 'count even numbers in an array' do
      expect([1, 4, 3, 8].my_count(&:even?)).to eql(2)
    end

    it 'counts words written in uppercase' do
      expect(%w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase }).to eql(3)
    end

    it 'count total items' do
      expect((1..3).my_count).to eql(3)
    end
  end

  describe '#my_map' do
    it 'multiply each item by 2 and put in a new array' do
      expect([1, 2, 3].my_map { |n| 2 * n }).to eql([2, 4, 6])
    end

    it 'intechanges the array components' do
      expect([false, true].my_map(&:!)).to eql([true, false])
    end
  end

  describe '#my_inject' do
    it 'adds elements accumulative' do
      expect([1, 2, 3, 4].my_inject { |accum, elem| accum + elem }).to eql(10)
    end

    it 'adds elements accumulative and adds 10 to the accumulative value' do
      expect([1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem }).to eql(20)
    end

    it 'returns product of items' do
      expect([5, 1, 2].my_inject(:*)).to eql(10)
    end
  end
end

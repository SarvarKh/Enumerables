require_relative '../main.rb'

describe Enumerable do
  arr = [3, 4, 7, 1, 2, 8]
  highest_num = 8
  my_hash = {min: 2, max: 5}

  describe '#my_each' do
    it 'Adding 1 to each array item' do
      array = []
      [1, 2, 3].my_each { |x| array.push(x + 1) }
      expect(array).to eql([2, 3, 4])
    end

    it 'my_each iteration testing with no block' do
      expect(%w(one two three).my_each).to be_an Enumerator
    end

    it 'my_each when self is a hash' do
      expect(my_hash.each { |key, value| "k: #{key}, v: #{value}" }).to eql({:min=>2, :max=>5})
    end
  end

  describe '#my_each_with_index' do
    it 'prints out elements and their indices' do
      [1, 2, 3].my_each_with_index { |elem, idx| "#{elem} : #{idx}" }
      expect([1, 0, 2, 1, 3, 2]).to eql([1, 0, 2, 1, 3, 2])
    end

    it "my_each_with_index iteration testing with no block" do
      expect(arr.my_each_with_index).to be_an Enumerator
    end

    it 'my_each_with_index when self is a hash' do
      expect(my_hash.my_each_with_index { |key, value| "k: #{key}, v: #{value}" }).to eql({:min=>2, :max=>5})
    end
  end

  describe '#my_select' do
    it 'Fetch even numbers' do
      expect([1, 2, 3, 8].my_select(&:even?)).to eql([2, 8])
    end

    it 'my_select iteration testing with no block' do
      expect(arr.my_select).to be_an Enumerator
    end

    it 'Fetch those greater than 0' do
      expect([0, 2018, 1994, -7].my_select { |item| item > 0 }).to eql([2018, 1994])
    end
  end

  describe '#my_all?' do
    it "checks a block that never returns false or nil" do
      expect(arr.my_all?(proc { |num| num <= highest_num } )).to eql(true)
    end

    it 'check if the block returns false or nil' do
      expect([2, 4, 6, 8].my_all?(&:even?)).to eql(true)
    end

    it 'check if no block or argument is given' do
      expect([1, 2, 3].my_all?).to eql(true)
    end

    it 'check if one of the collection members is false or nil' do
      array = [1, false, 'hi', []]
      expect(array.my_all?).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'checks a block that never returns false or nil' do
      array = [7, 10, 4, 5]
      expect(array.my_any?(10)).to eql(true)
    end

    it 'check if the block returns false or nil' do
      expect(%w[q r s t i].my_any? { |char| 'aeiou'.include?(char) }).to eql(true)
    end

    it 'check if no block or argument is given' do
      expect([1.1, nil, false].my_any?).to eql(true)
    end

    it 'check if one of the collection members is false or nil' do
      array = [1, false, 'hi', []]
      expect(array.my_any?).to eql(true)
    end
  end

  describe '#my_none' do
    it 'checks a block that never returns false or nil' do
      expect([3, 5, 7, 11].my_none?(1)).to eql(true)
    end

    it 'check if the block returns false or nil' do
      expect([1, 2, 3, 4].my_none? { |x| x > 4 }).to eql(true)
    end

    it 'check if no block or argument is given' do
      expect([1, 2, 3, 4].my_none?).to eql(false)
    end

    it 'check if one of the collection members is false or nil' do
      array = [1, false, 'hi', []]
      expect(array.my_none?).to eql(false)
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

    it "my_map iteration testing with no block" do
      expect(%w(one two three).my_map).to be_an Enumerator
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

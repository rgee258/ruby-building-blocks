require "myenumerable"

describe ".my_each" do

  let(:my_array) {[1, "two", 3.0]}

  context "given a mixed array with a print block" do
    it "returns the original array" do
	  expect(my_array.my_each { |elem| elem}).to eql([1,"two",3.0])
	end
  end

  context "given no block" do
  	it "returns an enumerator" do
  	  expect(my_array.my_each).to be_an Enumerator
  	end
  end
end

describe ".my_select" do

  let(:str_array) {["a", "b", "c"]}
  let(:int_array) {[1, 2, 3]}
  let(:mixed_array) {[1, "b", true]}
  let(:empty_array) {[]}
  let(:nil_array) {[nil, nil, nil]}

  context "given an array of strings with a block searching for 'a'" do
    it "returns [\"a\"]" do
      expect(str_array.my_select{|elem| elem == "a"}).to eql(["a"])
    end
  end

  context "given an array of integers with a block checking for integer types" do
    it "returns [1, 2, 3]" do
      expect(int_array.my_select{|elem| elem.is_a? Integer}).to eql([1, 2, 3])
    end
  end

  context "given an array of strings checking for integers" do
    it "returns an empty array" do
      expect(str_array.my_select{|elem| elem.is_a? Integer}).to eql([])
    end
  end

  context "given a mixed array find all values that are true" do
    it "returns [true]" do
      expect(mixed_array.my_select{|elem| elem == true}).to eql ([true])
    end
  end

  context "given an empty array with a block checking for integers" do
    it "returns an empty array" do
      expect(empty_array.my_select{|elem| elem.is_a? Integer}).to eql([])
    end
  end

  context "given an array with nil checking for nil" do
    it "returns [nil, nil, nil]" do
      expect(nil_array.my_select{|elem| elem.nil?}).to eql([nil, nil, nil])
    end
  end

  context "given an array with no block" do
    it "returns an Enumerator" do
      expect(int_array.my_select).to be_an Enumerator
    end
  end

end

describe ".my_all?" do
  
  let(:all_str_array) {["all", "of", "these", "words", "are", "length", "one", "or", "greater"]}
  let(:all_int_array) {[9, 11, 12, 13, 14, 15]}
  let(:nil_array) {[nil]}
  let(:empty_array) {[]}
  let(:truthy_array) {[5, true, "test"]}
  let(:falsy_array) {[false, nil]}

  context "given an array with strings greater than length 1" do
  	it "returns true" do
      expect(all_str_array.my_all? {|elem| elem.length > 1}).to eql(true)
    end
  end

  context "given an array where one value is less than 10" do
    it "returns false" do
      expect(all_int_array.my_all? {|elem| elem > 10}).to eql(false)
    end
  end

  context "given an array with only a nil value" do
    it "returns false" do
      expect(nil_array.my_all? {|elem|}).to eql(false)
    end
  end

  context "given an empty array" do
    it "returns true" do
      expect(empty_array.my_all? {|elem|}).to eql(true)
    end
  end

  context "given an array with no block" do
    it "returns true" do
      expect(all_str_array.my_all?).to eql(true)
    end
  end

  context "given an array with no block only truthy values" do
    it "returns true" do
      expect(truthy_array.my_all?).to eql(true)
    end
  end

  context "given an array with no block only falsy values" do
    it "returns false" do
      expect(falsy_array.my_all?).to eql(false)
    end
  end

end

describe ".my_any?" do

	let(:all_str_array) {["all", "of", "these", "words", "are", "length", "one", "or", "greater"]}
  let(:all_int_array) {[9, 11, 12, 13, 14, 15]}
  let(:mixed_array) {["one", 2]}
  let(:nil_array) {[nil]}
  let(:empty_array) {[]}
  let(:mixed_truthy_array) {[false, true, "test"]}
  let(:all_falsy_array) {[false, nil]}

  context "given an array where one string has length less than 3" do
    it "returns true" do
      expect(all_str_array.my_any? {|elem| elem.length < 3}).to eql(true)
    end
  end

  context "given an array where no integer is less than 5" do
    it "returns false" do
      expect(all_int_array.my_any? {|elem| elem < 5}).to eql(false)
    end
  end

  context "given a mixed array where one element is an integer" do
    it "returns true" do
      expect(mixed_array.my_any? {|elem| elem.is_a? Integer}).to eql(true)
    end
  end

  context "given an array with only a nil value" do
    it "returns false" do
      expect(nil_array.my_any? {|elem|}).to eql(false)
    end
  end

  context "given an empty array" do
    it "returns false" do
      expect(empty_array.my_any? {|elem|}).to eql(false)
    end
  end

  context "given an array with no block" do
    it "returns true" do
      expect(all_str_array.my_any?).to eql(true)
    end
  end

  context "given an array with no block and at least one falsy value" do
    it "returns false" do
      expect(mixed_truthy_array.my_any?).to eql(false)
    end
  end

  context "given an array with no block only falsy values" do
    it "returns false" do
      expect(all_falsy_array.my_any?).to eql(false)
    end
  end

end

describe ".my_count" do
	let(:str_array) {["a", "b", "c"]}
  let(:int_array) {[1, 2, 3]}
  let(:mixed_array) {[1, "b", true]}
  let(:empty_array) {[]}
  let(:nil_array) {[nil, nil, nil]}

  context "given an array of strings with a block looking for 'a'" do
    it "returns 1" do
      expect(str_array.my_count {|elem| elem == "a"}).to eql(1)
    end
  end

  context "given an array of integers with a block looking for strings" do
    it "returns 0" do
      expect(int_array.my_count{|elem| elem.is_a? String}).to eql(0)
    end
  end

  context "given a mixed array with a block looking for non-strings" do
    it "returns 2" do
      expect(mixed_array.my_count{|elem| !elem.is_a? String}).to eql(2)
    end
  end

  context "given an array of nil values wth a block looking for nil" do
    it "returns 3" do
      expect(nil_array.my_count{|elem| elem.nil?}).to eql(3)
    end
  end

  context "given an empty array" do
    it "returns 0" do
      expect(empty_array.my_count{|elem| elem}).to eql(0)
    end
  end

  context "given an integer array with no block" do
    it "returns the array length" do
      expect(int_array.my_count).to eql(3)
    end
  end
end

describe ".my_map" do
	let(:str_array) {["a", "b", "c"]}
  let(:int_array) {[1, 2, 3]}
  let(:empty_array) {[]}
  let(:mixed_array) {[nil, 2, nil]}

  context "given an array of strings with a block adding !" do
    it "returns [\"a!\", \"b!\", \"c!\"]" do
      expect(str_array.my_map {|elem| elem + "!"}).to eql(["a!", "b!", "c!"])
    end
  end

  context "given an array of integers with a block multiplying by 2" do
    it "returns [2, 4, 6]" do
      expect(int_array.my_map {|elem| elem * 2}).to eql([2, 4, 6])
    end
  end

  context "given an empty array" do
    it "returns an empty array" do
      expect(empty_array.my_map{|elem| elem*2}).to eql([])
    end
  end

  context "given an array with nil values and a block testing for nil" do
    it "returns [true, false, true]" do
      expect(mixed_array.my_map{|elem| elem.nil?}).to eql([true, false, true])
    end
  end

  context "given an array with no block" do
    it "returns an Enumerator" do
      expect(str_array.my_map).to be_an Enumerator
    end
  end 
end
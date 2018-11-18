require "./spec_helper"

describe BloomFilter do
	describe "#includes?" do
		it "returns true if the value has been inserted" do
			bf = BloomFilter(128,1,Crystal::Hasher).new
			bf.insert(1)
			bf.includes?(1).should be_true
			bf.includes?(15).should be_false
		end
	end
end

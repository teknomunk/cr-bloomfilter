# TODO: Write documentation for `Bloomfilter`
class BloomFilter(N,K,Hasher)
	VERSION = "0.1.0"

	@array : StaticArray(UInt8,N) = StaticArray(UInt8,N).new(0)
	SLOTS = N*8

	def insert( value )
		h = value.hash(Hasher.new()).result
		hash_bits = Math.log2(sizeof(typeof(h))).ceil.to_i32
		{% for i in 0...K %}
			part = (h >> ({{i.id}}*hash_bits)) & ((1<<hash_bits)-1)
			@array[part>>3] |= (1<<(part & 7))
		{% end %}
	end
	def includes?( value )
		h = value.hash(Hasher.new()).result
		hash_bits = Math.log2(sizeof(typeof(h))).ceil.to_i32
		{% for i in 0...K %}
			part = (h >> ({{i.id}}*hash_bits)) & ((1<<hash_bits)-1)
			return false if @array[part>>3] & (1<<(part & 7)) == 0
		{% end %}
		return true
	end
end

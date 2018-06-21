
class JsonRequestBody

    def self.parse_sym(json_str)
        parsed = JSON.parse json_str
        return parsed if parsed.class == String
        recur_sym(parsed)
    end

    def self.recur_sym(hash)
        hash.each do |k, v|
            hash[k] = recur_sym(v) if v.class == Hash
        end
        #hash.symbolize_keys
        Hash[hash.map { |k, v| [k.to_sym, v] }]
    end
    
end
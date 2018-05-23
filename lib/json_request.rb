require 'facets'

class JsonRequestBody

    def self.parse_sym(json_str)
        parsed = JSON.parse json_str
        recur_sym(parsed)
    end

    def self.recur_sym(hash)
        hash.each do |k, v|
            hash[k] = recur_sym(v) if v.class == Hash
        end
        hash.symbolize_keys
    end
    
end
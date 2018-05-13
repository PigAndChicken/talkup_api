class JsonRequestBody

    def self.parse_sym(json_str)
        parsed = JSON.parse json_str
        Hash[parsed.map { |k, v| [k.to_sym, v] }]
    end
    
end
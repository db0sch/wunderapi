module Wunderapi
  module Helper

    def to_hash
      i_vs = self.instance_variables
      i_vs.delete_if {|i_v| i_v.to_s == '@api'}
      hash = {}
      i_vs.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
      hash.reject! { |k, v| v.nil? || v == 0}
      hash
    end

    def update
      p resource_path
      p self.to_hash
      self.api.call :put, resource_path, self.to_hash
    end

    def create
      self.api.call :post, path, self.to_hash
    end

    def save
      if self.id.nil?
        res = self.create
      else
        res = self.update
      end
      raise "#{res["error"]["message"]}: #{res["error"].key(true)}" if res["error"]
      set_attrs(res)
    end

    def destroy
      self.api.call :delete, resource_path, {:revision => self.revision}
      self.id = nil

      self
    end

    def resource_path
      "api/v1/#{plural_model_name}/#{self.id}"
    end

    def path
      "api/v1/#{plural_model_name}"
    end

    def model_name
      self.class.to_s.gsub('Wunderapi::','').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z])([A-Z])/, '\1_\2').
        downcase
    end

    def plural_model_name
      "#{model_name}s"
    end

  end
end

class Hash
  def symbolize_keys
    inject({}){ |memo,(k,v)| memo[k.to_sym] = v; memo }
  end

  def stringify_keys
    self.replace(self.inject({}){|a,(k,v)| a[k.to_s] = v; a})
  end
end

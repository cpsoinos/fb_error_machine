module FbErrorMachine

  class MarketingApiError < ErrorBase

    attr_accessor :error_code, :description, :instructions

    def self.all
      @_errors ||= begin
        YAML.load_file(File.join(File.dirname(__FILE__), "marketing_api_errors.yml")).map do |entry|
          GraphApiError.new(entry)
        end
      rescue Psych::SyntaxError, Errno::EACCES, Errno::ENOENT
        {}
      end
    end

    def self.find(error_code)
      MarketingApiError.all.detect { |e| e.error_code == error_code.to_s }
    end

  end

end

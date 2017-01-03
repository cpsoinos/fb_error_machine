module FbErrorMachine

  class GraphApiError# < StandardError

    attr_accessor :error_code, :description, :instructions

    def self.all
      begin
        YAML.load_file(File.join(File.dirname(__FILE__),"graph_api_errors.yml")).map do |entry|
          GraphApiError.new(entry)
        end
      rescue Psych::SyntaxError, Errno::EACCES, Errno::ENOENT
        {}
      end
    end

    def initialize(attrs)
      @error_code = attrs[:error_code]
      @description = attrs[:description]
      @instructions = attrs[:instructions]
    end

    private

  end

  class MarketingApiError < StandardError; end

end

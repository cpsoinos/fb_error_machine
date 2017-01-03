module FbErrorMachine

  class GraphApiError < ErrorBase

    attr_accessor :error_code, :description, :instructions

    def self.all
      @_errors ||= begin
        YAML.load_file(File.join(File.dirname(__FILE__), "graph_api_errors.yml")).map do |entry|
          GraphApiError.new(entry)
        end
      rescue Psych::SyntaxError, Errno::EACCES, Errno::ENOENT
        {}
      end
    end

    def self.find(error_code)
      GraphApiError.all.detect { |e| e.error_code == error_code.to_s }
    end

  end

end

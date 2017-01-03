module FbErrorMachine
  class ErrorBase

    def initialize(attrs)
      @error_code = attrs[:error_code]
      @description = attrs[:description]
      @instructions = attrs[:instructions]
    end

  end
end

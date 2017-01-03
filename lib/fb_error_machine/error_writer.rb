module FbErrorMachine
  class ErrorWriter

    def self.write_errors(attrs)
      type = attrs.delete(:type)
      errors = attrs[:errors]

      store_path = "lib/fb_error_machine/#{type}_api_errors.yml"
      File.open(store_path, 'w') {|f| f.write errors.to_yaml }
    end

    def self.find_error_code(row)
      sanitize(row.tds.first.inner_html)
    end

    def self.find_description(row)
      dirty_html = row.tds.to_a[1].inner_html
      sanitize(dirty_html)
    end

    def self.find_instructions(row)
      sanitize(row.tds[2].inner_html)
    end

    def self.sanitize(html)
      Sanitize.fragment(html).strip.gsub("\n", "").gsub("  ", " ")
    end

  end
end

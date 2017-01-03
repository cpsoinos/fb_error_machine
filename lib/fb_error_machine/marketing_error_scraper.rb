module FbErrorMachine
  class MarketingErrorScraper

    def self.scrape_marketing_errors
      browser = Watir::Browser.new :phantomjs
      browser.goto("https://developers.facebook.com/docs/marketing-api/error-reference")
      rows = browser.trs.to_a
      rows.shift

      errors = []

      rows.each do |row|
        errors << {
          error_code: ErrorWriter.find_error_code(row),
          description: ErrorWriter.find_description(row),
        }
      end

      browser.close
      ErrorWriter.write_errors(type: 'marketing', errors: errors)
    end

  end
end

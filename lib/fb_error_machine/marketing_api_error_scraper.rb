module FbErrorMachine
  class MarketingApiErrorScraper

    def self.scrape_marketing_api_errors(version="2.7")
      browser = Watir::Browser.new :phantomjs
      browser.goto("https://developers.facebook.com/docs/marketing-api/error-reference/v#{version}")
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

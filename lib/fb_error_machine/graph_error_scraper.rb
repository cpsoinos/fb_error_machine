module FbErrorMachine
  class GraphErrorScraper

    def self.scrape_graph_api_errors
      browser = Watir::Browser.new :phantomjs
      browser.goto("https://developers.facebook.com/docs/graph-api/using-graph-api/v2.7")

      error_table = browser.table(xpath: '//*[@id="u_0_0"]/div/span/div/div[8]/div/div[1]/table')
      error_rows = error_table.rows.to_a
      error_rows.shift

      auth_table = browser.table(xpath: '//*[@id="u_0_0"]/div/span/div/div[8]/div/div[2]/table')
      auth_rows = auth_table.rows.to_a
      auth_rows.shift

      rows = error_rows + auth_rows
      errors = []

      rows.each do |row|
        errors << {
          error_code: ErrorWriter.find_error_code(row),
          description: ErrorWriter.find_description(row),
          instructions: ErrorWriter.find_instructions(row),
          # category: "graph_api_error"
        }
      end

      browser.close
      # create_errors(errors)
      ErrorWriter.write_errors(type: 'graph', errors: errors)
    end

  end
end

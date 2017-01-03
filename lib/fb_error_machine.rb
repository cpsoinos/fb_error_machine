require 'sinatra'
require 'watir'
require 'sanitize'
require 'pry'
require 'rest-client'
require 'yaml'
require 'fb_error_machine/marketing_error_scraper'
require 'fb_error_machine/graph_error_scraper'
require 'fb_error_machine/error_writer'
require 'fb_error_machine/errors'
# require 'fb_error_machine/graph_api_errors.yml'
# require 'fb_error_machine/marketing_errors.yml'
# require 'fb_error_machine/version'


module FbErrorMachine

  # post '/scrape' do
  #   scrape_marketing_errors
  #   scrape_graph_api_errors
  # end

  def scrape_marketing_errors
    browser = Watir::Browser.new :phantomjs
    browser.goto("https://developers.facebook.com/docs/marketing-api/error-reference")
    rows = browser.trs.to_a
    rows.shift

    errors = []

    rows.each do |row|
      errors << {
        error_code: find_error_code(row),
        description: find_description(row),
        category: "marketing_error"
      }
    end

    browser.close
    # create_errors(errors)
    write_errors(type: 'marketing', errors: errors)
  end

  def scrape_graph_api_errors
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
        error_code: find_error_code(row),
        description: find_description(row),
        instructions: find_instructions(row),
        category: "graph_api_error"
      }
    end

    browser.close
    # create_errors(errors)
    write_errors(type: 'graph', errors: errors)
  end

  def find_error_code(row)
    sanitize(row.tds.first.inner_html)
  end

  def find_description(row)
    dirty_html = row.tds.to_a[1].inner_html
    sanitize(dirty_html)
  end

  def find_instructions(row)
    sanitize(row.tds[2].inner_html)
  end

  def sanitize(html)
    Sanitize.fragment(html).strip
  end

  def create_errors(attrs)
    binding.pry
    # binding.pry
    RestClient.post("#{data_server[ENV['RACK_ENV']]}/v2/facebook_errors", { errors: attrs }) #do |response, request, result|
    #   if response.code == 200
    #     head: ok
    #   else
    #     head: 404
    #   end
    # end
  end

  def write_errors(attrs)
    type = attrs.delete(:type)
    errors = attrs[:errors]

    store_path = "/fb_error_machine/#{type}_api_errors.yml"
    File.open(store_path, 'w') {|f| f.write errors.to_yaml }
  end

  def data_server
    {
      "development" => "api.local.promoboxx.com",
      "local" => "api.local.pbxx",
      "staging" => "https://api.stg.promoboxx.com",
      "production" => "https://api.promoboxx.com"
    }
  end

end

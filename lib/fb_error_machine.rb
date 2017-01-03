require 'sinatra'
require 'watir'
require 'sanitize'
require 'pry'
require 'rest-client'
require 'yaml'
require 'phantomjs'
require 'fb_error_machine/marketing_api_error_scraper'
require 'fb_error_machine/graph_error_scraper'
require 'fb_error_machine/error_writer'
require 'fb_error_machine/error_base'
require 'fb_error_machine/marketing_api_error'
require 'fb_error_machine/graph_api_error'

module FbErrorMachine

  class Scraper

    def scrape_graph_api_errors(version="2.7")
      puts "Begin Graph API Error list from 'https://developers.facebook.com/docs/graph-api/using-graph-api/v#{version}'"
      GraphErrorScraper.scrape_graph_api_errors
      puts "Stored Graph API Errors"
    end

    def scrape_marketing_api_errors(version="2.7")
      puts "Begin scraping Marketing API Error list from 'https://developers.facebook.com/docs/marketing-api/error-reference/v#{version}'"
      GraphErrorScraper.scrape_marketing_api_errors
      puts "Stored Marketing API Errors"
    end

    def scrape(version="2.7")
      scrape_graph_api_errors(version)
      scrape_marketing_api_errors(version="2.7")
    end

  end

end

describe FbErrorMachine::MarketingApiError do

  it "returns a list of all errors" do
    expect(FbErrorMachine::MarketingApiError.all.count).to eq(71)
  end

  it "finds an error by code when passed a string" do
    found_error = FbErrorMachine::MarketingApiError.find("1487108")

    expect(found_error.error_code).to eq("1487108")
    expect(found_error.description).to eq("Invalid Cities: Please check that the format in which you are specify the cities is correct, and if you specify ids, that they are of the correct type (not, for example, the id of the page for the city; city ids are returned by, e.g., graph.facebook.com/search?type=adcity).")
    expect(found_error.instructions).to be_nil
  end

  it "finds an error by code when passed an integer" do
    found_error = FbErrorMachine::MarketingApiError.find(1487108)
    expect(found_error.error_code).to eq("1487108")
  end

end

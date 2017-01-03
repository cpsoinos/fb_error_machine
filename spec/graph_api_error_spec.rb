describe FbErrorMachine::GraphApiError do

  it "returns a list of all errors" do
    expect(FbErrorMachine::GraphApiError.all).count to eq(19)
  end

  it "finds an error by code when passed a string" do
    found_error = FbErrorMachine::GraphApiError.find("458")

    expect(found_error.error_code).to eq("458")
    expect(found_error.description).to eq("App Not Installed")
    expect(found_error.instructions).to eq("The user has not logged into your app. Reauthenticate the user.")
  end

  it "finds an error by code when passed an integer" do
    found_error = FbErrorMachine::GraphApiError.find(458)
    expect(found_error.error_code).to eq("458")
  end

end

require 'spec_helper'

describe TictactoeController do

  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'dashboard'
      response.should be_success
    end
  end

  describe "GET 'move'" do
    it "returns http success" do
      get 'move'
      response.should be_success
    end
  end

end

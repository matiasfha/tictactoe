require 'spec_helper'

describe API::TictactoeController do


  describe "POST 'move'" do
    it "return winner X" do

      params =  {
        "omarked" => ["b3","c1"],
        "xmarked" => ["a1","b2","c3"]
      }
      post :move, params, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      JSON.parse(response.body)["winner"].should == "X"
    end


    it "return winner O" do

      params =  {
        "omarked" => ["a3","b2","c3"],
        "xmarked" => ["a2","b1","c1","c2"]
      }
      post :move, params, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      JSON.parse(response.body)["winner"].should == "O"
    end

    it "return no winner " do

      params =  {
        "omarked" => ["a3","b2"],
        "xmarked" => ["b1","c1","c2"]
      }
      post :move, params, { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      JSON.parse(response.body)["winner"].should == ""
    end
  end

end

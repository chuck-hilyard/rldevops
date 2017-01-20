#!/usr/bin/env ruby

require 'rspec'
require_relative '../lib/googlesheets.rb'

describe GoogleSheets do

  it "should return a blank instance of GoogleSheets" do
    GoogleSheets.new.should == {}
  end

end

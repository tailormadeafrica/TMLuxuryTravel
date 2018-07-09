require 'spec_helper'

module Refinery
  module Teams
    describe Team do
      describe "validations" do
        subject do
          FactoryGirl.create(:team,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end

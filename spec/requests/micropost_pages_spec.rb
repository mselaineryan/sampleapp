require 'spec_helper'

describe "MicropostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user } 

	describe "micropost creation" do 
		before { visit root_path } 

		describe "with invalid information" do 

			it "should not create a micropost" do 
				expect { click_button "Post" }.not_to change(Micropost, :count)
			end

			describe "error messages" do 
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do 

			before { fill_in 'micropost_content', with: "Lorem ipsum" }
			it "should create a micropost" do 
				expect { click_button "Post" }.to change(Micropost, :count).by(1) 
			end	
		end

		describe "microposts sidebar" do 
			before { fill_in 'micropost_content', with: "Lorem ipsum" }
			before { click_button "Post"}

			describe "one micropst" do 
				it { should have_content ('1 micropost')}
			end

			describe "multiple microposts" do 
				before { fill_in 'micropost_content', with: "Lorem ipsum" }
				before { click_button "Post"}
				it { should have_content('microposts') }
			end
		end

	end

	describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

	    describe "as correct user" do
	      before { visit root_path }

	      it "should delete a micropost" do
	        expect { click_link "delete" }.to change(Micropost, :count).by(-1)
	      end
	    end
=begin
    	describe "as user who did not create micropost" do
    		
    		let(:user2) { FactoryGirl.create(:user2) }
    		before do 
    			sign_in user2 
    			visit root_path
    		end

			it "should not have a delete link beside another user's micropost" do 
	    		expect(micropost).to_not have_link('delete')
	    	end
	    end
=end
    		
  	end
end

require 'rails_helper'

RSpec.feature "MakeAndModels", type: :feature do
  context "As an internet user " do
    context "When I visit the welcome page" do
      it "shows 'Car Challenge'" do
        visit '/car/new_car'
        expect(page).to have_content("Car Challenge")
      end

      it "asked for make and model year of the car to be simulated" do
        visit '/car/new_car'
        expect(page).to have_field("Car Make")
        expect(page).to have_field("Model Year")

      end

      it "after entering make and model year, and clicking on a button labelled Simulate Car I am taken to a status page" do
        make_model
        expect(page).to have_field("Car Make:", with: 'Toyota')
        expect(page).to have_field("Model Year:", with: '2008')

        click_button 'Generate Your Dream Car'
        expect(page.current_path).to eq('/simulator/do')

      end

      it "has a status page showing make and model year of the car" do
        make_model
        click_button 'Generate Your Dream Car'

        expect(page).to have_content("Toyota 2008")


      end

    end

    context "when I visit the status page for a selected car" do

      it "it shows whether there are lights on the car." do
        make_model
        click_button 'Generate Your Dream Car'
        expect(page).to have_content("Lights On")
        expect(page).to have_content("Lights Off")

      end

      it "it shows whether the lights on the car starts with them off" do
        make_model
        click_button 'Generate Your Dream Car'
        within('form#lights') do
          find('input#lightsOff').should be_checked

        end

      end

      it "it shows whether the lights on the car are switched on" do
        make_model
        click_button 'Generate Your Dream Car'
        within('form#lights') do
          find('input#lightsOn').set(true)
        end

      end

      it "speed starts at zero"do
        make_model
        click_button 'Generate Your Dream Car'
        expect(page).to have_content(0)

      end

      it "i can click on an accelerate button, which makes the car go faster" do
        make_model
        click_button 'Generate Your Dream Car'
        click_button 'Accelerate'
        expect(page).to have_content(10)

        end


      it "I can click on an brake button, which makes the car go slower, and shows that in the car status page.", js:true do
        make_model
        click_button 'Generate Your Dream Car'
        click_button 'Accelerate'
        click_button 'Decelerate'
        expect(page).to have_content(3)

        end

      it "can set and release the parking brake using radio buttons." do
        make_model
        click_button 'Generate Your Dream Car'
        within('form#parking_brake') do
          find('input#parking_off').should be_checked
        end

        click_button 'Set Parking Brake'
        within('form#parking_brake') do
          find('input#parking_on').set(true)
        end

      end



      end

    def make_model
      visit 'car/new_car'

      within("form#make_model") do
        fill_in("Car Make:", with: 'Toyota')
        fill_in("Model Year:", with: '2008')

      end
    end

  end
end

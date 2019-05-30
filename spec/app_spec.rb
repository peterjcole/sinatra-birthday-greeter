feature 'BirthdayGreeter' do
  let(:days_until_birthday) do
    today = Date.today
    birthday = Date.new(today.year, 04, 13)
    if birthday >= today
      return (birthday - today).to_i
    else
      return (birthday.next_year - today).to_i
    end
  end 
  feature 'homepage' do
    background do
      visit('/')
    end
    
    scenario 'contains a title' do
      expect(page).to have_css('.title')
    end
    scenario 'contains a name input box' do
      expect(page).to have_css('input[name=name][type=text]')
    end
    scenario 'contains a birthday day input box' do
      expect(page).to have_css('input[name=day][type=text]')
    end
    scenario 'contains a birthday month dropdown' do
      expect(page).to have_css('select[name=month]')
    end
    scenario 'contains a go button' do
      expect(page).to have_css('input[name=go][type=submit]')
    end

  end

  feature '/greet' do
    feature 'when name input was empty' do
      background do
        visit('/')
        page.fill_in('day', with: '13')
        page.select('April', from: 'month')
        page.click_button('Go')
      end

      scenario "greets without a name" do
        expect(page).to have_css('h1', text: "It is not your birthday :(. Don't be too sad though, it's in #{days_until_birthday} days")
      end
    end

    feature 'when day input was empty' do
      background do
        visit('/')
        page.fill_in('name', with: 'Peter')
        page.select('April', from: 'month')
        page.click_button('Go')
      end

      scenario "complains at the user" do
        expect(page).to have_css('h1', text: "I have no idea whether it's your birthday because you didn't tell me the day!")
      end
    end

    feature "when it is not the person's birthday" do
      background do
        visit('/')
        page.fill_in('name', with: 'Peter')
        page.fill_in('day', with: '13')
        page.select('April', from: 'month')
        page.click_button('Go')
      end

      scenario 'contains a title' do
        expect(page).to have_css('h1')
      end

      scenario "says that it is not the person's birthday" do
        expect(page).to have_css('h1', text: "It is not your birthday Peter :(. Don't be too sad though, it's in #{days_until_birthday} days")
      end
    end

    feature "when it is the person's birthday" do
      background do
        visit('/')
        day = Time.now.strftime('%d')
        month = Time.now.strftime('%B')
        page.fill_in('name', with: 'Peter')
        page.fill_in('day', with: day)
        page.select(month, from: 'month')
        page.click_button('Go')
      end

      scenario 'contains a title' do
        expect(page).to have_css('h1')
      end

      scenario "says that it is the person's birthday" do
        expect(page).to have_css('h1', text: "It's your birthday Peter!!!!!!!!!!!!!!!!!!!!!!!!!")
      end
    end
  end
end


# describe 'app' do
  
#   visit '/'
#   let(:days_until_birthday) do
#     today = Date.today
#     birthday = Date.new(today.year, 04, 13)
#     if birthday >= today
#       return (birthday - today).to_i
#     else
#       return (birthday.next_year - today).to_i
#     end
#   end

#   context 'homepage' do
#     before (:context) do
#       visit('http://localhost:9393')
#     end
#     it 'contains a title' do
#       expect(page).to have_css('.title')
#     end
#     it 'contains a name input box' do
#       expect(page).to have_css('input[name=name][type=text]')
#     end
#     it 'contains a birthday day input box' do
#       expect(page).to have_css('input[name=day][type=text]')
#     end
#     it 'contains a birthday month dropdown' do
#       expect(page).to have_css('select[name=month]')
#     end
#     it 'contains a go button' do
#       expect(page).to have_css('input[name=go][type=submit]')
#     end
#   end

#   context '/greet' do

#     context 'when name input was empty' do
#       before(:context) do
#         visit('http://localhost:9393')
#         page.fill_in('day', with: '13')
#         page.select('April', from: 'month')
#         page.click_button('Go')
#       end

#       it "greets without a name" do
#         expect(page).to have_css('h1', text: "It is not your birthday :(. Don't be too sad though, it's in #{days_until_birthday} days")
#       end
#     end

#     context 'when day input was empty' do
#       before(:context) do
#         visit('http://localhost:9393')
#         page.fill_in('name', with: 'Peter')
#         page.select('April', from: 'month')
#         page.click_button('Go')
#       end

#       it "complains at the user" do
#         expect(page).to have_css('h1', text: "I have no idea whether it's your birthday because you didn't tell me the day!")
#       end

#     end

#     context "when it is not the person's birthday" do
#       before(:context) do
#         visit('http://localhost:9393')
#         page.fill_in('name', with: 'Peter')
#         page.fill_in('day', with: '13')
#         page.select('April', from: 'month')
#         page.click_button('Go')
#       end

#       it 'contains a title' do
#         expect(page).to have_css('h1')
#       end

#       it "says that it is not the person's birthday" do

#         expect(page).to have_css('h1', text: "It is not your birthday Peter :(. Don't be too sad though, it's in #{days_until_birthday} days")
#       end
#     end

#     context "when it is the person's birthday" do
#       before(:context) do
#         visit('http://localhost:9393')
#         day = Time.now.strftime('%d')
#         month = Time.now.strftime('%B')
#         page.fill_in('name', with: 'Peter')
#         page.fill_in('day', with: day)
#         page.select(month, from: 'month')
#         page.click_button('Go')
#       end

#       it 'contains a title' do
#         expect(page).to have_css('h1')
#       end

#       it "says that it is the person's birthday" do
#         expect(page).to have_css('h1', text: "It's your birthday Peter!!!!!!!!!!!!!!!!!!!!!!!!!")
#       end
#     end
#   end
# end

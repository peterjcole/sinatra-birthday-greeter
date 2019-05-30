require 'capybara/dsl'
require 'selenium-webdriver'
include Capybara::DSL
Capybara.default_driver = :selenium


describe 'app' do
  
  context 'homepage' do
    before (:context) do
      visit('http://localhost:9393')
    end
    it 'contains a title' do
      expect(page).to have_css('.title')
    end
    it 'contains a name input box' do
      expect(page).to have_css('input[name=name][type=text]')
    end
    it 'contains a birthday day input box' do
      expect(page).to have_css('input[name=day][type=text]')
    end
    it 'contains a birthday month dropdown' do
      expect(page).to have_css('select[name=month]')
    end
    it 'contains a go button' do
      expect(page).to have_css('input[name=go][type=submit]')
    end
  end

  context '/greet' do
    context "when it is not the person's birthday" do
      before(:context) do
        visit('http://localhost:9393')
        page.fill_in('name', with: 'Peter')
        page.fill_in('day', with: '25')
        page.select('April', from: 'month')
        page.click_button('Gogi')
      end

      it 'contains a title' do
        expect(page).to have_css('h1.greeting')
      end

      it "says that it is not the person's birthday" do
        today = Date.today
        birthday = Date.new(today.year, 04, 25)
        if birthday > today
          days_until_birthday = birthday - today
        else
          days_until_birthday = birthday.next_year - today
        end
        expect(page).to have_css('h1.greeting', text: "It is not your birthday Peter :(. Don't be too sad though, it's in #{days_until_birthday.to_i} days")
      end
    end

    context "when it is the person's birthday" do
      before(:context) do
        visit('http://localhost:9393')
        day = Time.now.strftime('%d')
        month = Time.now.strftime('%B')
        page.fill_in('name', with: 'Peter')
        page.fill_in('day', with: day)
        page.select(month, from: 'month')
        page.click_button('Go')
      end

      it 'contains a title' do
        expect(page).to have_css('h1.greeting')
      end

      it "says that it is the person's birthday" do
        expect(page).to have_css('h1.greeting', text: "It's your birthday Peter!!!!!!!!!!!!!!!!!!!!!!!!!")
      end
    end
  end
end

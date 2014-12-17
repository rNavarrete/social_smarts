require 'rails_helper'

describe 'HomePage' do

  context 'given a user has no tweets' do
  end

  context 'given a user that has tweets' do
    it 'displays tweets' do
      VCR.use_cassette("j3_tweets") do
        visit root_path
        expect(page).to have_content('Tweets')
        within('ul.tweets') do
          expect(page.has_css? 'li.tweet').to eq true
        end
      end
    end

  end

end

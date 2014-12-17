require 'rails_helper'

describe TwitterClient do
  let(:client) { TwitterClient.new }

  context 'tweets' do
    before do
      VCR.use_cassette("j3_tweets") do
        @tweets = client.fetch_tweets('j3')
      end
    end

    it 'fetches array of tweets' do
      expect(@tweets).to be_a Array
    end

    it 'returns tweet objects with text' do
      expect(@tweets.first.text?).to eq true
    end
  end

  context 'mentions' do
    before do
      VCR.use_cassette("j3_mentions") do
        @mentions = client.fetch_mentions("j3")
      end
    end

    xit 'fetches array of mentions' do
      binding.pry
    end
  end


end

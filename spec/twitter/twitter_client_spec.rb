require 'rails_helper'

describe TwitterClient do
  let(:client) { TwitterClient.new }

  context 'tweets' do
    let (:tweets) { client.fetch_tweets('j3') }

    it 'fetches array of tweets' do
      VCR.use_cassette("j3_tweets") do
        expect(tweets).to be_a Array
      end
    end

    it 'returns tweet objects with text' do
      VCR.use_cassette("j3_tweets") do
        expect(tweets.first.text?).to eq true
      end
    end
  end

  context 'mentions' do
    let (:mentions) { client.fetch_mentions }

    it 'fetches array of mentions' do
      VCR.use_cassette("j3_mentions") do
        expect(mentions).to be_a Array
      end
    end

    it 'returns mention objects with text' do
      VCR.use_cassette("j3_mentions") do
        expect(mentions.first.text?).to eq true
      end
    end
  end

end

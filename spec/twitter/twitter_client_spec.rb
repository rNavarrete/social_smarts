# require 'rails_helper'

# describe TwitterClient do
#   let(:client) { TwitterClient.new }

#   context 'tweets' do
#     before do
#       VCR.use_cassette("j3_tweets") do
#         @tweets = client.fetch_tweets('j3')
#       end
#     end

#     it 'fetches array of tweets' do
#       expect(@tweets).to be_a Array
#     end

#     it 'returns tweet objects with text' do
#       expect(@tweets.first.text?).to eq true
#     end
#   end

#   context 'mentions' do
#     before do
#       VCR.use_cassette("j3_mentions") do
#         @mentions = client.fetch_mentions
#       end
#     end

#     it 'fetches array of mentions' do
#       expect(@mentions).to be_a Array
#     end

#     it 'returns mention objects with text' do
#       expect(@mentions.first.text?).to eq true
#     end
#   end


# end

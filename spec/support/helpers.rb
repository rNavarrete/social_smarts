module Helpers
  def parsed_json_response_body
    JSON.parse(response.body)
  end
end

RSpec.configure do |c|
  c.include Helpers
end

module WebmockStubs
  def self.included(base)
    base.extend(ClassMethods)
    base.setup_stubbed_requests
  end

  def headers
    {
      'Accept' => 'application/vnd.github.v3+json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type' => 'application/json',
      'User-Agent' => "Octokit Ruby Gem #{Octokit::VERSION}"
    }
  end

  def json_response_for(file_name)
    {
      status: 200,
      body: File.read("spec/fixtures/#{file_name}"),
      headers: {
        'Content-Type' => 'application/json',
      }
    }
  end

  module ClassMethods
    def setup_stubbed_requests
      before do
        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls/23")
          .with(headers: headers)
          .to_return(json_response_for("rails-23.json"))

       stub_request(:get, "https://api.github.com/search/issues?q=is:open%20is:pr%20repo:rails/rails%20label:%20activemodel")
         .with(headers: headers)
         .to_return(json_response_for("rails-pull-requests-labeled-activemodel.json"))
      end
    end


  end
end

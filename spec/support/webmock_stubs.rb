module WebmockStubs
  def self.included(base)
    base.extend(ClassMethods)
    base.setup_stubbed_requests
  end

  module ClassMethods
    def setup_stubbed_requests
      before do
        stub_request(:get, "https://api.github.com/repos/rails/rails/pulls/23")
          .with(
            headers: {
              'Accept' => 'application/vnd.github.v3+json',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/json',
              'User-Agent' => 'Octokit Ruby Gem 4.2.0'
            }
          )
          .to_return(
            status: 200,
            body: File.read("spec/fixtures/rails-23.json"),
            headers: {
              'Content-Type' => 'application/json',
            }
          )
      end
    end
  end
end

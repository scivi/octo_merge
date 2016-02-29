module SetupExampleRepos
  def self.included(base)
    base.instance_eval do
      subject(:history) { mallory.history }

      let(:upstream) { SimpleGit.new(name: "upstream") }
      let(:alice) { SimpleGit.new(name: "alice") }
      let(:bob) { SimpleGit.new(name: "bob") }
      let(:mallory) { SimpleGit.new(name: "mallory") }

      let(:working_directory) { mallory.path }
      let(:alice_cowboy_hat) {
        instance_double(OctoMerge::PullRequest, remote: "alice", branch: "cowboy_hat")
      }
      let(:bob_sunglasses) {
        instance_double(OctoMerge::PullRequest, remote: "bob", branch: "sunglasses")
      }

      before { setup_example_repos }

      before do
        described_class.run(
          working_directory: working_directory,
          change_sets: [alice_cowboy_hat, bob_sunglasses]
        )
      end
    end
  end

  def setup_example_repos
    SimpleGit.clear!

    upstream.create
    alice.create
    bob.create
    mallory.create

    alice.add_remote("upstream")
    bob.add_remote("upstream")

    mallory.add_remote("upstream")
    mallory.add_remote("alice")
    mallory.add_remote("bob")

    # First commit
    upstream.add_item("earrrings")

    alice.reset("upstream", "master")
    alice.checkout_branch("cowboy_hat")
    alice.add_item("cowboy_hat")

    # Second commit
    upstream.add_item("tattoo")

    bob.reset("upstream", "master")
    bob.checkout_branch("sunglasses")
    bob.add_item("sunglasses")

    # Third commit
    upstream.add_item("piercing")
  end
end

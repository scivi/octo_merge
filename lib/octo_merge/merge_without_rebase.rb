module OctoMerge
  class MergeWithoutRebase < AbstractMerge
    def run
      git.checkout(master)
      git.fetch(upstream)
      git.reset_hard("#{upstream}/#{master}")

      pull_requests.each do |pull_request|
        git.remote_add("#{pull_request.remote} #{pull_request.remote_url}")
        git.fetch(pull_request.remote)
        git.merge_no_ff("#{pull_request.remote}/#{pull_request.branch}")
      end
    end
  end
end

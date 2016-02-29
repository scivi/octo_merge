# == Links
#
# * https://www.atlassian.com/git/tutorials/merging-vs-rebasing/workflow-walkthrough
# * https://www.atlassian.com/git/articles/git-team-workflows-merge-or-rebase/
module OctoMerge
  class MergeWithRebase < AbstractMerge
    def run
      git.checkout(master)
      git.fetch(upstream)
      git.reset_hard("#{upstream}/#{master}")

      pull_requests.each do |pull_request|
        git.remote_add("#{pull_request.remote} #{pull_request.remote_url}")
        git.fetch(pull_request.remote)
        git.checkout(pull_request.branch)
        git.rebase(master)
        git.checkout(master)
        git.merge_no_ff(pull_request.branch)
      end
    end
  end
end

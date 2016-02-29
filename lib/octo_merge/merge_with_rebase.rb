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

      change_sets.each do |change_set|
        git.fetch(change_set.remote)
        git.checkout(change_set.branch)
        git.rebase(master)
        git.checkout(master)
        git.merge_no_ff(change_set.branch)
      end
    end
  end
end

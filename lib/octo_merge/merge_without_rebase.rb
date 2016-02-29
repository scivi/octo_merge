module OctoMerge
  class MergeWithoutRebase < AbstractMerge
    def run
      git.checkout(master)
      git.fetch(upstream)
      git.reset_hard("#{upstream}/#{master}")

      change_sets.each do |change_sets|
        git.fetch(change_sets.remote)
        git.merge_no_ff("#{change_sets.remote}/#{change_sets.branch}")
      end
    end
  end
end

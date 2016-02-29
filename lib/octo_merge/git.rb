# TODO: Move to another repository (e.g.: `SimpleGit`)
class Git
  def self.git(method_name, cmd = nil)
    define_method(method_name) do |args|
      if cmd
        git("#{cmd} #{args}")
      else
        git("#{method_name} #{args}")
      end
    end
  end

  attr_reader :working_directory

  def initialize(working_directory)
    @working_directory ||= File.absolute_path(working_directory)
  end

  git :checkout
  git :fetch
  git :merge_no_ff, "merge --no-ff"
  git :rebase
  git :remote_add, "remote add"
  git :reset_hard, "reset --hard"


  private

  def git(cmd)
    run "git #{cmd}"
  end

  def run(cmd)
    cmd = <<-CMD
      cd #{working_directory} &&
      #{cmd}
    CMD

    `#{cmd}`
  end
end

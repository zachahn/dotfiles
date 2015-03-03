task :default do
  Rake::Task["link"].invoke
  Rake::Task["vim"].invoke
end

task :vim do
  path_to_vundle = File.join(ENV["HOME"], ".vim/bundle/Vundle.vim")

  unless File.exist?(path_to_vundle)
    `git clone https://github.com/gmarik/Vundle.vim.git #{path_to_vundle}`
  end

  `vim +PluginInstall +qall`
end

task :link do
  Dotfile.each do |df|
    if df.exists?
      fail "#{df.link} already exists" unless df.linked?
      puts "exists #{df.link}"
    else
      df.link!
      puts "linked #{df.link}"
    end
  end
end

task :clean do
  Dotfile.each do |df|
    was_unlinked = df.unlink!

    puts "unlinking #{df.link}" if was_unlinked
  end
end

# helpers

class Dotfile
  def self.each(&block)
    all_dotfiles = Dir.glob("_*")
    instances    = all_dotfiles.map { |file| self.new(file) }

    instances.each(&block)
  end

  def initialize(dotfile)
    link_name = dotfile.sub("_", ".")
    @target   = File.join(Dir.pwd, dotfile)
    @link     = File.join(ENV["HOME"], link_name)
  end

  attr_reader :target, :link

  def exists?
    File.exist?(@link)
  end

  def linked?
    File.symlink?(@link) && File.readlink(@link) == @target
  end

  def link!
    File.symlink(@target, @link)
  end

  def unlink!
    if exists? && linked?
      File.delete(@link)
      true
    else
      false
    end
  end
end


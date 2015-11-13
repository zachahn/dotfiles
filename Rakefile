desc "run all nondestructive tasks"
task :default do
  Rake::Task["link"].invoke
  Rake::Task["vim"].invoke
  Rake::Task["zsh"].invoke
end

desc "setup all symlinks"
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

desc "setup vim + vundle"
task :vim do
  path_to_vundle = File.join(ENV["HOME"], ".vim/bundle/Vundle.vim")

  if File.exist?(path_to_vundle)
    `vim +PluginUpdate +qall`
  else
    `git clone https://github.com/gmarik/Vundle.vim.git #{path_to_vundle}`
    `vim +PluginInstall +qall`
  end

  unless File.exist?(File.join(ENV["HOME"], ".vim/init"))
    File.symlink(
      File.join(Dir.pwd, "vim_init"),
      File.join(ENV["HOME"], ".vim/init")
    )
  end
end

desc "setup zsh (prezto)"
task :zsh do
  path_to_prezto = File.join(ENV["HOME"], ".zprezto")
  clone_url      = "https://github.com/sorin-ionescu/prezto.git"

  unless File.exist?(path_to_prezto)
    `git clone --recursive #{clone_url} #{path_to_prezto}`
  end
end

desc "delete all symlinks"
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


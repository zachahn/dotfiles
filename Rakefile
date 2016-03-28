require_relative "lib"

desc "run all nondestructive tasks"
task :default do
  Rake::Task["link"].invoke
  Rake::Task["vim"].invoke
  Rake::Task["zsh"].invoke
end

desc "setup all symlinks"
task :link do
  Dir.glob("_*")
    .map  { |file| Dot.new(file) }
    .map  { |dot|  DotfileLinker.new(dot) }
    .each { |dot|  dot.link }
end

desc "setup vim + vundle"
task :vim do
  path_to_vundle = File.join(ENV["HOME"], ".vim/bundle/Vundle.vim")
  clone_url = "https://github.com/VundleVim/Vundle.vim.git"

  target = File.join(Dir.pwd, "vim_init"),
  link   = File.join(ENV["HOME"], ".vim/init")

  vun = Sloth.new
  vun.dsm(:first_run?) { !File.exist?(path_to_vundle) }
  vun.dsm(:first)      { `git clone #{clone_url} #{path_to_vundle}` }
  vun.dsm(:always)     { `vim +PluginInstall +qall ; vim +PluginUpdate +qall` }
  vun.call

  ini = Sloth.new
  ini.dsm(:first_run?) { !File.exist?(File.join(ENV["HOME"], ".vim/init")) }
  ini.dsm(:first)      { File.symlink(target, link) }
  ini.call
end

desc "setup zsh (prezto)"
task :zsh do
  path_to_prezto = File.join(ENV["HOME"], ".zprezto")
  clone_url      = "https://github.com/sorin-ionescu/prezto.git"

  prz = Sloth.new
  prz.dsm(:first_run?) { !File.exist?(path_to_prezto) }
  prz.dsm(:first)      { `git clone --recursive #{clone_url} #{path_to_prezto}` }
  prz.dsm(:tail)       { `cd #{path_to_prezto} ; git pull ; git submodule update --recursive` }
  prz.call
end

desc "delete all symlinks"
task :clean do
  Dir.glob("_*")
    .map  { |file| Dot.new(file) }
    .map  { |dot|  DotfileLinker.new(dot) }
    .each { |dot|  dot.unlink }
end

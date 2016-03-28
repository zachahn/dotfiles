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
    .map  { |file| Dotfile.new(file) }
    .map  { |dot|  DotfileLinker.new(dot) }
    .each { |dot|  dot.link }
end

namespace :link do
  desc "delete all symlinks"
  task :clean do
    Dir.glob("_*")
      .map  { |file| Dotfile.new(file) }
      .map  { |dot|  DotfileLinker.new(dot) }
      .each { |dot|  dot.unlink }
  end
end

desc "setup/update vim + plug + plugins"
task :vim do
  path_to_plug = File.join(ENV["HOME"], ".vim/autoload/plug.vim")
  curl_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  target = File.join(Dir.pwd, "vim_init"),
  link   = File.join(ENV["HOME"], ".vim/init")

  vun = Sloth.new
  vun.dsm(:first_run?) { !File.exist?(path_to_plug) }
  vun.dsm(:first)      { `curl -fLo #{path_to_plug} --create-dirs #{curl_url}` }
  vun.dsm(:always)     { `vim +PlugUpgrade +PlugUpdate +qall` }
  vun.call

  ini = Sloth.new
  ini.dsm(:first_run?) { !File.exist?(File.join(ENV["HOME"], ".vim/init")) }
  ini.dsm(:first)      { File.symlink(target, link) }
  ini.call
end

desc "setup/update zsh (prezto)"
task :zsh do
  path_to_prezto = File.join(ENV["HOME"], ".zprezto")
  clone_url      = "https://github.com/sorin-ionescu/prezto.git"

  prz = Sloth.new
  prz.dsm(:first_run?) { !File.exist?(path_to_prezto) }
  prz.dsm(:first)      { `git clone --recursive #{clone_url} #{path_to_prezto}` }
  prz.dsm(:tail)       { `cd #{path_to_prezto} ; git pull ; git submodule update --recursive` }
  prz.call
end

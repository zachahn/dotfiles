require_relative "lib"

desc "run all nondestructive tasks"
task :default do
  Rake::Task["link"].invoke
  Rake::Task["zsh"].invoke
end

desc "setup all symlinks"
task :link do
  Dir.glob("_*")
    .map  { |file| Dotfile.new(file) }
    .map  { |dot|  DotfileLinker.new(dot) }
    .each { |dot|  dot.link }

  bin_local_path = File.join(ENV["HOME"], ".bin_local")
  bin_local = Sloth.new
  bin_local.dsm(:first_run?) { !File.exist?(bin_local_path) }
  bin_local.dsm(:first) { Dir.mkdir(bin_local_path) }
  bin_local.call
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

desc "setup/update prezto (zsh)"
task :zsh do
  path_to_prezto = File.join(ENV["HOME"], ".zprezto")
  clone_url      = "https://github.com/sorin-ionescu/prezto.git"

  prz = Sloth.new
  prz.dsm(:first_run?) { !File.exist?(path_to_prezto) }
  prz.dsm(:first)      { `git clone --recursive #{clone_url} #{path_to_prezto}` }
  prz.dsm(:tail)       { `cd #{path_to_prezto} ; git pull ; git submodule update --recursive` }
  prz.call
end

desc "setup rbenv"
task :ruby do
  path_to_rbenv = File.join(ENV["HOME"], ".rbenv")
  clone_url     = "https://github.com/rbenv/rbenv.git"

  sloth = Sloth.new
  sloth.dsm(:first_run?) { !File.exist?(path_to_rbenv) }
  sloth.dsm(:first)      { `git clone #{clone_url} #{path_to_rbenv}` }
  sloth.dsm(:tail)       { `cd #{path_to_rbenv} ; git pull` }
  sloth.call

  path_to_rbinstall = File.join(ENV["HOME"], ".rbenv", "plugins", "ruby-build")
  clone_urli        = "https://github.com/rbenv/ruby-build.git"

  slothi = Sloth.new
  slothi.dsm(:first_run?) { !File.exist?(path_to_rbinstall) }
  slothi.dsm(:first)      { `git clone #{clone_urli} #{path_to_rbinstall}` }
  slothi.dsm(:tail)       { `cd #{path_to_rbinstall} ; git pull` }
  slothi.call
end

require "strscan"

if __FILE__ == $0
  require "minitest/autorun"

  $home = ENV["HOME"].dup.freeze
  $pwd  = Dir.pwd.dup.freeze
end

# Things that need to be done.
#
# - Normal links
# - Weird links
# - Commands
#   - Install
#   - Update
# - Library files


# _  eq hidden link
# =  eq shown link
# -  eq hidden file/folder
# +  eq shown file/folder
#
# ex.   .vim/init
#       -vim/=init
# ex.   .vim/autoload/plug.vim
#       +vim/+autoload/=plug.vim
# ex.   .vimrc
#       _vimrc

class Tokenizer
  class PathToken
    attr_accessor :visibility, :type, :name

    def initialize(visibility, type, name = nil)
      @visibility = visibility
      @type       = type
      @name       = name
    end

    def to_a
      [visibility, type, name]
    end

    def show?
      @visibility == :show
    end

    def hide?
      @visibility == :hide
    end

    def link?
      @type == :link
    end

    def real?
      @type == :real
    end
  end

  def self.call(source_relpath)
    instance = new(source_relpath)
    instance.call
  end

  def initialize(source_relpath)
    @source_relpath = source_relpath
  end

  def call
    ss = StringScanner.new(@source_relpath)
    result = []

    until ss.eos?
      component = start_component(ss)
      component.name = get_name(ss)

      result.push(component)
    end

    result
  end

  private

  def start_component(ss)
    loop do
      type = ss.getch

      case type
      when "/" then next
      when "_" then return PathToken.new(:hide, :link)
      when "=" then return PathToken.new(:show, :link)
      when "-" then return PathToken.new(:hide, :real)
      when "+" then return PathToken.new(:show, :real)
      else     fail "bad path"
      end
    end
  end

  def get_name(ss)
    ss.scan(%r{[^/=\+]+})
  end
end

if __FILE__ == $0
  class TokenizerTest < Minitest::Test
    def test_vim_init_as_multiple_directories
      pp = Tokenizer.new("-vim/=init")
      r = pp.call

      assert_equal([:hide, :real, "vim"], r[0].to_a)
      assert_equal([:show, :link, "init"], r[1].to_a)
      assert_equal(2, r.length)
    end

    def test_vim_init_as_single_directory
      pp = Tokenizer.new("-vim=init")
      r = pp.call

      assert_equal([:hide, :real, "vim"], r[0].to_a)
      assert_equal([:show, :link, "init"], r[1].to_a)
      assert_equal(2, r.length)
    end

    def test_vimrc_bundles
      pp = Tokenizer.new("_vimrc_bundles")
      r = pp.call

      assert_equal([:hide, :link, "vimrc_bundles"], r[0].to_a)
      assert_equal(1, r.length)
    end
  end
end

class Parser
  def initialize(tokens)
    @tokens = tokens
  end

  def call
    already_link = false

    @tokens.each do |token|
      if already_link
        return false
      end

      if token.link?
        already_link = true
      end
    end

    true
  end
end

if __FILE__ == $0
  class ParserTest < Minitest::Test
    def test_valid
      tokens = [
        Tokenizer::PathToken.new(:hide, :real, "vim"),
        Tokenizer::PathToken.new(:show, :link, "init")
      ]

      result = Parser.new(tokens).call

      assert_equal(true, result)
    end

    def test_invalid_link_then_link
      tokens = [
        Tokenizer::PathToken.new(:hide, :link, "vim"),
        Tokenizer::PathToken.new(:show, :link, "init")
      ]

      result = Parser.new(tokens).call

      assert_equal(false, result)
    end

    def test_invalid_link_then_real
      tokens = [
        Tokenizer::PathToken.new(:hide, :link, "vim"),
        Tokenizer::PathToken.new(:show, :real, "init")
      ]

      result = Parser.new(tokens).call

      assert_equal(false, result)
    end
  end
end

# NOTE: The endpoint *must* be a link
# This might be changed later
class Weirdfile
  def self.all()
    fs_dotfiles = Dir.glob(glob_pattern)
    dotfiles = fs_dotfiles.map { |df| self.new(df) }

    if block_given?
      dotfiles.each(&Proc.new)
    else
      dotfiles.to_enum
    end
  end

  attr_reader :target, :link

  def initialize(source_relpath)
    @path_tokens = Tokenizer.call(source_relpath)

    @target = File.expand_path(source_relpath)
    @link   = compute_link_path(@path_tokens)
  end

  def create!
    built = HOME["ENV"]

    @path_tokens.each do |token|
      name =
        if token.hide?
          ".#{token.name}"
        else
          token.name
        end

      built = File.join(built, name)

      if token.link?
        File.symlink(@target, built)
      else
        Dir.mkdir(built)
      end
    end
  end

  def destroy!
  end

  private

  def compute_link_path(tokens)
    path_components =
      tokens.map do |token|
        if token.hide?
          ".#{token.name}"
        else
          token.name
        end
      end

    File.join(ENV["HOME"], *path_components)
  end
end

if __FILE__ == $0
  class WeirdfileTest < Minitest::Test
    def test_target_and_link_for_vim_init
      wf = Weirdfile.new("-vim/=init")
      assert_equal(File.join($pwd, "-vim/=init"), wf.target)
      assert_equal(File.join($home, ".vim/init"), wf.link)

      wf2 = Weirdfile.new("-vim=init")
      assert_equal(File.join($pwd, "-vim=init"), wf2.target)
      assert_equal(File.join($home, ".vim/init"), wf2.link)
    end

    def test_target_and_link_for_vimrc
      wf = Weirdfile.new("_vimrc")
      assert_equal(File.join($pwd, "_vimrc"), wf.target)
      assert_equal(File.join($home, ".vimrc"), wf.link)
    end
  end
end

class Dotfile
  def self.all(glob_pattern = "_*")
    fs_dotfiles = Dir.glob(glob_pattern)
    dotfiles = fs_dotfiles.map { |df| self.new(df) }

    if block_given?
      dotfiles.each(&Proc.new)
    else
      dotfiles.to_enum
    end
  end

  attr_reader :target, :link

  def initialize(target_basename)
    basename = target_basename.sub("_", ".")
    @target  = File.expand_path(target_basename)
    @link    = File.join(ENV["HOME"], basename)
  end

  def exists?
    File.exist?(@link)
  end

  def valid_link?
    File.symlink?(@link) && File.readlink(@link) == @target
  end

  def link!
    if !exists?
      File.symlink(@target, @link)
      true
    else
      false
    end
  end

  def unlink!
    if exists? && valid_link?
      File.delete(@link)
      true
    else
      false
    end
  end
end

if __FILE__ == $0
  class DotfileTest < Minitest::Test
    def test_class_all_method_returns_enumerator
      assert_kind_of(Enumerator, Dotfile.all)
    end

    def test_class_all_method_yields_dotfile_to_block
      Dotfile.all do |df|
        assert_kind_of(Dotfile, df)

        assert_equal(true, File.exist?(df.target))
        assert_includes(df.link, $home)
        assert_includes([true, false], df.valid_link?)
      end
    end
  end
end


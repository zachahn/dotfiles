if __FILE__ == $0
  require "minitest/autorun"

  $home = ENV["HOME"].dup.freeze
  $pwd  = Dir.pwd.dup.freeze
  $test = true
end

module Action
  def call
    if first_run?
      first
    else
      if respond_to?(:tail)
        tail
      end
    end

    if respond_to?(:always)
      always
    end
  end
end

class Sloth
  include Action

  def dsm(name, &block)
    define_singleton_method(name, &block)
  end
end

if $test
  class ActionTest < Minitest::Test
    def test_call_first
      x = Object.new
      x.singleton_class.include(Action)
      x.define_singleton_method(:first_run?, -> { true })
      x.define_singleton_method(:first, -> {})

      x.call
    end

    def test_call_tail
      x = Object.new
      x.singleton_class.include(Action)
      x.define_singleton_method(:first_run?, -> { false })
      x.define_singleton_method(:tail, -> {})

      x.call
    end

    def test_call_always
      always_called = false
      x = Object.new
      x.singleton_class.include(Action)
      x.define_singleton_method(:first_run?, -> { false })
      x.define_singleton_method(:tail, -> {})
      x.define_singleton_method(:always, -> { always_called = true})

      x.call

      assert_equal true, always_called
    end
  end
end

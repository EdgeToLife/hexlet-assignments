# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def test_add_element_to_stack
    @stack.push! 'ruby'
    @stack.push! 'php'
    @stack.push! 'java'

    actual = @stack.to_a
    expected = ['ruby', 'php', 'java']

    assert { actual == expected }
  end

  def test_delete_element_from_stack
    @stack.push! 'ruby'
    @stack.push! 'php'
    @stack.push! 'java'
    @stack.pop!

    actual = @stack.to_a
    expected = ['ruby', 'php']

    assert { actual == expected }
  end

  def test_if_stack_is_clean
    @stack.push! 'ruby'
    @stack.push! 'php'
    @stack.push! 'java'
    @stack.clear!

    actual = @stack.to_a
    expected = []

    assert { actual == expected }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?

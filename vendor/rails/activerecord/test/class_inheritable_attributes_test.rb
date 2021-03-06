#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test/unit'
require 'abstract_unit'
require 'active_support/core_ext/class/inheritable_attributes'

class A
  include ClassInheritableAttributes
end

class B < A
  write_inheritable_array "first", [ :one, :two ]
end

class C < A
  write_inheritable_array "first", [ :three ]
end

class D < B
  write_inheritable_array "first", [ :four ]
end


class ClassInheritableAttributesTest < Test::Unit::TestCase
  def test_first_level
    assert_equal [ :one, :two ], B.read_inheritable_attribute("first")
    assert_equal [ :three ], C.read_inheritable_attribute("first")
  end
  
  def test_second_level
    assert_equal [ :one, :two, :four ], D.read_inheritable_attribute("first")
    assert_equal [ :one, :two ], B.read_inheritable_attribute("first")
  end
end

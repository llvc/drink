#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveRecord
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 14
    TINY  = 2

    STRING = [MAJOR, MINOR, TINY].join('.')
  end
end

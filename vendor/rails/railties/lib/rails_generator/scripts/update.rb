#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../scripts'

module Rails::Generator::Scripts
  class Update < Base
    mandatory_options :command => :update

    protected
      def banner
        "Usage: #{$0} [options] scaffold"
      end
  end
end

#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Date #:nodoc:
      # Getting dates in different convenient string representations and other objects
      module Conversions
        DATE_FORMATS = {
          :short => "%e %b",
          :long  => "%B %e, %Y"
        }
        
        def self.included(klass) #:nodoc:
          klass.send(:alias_method, :to_default_s, :to_s)
          klass.send(:alias_method, :to_s, :to_formatted_s)
        end
        
        def to_formatted_s(format = :default)
          DATE_FORMATS[format] ? strftime(DATE_FORMATS[format]).strip : to_default_s   
        end

        # To be able to keep Dates and Times interchangeable on conversions
        def to_date
          self
        end

        def to_time(form = :local)
          ::Time.send(form, year, month, day)
        end
        
        alias :xmlschema :to_s
      end
    end
  end
end
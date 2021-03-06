#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionView
  module Helpers
    # Capture lets you extract parts of code into instance variables which
    # can be used in other points of the template or even layout file.
    #
    # == Capturing a block into an instance variable
    #
    #   <% @script = capture do %>
    #     [some html...]
    #   <% end %>
    #  
    #
    # == Add javascript to header using content_for
    #
    # content_for("name") is a wrapper for capture which will store the 
    # fragment in a instance variable similar to @content_for_layout.
    #
    # layout.rhtml:
    #
    #   <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    #   <head>
    #	    <title>layout with js</title>
    #	    <script type="text/javascript">
    #	    <%= @content_for_script %>
    #   	</script>
    #   </head>
    #   <body>
    #     <%= @content_for_layout %>
    #   </body>
    #   </html>
    #
    # view.rhtml
    #   
    #   This page shows an alert box!
    #
    #   <% content_for("script") do %>
    #     alert('hello world')
    #   <% end %>
    #
    #   Normal view text
    module CaptureHelper
      # Capture allows you to extract a part of the template into an 
      # instance variable. You can use this instance variable anywhere
      # in your templates and even in your layout. 
      # 
      # Example of capture being used in a .rhtml page:
      # 
      #   <% @greeting = capture do %>
      #     Welcome To my shiny new web page!
      #   <% end %>
      #
      # Example of capture being used in a .rxml page:
      # 
      #   @greeting = capture do
      #     'Welcome To my shiny new web page!'
      #   end
      def capture(*args, &block)
        # execute the block
        begin
          buffer = eval("_erbout", block.binding)
        rescue
          buffer = nil
        end
        
        if buffer.nil?
          capture_block(*args, &block)
        else
          capture_erb_with_buffer(buffer, *args, &block)
        end
      end
      
      # Content_for will store the given block
      # in an instance variable for later use in another template
      # or in the layout. 
      # 
      # The name of the instance variable is content_for_<name> 
      # to stay consistent with @content_for_layout which is used 
      # by ActionView's layouts
      # 
      # Example:
      # 
      #   <% content_for("header") do %>
      #     alert('hello world')
      #   <% end %>
      #
      # You can use @content_for_header anywhere in your templates.
      #
      # NOTE: Beware that content_for is ignored in caches. So you shouldn't use it
      # for elements that are going to be fragment cached. 
      def content_for(name, &block)
        eval "@content_for_#{name} = (@content_for_#{name} || '') + capture(&block)"
      end

      private
        def capture_block(*args, &block)
          block.call(*args)
        end
      
        def capture_erb(*args, &block)
          buffer = eval("_erbout", block.binding)
          capture_erb_with_buffer(buffer, *args, &block)
        end
      
        def capture_erb_with_buffer(buffer, *args, &block)
          pos = buffer.length
          block.call(*args)
        
          # extract the block 
          data = buffer[pos..-1]
        
          # replace it in the original with empty string
          buffer[pos..-1] = ''
        
          data
        end
      
        def erb_content_for(name, &block)
          eval "@content_for_#{name} = (@content_for_#{name} || '') + capture_erb(&block)"
        end
      
        def block_content_for(name, &block)
          eval "@content_for_#{name} = (@content_for_#{name} || '') + capture_block(&block)"
        end
    end
  end
end

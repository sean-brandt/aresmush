module AresMUSH
  module Bbs
    module RendererFactory
      def self.board_list_renderer=(renderer)
        @@board_list_renderer = renderer
      end
    
      def self.board_list_renderer
        @@board_list_renderer
      end
    
      def self.board_renderer=(renderer)
        @@board_renderer = renderer
      end
    
      def self.board_renderer
        @@board_renderer
      end
    
      def self.build_renderers
        self.board_list_renderer = BoardListRenderer.new
        self.board_renderer = BoardRenderer.new
      end
    end
  end
end
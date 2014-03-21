module AresMUSH
  module Help
    
    class HelpListCmd
      include AresMUSH::Plugin
      attr_accessor :category
      
      no_switches
      argument_must_be_present "category", "help"
      
      def want_command?(client, cmd)
        Help.valid_commands.include?(cmd.root) && cmd.args.nil?
      end

      def crack!
        self.category = Help.category_for_command(cmd.root)
      end
      
      # TODO - Validate permissions
      
      def handle
        toc = Help.category_toc(self.category)
        text = ""
        toc.sort.each do |toc_key|
          text << "%r%xg#{toc_key.titleize}%xn"
          entries = Help.topics_for_toc(self.category, toc_key).sort
          entries.each do |entry_key|
            entry = Help.topic(self.category, entry_key)
            text << "%r     %xh#{entry_key.titleize}%xn - #{entry["summary"]}"
          end
        end
        text << "%r"
        categories = Help.categories.select { |c| c != self.category }
        
        if (!categories.empty?)
          text << "%l2%r"
          text << "%xh#{t('help.other_help_libraries')}%xn"
          
          categories.keys.each do |category|
            text << " \[#{categories[category]['command']}\] #{categories[category]['title']}"
          end
        end
        title = t('help.toc', :category => Help.category_title(self.category))
        client.emit BorderedDisplay.text(text, title, false)
      end
    end
  end
end
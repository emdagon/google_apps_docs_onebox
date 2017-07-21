
Onebox = Onebox

module Onebox
  module Engine
    class GoogleAppsDocsOnebox

      include Engine

      def self.supported_endpoints
        %w(spreadsheets document forms presentation)
      end

      matches_regexp /^(https?:)?\/\/(docs\.google\.com)\/(?<endpoint>(#{supported_endpoints.join('|')}))\/d\/((?<key>[\w-]*)).+$/

      def data
        result = { 
                   title: "Google #{shorttype.to_s.capitalize}",
                   description: "This #{shorttype.to_s.chop.capitalize} is private",
                   type: shorttype
                 }
        if document?
          result[:link] = "https://docs.google.com/document/d/#{key}/pub?embedded=true"
        elsif spreadsheet?
          result[:link] = "https://docs.google.com/spreadsheet/ccc?key=#{key}&usp=sharing&rm=minimal"
        elsif presentation?
          result[:link] = "https://docs.google.com/presentation/d/#{key}/embed?start=false&loop=false&delayms=3000"
        elsif forms?
          result[:link] = "https://docs.google.com/forms/d/#{key}/viewform?embedded=true"
        end
        result
      end

      def self.short_types
        @shorttypes ||= {
          spreadsheets: :sheets,
          document: :docs,
          presentation: :slides,
          forms: :forms,
        }
      end
      
      def doc_type
        @doc_type ||= match[:endpoint].to_sym
      end

      def shorttype
        GoogleDocsOnebox.short_types[doc_type]
      end

      def key
        match[:key]
      end

      def match
        @match ||= @url.match(@@matcher)
      end
    end
  end
end

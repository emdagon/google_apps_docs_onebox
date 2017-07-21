# name: google_apps_docs_onebox
# about: Google docs Onebox for embding *private* spreadsheets, forms, documents and presentations.
# version: 0.1
# authors: Naveed Ahmad, Emilio González

Onebox = Onebox

module Onebox
  module Engine
    class GoogleAppsDocsOnebox

      include Engine

      def self.supported_endpoints
        %w(spreadsheets document forms presentation)
      end

      # matches_regexp /^(https?:)?\/\/(docs\.google\.com)\/(?<endpoint>(#{supported_endpoints.join('|')}))\/d\/((?<key>[\w-]*)).+$/
      matches_regexp /^\[embed\-(?<endpoint>(xx|yy))\=(?<key>[\w-]*)\]$/
      
      def data
        result = { 
                   title: "Google #{shorttype.to_s.capitalize}",
                   description: "This #{shorttype.to_s.chop.capitalize} is private",
                   type: shorttype
                 }
        if document?
          result[:html] = "<iframe class='gdocs-onebox document?-onebox' src='https://docs.google.com/document/d/#{key}/pub?embedded=true' style='border: 0' width='800' height='600' frameborder='0' scrolling='yes' ></iframe>"
        elsif spreadsheet?
          result[:html] = "<iframe class='gdocs-onebox spreadsheet-onebox' src='https://docs.google.com/spreadsheet/ccc?key=#{key}&usp=sharing&rm=minimal' style='border: 0' width='800' height='600' frameborder='0' scrolling='yes' ></iframe>"
        elsif presentation?
           result[:html] = "<iframe class='gdocs-onebox presentation-onebox' src='https://docs.google.com/presentation/d/#{key}/embed?start=false&loop=false&delayms=3000' frameborder='0' width='960' height='749' allowfullscreen='true' mozallowfullscreen='true' webkitallowfullscreen='true'></iframe>"
        elsif forms?
          result[:html] = "<iframe class='gdocs-onebox forms-onebox' src='https://docs.google.com/forms/d/#{key}/viewform?embedded=true' width='760' height='500' frameborder='0' marginheight='0' marginwidth='0' scrolling='yes'>Loading...</iframe>"
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
        GoogleAppsDocsOnebox.short_types[doc_type]
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

module Pageflow
  module Panorama
    module Validation
      class KrPano < Struct.new(:entries)
        def parse
          find_tiles_directory!

          Result.new(find_index_document!,
                     find_thumbnail!)
        end

        private

        def find_tiles_directory!
          find_file!('*.tiles/**/*', :missing_tiles_directory)
        end

        def find_index_document!
          find_file!('*.html', :missing_index_document)
        end

        def find_thumbnail!
          find_file!('**/mobile_f.jpg', :missing_preview)
        end

        def find_file!(glob, message_i18n_key)
          entries.map(&:name).find do |name|
            File.fnmatch(glob, name)
          end || raise(Error.new("pageflow.panorama.validation.#{message_i18n_key}"))
        end
      end
    end
  end
end

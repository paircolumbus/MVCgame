#needs to get data from dictionary file (let's call it translation_dict.json)'

#define here methods for:
#retrieving entry data for viewing
#adding new entries
#updating entries
#deleting entries
#saving current translation dictionary to file

require 'json'

module TranslatorModel
  module Schema
    WORDS_REGEX = /\w+[a-z']*/
    class << self
      def import_translation_schema source = 'schema.json'
        JSON.parse(File.new(source).read)
      end

      def export_translation_schema(translation_dict, target = 'schema.json')
        File.open(target, "w") do |f|
          f.write(JSON.dump(translation_dict))
        end
      end

      def update_entry(target_dict, original, translated)
        target_dict[original] = translated
      end

      def destroy_entry(target_dict, entry_key)
        target_dict.delete entry_key
      end
    end
  end
end
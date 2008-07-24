namespace :tosca do
  namespace :extensions do
    namespace :colored_text_files do

      desc "Runs the migration of the Colored Text Files extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ColoredTextFilesExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ColoredTextFilesExtension.migrator.migrate
        end
      end

      desc "Copies public assets of the Colored Text Files to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[ColoredTextFilesExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(ColoredTextFilesExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end
    end
  end
end

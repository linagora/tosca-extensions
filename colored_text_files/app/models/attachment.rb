class Attachment < ActiveRecord::Base
  file_column :file, :fix_file_extensions => nil,
    :uv => { :theme => "active4d" },
    :magick => {
      :versions => {
        :fit_size => { :size => "800x600>" }
      }
    }

end

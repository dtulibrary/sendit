ActiveAdmin.register Template do
  menu :priority => 1

  form do |f|
    f.inputs do
      f.input :code
      f.input :template_type, :include_blank => false
      f.input :template_format, :include_blank => false
      f.input :template_locale, :include_blank => false
      f.input :body
      f.input :valid_from, :as => :just_datetime_picker
      f.input :valid_until, :as => :just_datetime_picker
    end

    f.actions
  end

end

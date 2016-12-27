class CustomerFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, to: :@template

  %w( text_field password_field text_area url_field file_field collection_select select ).each do |method_name|
    define_method(method_name) do |method, *tag_value|
      content_tag(:div, class: 'form-group') do
        label(method, class: 'col-sm-3 control-label') +
          content_tag(:div, class: 'col-sm-9') do
            super(method, *tag_value)
          end
      end
    end
  end
end
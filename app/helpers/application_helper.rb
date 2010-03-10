# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def delete_child_option(form)
    unless form.object.new_record?
      form.check_box("_delete") + form.label("_delete", "Delete")
    end
  end
end

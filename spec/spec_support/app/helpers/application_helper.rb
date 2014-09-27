module ApplicationHelper
  def object_action_links(object)
    object_name = object.class.name.underscore
    [
        link_to(I18n.t('helpers.links.show'), object, :class => 'btn btn-mini'),
        link_to(I18n.t('helpers.links.edit'), send("edit_#{object_name}_path", object), :class => 'btn btn-mini btn-inverse'),
        link_to(I18n.t('helpers.links.destroy'), object, 'data-method' => 'delete', 'data-confirm' => I18n.t("#{object_name}.confirm_destroy"), :class => 'btn btn-mini btn-danger')
    ].join(' ')
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def load_resource
    object_name = self.class.name.sub('Controller', '').underscore.singularize

    begin
      instance_variable_set "@#{object_name}", object_name.classify.constantize.find(params[:id])
    rescue
      redirect_to send("#{object_name.pluralize}_path"), :flash => { :error => t("#{object_name}.notifications.does_not_exist") }
    end
  end
end

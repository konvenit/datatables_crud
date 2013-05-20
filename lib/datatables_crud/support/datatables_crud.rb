module DatatablesCRUD
  module Controller
    def crud_actions(actions)
      actions = [:index, :show, :new, :create, :edit, :update, :destroy] if actions == :all
      before_filter :load_resource, :only => [:show, :edit, :update, :destroy].select { |action| actions.include?(action) }
      actions.each { |action| send("define_#{action}") }

      if actions.present?
        prepend_view_path(File.dirname(__FILE__) + "/../views")
      end
    end

    def define_index
      define_method(:index) do
        @model_class = controller_name.singularize.classify.constantize
        unauthorized! if cannot? :read, @model_class

        respond_to do |format|
          format.html
          format.json do
            @datatable = self.class.name.sub('Controller', 'Datatable').constantize.new(view_context)
            render :json => @datatable
          end
        end
      end
    end

    def define_show
    end

    def define_new
      define_method(:new) do
        unauthorized! if cannot? :create, controller_name.singularize.classify.constantize

        object_name = controller_name.singularize
        instance_variable_set("@#{object_name}", object_name.classify.constantize.new)
      end
    end

    def define_create
      define_method(:create) do
        unauthorized! if cannot? :create, controller_name.singularize.classify.constantize

        object_name = controller_name.singularize
        object = object_name.classify.constantize.new(params[object_name.to_sym])
        instance_variable_set "@#{object_name}", object

        if object.save
          redirect_to send("#{object_name.pluralize}_path"), :notice => t("#{object_name}.notifications.created")
        else
          render :new
        end
      end
    end

    def define_edit
    end

    def define_update
      define_method(:update) do
        object_name = controller_name.singularize
        object = instance_variable_get("@#{object_name}")

        unauthorized! if cannot? :update, object

        if object.update_attributes params[object_name.to_sym]
          redirect_to send("#{object_name.pluralize}_path"), :notice => t("#{object_name}.notifications.updated")
        else
          render :edit
        end
      end
    end

    def define_destroy
      define_method(:destroy) do
        object_name = controller_name.singularize
        object = instance_variable_get("@#{object_name}")
        unauthorized! if cannot? :destroy, object

        if object.destroy
          flash[:notice] = t("#{object_name}.notifications.destroyed")
        else
          flash[:error] = t("#{object_name}.notifications.could_not_destroy")
        end

        redirect_to send("#{object_name.pluralize}_path")
      end
    end
  end
end

DatatablesCRUDApp::Application.routes.draw do
  match '/:controller(/:action(/:id))'
end

module API
  module V1
    class Menus < Grape::API
      include API::V1::Defaults

      resource :menus do
        desc "Return all Menus"
        get "", root: :menus do
          Menu.all
        end

        desc "Return a menu"
        params do
          requires :id, type: String, desc: "ID of the
            menu"
        end
        get ":id", root: "menu" do
          Menu.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end

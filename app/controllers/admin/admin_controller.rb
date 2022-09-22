module Api::V1
  module Admin
    class Admin::AdminController < ApplicationController
      include Admin::PaymentsHelper
      include Admin::UsersHelper
      before_action :is_admin?
      layout "admin/layouts/application"

      private
      def is_admin?
        return if current_user.admin?

        redirect_to root_path
      end
    end
  end
end

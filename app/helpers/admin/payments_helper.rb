module Admin::PaymentsHelper
  def status_order status
    case status
    when :active
      content_tag(:th, "Accept", class: "table-info")
    when :inactive
      content_tag(:th, "Pending", class: "table-warning")
    end
  end

  def check_expired payment
    Payment.check_expire(payment.id, payment.created_at).present?
  end

  def select_status payment
    if check_expired payment
      content_tag(:p, "Pending", class: "text-warning")
    else
      link_to_delete payment
    end
  end

  def link_to_delete payment
    link_to "Cancel", admin_payment_path(payment),
            method: :delete, class: "btn btn-danger remove_fields"
  end
end

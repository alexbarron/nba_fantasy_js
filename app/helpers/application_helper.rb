module ApplicationHelper

  def permitted_links(model)
    if permitted?(model)
      simple_format(link_to("Edit #{model.name}", edit_polymorphic_path(model), class: "btn btn-primary")) + 
      simple_format(link_to("Delete #{model.name}", polymorphic_path(model), method: :delete, data: {confirm: "Are you sure?"}, class: "btn btn-danger"))
    end
  end

  def permitted?(model)
    if model.class.name == "Player"
      admin_check?
    else
      admin_check? || current_user == model.user
    end
  end

  def admin_check?
    !!current_user && current_user.admin?
  end

end

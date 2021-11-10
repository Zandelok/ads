ActiveAdmin.register Post do
  permit_params :title, :text, :image_url, :user_id, :category_id, :state, :comment

  action_item :view, only: %i[show approve_post decline_post change_mind] do
    case post.state
    when 'submitted'
      (link_to 'Approve', approve_post_path) + ' ' +
      (link_to 'Decline', decline_post_path)
    when 'approved'
      link_to 'Undo decision', change_mind_path
    when 'declined'
      link_to 'Undo decision', change_mind_path
    end
  end
end

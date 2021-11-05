ActiveAdmin.register Post do
  permit_params :title, :text, :image_url, :user_id, :category_id, :state

  action_item :view, only: %i[show approve_post decline_post] do
    unless post.state != 'submitted'
      (link_to 'Approve', approve_post_path) + " " +
      (link_to 'Decline', decline_post_path)
    end
  end
end

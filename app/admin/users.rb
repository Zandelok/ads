ActiveAdmin.register User do
  permit_params :name, :surname, :email, :description
end

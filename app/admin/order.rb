ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :rider_id, :order_id, :location_to, :location_from, :status, :price, :description

  form do |f|
    inputs 'Details' do
      input :rider_id
      input :order_id
      input :location_to
      input :location_from
      input :status
      input :price
      input :description
    end
    actions
  end
end

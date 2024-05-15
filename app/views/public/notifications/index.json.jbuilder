json.data do
  json.notifications do
    json.array!(@notifications) do |notification|

      json.id notification.id

    end
  end
end
json.array!(@person_in_charges) do |person_in_charge|
  json.extract! person_in_charge, :id, :user_id, :name
  json.url person_in_charge_url(person_in_charge, format: :json)
end

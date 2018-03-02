module User::Twin
  class Create < Disposable::Twin
    include Disposable::Twin::Property::Hash

    property :content, field: :hash do
      property :firstname
      property :lastname
      property :email
      property :address1
      property :address2
      property :city
      property :postcode
      property :state
      property :country
      property :abn

      property :created_at
      property :updated_at
    end

    property :id, writeable: false


    unnest :firstname, from: :content
    unnest :lastname, from: :content
    unnest :email, from: :content
    unnest :address1, from: :content
    unnest :address2, from: :content
    unnest :city, from: :content
    unnest :postcode, from: :content
    unnest :state, from: :content
    unnest :country, from: :content
    unnest :abn, from: :content

    unnest :created_at, from: :content
    unnest :updated_at, from: :content

    def fullname
      [firstname, lastname].join(' ')
    end

    def full_address
      [address1, address2, city, postcode, state, country].join(' ')
    end

    include Disposable::Twin::Sync
    include Disposable::Twin::Save
  end
end

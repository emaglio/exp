module User::Form
  class Create < Reform::Form
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

    validation :default, with: { form: true } do
      configure do
        config.messages_file = 'config/error_messages.yml'

        def unique_user?
          return true if current_user?(form)

          content = Sequel.pg_jsonb_op(:content)
          User::Row.where(
            content.get_text('firstname') => form.firstname,
            content.get_text('lastname') => form.lastname,
            content.get_text('email') => form.email,
          ).count.zero?
        end

        def email?
          ! /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match(form.email).nil?
        end

      private
        def current_user?(form)
          [
            form&.model&.firstname == form.firstname,
            form&.model&.lastname == form.lastname,
            form&.model&.email == form.email
          ].all?
        end
      end

      required(:firstname).filled(:unique_user?)
      required(:lastname).filled(:unique_user?)
      required(:address2).filled
      required(:city).filled
      required(:postcode).filled
      required(:country).filled
      required(:abn).filled
      required(:email).filled(:email?, :unique_user?)
    end
  end
end

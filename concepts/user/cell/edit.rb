require_relative "new"

module User::Cell
  class Edit < New
    def post_url
      "/users/#{model.model.id}"
    end

    def show # TODO: can we do this declaratively?
      render :new
    end

    def heading
      "Edit user"
    end
  end
end

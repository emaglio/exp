module User::Cell
  class New < Trailblazer::Cell
    include Cell::Erb

    def post_url
      "/users"
    end

    def heading
      "Create user"
    end
  end
end

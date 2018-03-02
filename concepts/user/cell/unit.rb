module User::Cell
  class Unit < Trailblazer::Cell
    include Cell::Erb

    def user
      User::Twin::Create.new(model)
    end

    def show_link
      %{<a href="/users/#{user.id}" class="btn btn-info" role="button">Show</a>}
    end
  end
end

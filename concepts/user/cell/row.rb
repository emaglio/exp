module User::Cell
  class Row < Trailblazer::Cell
    include Cell::Erb

    def user
      User::Twin::Create.new(model)
    end

    def edit_link
      %{<a href="/users/edit/#{user.id}" class="btn btn-info" role="button">Edit</a>}
    end

    def delete_link
      %{<a href="/users/delete/#{user.id}" class="btn btn-danger" role="button">Delete</a>}
    end
  end
end

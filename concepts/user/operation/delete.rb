module User
  class Delete < Trailblazer::Operation
    step Model(Row, :[])
    step :delete!

    def delete!(ctx, model:, **)
      model.delete
    end
  end
end

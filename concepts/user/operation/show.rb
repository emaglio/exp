module User
  class Show < Trailblazer::Operation
    step Model(Row, :[])
  end
end

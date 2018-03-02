module User
  class Index < Trailblazer::Operation
    step :model!

    def model!(options, *)
      options[:model] = User::Row.all
    end
  end
end

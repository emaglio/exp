module User
  class Update < Trailblazer::Operation
    class Present < Create::Present
      step Model( Row, :[]), override: true
      step Contract::Build( constant: Form::Update ), override: true
    end

    step Nested( Present )
    step Contract::Validate()
    step Exp::Step::UpdatedAt
    step Contract::Persist()
  end
end

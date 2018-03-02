module Endpoint
  module HTML
    def self.call(operation, options, cell, hint, &block)
      result = operation.( params: options ) # this should happen in the endpoint gem.

      if result.success? && block_given? # first pattern
        yield_block(result, &block)
      elsif result.success? && hint == :new # next matcher
        render(cell, result)
      elsif result.success? && hint == :edit # next matcher
        render(cell, result)
      elsif result.failure? && hint == :create # next matcher
        render(cell, result) # same resolve
      elsif result.failure? && hint == :update # next matcher
        render(cell, result) # same resolve
      elsif result.failure? && hint == :delete # next matcher
        render(cell, result) # same resolve
      elsif result.success? && hint == :show # next matcher
        render_model(cell, result) # same resolve
      end
    end

    # @resolve action
    def self.yield_block(result, &block)
      yield(result)
    end
    # @resolve action
    def self.render(cell, result)
      cell.( result["contract.default"], layout: Bootstrap::Cell::Layout ).()
    end

    def self.render_model(cell, result)
      cell.( result[:model], layout: Bootstrap::Cell::Layout ).()
    end
  end
end

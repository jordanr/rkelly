require 'rkelly/runtime/scope'
require 'rkelly/runtime/scope_chain'

module RKelly
  class Runtime
    def initialize
      @parser = Parser.new
      @scope  = ScopeChain.new
    end

    # Execute +js+
    def execute(js)
      function_visitor  = Visitors::FunctionVisitor.new(@scope)
      var_visitor       = Visitors::VariableVisitor.new(@scope)
      tree = @parser.parse(js)
      function_visitor.accept(tree)
      var_visitor.accept(tree)
      @scope
    end

    def define_function(function, &block)
      @scope[function.to_s].value = block
    end
  end
end
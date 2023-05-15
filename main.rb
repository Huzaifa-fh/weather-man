#main method
def main
  require_relative "weatherman_tools"
  include Weatherman_Tools
  arg_validation = Weatherman_Tools::arg_validator

  unless arg_validation
    return false
  end

  Weatherman_Tools::func_caller

end

main

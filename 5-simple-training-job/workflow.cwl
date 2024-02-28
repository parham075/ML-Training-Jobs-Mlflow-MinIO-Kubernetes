cwlVersion: v1.2
class: Workflow

inputs:
  n_estimators: int
  max_depth: int
  random_state: int
  #script : File
steps:
  # install_dependencies:
  #   run: req.cwl
  #   in:
  #     n_es: n_es
  #     lr: lr
  #     alpha: alpha
  #   out: []
  
  run_srcipt:
    run: script.cwl
    in:
      n_estimators: n_estimators
      max_depth: max_depth
      random_state: random_state
    out: [importance_file]
outputs:
  - id: importance_file
    type: File
    outputSource: [run_srcipt/importance_file]

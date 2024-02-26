cwlVersion: v1.0
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.0.0
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: main
    label: Training a randomforest calssifier
    doc: Training a randomforest calssifier on callifornia data and track it using mlflow
    requirements:
      - class: ScatterFeatureRequirement
    inputs:
      n_estimators:
        label: number of estimator
        doc: number of estimator
        type: int
      max_depth:
        label: max_depth
        doc: max_depth
        type: int
        default: 10
      random_state:
        label: random_state
        doc: random_state to avoid overfitting
        type: int
        default: 100

    outputs:
      - id: Feature Importance
        outputSource:
          - Training/feature_importances
        type: File
    steps:
      Training:
        run: "#train"
        in:
          n_estimators: n_estimators
          max_depth: max_depth
          random_state: random_state
        out:
          - feature_importances
      # Checking:
      #   run: "#check"
      #   in: []
      #   out: []
  - class: CommandLineTool
    id: train
    requirements:
      InlineJavascriptRequirement: {}
      EnvVarRequirement:
        envDef:
          PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
          PYTHONPATH: /calrissian
      ResourceRequirement:
        coresMax: 1
        ramMax: 512
    hints:
      DockerRequirement:
        dockerPull: docker.io/pippo/training-container:0.1
    baseCommand: ["python", "-m", "app"]
    arguments: []
    inputs:
      n_estimators:
        type: int
        inputBinding:
          prefix: --n_estimators
      max_depth:
        type: int
        inputBinding:
          prefix: --max_depth
      random_state:
        type: int
        inputBinding:
          prefix: --random_state
      
    outputs:
      feature_importances:
        outputBinding:
          glob: 'importance.csv'
          location: '/calrissian/output-data/'
        type: File
        
  # - class: CommandLineTool
  #     id: check
  #     requirements:
  #       InlineJavascriptRequirement: {}
  #       EnvVarRequirement:
  #         envDef:
  #           PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
  #           PYTHONPATH: /calrissian/out
  #       ResourceRequirement:
  #         coresMax: 1
  #         ramMax: 512
  #     hints:
  #       DockerRequirement:
  #         dockerPull: docker.io/pippo/training-container:0.1
  #     baseCommand: ["ls", "/calrissian/output-data"]
  #     arguments: []
  #     inputs: []
  #     outputs: []
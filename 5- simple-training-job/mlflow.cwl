cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["sh", "mlflow.sh"]
inputs: []
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: mlflow.sh
        entry: |-
          pip install scikit-learn
          pip install mlflow
          sudo fuser -k 5000/tcp
          mlflow ui

outputs: []
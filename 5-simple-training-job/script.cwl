cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["python", "script.py"]
inputs:
  n_estimators: int
  max_depth: int
  random_state: int
outputs:
  importance_file:
    outputBinding:
      glob: 'importance.csv'
    type: File
      
requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: script.py
        entry: |-
          import pandas as pd
          from sklearn.datasets import fetch_california_housing
          from sklearn.model_selection import train_test_split
          from sklearn.ensemble import RandomForestRegressor
          from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
          import matplotlib.pyplot as plt
          import mlflow
          import mlflow.sklearn

          # Load California Housing dataset
          california = fetch_california_housing()
          X = pd.DataFrame(california.data, columns=california.feature_names)
          y = california.target
          mlflow.set_tracking_uri('http://127.0.0.1:5000/')
          # Split the dataset
          X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

          # MLflow logging function
          def log_rf(run_name, params, X_train, X_test, y_train, y_test):
              with mlflow.start_run(run_name=run_name) as run:
                  # Create and train model
                  rf = RandomForestRegressor(**params)
                  rf.fit(X_train, y_train)
                  predictions = rf.predict(X_test)

                  # Log model
                  mlflow.sklearn.log_model(rf, "random_forest_model")

                  # Log parameters
                  mlflow.log_params(params)

                  # Log metrics
                  mlflow.log_metrics({
                      "mse": mean_squared_error(y_test, predictions),
                      "mae": mean_absolute_error(y_test, predictions),
                      "r2": r2_score(y_test, predictions)
                  })

                  # Log feature importance
                  importance = pd.DataFrame(list(zip(X_train.columns, rf.feature_importances_)),
                                            columns=["Feature", "Importance"]).sort_values("Importance", ascending=False)
                  importance_path = "importance.csv"
                  importance.to_csv(importance_path, index=False)
                  mlflow.log_artifact(importance_path, "feature-importance")

                  # Log plot
                  fig, ax = plt.subplots()
                  importance.plot.bar(ax=ax)
                  plt.title("Feature Importances")
                  mlflow.log_figure(fig, "feature_importances.png")

                  return run.info.run_id

          # Example parameters
          params = {
              "n_estimators": $(inputs.n_estimators),
              "max_depth": $(inputs.max_depth),
              "random_state": $(inputs.random_state)
          }

          # Log the experiment
          run_id = log_rf("California Housing RF Model", params, X_train, X_test, y_train, y_test)
          print(f"Run ID: {run_id}")

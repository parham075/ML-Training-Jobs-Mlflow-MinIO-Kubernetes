# Simple water body job without mlflow using cwltool

To to detect water-body and track it using Mlflow in your localhost. This job is developed based on this [Tutorial](https://eoap.github.io/mastering-app-package/app-package/ogc-context/) with subtele changes(tracking the job with mlflow). To excute this job please follow steps bellow:


0) Go to [Containers](Containers) and follow REAME.md files to build docker images for each sections.
- [crop](Containers/crop/README.md)
- [norm_diff](Containers/norm_diff/README.md)
- [otsu](Containers/otsu/README.md)
- [stac](Containers/stac/README.md)

1) You can execute the results by executing this command:
    ```
    cwltool workflow.cwl params.yaml
    ```

2) You can find an example of results in [check-result.log](outputs/check-results.log)


3) After checking the results you may want to remove your resources.
    ```python
    kubectl delete ns "$NAMESPACE_NAME"
    ```

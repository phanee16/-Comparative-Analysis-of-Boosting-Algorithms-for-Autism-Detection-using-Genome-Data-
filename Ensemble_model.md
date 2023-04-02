# Ensemble_Model
![image](https://user-images.githubusercontent.com/47351536/229376434-8fd6d544-954d-430e-a8ea-9d3a552f5b73.png)

This project aims to detect autism using an Ensemble Model, which combines different predictors to improve accuracy. The model uses the Random Forest algorithm to classify individuals as either having or not having autism based on a set of features.

The first step of the project involves loading the necessary data using the read.csv function, which reads in a CSV file containing composite data. The next step is to combine different predictors with network scores using the cbind function.

The training of the model is done using the randomForest function. The data is split into a training set and a testing set, and the model is trained on the training set. The trained model is then used to predict the outcomes of the testing set.

Finally, the predictions are combined with other features using the cbind function, and the results are written to a CSV file using the write.csv function. The resulting CSV file contains information about the probability of an individual having autism, as well as the different predictors used in the model.

This project is innovative and impactful because it uses an Ensemble Model to improve the accuracy of autism detection. The combination of different predictors helps to reduce the risk of misclassification and increases the sensitivity and specificity of the model. By using this approach, we can detect autism earlier and provide better care for individuals with the disorder.





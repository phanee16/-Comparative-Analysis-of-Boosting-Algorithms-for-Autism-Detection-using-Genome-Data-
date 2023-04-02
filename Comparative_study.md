# Gradient Boosting Machines
![image](https://user-images.githubusercontent.com/47351536/229376950-e11ffa83-9241-48e4-bab2-add04f8fffc3.png)


# AdaBoost
![image](https://user-images.githubusercontent.com/47351536/229377071-3483316a-7f37-4c4e-a8d9-fcdf89b71249.png)

# XGBoost
![image](https://user-images.githubusercontent.com/47351536/229377151-4bb11bf3-e904-4ff7-aca8-efd680cf4f06.png)

# About the comparative study we have done
The project uses an ensemble model to predict whether genes are positive or negative regulators of a specific biological function. The goal is to identify genes that play a crucial role in regulating biological functions, which can aid in the development of therapies for diseases.

The project uses four different models to predict gene regulation: random forest, gradient boosting machine (GBM), AdaBoost, and XGBoost. The models use various features such as gene expression, protein-protein interactions, and functional annotations to predict gene regulation.

The random forest model uses a decision tree algorithm to predict gene regulation. The model is trained on a subset of the data and tested on the remaining data. The model predicts whether genes are positive or negative regulators of the biological function, and the accuracy of the model is evaluated using error rate. The feature importance of the random forest model is also calculated, which helps in identifying the most important features for predicting gene regulation.

The GBM and AdaBoost models are both boosting algorithms that combine multiple weak models to create a strong model. The models use a loss function to evaluate the performance of the weak models and update the model parameters. The GBM model uses a Gaussian distribution, while the AdaBoost model uses the AdaBoost algorithm to create the strong model.

Finally, the XGBoost model is an optimized gradient boosting machine that uses a similar algorithm to the GBM model but with more advanced features. The XGBoost model uses parallel processing and tree pruning techniques to optimize performance and accuracy.

The project combines the predictions of all four models to create an ensemble model that has higher accuracy than any of the individual models. The final prediction is made based on a majority vote of the predictions of the four models. The ensemble model can be used to identify genes that are most likely to play a crucial role in regulating the biological function of interest.

In summary, the project uses an ensemble model that combines four different models to predict gene regulation. The models use various features such as gene expression and protein-protein interactions to predict gene regulation. The ensemble model has higher accuracy than any of the individual models and can be used to identify genes that play a crucial role in regulating biological functions.

### Project overview
This is our Capstone Project for Big Data and it is about a fictional music streaming company called Sparkify, similar to companies like Spotify and Pandora. In this project, we will go through how to manipulate a big dataset to engineer relevant features for predicting customer churn and build and evaluate machine learning models using Apache Spark’s PySpark API and PySpark ML Package.
The dataset (*'mini-sparkify-event-data.json'*) comes in the form of a JSON file that contains 286500 samples of event log data for October-December 2018 from Sparkify's platform. Each data entry involves the features: ts, userId, sessionId, page, auth, method, status, level, itemInSession, location, userAgent, lastName, firstName, registration, gender, artist, song, length. In our dataset, there is a variable called ‘page’ (target variable with supervised binary classification), showing which platform page the event is linked to. Here we have an option called ‘Cancellation Confirmation’, which refers to the company’s confirmation of a customer’s request to cancel their account. Using this page event as our churn definition means that a customer has churned only when they have completely stopped using the service and canceled their account. We initially cleaned the data, performed some EDA to understand how the features are related to each other and how they influence our problem statement, then finally included few interesting features in our model to predict customer churn along with identifying most important feature to decide if a customer will churn or not.

### Problem statement
Customer Churn is one of the most important metrics for businesses to evaluate. It is the percentage of customers that stopped using your company’s product or service during a certain time frame. This is important to keep track of because it costs more to acquire new customers than it does to retain existing customers. The goal of this project is to help Sparkify build a machine learning model that can predict when it is likely that a customer is going to churn, to be able to take action on this and prevent customers from canceling their accounts. This kind of prediction model involves a binary classificaion problem, where a user can belong to one of two classes, churned or not churned (still active). To solve this problem we need to do some rigorous data exploration and pre-processing, including:
- define what churn is
- explore how churned and active users differ across different data
- find columns of interest to use in modeling, and create new features based on available data (feature engineering)
- select which features are most suitable in modeling (feature selection)
- test different classification models to see how well suited they are
- define evaluation metrics to use to measure model performance on this dataset correctly (for imbalanced dataset)
- tune hyperparameters to explore how we can improve model performance
- evaluate the model performance and functions
- discuss how to make further model improvements

Local run of the source code was taking a lot of time to train the models. So we shifted to Azure Cloud Platform.

### Installations
Reguired installations:
- Jupyter Notebooks (Anaconda Distribution)
- Python >= 3.6

Required packages:
- PySpark 2.4.4 (PySpark.sql and PySpark.ml)
- NumPy >= 1.19.2
- Pandas >= 1.0.1
- Matplotlib >= 3.0
- Seaborn
- Datetime

Cloud Platform:
-	Azure

### Conclusion
To summarize this project, we trained our model on 5 classifiers (Naïve Bayes, Logistic Regression, Linear SVC, Random Forest, Decision Tree) to predict customer churn based on event log and user data. The best model, the Random Forest, presents quite a good result on the validation data (0.82) and test data(0.70), with the best number of trees equals 20 and maximum depth equals 10. We recoded multiple variables related to event logs into new frequency variables per user, to be able to restructure the model input data to one row per unique user instead of one row per event. We only used the most recent event row per user to get the most updated data. We turned categorical columns into indices, one hot encoded them to separate numerical binary columns, scaled all numerical features using MinMaxScaler, and transformed all input features to one single vector to use in modeling. We tested various classifiers as baseline models without any hyperparameter tuning, selected the best performing baseline model, which was a Random Forest classifier, and tuned its hyperparameters to improve its performance. Finally, we explored how to explain the model by looking at feature importances and their predictive power.

This project was challenging and fun because we have never used Apache Spark previously, the code and functions are different, and it was very useful to learn how to work with analytics and machine learning in a big data setting. Debugging was a bit challenging because the error messages are hard to interpret in Spark, and it took us a while to figure out why we could not join the tables where we had recoded new variables to the dataset. We figured out after much debugging that it was most likely due to not caching the dataframes before joining them, and that some variables had missing data in them that messed up the join function.

### Acknowledgements
The *'mini-sparkify-event-data.json'* dataset has been provided by [Udacity](https://www.udacity.com/).

# Automatic Product Suggestions for website or clothing shopping
 
Suppose you are looking at clothing models on an online shopping site that you like from a set of clothes of a model. The goal is to create a software that searches the site database to select and display the most similar clothes to offer to the user. Alternatively, in a store, according to the available clothes, automatically, according to the clothes of the user's selected model, offer him clothes.

First, we need to change the query image to a person's photo on a dark background. We can use the Grabcut algorithm, which is essentially a function of the Gamma variable.
Next, we determine the person's body parts using the pose estimation method on the photo. Then segment the individual clothes. Then we compare each specified area of this query image with the products and suggest the closest ones (for example, the KNN method and Euclidean distance). We have pre-made the features of the products offline with the mentioned methods.
We have to perform Feature Extraction. We use a hybrid method and create our features from features obtained from the four methods SIFT,  LBP, HSV, and Histogram.

<br/><img src='https://github.com/MohammadAhmadig/MohammadAhmadig.github.io/blob/master/images/automatic-product.png'>

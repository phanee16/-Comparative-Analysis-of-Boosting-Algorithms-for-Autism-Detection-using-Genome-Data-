# # # # # # # # # # # # #
#### Ensembel Model #####
# # # # # # # # # # # # #

library(randomForest)

load("01_training_labels.Rdata")
load("02_STRING_rf.Rdata")
load("02_brainspan_RF.Rdata")
load("02_network_rf.Rdata")

# # # # # # # # # # # # 
#### Load in data #####
# # # # # # # # # # # # 

meta = read.csv("./ext_data/composite_table.csv", stringsAsFactors = F, row.names = 1)

string.prd = string.prd[rownames(meta), ]
bs.prd = bs.prd[rownames(meta), ]

## combine other predictors with network scores
meta = cbind(
  data.frame(
    STRING_score = string.prd[rownames(meta) , "TRUE"],
    BrainSpan_score = bs.prd[rownames(meta), "TRUE"]
  ),
  meta[rownames(meta), ]
)

# # # # # # # # # # # # 
#### train forest ##### # Model 1
# # # # # # # # # # # # 

meta.train = na.roughfix(
  meta[meta$ensembl_string %in% c(pos,neg), -(3:9)]   ## remove gene identifiers, etc.
) 
nrow(meta.train)
idx = sample(nrow(meta.train), nrow(meta.train)*0.3)
meta.split.test = meta.train[idx,]
nrow(meta.split.test)
meta.split.train = meta.train[-idx,]
nrow(meta.split.train)
y.split.train = as.factor(rownames(meta.split.train) %in% pos)
y.split.test = as.factor(rownames(meta.split.test) %in% pos)

set.seed(43775)
rf = randomForest(
  y = y.split.train,
  x = meta.split.train, 
  importance = T,
  do.trace = 10,
  strata = y,
  sampsize = c(76,76)
  )
meta.split.pred <- predict(rf, meta.split.test, type="prob")
a = data.frame(res=meta.split.pred[rownames(meta.split.pred),"TRUE"])
a = a %>% mutate(probab_res = case_when(res >=0.5 ~ TRUE, 
                                        res < 0.5 ~ FALSE))
rf_Error <- mean(a$probab_res != y.split.test) # Error for Random forest
rf_Error # 0.012 is error for RF
plot(rf) # This indicates number of trees which can be used effectively

hist(treesize(rf),
     main = "No. of Nodes for the Trees",
     col = "green")

#Finding Feature importance#

varImpPlot(rf,
           sort = T,
           n.var = 10,
           main = "Top 10 - Variable Importance")
importance(rf)
varUsed(rf)

#getTree(rf, 1, labelVar = TRUE)

#####GBM- using Gaussian## Model -2
library("caret")
library("ggplot2")
library("gbm")
new_train = meta.split.train
new_train = new_train %>% mutate(result = case_when(y.split.train == TRUE ~ 1, 
                                                    y.split.train == FALSE ~ 0))
boost.gb = gbm(result ~ ., data = new_train, distribution = "gaussian", n.trees = 5000)
new_test = meta.split.test
new_test = new_test %>% mutate(result = case_when(y.split.test == TRUE ~ 1, 
                                                  y.split.test == FALSE ~ 0))
predict.gb.boost = predict(boost.gb, newdata = new_test, type='response') %>% round()
gbm_error <- mean(predict.gb.boost!=new_test$result)
gbm_error
cat('Error for GBM', gbm_error) 
#### end of GBM ####

##AdaBoost ### Model -3
new_train = meta.split.train
new_train = new_train %>% mutate(result = case_when(y.split.train == TRUE ~ 1, 
                                                    y.split.train == FALSE ~ 0))
boost.ad = gbm(result ~ ., data = new_train, distribution = "adaboost", n.trees = 5000)
new_test = meta.split.test
new_test = new_test %>% mutate(result = case_when(y.split.test == TRUE ~ 1, 
                                                  y.split.test == FALSE ~ 0))
predict.ad.boost = predict(boost.ad, newdata = new_test, type='response') %>% round()
ad_error <- mean(predict.ad.boost!=new_test$result)
ad_error
cat('Error for GBM Adaboost', ad_error)

## end of Adaboost ##

###XGBOOST ### Model -4
library(xgboost)
xgboost.gb = xgboost(data = as.matrix(new_train[-14]), label=new_train$result, nrounds=10)
predict.xg = predict(xgboost.gb, newdata = as.matrix(new_test[-14])) %>% round()
xg_error <- mean(predict.xg!=new_test$result)
xg_error
cat('Error for XGBoost', xg_error)
#### model end##

# fearure IMportaance of XGBOOST

xgb_imp <- xgb.importance(colnames(new_train[-14]), model=xgboost.gb)
xgb.plot.importance(xgb_imp)



data.j = data.frame(randF_Error = rf_Error, xgbst_error = xg_error, adaboost_error = ad_error, gbm_error = gbm_error)
data.j 

####last part begin####
meta.test = na.roughfix(
  meta[!(meta$ensembl_string %in% c(pos,neg)), -(3:9)]   ## remove gene identifiers, etc.
) 

meta.prd <- predict(rf, 
                    meta.test, 
                    type = "prob")

meta.score <- rbind(rf$votes, meta.prd)

final.data <- cbind(
  data.frame(
    forecASD = meta.score[rownames(meta),"TRUE"],
    'STRING+BrainSpan_RF' = network.prd[rownames(meta),"TRUE"]
  ), 
  meta
)

write.csv(final.data, 
          file = "forecASD_table.csv",
          quote = F, 
          row.names = F)
############Last part end#

# ---------- Chargement des packages nécéssaires
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)
install.packages("randomForest")
library(randomForest)
source("fonctions_utiles.R")

# ---------- Chargement des données
donnee = read.table("./ndg.txt", header = T)
cl = read.table("./ListeClasses.txt", header = T)
donnee = cbind(donnee,as.factor(cl$Classe))
colnames(donnee)[257]="classe"

table(cl$Classe)


# ---------- Separation Apprentissage/Validation/Test
nall = nrow(donnee) #total number of rows in data
ntrain = floor(0.7 * nall) # number of rows for train: 70% (vous pouvez changer en fonction des besoins)
ntest = nall - ntrain # number of rows for test: le reste

set.seed(20) # choix d une graine pour le tirage aléatoire
index = sample(nall) # permutation aléatoire des nombres 1, 2, 3 , ... nall

donnee_app = donnee[index[1:ntrain],] # création du jeu d'apprentissage
donnee_test = donnee[index[(ntrain+1):(ntrain+ntest)],] # création du jeu de test


# ---------- Construction de la foret

# La fonction randomForest permet d'ajuster une forêt aléatoire à partir d'un ensemble d'apprentissage.
# Les paramètres sont :
# - une formule  : NomdeColonne~., ou NomDeColonne correspond au nom de la colonne qui contient la classe
# dans les données (ici Reussite), et le  '.' indique que toutes les autres colonnes sont utilisees comme 
# variables pour construire le classifieur.
# - data = ... , le nom de la variable qui contient les données
# - ntree, qui correspond au nombre d'arbre que vous voulez créer dans la foret (ici 2 dans cet exemple)

############~~~~~~nombre d'arbre = 2 ~~~~~~~~~~~~~~~~~###############
foret = randomForest(classe~., data = donnee_app, ntree = 2,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 2,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 2,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)

getTree(foret, 1)
getTree(foret, 2)

print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==2))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))


############~~~~~~nombre d'arbre = 10 ~~~~~~~~~~~~~~~~~###############
foret = randomForest(classe~., data = donnee_app, ntree = 10,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 10,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 10,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==10))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))

############~~~~~~nombre d'arbre = 20 ~~~~~~~~~~~~~~~~~###############
#foret = randomForest(classe~., data = donnee_app, ntree = 20,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 20,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
foret = randomForest(classe~., data = donnee_app, ntree = 20,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==20))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))

############~~~~~~nombre d'arbre = 50 ~~~~~~~~~~~~~~~~~###############
#foret = randomForest(classe~., data = donnee_app, ntree = 50,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 50,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
foret = randomForest(classe~., data = donnee_app, ntree = 50,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==50))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))

############~~~~~~nombre d'arbre = 100 ~~~~~~~~~~~~~~~~~###############
#foret = randomForest(classe~., data = donnee_app, ntree = 100,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 100,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
foret = randomForest(classe~., data = donnee_app, ntree = 100,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==100))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))

############~~~~~~nombre d'arbre = 200 ~~~~~~~~~~~~~~~~~###############
#foret = randomForest(classe~., data = donnee_app, ntree = 200,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 200,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
foret = randomForest(classe~., data = donnee_app, ntree = 200,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==500))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))

############~~~~~~nombre d'arbre = 1000 ~~~~~~~~~~~~~~~~~###############
#foret = randomForest(classe~., data = donnee_app, ntree = 1000,mtry=floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
#foret = randomForest(classe~., data = donnee_app, ntree = 1000,mtry=2*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
foret = randomForest(classe~., data = donnee_app, ntree = 1000,mtry=3*floor(sqrt(ncol(donnee)-1)), norm.votes=FALSE)
print(foret)

vote = foret$votes
#foret$predicted
obbTimes=foret$oob.times

print(sum(vote))
# nb d'exemples qui n'ont jamais ete utilises pour construire l'un des arbres de la foret
print(sum(foret$oob.times==100))
# nb d'exemples qui n'ont jamais fait parti de l'ensemble OOB (pour aucun des arbres de la foret)
print(sum(foret$oob.times==0))

#predict(foret, donnee_app)

#### proportion de prédictions correctes faite par cet arbre sur l'ensemble d'apprentissage
print(ntrain)
s=sum(predict(foret,donnee_app)==donnee_app$classe)
print(s)
print(1-(s/ntrain))
#### erreur en generalisation (erreur reelle).
print(ntest)
s=sum(predict(foret, donnee_test)==donnee_test$classe)
print(s)
print(1-(s/ntest))

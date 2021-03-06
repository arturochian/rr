\name{rrreg} 
\alias{rrreg}
\title{Randomized Response Regression} 
\description{ 
\code{rrreg} is used to conduct multivariate regression analyses of survey data using randomized response methods. 
} 

\usage{
  rrreg(formula, p, p0, p1, q, design, data, start = NULL, maxIter = 10000, 
        verbose = FALSE, optim = FALSE, em.converge = 10^(-8), glmMaxIter = 10000,
        solve.tolerance = .Machine$double.eps)
}

\arguments{ 
  \item{formula}{An object of class "formula": a symbolic description of the model to be fitted.} 
  \item{p}{The probability of receiving the sensitive question (Mirrored Question Design, Unrelated Question Design); the   
  probability of answering truthfully (Forced Response Design); the probability of selecting a red card from the 'yes' stack 
  (Disguised Response Design). For "mirrored" and "disguised" designs, p cannot equal .5.}
  \item{p0}{The probability of forced 'no' (Forced Response Design).} 
  \item{p1}{The probability of forced 'yes' (Forced Response Design).}
  \item{q}{The probability of answering 'yes' to the unrelated question, which is assumed to be independent of covariates 
  (Unrelated Question Design).}
  \item{design}{One of the four standard designs: "forced-known", "mirrored", "disguised", or "unrelated-known".}
  \item{data}{A data frame containing the variables in the model.}
  \item{start}{Optional starting values of coefficient estimates for the Expectation-Maximization (EM) algorithm.}
  \item{maxIter}{Maximum number of iterations for the Expectation-Maximization algorithm. The default is \code{10000}.} 
  \item{verbose}{A logical value indicating whether model diagnostics counting the number of EM iterations are printed out. 
  The default is \code{FALSE}.}
  \item{optim}{A logical value indicating whether to use the quasi-Newton "BFGS" method to calculate the variance-covariance   
  matrix and standard errors. The default is \code{FALSE}.}
  \item{em.converge}{A value specifying the satisfactory degree of convergence under the EM algorithm. The default is 
  \code{10^(-8)}.}
  \item{glmMaxIter}{A value specifying the maximum number of iterations to run the EM algorithm. The default is \code{10000}.}
  \item{solve.tolerance}{When standard errors are calculated, this option specifies the tolerance of the matrix inversion operation solve.}
}

\details{
  This function allows users to perform multivariate regression analysis on data from the randomized response technique.
  Four standard designs are accepted by this function: mirrored question, forced response, disguised response, and unrelated 
  question. The method implemented by this function is the Maximum Likelihood (ML) estimation for the 
  Expectation-Maximization (EM) algorithm.
}

\value{
  \code{rrreg} returns an object of class "rrreg".  The function \code{summary} is used to obtain a table of the results.  
  The object \code{rrreg} is a list that contains the following components (the inclusion of some components such as the 
  design parameters are dependent upon the design used):

  \item{est}{Point estimates for the effects of covariates on the randomized response item.}
  \item{vcov}{Variance-covariance matrix for the effects of covariates on the randomized response item.}
  \item{se}{Standard errors for estimates of the effects of covariates on the randomized response item.}
  \item{data}{The \code{data} argument.}
  \item{coef.names}{Variable names as defined in the data frame.}
  \item{x}{The model matrix of covariates.}
  \item{y}{The randomized response vector.}
  \item{design}{Call of standard design used: "forced-known", "mirrored", "disguised", or "unrelated-known".}
  \item{p}{The \code{p} argument.}
  \item{p0}{The \code{p0} argument.}
  \item{p1}{The \code{p1} argument.}
  \item{q}{The \code{q} argument.}
  \item{call}{The matched call.}
}

\references{
  Blair, Graeme, Kosuke Imai and Yang-Yang Zhou. (2014) "Design and Analysis of the Randomized Response Technique." Working 
  Paper. Available at \url{http://imai.princeton.edu/research/randresp.html}.
}

\examples{
\dontrun{
data(nigeria)

set.seed(1)

## Define design parameters
p <- 2/3  # probability of answering honestly in Forced Response Design
p1 <- 1/6 # probability of forced 'yes'
p0 <- 1/6 # probability of forced 'no'

## Fit linear regression on the randomized response item of whether 
## citizen respondents had direct social contacts to armed groups

rr.q1.reg.obj <- rrreg(rr.q1 ~ cov.asset.index + cov.married + 
                    I(cov.age/10) + I((cov.age/10)^2) + cov.education + cov.female,   
                    data = nigeria, p = p, p1 = p1, p0 = p0, 
                    design = "forced-known")
  
summary(rr.q1.reg.obj)

## Replicates Table 3 in Blair, Imai, and Zhou (2014)
}
}

\seealso{
\code{\link{predict.rrreg}} for predicted probabilities.
}

\keyword{regression}
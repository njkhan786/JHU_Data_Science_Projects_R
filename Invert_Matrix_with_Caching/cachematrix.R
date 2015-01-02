## The goal of this programing assignment is to calculate the inverse of a square 
## matrix and cache it, or find the calculated inverse matrix from the cache.
## Emma Yu Sep 21 2014
## JHU DataScience R W3


## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
    invermatrix <- NULL
    set <- function(y){
        x <<- y
        invermatrix <<- NULL
    }
    get <- function() x
    setinverse <- function(inver) invermatrix <<- inver
    getinverse <- function() invermatrix
    list(set = set, 
         get = get,
         setinverse = setinverse, 
         getinverse = getinverse)
}


## cacheSolve - computes the inverse of a matrix returned by the makeCacheMatrix function.
## if the inverse has already been calculated, then the cachesolve should retrieve the 
## inverse from the cache.

cacheSolve <- function(x = matrix(), ...) {
    # be carefule that the matrix has to be an square matrix to be invertable.
    invermatrix <- x$getinverse()
    if(!is.null(invermatrix)){
        message("getting cached data")
        return(invermatrix)
    }
    data <- x$get()
    invermatrix <- solve(data, ...)
    x$setinverse(invermatrix)
    invermatrix
}

# Testing case:
#source("cachematrix.R")
#m<-makeCacheMatrix(matrix(1:4,2,2))
#cacheSolve(m)

# add a small profiling
#> system.time(cacheSolve(m))
#user  system elapsed 
#0.001   0.001   0.008 

#amatrix = makeCacheMatrix(matrix(c(1,2,3,4), nrow=2, ncol=2))
#amatrix$get()    
#cacheSolve(amatrix)
#amatrix$getinverse()
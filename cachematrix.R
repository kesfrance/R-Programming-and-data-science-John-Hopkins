#!/usr/bin/R
# This program was created from the second project in R-programming
#
# by: Francis Kessie
#
# cachematrix.R contain two functions that are used to create a special matrix object
# and its inverse. However, it first checks to see if the inverse has already been
# calculated. If so, it `get`s the mean from the cache and skips the computation
# This program assumes that the matrix supplied is always invertible.
# This function creates a special "matrix" object
# that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
m <- NULL
set <- function(y) {
x <<- y
m <<- NULL
}
get <- function() x
setinverse <- function(solve) m <<- solve
getinverse <- function() m
list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}
## This function computes the inverse of the special "matrix" returned
## by `makeCacheMatrix` above. If the inverse has already been calculated
## (and the matrix has not changed), then it retrieves the inverse from the cache.
cacheSolve <- function(x, ...) {
## Return a matrix that is the inverse of 'x'
m <- x$getinverse()
if (!is.null(m)) {
message("getting cached data")
return(m)
}
data <- x$get()
m <- solve(data, ...)
x$setinverse(m)
m
}

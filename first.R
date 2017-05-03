checkPrime <- function(n){
  lim = as.integer(sqrt(n))
  f <- 2
  for(f in 2:lim){
    if((n%%f)==0){
      break
    }
  }
  if(n==lim){
    print("prime")
  }else{
    print("not!")
  }

}

checkPrime(16)

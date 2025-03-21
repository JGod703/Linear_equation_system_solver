sistemEquations<- function() {
  cicle<-1
  while (cicle==1) {
    # Function to create an identity matrix
    create_identity_matrix <- function(n) {
      outMatrix <- matrix(0, nrow = n, ncol = n)
      
      for (i in 1:n) {
        for (j in 1:n) {
          if (i == j) {
            outMatrix[i,j] <- 1
          } else {
            outMatrix[i,j] <- 0
          }
        }
      }
      
      return(outMatrix)
    }
    
    # Function to create a matrix with user provided values
    create_custom_matrix <- function(n) {
      outMatrix <- matrix(0, nrow = n, ncol = n)
      
      for (i in 1:n) {
        for (j in 1:n) {
          prompt <- paste("Enter the [", i, ",", j, "] number: ")
          item <- readline(prompt = prompt)
          
          outMatrix[i,j] <- as.numeric(item)
        }
      }
      
      return(outMatrix)
    }
    
    # Function to calculate an inverse matrix
    calculate_inverse_matrix <- function(n, custom_matrix) {
      identity_matrix <- create_identity_matrix(n)
      
      # Calculate the inverse
      for (i in 1:n) {
        pivot <- custom_matrix[i,i]
        
        # If pivot is nan is because the system has no solution
        # Beacause there was no number but 0 to put in the principal diagonal
        # So it produces a number/0 error so pivot becomes number/0 -> NaN
        if (is.nan(pivot)) {
          stop("The system has no solutions")
        }
        
        # Move the 0 from the principal diagonal
        if (pivot == 0) {
          for (j in (i+1):n) {
            if (custom_matrix[j,i] != 0) {
              # Reorder the custom matrix rows
              aux <- custom_matrix[j,]
              custom_matrix[j,] <- custom_matrix[i,]
              custom_matrix[i,] <- aux
              
              # Reorder the identity matrix rows
              aux_i <- identity_matrix[j,]
              identity_matrix[j,] <- identity_matrix[i,]
              identity_matrix[i,] <- aux_i
              
              break
            }
          }
        }
        
        # Operate rows
        pivot <- custom_matrix[i,i]
        custom_matrix[i,] <- custom_matrix[i,] / pivot
        identity_matrix[i,] <- identity_matrix[i,] / pivot
        
        for (j in 1:n) {
          if (j != i) {
            item_in_pivot_column <- custom_matrix[j,i]
            
            custom_matrix[j,] <- custom_matrix[j,] - (custom_matrix[i,] * item_in_pivot_column)
            identity_matrix[j,] <- identity_matrix[j,] - (identity_matrix[i,] * item_in_pivot_column)
          }
        }
      }
      
      return(identity_matrix)
    }
    
    # Function to create the vector of equations values
    create_values_matrix <- function(n) {
      outMatrix <- matrix(0, nrow = n, ncol = 1)
      
      for (i in 1:n) {
        prompt <- paste("Enter the value of the ", i," equation: ")
        item <- readline(prompt = prompt)
        
        outMatrix[i,1] <- as.numeric(item)
      }
      
      return(outMatrix)
    }
    
    # Function to calculate the equations solutions
    calculate_solutions_matrix <- function(inverse, values) {
      solutions_matrix <- inverse %*% values
      
      return(solutions_matrix)
    }
    
    res <- readline(prompt = "Enter the n value for nxn matrix: ")
    n <- as.numeric(res)
    
    custom <- create_custom_matrix(n)
    values <- create_values_matrix(n)
    inverse <- calculate_inverse_matrix(n, custom)
    
    solutions <- calculate_solutions_matrix(inverse, values)
    
    print("Matrix Initial")
    print(custom)
    print("Matrix Values")
    print(values)
    print("Matrix Inverse")
    print(inverse)
    print("Solutions")
    print(solutions)
    
    cicle <- readline("Do you want to try again?\n press 1 to continue: ")
  }
  print("End of program...")
}
sistemEquations()
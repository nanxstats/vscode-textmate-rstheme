import cvxpy as cp
import numpy as np

m = 20
n = 15
np.random.seed(1)
A = np.random.randn(m, n)
b = np.random.randn(m)

x = cp.Variable(n)
cost = cp.sum_squares(A @ x - b)
prob = cp.Problem(cp.Minimize(cost))
prob.solve()

print("\nThe optimal value is", prob.value)
print("The norm of the residual is ", cp.norm(A @ x - b, p=2).value)


# Fibonacci numbers module, 1, 1, 2, 3, 5, 8, 13, ...

def fib(n):    # write Fibonacci series up to n
    a, b = 0, 1
    while a < n:
        print(b, end=' ')
        a, b = b, a+b
    print()

def fib2(n):   # return Fibonacci series up to n
    result = []
    a, b = 0, 1
    while a < n:
        result.append(a)
        a, b = b, a+b
    return result

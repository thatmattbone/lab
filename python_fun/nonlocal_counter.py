def counter():
    a = 0
    def inc():
        nonlocal a
        a+=1
        return a
    return inc

c = counter()
print(c())
print(c())
print(c())

print(c.__closure__)
print(c.__closure__[0].cell_contents)

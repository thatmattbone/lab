class A:
    kls_var = 2
    inst_var = 3

if __name__ == "__main__":

    a1 = A()
    a2 = A()

    a1.inst_var = 4
    a2.inst_var = 5

    A.kls_var = 666

    print(a1.kls_var)
    print(a1.inst_var)

    print(a2.kls_var)
    print(a2.inst_var)

    a2.kls_var = 777
    print(a1.kls_var)
    print(a2.kls_var)

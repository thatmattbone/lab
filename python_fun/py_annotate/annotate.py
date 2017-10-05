def foo(bar: "I'm a string") -> None:
    print(bar)

if __name__=="__main__":
    foo("hello")
    foo(5)
    print(foo.func_annotations)

use std;

fn fib(n: uint) -> uint {
    if(n == 0u) {
        0u
    } else if(n == 1u) {
        1u
    } else {
        fib(n-1u) + fib (n-2u)
    }
}

fn main() {
    task::spawn {||
        io::println(#fmt("%u", fib(45u)));
    }

    task::spawn {||
        io::println(#fmt("%u", fib(48u)));
    }
}
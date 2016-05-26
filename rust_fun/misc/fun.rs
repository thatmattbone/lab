use std;

const max_count: uint = 10u;

fn sub_two(x: int, y: int) -> int {
    ret x - y;
}


fn foo() {
    //io::println("foo!");
    let baz = "baz";
    let boop: fn() = {||
        //io::println("bar!");
        io::println(baz);
    };
    boop();
}

fn main(_args: [str]) {
    
    // let hi: str = "Hi!!";
    // let mut i: uint = 0u;
    // while i < max_count {
    //     io::println(hi);
    //     i += 1u;
    // }
    //fail "fuck!";
    //foo();
    //foo();
    //let doubled = vec::map([1, 2, 3],  {|x| x*2});
    let some_num = sub_two(100, 23);
    let minus_one = bind sub_two(_, 1);
    io::println(#fmt("%d", some_num));
    io::println(#fmt("%d", minus_one(9)));
}
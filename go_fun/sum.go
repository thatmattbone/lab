package main

import "fmt"

func sum(a []int, out chan int) {
	s := 0
	for _, v := range a {
		s += v
	}
	//return s
	out <- s
	//return s
}

func wtf(foo map[string]int) {
	for key, value := range foo {
		fmt.Printf("%s:%d\n", key, value)
	}
}

func main() {
	var foo = [3]int{1,2,3}	

	//var bar = foo[:]
	//var baz = &foo
	//fmt.Print(bar)
	//fmt.Print(*baz)

	var my_chan = make(chan int)


	go sum(foo[:], my_chan)
	var result = <- my_chan

	fmt.Printf("sum: %d\n", result)

	//wtf(map[string]int{"one":1, "two":2})
}